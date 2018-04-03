Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755150AbeDCXQi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 19:16:38 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:38116 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753773AbeDCXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 19:16:35 -0400
X-Google-Smtp-Source: AIpwx48/YpiZYN+uaXwo6vYn2hzFxvAG/AjLRHQBmjJeapCY5o8rWRXwWj/5ssH8Nxi/HZY/OMvLSA==
Date: Tue, 3 Apr 2018 16:16:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jon Rosen <jrosen@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Maloney <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
 to prevent RX ring overrun
Message-ID: <20180403161630.24f8339c@xeon-e3>
In-Reply-To: <20180403215526.15934-1-jrosen@cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Apr 2018 17:55:25 -0400
Jon Rosen <jrosen@cisco.com> wrote:

> Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
> casues the ring to get corrupted by allowing multiple kernel threads
> to claim ownership of the same ring entry, Mark the ring entry as
> already being used within the spin_lock to prevent other kernel
> threads from reusing the same entry before it's fully filled in,
> passed to user space, and then eventually passed back to the kernel
> for use with a new packet.
> 
> Note that the proposed change may modify the semantics of the
> interface between kernel space and user space in a way which may cause
> some applications to no longer work properly. More discussion on this
> change can be found in the additional comments section titled
> "3. Discussion on packet_mmap ownership semantics:".
> 
> Signed-off-by: Jon Rosen <jrosen@cisco.com>
> ---
> 
> Additional Comments Section
> ---------------------------
> 
> 1. Description of the diffs:
> ----------------------------
> 
>    TPACKET_V1 and TPACKET_V2 format rings:
>    -------------------------------------------
>    Mark each entry as TP_STATUS_IN_PROGRESS after allocating to
>    prevent other kernel threads from re-using the same entry.
> 
>    This is necessary because there may be a delay from the time the
>    spin_lock is released to the time that the packet is completed and
>    the corresponding ring entry is marked as owned by user space.  If
>    during this time other kernel threads enqueue more packets to the
>    ring than the size of the ring then it will cause mutliple kernel
>    threads to operate on the same entry at the same time, corrupting
>    packets and the ring state.
> 
>    By marking the entry as allocated (IN_PROGRESS) we prevent other
>    kernel threads from incorrectly re-using an entry that is still in
>    the progress of being filled in before it is passed to user space.
> 
>    This forces each entry through the following states:
> 
>    +-> 1. (tp_status == TP_STATUS_KERNEL)
>    |      Free: For use by any kernel thread to store a new packet
>    |
>    |   2. !(tp_status == TP_STATUS_KERNEL) && !(tp_status & TP_STATUS_USER)
>    |      Allocated: In use by a *specific* kernel thread
>    |
>    |   3. (tp_status & TP_STATUS_USER)
>    |      Available: Packet available for user space to process
>    |
>    +-- Loop back to #1 when user space writes entry as TP_STATUS_KERNEL
> 
> 
>    No impact on TPACKET_V3 format rings:
>    -------------------------------------
>    Packet entry ownership is already protected from other kernel
>    threads potentially re-using the same entry. This is done inside
>    packet_current_rx_frame() where storage is allocated for the
>    current packet. Since this is done within the spin_lock no
>    additional status updates for this entry are required.
> 
> 
>    Defining TP_STATUS_IN_PROGRESS:
>    -------------------------------
>    Rather than defining a new-bit we re-use an existing bit for this
>    intermediate state.  Status will eventually be overwritten with the
>    actual true status when passed to user space.  Any bit used to pass
>    information to user space other than the one that passes ownership
>    is suitable (can't use TP_STATUS_USER).  Alternatively a new bit
>    could be defined.
> 
> 
> 2. More detailed discussion:
> ----------------------------
>    Ring entries basically have 2 states, owned by the kernel or owned by
>    user space. For single producer/single consumer this works fine. For
>    multiple producers there is a window between the call to spin_unlock
>    [F] and the call to __packet_set_status [J] where if there are enough
>    packets added to the ring by other kernel threads then the ring can
>    wrap and multiple threads will end up using the same ring entries.
> 
>    This occurs because the ring entry alocated at [C] did not modify the
>    state of the entry so it continues to appear as owned by the kernel
>    and available for use for new packets even though it has already been
>    allocated.
> 
>    A simple fix is to temporarily mark the ring entries within the spin
>    lock such that user space will still think it?s owned by the kernel
>    and other kernel threads will not see it as available to be used for
>    new packets. If a kernel thread gets delayed between [F] and [J] for
>    an extended period of time and the ring wraps back to the same point
>    then subsiquent kernel threads attempts to allocate will fail and be
>    treated as the ring being full.
> 
>    The change below at [D] uses a newly defined TP_STATUS_IN_PROGRESS bit
>    to prevent other kernel threads from re-using the same entry. Note that
>    any existing bit other than TP_STATUS_USER could have been used.
> 
>    af_packet.c:tpacket_rcv()
>       ... code removed for brevity ...
> 
>       // Acquire spin lock
> A:    spin_lock(&sk->sk_receive_queue.lock);
> 
>             // Preemption is disabled
> 
>             // Get current ring entry
> B:          h.raw = packet_current_rx_frame(
>                         po, skb, TP_STATUS_KERNEL, (macoff+snaplen));
> 
>             // Get out if ring is full
>             // Code not show but it will also release lock
>             if (!h.raw) goto ring_is_full;
> 
>             // Allocate ring entry
> C:          packet_increment_rx_head(po, &po->rx_ring);
> 
>             // Protect against allocation overrun (the simple fix)
>             // by changing TP_STATUS_KERNEL to TP_STATUS_IN_PROGRESS
> D:          if (po->tp_version <= TPACKET_V2) 
>                __packet_set_status(po, h.raw, TP_STATUS_IN_PROGRESS);
> 
>             // Update counter
> E:          po->stats.stats1.tp_packets++;
> 
>       // Release spin lock
> F:    spin_unlock(&sk->sk_receive_queue.lock);
> 
>       // Copy packet payload
> G:    skb_copy_bits(skb, 0, h.raw + macoff, snaplen);
> 
>       // Get current timestamp
> H:    if (!(ts_status = tpacket_get_timestamp(skb, &ts, po->tp_tstamp))) 
>          getnstimeofday(&ts);
>       status |= ts_status;
> 
>       // Fill in header portions of ring entry (removed a bunch of
>       // writes for brevity)
>       ...
>       h.h1->tp_sec = ts.tv_sec;
>       h.h1->tp_usec = ts.tv_nsec / NSEC_PER_USEC;
>       sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>       ...
> 
>       // Memory Barrier to make sure all data is written before
>       // passing ownership to user space
> I:    smp_mb();
> 
>       // Update Status, passing ownership to user space
> J:    __packet_set_status(po, h.raw, status | TP_STATUS_USER);
> 
> 
> 3. Discussion on packet_mmap ownership semantics:
> -------------------------------------------------
>    One issue with the above proposed change to use TP_STATUS_IN_PROGRESS
>    is that the documentation of the tp_status field is somewhat
>    inconsistent.  In some places it's described as TP_STATUS_KERNEL(0)
>    meaning the entry is owned by the kernel and !TP_STATUS_KERNEL(0)
>    meaning the entry is owned by user space.  In other places ownership
>    by user space is defined by the TP_STATUS_USER(1) bit being set.
> 
>    Relevant section of packet_mmap documentation from
>    https://www.kernel.org/doc/Documentation/networking/packet_mmap.txt
>    follow but a summary of the semantics in question are described as:
> 
>    - At the beginning of each frame there is an status field
>    - If this field is 0 means that the frame is ready to be
>      used for the kernel
>    - If not, there is a frame the user can read
> 
>    This would indicate that 0 means owned by the kernel and non-0 is
>    owned by the user.  The simple fix above is to set the status to
>    something that neither the kernel nor the user thinks they own.  That
>    means that 0 vs. non-0 would be insufficient.
> 
>    The description and examples in packet_mmap.txt actually talk about
>    using a specific bit, the TP_STATUS_USER bit, to indicate something is
>    owned by the kernel vs something is owned by the user.  The relevant
>    references from packet_mmap.txt to this bit are:
> 
>    - The kernel initializes all frames to TP_STATUS_KERNEL(0)
>    - when the kernel receives a packet it puts in the buffer and
>      updates the status with at least the TP_STATUS_USER(1) flag
> 
>    This description contradicts the previous description which implied
>    that non-0 means owned by the user. In the above statement it implies
>    that there needs to be more than just non-0 and that the
>    TP_STATUS_USER bit must be set for it to be owned by user space.
> 
>    If the above proposed fix of using a new TP_STATUS_IN_PROGRESS bit (or
>    any existing bit other than TP_STATUS_USER) were to be used and an
>    application were written assuming !TP_STATUS_KERNEL implies owned by
>    user space then the application would incorrectly assume there was a
>    valid packet entry to be processed when the entry is not ready.  If an
>    application were instead written to look specificaly for
>    TP_STATUS_USER then the above proposed fix would work correctly.
> 
>    A more complex solution might be to create a shadow data structure
>    which is private to the kernel and keeps status bits for each ring
>    entry to indicate the intermediate state between owned by kernel and
>    owned by user space.
> 
> 
> 4. Snipet from packet_mmap.txt
> ------------------------------
>    At the beginning of each frame there is an status field (see 
>    struct tpacket_hdr). If this field is 0 means that the frame is ready
>    to be used for the kernel, If not, there is a frame the user can read 
>    and the following flags apply:
> 
>    +++ Capture process:
>    from include/linux/if_packet.h
> 
>    #define TP_STATUS_COPY          (1 << 1)
>    #define TP_STATUS_LOSING        (1 << 2)
>    #define TP_STATUS_CSUMNOTREADY  (1 << 3)
>    #define TP_STATUS_CSUM_VALID    (1 << 7)
> 
>    TP_STATUS_COPY        : This flag indicates that the frame (and associated
>    meta information) has been truncated because it's 
>    larger than tp_frame_size. This packet can be 
>    read entirely with recvfrom().
> 
>    In order to make this work it must to be
>    enabled previously with setsockopt() and 
>    the PACKET_COPY_THRESH option. 
> 
>    The number of frames that can be buffered to
>    be read with recvfrom is limited like a normal socket.
>    See the SO_RCVBUF option in the socket (7) man page.
> 
>    TP_STATUS_LOSING      : indicates there were packet drops from last time 
>    statistics where checked with getsockopt() and
>    the PACKET_STATISTICS option.
> 
>    TP_STATUS_CSUMNOTREADY: currently it's used for outgoing IP packets which 
>    its checksum will be done in hardware. So while
>    reading the packet we should not try to check the 
>    checksum. 
> 
>    TP_STATUS_CSUM_VALID  : This flag indicates that at least the transport
>    header checksum of the packet has been already
>    validated on the kernel side. If the flag is not set
>    then we are free to check the checksum by ourselves
>    provided that TP_STATUS_CSUMNOTREADY is also not set.
> 
>    for convenience there are also the following defines:
> 
>    #define TP_STATUS_KERNEL        0
>    #define TP_STATUS_USER          1
> 
>    The kernel initializes all frames to TP_STATUS_KERNEL, when the kernel
>    receives a packet it puts in the buffer and updates the status with
>    at least the TP_STATUS_USER flag. Then the user can read the packet,
>    once the packet is read the user must zero the status field, so the kernel 
>    can use again that frame buffer.
> 
>    The user can use poll (any other variant should apply too) to check if new
>    packets are in the ring:
> 
>    struct pollfd pfd;
> 
>    pfd.fd = fd;
>    pfd.revents = 0;
>    pfd.events = POLLIN|POLLRDNORM|POLLERR;
> 
>    if (status == TP_STATUS_KERNEL)
>    retval = poll(&pfd, 1, timeout);
> 
>    It doesn't incur in a race condition to first check the status value and 
>    then poll for frames.
> 
> 
> 5. Snipet from man pages for packet(7):
> ---------------------------------------
> 
>    See portion marked with "***" for reference to use of TP_STATUS_USER bit.
> 
>        PACKET_RX_RING
> 
>               Create a memory-mapped ring buffer for asynchronous
>               packet reception.  The packet socket reserves a
>               contiguous region of application address space, lays it
>               out into an array of packet slots and copies packets (up
>               to tp_snaplen) into subsequent slots.  Each packet is
>               preceded by a metadata structure similar to
>               tpacket_auxdata.  The protocol fields encode the offset
>               to the data from the start of the metadata header.
>               tp_net stores the offset to the network layer.  If the
>               packet socket is of type SOCK_DGRAM, then tp_mac is the
>               same.  If it is of type SOCK_RAW, then that field stores
>               the offset to the link-layer frame.  Packet socket and
>               application communi? cate the head and tail of the ring
>               through the tp_status field.  The packet socket owns all
>               slots with tp_status equal to TP_STATUS_KERNEL.  After
>               filling a slot, it changes the status of the slot to
>        ***    transfer ownership to the application.  During normal
>        ***    operation, the new tp_status value has at least the
>        ***    TP_STATUS_USER bit set to signal that a received packet
>        ***    has been stored.  When the application has finished
>               processing a packet, it transfers ownership of the slot
>               back to the socket by setting tp_status equal to
>               TP_STATUS_KERNEL.
> 
>               Packet sockets implement multiple variants of the packet
>               ring.  The implementation details are described in
>               Documentation/networking/packet_mmap.txt in the Linux
>               kernel source tree.
> 
> 
> 6. Relevant files:
> ------------------
>   net/packet/af_packet.c
>   include/uapi/linux/if_packet.h
>   Documentation/networking/packet_mmap.txt
> 
> Jon Rosen (1):
>   packet: mark ring entry as in-use inside spin_lock to prevent RX ring
>     overrun
> 
>  net/packet/af_packet.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index e0f3f4a..264d7b2 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2287,6 +2287,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		if (po->stats.stats1.tp_drops)
>  			status |= TP_STATUS_LOSING;
>  	}
> +
> +        /*
> +         * Mark this entry as TP_STATUS_IN_PROGRESS to prevent other
> +         * kernel threads from re-using this same entry.
> +         */
> +#define TP_STATUS_IN_PROGRESS TP_STATUS_LOSING
> +	if (po->tp_version <= TPACKET_V2)
> +            __packet_set_status(po, h.raw, TP_STATUS_IN_PROGRESS);
> +
>  	po->stats.stats1.tp_packets++;
>  	if (copy_skb) {
>  		status |= TP_STATUS_COPY;

This patch looks correct. Please resend it with proper signed-off-by
and with a kernel code indenting style (tabs).  Is this bug present
since the beginning of af_packet and multiqueue devices or did it get
introduced in some previous kernel?
