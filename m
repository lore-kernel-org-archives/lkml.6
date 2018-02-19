Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519034760; cv=none;
        d=google.com; s=arc-20160816;
        b=v0gvRnlfcG7FSVMiRHoZyNbWCCXEFuy6KQjS4NR3qSyL4fNMjTdzDMO8R4rxfCuYgw
         uT2a2vrzZVbBpjk91MqQxdJ5JK/nN7heyYI45ng4X3HGldS+tlBVHlpp9SjbQ7PHhLF/
         V8tlVq/9VTAGaZT4r8+BNkcTrPrmJgZLA1adZH31otH82XRw05QbpRHbXYvJB4Dty3od
         zA6MxhxJjDthnjsHv0CedHkL1o55eo8Bmf2JqxmTCRBzxHSVg1A5nC3YPa3KXqMV1+1f
         tF+dnvgJTEg95juIn67Nq7dkIivScGhXQ/dCoRRCz+S4OHsm1Kp7SmX1WaCg0Pv91Z/w
         SHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=SPC00nc0wJNoggUNnsb1JBG5dynpClCczFFObF/VcZk=;
        b=gseW5m3QvGZBMwXEFTlYGrK7uvnhe599nw8E5yswCxGmjU5+UQE3Ta4eDHIb9+OSsL
         3jkDMdYsRWmULeqwq2qGTwplO9ZaPNce7VcrgDStE2lRVLjjioS9Z9O/3DPS9FZnPioJ
         YS8JflGRQZ/3pkK4ccsfeC1YIuDDAYa9bUFSfyQMXjRYoqsAsajcMrdu6FBkiYnRMb5s
         hYzN6c4b24tyQEXesfuL1WqjdkDygk1S26ODovxjZCtWTp1d+noE7ZcHfwG3/+ZO6/aj
         n5vTWHhIDlzuqyxrmFdNMjTdbYhNRgICZpKfhdXLRSp8homAUVxPOPCtDff2FgHk62vA
         l6Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ewQpdo2v;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ewQpdo2v;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x226BqqZWgksCigpFmbtlps7ABWJsks6BjVhmb/0+8n2WX89WLLIy7RFrUL9DQtIP7qyVe95YcIpgRsjQQRaKOQ4=
MIME-Version: 1.0
In-Reply-To: <20180219072243.vk7ow4gdpqhz5gbp@gauss3.secunet.de>
References: <001a1141ba9ea381f70565057687@google.com> <CACT4Y+Z-iMWQccvthBAb2Ze4GjkVAm-B7m=b+KYg8AqEn4gw1Q@mail.gmail.com>
 <CACT4Y+aHScQyOybzx22irqKE+B=xU79+zfgSnjCHZT6gqF89Hw@mail.gmail.com> <20180219072243.vk7ow4gdpqhz5gbp@gauss3.secunet.de>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 19 Feb 2018 11:05:38 +0100
Message-ID: <CACT4Y+ZNFC0sBUd+ikf64N6vv26v-GcqD+M2p7q=gDDw-LkBQQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in xfrm_confirm_neigh
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: syzbot <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com>,
	dzickus@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, npiggin@gmail.com,
	Philippe Ombredanne <pombredanne@nexb.com>, syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, "the arch/x86 maintainers" <x86@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>,
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592209203961806699?=
X-GMAIL-MSGID: =?utf-8?q?1592823392286243842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 8:22 AM, Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>> > <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com> wrote:
>> >> Hello,
>> >>
>> >> syzbot hit the following crash on net-next commit
>> >> 9515a2e082f91457db0ecff4b65371d0fb5d9aad (Thu Jan 25 03:37:38 2018 +0000)
>> >> net/ipv4: Allow send to local broadcast from a socket bound to a VRF
>> >>
>> >> So far this crash happened 6 times on net-next.
>> >> Unfortunately, I don't have any reproducer for this crash yet.
>> >> Raw console output is attached.
>> >> compiler: gcc (GCC) 7.1.1 20170620
>> >> .config is attached.
>> >
>> >
>> > +xfrm maintainers
>>
>> Here is a C repro:
>> https://gist.githubusercontent.com/dvyukov/92c67ba9afaaa960bcfbdc6ef549ac10/raw/786f9221c1d707c7f4a15effcb1d5997dd4f8638/gistfile1.txt
>
> Seems like syzbot does not know about this reproducer.
>
> I've send a patch to test and got this as the reply:
>
> This crash does not have a reproducer. I cannot test it.

Yes, it does not know about the reproducer. I've extracted it
manually, these hangs are sometimes hard to reproduce. For syzbot this
bug does not have a reproducer.
Have you tried to run the reproducer? For me it reproduced the bug
quite reliably.
