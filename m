Return-Path: <willemdebruijn.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526922468; cv=none;
        d=google.com; s=arc-20160816;
        b=xP9XJkrTiWtIAvTEy4Rxp9dazj3RURjmuQY6kTScmQoY/Cs6NcZ4uOsKx3coO/iUc/
         iSROEPUXxdv0k8/13yqVzauwKoBh+67q18yoY1waaI290FbW4f65AjGG2SDjMcDDwrDi
         eMShPtuzB4+7BE/QJvPyvR4x44qOvlo89qxm8E/5gtNDeX4e+XkN1gYaSsVivZnKeSmt
         8u9mBlqIydFCD/vyVNhprGrKvGUY2SsUprQAxwYZPE8U7kOG2+luAKfbsS2qx8CWoSpm
         /DdO4th58vYGqwhtlf2lvoh6a6FSKzCFbdsL4utkrm+QRUS9M6djl7kDzTmDDzxIKPDv
         7F5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Gsyc3Qzc6ghGgqw/ldGZrbjMIpE7sxZKyyK1s4k0+i4=;
        b=ogSbHsPZzKN56RSH+JQLBFA06dVv4u3YP+g2vximL07NqxEzxhPbRgzCpSmuzMuCdO
         yYvN9SbHWBxRB8Ggkpa7HuTDUzGKTACbtNVsn1lOZgRP1ik92TMXSkERTrfQY4Tp8CVi
         D1pxpir7qH8TEr/h9H2LIqJB8i+ZhE9nGYHA/JYuYTRDsAQ9wm6CHBFWibW0lK6+zLf4
         jFKS1NdU7/Au9wA9udfUpFSz6yhrh/K1+5CMI2seePHYo5SGQONxOm4C+2Bif3LC4LJ9
         43Cqh5dmmoyCdQkryV6yqS/f/vS4NXayOINk/xbAAavakb97VKeWQyd1tkYanuawko8d
         UkTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FgieNask;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FgieNask;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoOc/bWSk9cDAZOrrjiaOCTFcznYbczccwSKwh6r0eBKtpxrWlXdWZgR4Mx50dXFM2ke1WQgtX5L8lCPB6LiMo=
MIME-Version: 1.0
In-Reply-To: <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com> <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 21 May 2018 13:07:06 -0400
Message-ID: <CAF=yD-Kfto4jJYMFzn=PV8OYdhEmdNfW+aakDhRMzRBWhWY0UQ@mail.gmail.com>
Subject: Re: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
To: "Jon Rosen (jrosen)" <jrosen@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
	David Windsor <dwindsor@gmail.com>, "Rosen, Rami" <rami.rosen@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>, Mike Maloney <maloney@google.com>,
	Benjamin Poirier <bpoirier@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600894186810885957?=
