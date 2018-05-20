Return-Path: <willemdebruijn.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526858581; cv=none;
        d=google.com; s=arc-20160816;
        b=ls+6RxacEE2fkz5mK4RumBapRwuXNncN8J6oi1s1LYUvpUaFrEP5a52Pwjc19Dt/I9
         Vfjy/+MJNyfIsqwsk99M+ECecu/kuJsTTzOMZlWQ3Y6qsHUm7E89iPIhDiQSNxd79i7q
         ACCM7DJBqLBURrqe+CSmykOwpod48XRXZw8kWMG7w912jsEsRL7Khdl9FDR3zefG02CX
         CGcwvmGyksoNDUdDokFOtBsidI28yauxx42PoxW+aqmzEvCrTvLzwKbk5HgHHF+OZnRz
         wlBBU2n0yG8Hl2wFxyIkcYycu2mY89QOEg8GETwPawdbOpZoU9La/60bkWZlyZB+IGdc
         7sQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DUrdLBjhaGOOJGCMkUJ1QCbYL0VDHM7YCP5g+XOL+R0=;
        b=NgwZ20LMUo82u+OeDWzPERvoh+4i1HZSjl4gC/8odS6vTSa/9Nn8O2CiCP6S/oWgI3
         YXxCAVYXFpl7+1/I8RNmquIyxgSvk/A3C4rGLdOtKgEWTMQuBGExEloAob1kUVXsy/Gb
         bBKAyZ6Boh/I4Dt/u9ZclQelOWP81KUs5e3igpa1+BGFzPmwhOkAuGiQbrbWeH2mf5Ze
         XpkYDlvHn3q/LHcMsHWo7uBlaL2vd7QvKmCeLvY6t4iP/oKEq/hIUNi6feiiNXhCLfos
         ZFsEvp2crmcDbYp5MSIVfgj07EP9dv34sZFSmPQi/hxDLUMtwbYEEP3RwVAhysxrsqSE
         oFDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HDDX4Zig;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HDDX4Zig;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpDVKg0b3sGGasHfsUeQ95sfqiXHWjp9yuJg8fQu3Fel2uOLqSJATDUp4qiTaMrAh0ub9mOJaDuPWLhuwgccuU=
MIME-Version: 1.0
In-Reply-To: <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com> <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 20 May 2018 19:22:20 -0400
Message-ID: <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
Subject: Re: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
To: Jon Rosen <jrosen@cisco.com>
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
X-GMAIL-MSGID: =?utf-8?q?1601027264374088385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 20, 2018 at 6:51 PM, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Sat, May 19, 2018 at 8:07 AM, Jon Rosen <jrosen@cisco.com> wrote:
>> Fix PACKET_RX_RING bug for versions TPACKET_V1 and TPACKET_V2 which
>> casues the ring to get corrupted by allowing multiple kernel threads
>> to claim ownership of the same ring entry. Track ownership in a shadow
>> ring structure to prevent other kernel threads from reusing the same
>> entry before it's fully filled in, passed to user space, and then
>> eventually passed back to the kernel for use with a new packet.
>>
>> Signed-off-by: Jon Rosen <jrosen@cisco.com>
>> ---
>>
>> There is a bug in net/packet/af_packet.c:tpacket_rcv in how it manages
>> the PACKET_RX_RING for versions TPACKET_V1 and TPACKET_V2.  This bug makes
>> it possible for multiple kernel threads to claim ownership of the same
>> ring entry, corrupting the ring and the corresponding packet(s).
>>
>> These diffs are the second proposed solution, previous proposal was described
>> in https://www.mail-archive.com/netdev@vger.kernel.org/msg227468.html
>> subject [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
>> to prevent RX ring overrun
>>
>> Those diffs would have changed the binary interface and have broken certain
>> applications. Consensus was that such a change would be inappropriate.
>>
>> These new diffs use a shadow ring in kernel space for tracking intermediate
>> state of an entry and prevent more than one kernel thread from simultaneously
>> allocating a ring entry. This avoids any impact to the binary interface
>> between kernel and userspace but comes at the additional cost of requiring a
>> second spin_lock when passing ownership of a ring entry to userspace.
>>
>> Jon Rosen (1):
>>   packet: track ring entry use using a shadow ring to prevent RX ring
>>     overrun
>>
>>  net/packet/af_packet.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  net/packet/internal.h  | 14 +++++++++++
>>  2 files changed, 78 insertions(+)
>>
>
>> @@ -2383,7 +2412,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>  #endif
>>
>>         if (po->tp_version <= TPACKET_V2) {
>> +               spin_lock(&sk->sk_receive_queue.lock);
>>                 __packet_set_status(po, h.raw, status);
>> +               packet_rx_shadow_release(rx_shadow_ring_entry);
>> +               spin_unlock(&sk->sk_receive_queue.lock);
>> +
>>                 sk->sk_data_ready(sk);
>
> Thanks for continuing to look at this. I spent some time on it last time
> around but got stuck, too.
>
> This version takes an extra spinlock in the hot path. That will be very
> expensive. Once we need to accept that, we could opt for a simpler
> implementation akin to the one discussed in the previous thread:
>
> stash a value in tp_padding or similar while tp_status remains
> TP_STATUS_KERNEL to signal ownership to concurrent kernel
> threads. The issue previously was that that field could not atomically
> be cleared together with __packet_set_status. This is no longer
> an issue when holding the queue lock.
>
> With a field like tp_padding, unlike tp_len, it is arguably also safe to
> clear it after flipping status (userspace should treat it as undefined).
>
> With v1 tpacket_hdr, no explicit padding field is defined but due to
> TPACKET_HDRLEN alignment it exists on both 32 and 64 bit
> platforms.
>
> The danger with using padding is that a process may write to it
> and cause deadlock, of course. There is no logical reason for doing
> so.

For the ring, there is no requirement to allocate exactly the amount
specified by the user request. Safer than relying on shared memory
and simpler than the extra allocation in this patch would be to allocate
extra shadow memory at the end of the ring (and not mmap that).

That still leaves an extra cold cacheline vs using tp_padding.
