Return-Path: <willemdebruijn.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525882326; cv=none;
        d=google.com; s=arc-20160816;
        b=ybJovT//K3B4JKqJ9hhEc92On9i1cU/cRO6TvPBp/cqRmhs8BcyGd67lTH4vqmmsyr
         +d2JfaBmuTaArdeDHISU6bba8+I486wZR47etDc9AlV1Sr/9kx6uEhG/U7ASFV8YZNWw
         b67dM+eYFl5WORjMUpkVmNoYXe3gQBDFaEroq7mJaIpkWBywya/SodDIUF8MOxnwtOxh
         koyG4Y3ZxvN/Lf5x82t2Qm3Lck21gG0i4FKlJqWS01PuLZcyzeWxiXK0qxD2PL30m6GA
         uuhj7d2IsAsACJrUXgkLJ0SAO89L5HeAa/TdNjZBhZqRmBQamHYvwffB0Tl9ijq9U1av
         FKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=sNoddvFokU5OQf/EACgG0Dl7RrTLtu192Q5ap+EEXuA=;
        b=NlxVwyCLtoRcOw4Wj6Jgs7MpquJj9GW39pimYawzQXHnSeh4Smx4bqMMn9VykObg7c
         WShIz0imRW+Nq8JlYTkx/gAXrxFgTTY0eUQGUKi5eJ1reu/n7SELsqOBpjhl4fGe9saF
         BWZqYF9eMKdb7GZ4ZRLUti+iVNoHhDObR/Xd6SUYZnQckdAzpD+lfPlNSNRH4oZa67W0
         TZp51BCtvkJCrr/S5ok1iqjLq/zz0pZ01mFXSklrZBDpx0RAmqTpKZ4LDDnHACLDarMM
         pY1w/l02e2NwPM21L6tHALwxXmXJYq92qnx+Kbuuc9fQo9Taj95LMQ+OkhhY+pQtKxMy
         bOAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RNEtzlyx;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RNEtzlyx;
       spf=pass (google.com: domain of willemdebruijn.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=willemdebruijn.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqqDsL5FpH6vpx/StMY/w0qBINVOdoqyzPoHnQjzW5+/nMUwo2IRSWLPhkcUg0iHcoQWHIe9s+9Sg55Rd6BRCs=
MIME-Version: 1.0
In-Reply-To: <20180509073754.GG711@sol.localdomain>
References: <94eb2c0ce3aa27cfa40561ec2dc3@google.com> <CANn89iLEt2e0X-zj0f_05R-oN7sX7fKUWbNz_DJSeKXJMSwUBQ@mail.gmail.com>
 <1515048794.131759.4.camel@gmail.com> <20180509073754.GG711@sol.localdomain>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 9 May 2018 12:11:25 -0400
Message-ID: <CAF=yD-Je0ej2XDcfyEKano4R-og5oGjPvP36X4dSmpYshzBuKA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __dev_queue_xmit
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com>,
	alexander.deucher@amd.com, Andrey Konovalov <andreyknvl@google.com>,
	Anoob Soman <anoob.soman@citrix.com>, chris@chris-wilson.co.uk,
	David Miller <davem@davemloft.net>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>, Mike Maloney <maloney@google.com>, mchehab@kernel.org,
	netdev <netdev@vger.kernel.org>, "Rosen, Rami" <rami.rosen@intel.com>,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, syzkaller-bugs@googlegroups.com,
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588636556567233283?=
X-GMAIL-MSGID: =?utf-8?q?1600003586944703621?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 3:37 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jan 03, 2018 at 10:53:14PM -0800, Eric Dumazet wrote:
>> On Wed, 2018-01-03 at 21:13 -0800, Eric Dumazet wrote:
>> > Note: all commands must start from beginning of the line in the email body.
>> >
>> > I guess skb_probe_transport_header() should be hardened to reject malicious
>> > packets given by user space, instead of being gentle.
>>
>> Although bug triggered for this particular repro is in flow dissector
>> :/
>>
>> I will test :
>>
>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> index 15ce300637650e17fcab7e378b20fe7972686d46..544bddf08e13c7f6e47aadc737244c9ba5af56b2 100644
>> --- a/net/core/flow_dissector.c
>> +++ b/net/core/flow_dissector.c
>> @@ -976,8 +976,8 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>>  out_good:
>>         ret = true;
>>
>> -       key_control->thoff = (u16)nhoff;
>>  out:
>> +       key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
>>         key_basic->n_proto = proto;
>>         key_basic->ip_proto = ip_proto;
>>
>> @@ -985,7 +985,6 @@ bool __skb_flow_dissect(const struct sk_buff *skb,
>>
>>  out_bad:
>>         ret = false;
>> -       key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
>>         goto out;
>>  }
>>  EXPORT_SYMBOL(__skb_flow_dissect);
>
> Fix for this was commit d0c081b49137cd:
>
> #syz fix: flow_dissector: properly cap thoff field
>
> But a crash with the same signature is still occurring, so it should eventually
> get reported again.  C reproducer is here, it works on Linus' tree (commit
> 036db8bd963): https://syzkaller.appspot.com/text?tag=ReproC&x=105b1ae7800000

This appears to be a separate issue.

This reproducer requires a setsockopt SOL_SOCKET/SO_TIMESTAMPING
to trigger the use-after-free. And the freed path also points at a timestamping
skb:

[   31.963619] Freed by task 2672:
[   31.964006]  __kasan_slab_free+0x125/0x170
[   31.964509]  kfree+0x8b/0x1a0
[   31.964875]  skb_free_head+0x6f/0xa0
[   31.965314]  skb_release_data+0x420/0x5a0
[   31.965802]  skb_release_all+0x46/0x60
[   31.966260]  kfree_skb+0x91/0x1c0
[   31.966669]  __skb_complete_tx_timestamp+0x2e9/0x3d0
[   31.967273]  __skb_tstamp_tx+0x3b3/0x620
[   31.967774]  __dev_queue_xmit+0xed5/0x1a20
[   31.968300]  packet_sendmsg+0x36fd/0x5400
[   31.968821]  sock_sendmsg+0xc0/0x100
[   31.969284]  ___sys_sendmsg+0x367/0x880
[   31.969777]  __sys_sendmmsg+0x178/0x410
[   31.970267]  __x64_sys_sendmmsg+0x99/0x100
[   31.970789]  do_syscall_64+0x9a/0x2c0
[   31.971260]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

The data skb itself is zero bytes, it appears.
