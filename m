Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeEUNHM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:07:12 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:6680 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeEUNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:07:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AaAQDQwQJb/4wNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYMUL2F9KAqDa4gEjHOBeYEPhwOMM4F4CyOESQIagX0hNBg?=
 =?us-ascii?q?BAgEBAQEBAQJsHAyFKAEBAQEDIwQNRRACAQgYAgImAgICHxEVEAIEDgUIE4M?=
 =?us-ascii?q?JgWcDFQ+mfoFpM4cHDYErggoFgQmHLIFUP4Qbgk9CA4E/AQE1gmmCVAKHG5E?=
 =?us-ascii?q?FLAkCi1aCd40FiimGJwIREwGBJAEcOIFScBWCfoJIgzSKUm8BAQGNeoEfgRg?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.49,426,1520899200";
   d="scan'208";a="395453787"
From: "Jon Rosen (jrosen)" <jrosen@cisco.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Mike Maloney" <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Topic: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Index: AQHT72oCSQesQH+wcU+iC1K5zWLMg6Q5fnUAgAAIkQCAAJ/kcA==
Date: Mon, 21 May 2018 12:57:30 +0000
Message-ID: <b7f6cc54a9f04132a279b15de0187ddd@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
In-Reply-To: <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.117.112.181]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LD7IfE007978

On Sunday, May 20, 2018 7:22 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Sun, May 20, 2018 at 6:51 PM, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>> On Sat, May 19, 2018 at 8:07 AM, Jon Rosen <jrosen@cisco.com> wrote:
>>> Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
>>> casues the ring to get corrupted by allowing multiple kernel threads
>>> to claim ownership of the same ring entry. Track ownership in a shadow
>>> ring structure to prevent other kernel threads from reusing the same
>>> entry before it's fully filled in, passed to user space, and then
>>> eventually passed back to the kernel for use with a new packet.
>>>
>>> Signed-off-by: Jon Rosen <jrosen@cisco.com>
>>> ---
>>>
>>> There is a bug in net/packet/af_packet.c:tpacket_rcv in how it manages
>>> the PACKET_RX_RING for versions TPACKET_V1 and TPACKET_V2.  This bug makes
>>> it possible for multiple kernel threads to claim ownership of the same
>>> ring entry, corrupting the ring and the corresponding packet(s).
>>>
>>> These diffs are the second proposed solution, previous proposal was described
>>> in https://www.mail-archive.com/netdev@vger.kernel.org/msg227468.html
>>> subject [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
>>> to prevent RX ring overrun
>>>
>>> Those diffs would have changed the binary interface and have broken certain
>>> applications. Consensus was that such a change would be inappropriate.
>>>
>>> These new diffs use a shadow ring in kernel space for tracking intermediate
>>> state of an entry and prevent more than one kernel thread from simultaneously
>>> allocating a ring entry. This avoids any impact to the binary interface
>>> between kernel and userspace but comes at the additional cost of requiring a
>>> second spin_lock when passing ownership of a ring entry to userspace.
>>>
>>> Jon Rosen (1):
>>>   packet: track ring entry use using a shadow ring to prevent RX ring
>>>     overrun
>>>
>>>  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  net/packet/internal.h  | 14 +++++++++++
>>>  2 files changed, 78 insertions(+)
>>>
>>
>>> @@ -2383,7 +2412,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>>  #endif
>>>
>>>         if (po->tp_version <= TPACKET_V2) {
>>> +               spin_lock(&sk->sk_receive_queue.lock);
>>>                 __packet_set_status(po, h.raw, status);
>>> +               packet_rx_shadow_release(rx_shadow_ring_entry);
>>> +               spin_unlock(&sk->sk_receive_queue.lock);
>>> +
>>>                 sk->sk_data_ready(sk);
>>
>> Thanks for continuing to look at this. I spent some time on it last time
>> around but got stuck, too.
>>
>> This version takes an extra spinlock in the hot path. That will be very
>> expensive. Once we need to accept that, we could opt for a simpler
>> implementation akin to the one discussed in the previous thread:
>>
>> stash a value in tp_padding or similar while tp_status remains
>> TP_STATUS_KERNEL to signal ownership to concurrent kernel
>> threads. The issue previously was that that field could not atomically
>> be cleared together with __packet_set_status. This is no longer
>> an issue when holding the queue lock.
>>
>> With a field like tp_padding, unlike tp_len, it is arguably also safe to
>> clear it after flipping status (userspace should treat it as undefined).
>>
>> With v1 tpacket_hdr, no explicit padding field is defined but due to
>> TPACKET_HDRLEN alignment it exists on both 32 and 64 bit
>> platforms.
>>
>> The danger with using padding is that a process may write to it
>> and cause deadlock, of course. There is no logical reason for doing
>> so.
>
> For the ring, there is no requirement to allocate exactly the amount
> specified by the user request. Safer than relying on shared memory
> and simpler than the extra allocation in this patch would be to allocate
> extra shadow memory at the end of the ring (and not mmap that).
>
> That still leaves an extra cold cacheline vs using tp_padding.

Given my lack of experience and knowledge in writing kernel code
it was easier for me to allocate the shadow ring as a separate
structure.  Of course it's not about me and my skills so if it's
more appropriate to allocate at the tail of the existing ring
then certainly I can look at doing that.

I think the bigger issues as you've pointed out are the cost of
the additional spin lock and should the additional state be
stored in-band (fewer cache lines) or out-of band (less risk of
breaking due to unpredictable application behavior).

As much as I would like to find a solution that doesn't require
the spin lock I have yet to do so. Maybe the answer is that
existing applications will need to suffer the performance impact
but a new version or option for TPACKET_V1/V2 could be added to
indicate strict adherence of the TP_STATUS_USER bit and then the
original diffs could be used.

There is another option I was considering but have yet to try
which would avoid needing a shadow ring by using counter(s) to
track maximum sequence number queued to userspace vs. the next
sequence number to be allocated in the ring.  If the difference
is greater than the size of the ring then the ring can be
considered full and the allocation would fail. Of course this may
create an additional hotspot between cores, not sure if that
would be significant or not.