X-GMAIL-MSGID: =?utf-8?q?1601094254075710562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 8:57 AM, Jon Rosen (jrosen) <jrosen@cisco.com> wrote:
> On Sunday, May 20, 2018 7:22 PM, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>> On Sun, May 20, 2018 at 6:51 PM, Willem de Bruijn
>> <willemdebruijn.kernel@gmail.com> wrote:
>>> On Sat, May 19, 2018 at 8:07 AM, Jon Rosen <jrosen@cisco.com> wrote:
>>>> Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
>>>> casues the ring to get corrupted by allowing multiple kernel threads
>>>> to claim ownership of the same ring entry. Track ownership in a shadow
>>>> ring structure to prevent other kernel threads from reusing the same
>>>> entry before it's fully filled in, passed to user space, and then
>>>> eventually passed back to the kernel for use with a new packet.
>>>>
>>>> Signed-off-by: Jon Rosen <jrosen@cisco.com>
>>>> ---
>>>>
>>>> There is a bug in net/packet/af_packet.c:tpacket_rcv in how it manages
>>>> the PACKET_RX_RING for versions TPACKET_V1 and TPACKET_V2.  This bug makes
>>>> it possible for multiple kernel threads to claim ownership of the same
>>>> ring entry, corrupting the ring and the corresponding packet(s).
>>>>
>>>> These diffs are the second proposed solution, previous proposal was described
>>>> in https://www.mail-archive.com/netdev@vger.kernel.org/msg227468.html
>>>> subject [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
>>>> to prevent RX ring overrun
>>>>
>>>> Those diffs would have changed the binary interface and have broken certain
>>>> applications. Consensus was that such a change would be inappropriate.
>>>>
>>>> These new diffs use a shadow ring in kernel space for tracking intermediate
>>>> state of an entry and prevent more than one kernel thread from simultaneously
>>>> allocating a ring entry. This avoids any impact to the binary interface
>>>> between kernel and userspace but comes at the additional cost of requiring a
>>>> second spin_lock when passing ownership of a ring entry to userspace.
>>>>
>>>> Jon Rosen (1):
>>>>   packet: track ring entry use using a shadow ring to prevent RX ring
>>>>     overrun
>>>>
>>>>  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  net/packet/internal.h  | 14 +++++++++++
>>>>  2 files changed, 78 insertions(+)
>>>>
>>>
>>>> @@ -2383,7 +2412,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>>>  #endif
>>>>
>>>>         if (po->tp_version <= TPACKET_V2) {
>>>> +               spin_lock(&sk->sk_receive_queue.lock);
>>>>                 __packet_set_status(po, h.raw, status);
>>>> +               packet_rx_shadow_release(rx_shadow_ring_entry);
>>>> +               spin_unlock(&sk->sk_receive_queue.lock);
>>>> +
>>>>                 sk->sk_data_ready(sk);
>>>
>>> Thanks for continuing to look at this. I spent some time on it last time
>>> around but got stuck, too.
>>>
>>> This version takes an extra spinlock in the hot path. That will be very
>>> expensive. Once we need to accept that, we could opt for a simpler
>>> implementation akin to the one discussed in the previous thread:
>>>
>>> stash a value in tp_padding or similar while tp_status remains
>>> TP_STATUS_KERNEL to signal ownership to concurrent kernel
>>> threads. The issue previously was that that field could not atomically
>>> be cleared together with __packet_set_status. This is no longer
>>> an issue when holding the queue lock.
>>>
>>> With a field like tp_padding, unlike tp_len, it is arguably also safe to
>>> clear it after flipping status (userspace should treat it as undefined).
>>>
>>> With v1 tpacket_hdr, no explicit padding field is defined but due to
>>> TPACKET_HDRLEN alignment it exists on both 32 and 64 bit
>>> platforms.
>>>
>>> The danger with using padding is that a process may write to it
>>> and cause deadlock, of course. There is no logical reason for doing
>>> so.
>>
>> For the ring, there is no requirement to allocate exactly the amount
>> specified by the user request. Safer than relying on shared memory
>> and simpler than the extra allocation in this patch would be to allocate
>> extra shadow memory at the end of the ring (and not mmap that).
>>
>> That still leaves an extra cold cacheline vs using tp_padding.
>
> Given my lack of experience and knowledge in writing kernel code
> it was easier for me to allocate the shadow ring as a separate
> structure.  Of course it's not about me and my skills so if it's
> more appropriate to allocate at the tail of the existing ring
> then certainly I can look at doing that.
>
> I think the bigger issues as you've pointed out are the cost of
> the additional spin lock and should the additional state be
> stored in-band (fewer cache lines) or out-of band (less risk of
> breaking due to unpredictable application behavior).

We don't need the spinlock if clearing the shadow byte after
setting the status to user.

Worst case, user will set it back to kernel while the shadow
byte is not cleared yet and the next producer will drop a packet.
But next producers will make progress, so there is no deadlock
or corruption.

It probably does require a shadow structure as opposed to a
padding byte to work with the long tail of (possibly broken)
applications, sadly.

A setsockopt for userspace to signal a stricter interpretation of
tp_status to elide the shadow hack could then be considered.
It's not pretty. Either way, no full new version is required.

> As much as I would like to find a solution that doesn't require
> the spin lock I have yet to do so. Maybe the answer is that
> existing applications will need to suffer the performance impact
> but a new version or option for TPACKET_V1/V2 could be added to
> indicate strict adherence of the TP_STATUS_USER bit and then the
> original diffs could be used.
>
> There is another option I was considering but have yet to try
> which would avoid needing a shadow ring by using counter(s) to
> track maximum sequence number queued to userspace vs. the next
> sequence number to be allocated in the ring.  If the difference
> is greater than the size of the ring then the ring can be
> considered full and the allocation would fail. Of course this may
> create an additional hotspot between cores, not sure if that
> would be significant or not.

Please do have a look, but I don't think that this will work in this
case in practice. It requires tracking the producer tail. Updating
the slowest writer requires probing each subsequent slot's status
byte to find the new tail, which is a lot of (by then cold) cacheline
reads.
