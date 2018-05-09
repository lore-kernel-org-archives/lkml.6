Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AB8JxZquhWduC0cXxgDP+d/aZ0AagIXTqF5Z3otumH4yyx/24+zugjy+qrsNytBVa7xOWSrnzj2N
ARC-Seal: i=1; a=rsa-sha256; t=1525908029; cv=none;
        d=google.com; s=arc-20160816;
        b=JTHLNfyGxm3oeUkpFHTc/qIm/8/oES2MA6T2N8qRBs4DuXVjKA1eYMBb4TcuryKqb8
         M5YkA0qNWpzqix9zN/9Jz+ck0DRhR5zM4ZGt3sRa907SInXTpcmDSnNhzYFbE6t5SOV8
         xDSa7Tl94wxKABHMGP8M+bkbsfcq5a1nLx86MqiPCA0pET5p9v5FXkwGJExOBpn1s9wP
         hLPERXj9Y2gF8TTlt1ILaBUXe6ApR3kqdghDtXqnvpWZaJ4MCvUE4Y9ZuUbECfaVMES1
         Ky71teKg4iVzegE21Quz0BoM4BTm18b7RPtE5Dt+zt2XfLJzBUFUCTu5oW93TMwj90pj
         3tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=T4wF8U34VkSeGfIoWrZ5D0JWOFBxC1tPRtvHQFSlCaw=;
        b=dI8qWceY3KrYca+mySgqc6W9tmQBhVWVoljD6Rv1SvV+oZXJoQ0W6jy7qQhywNsFgf
         xyzdN+EszcYCu3eIT1jbcOhmXEuGxkBMJTnd5+M+gTS40DQgNP6Epf/T8ktiIgCp3lj1
         JRCVtWxTKjmRKFJpej0W7fBsCrZUZcvl1H6y9pULy+MZLxYO+Vk7mvAjZMjL2ikxhskU
         BIhBLOyUovMao6KEQ2CAXgaXcQHXsvBJ1etO9Y5RLr4IyMwwJe6hplXwppDQ6ms0mqyC
         NfnC4f9MDeWrMwvDpVvlN3YTS9Is6ifpIZHDrIBTRHLC6TmBWM5E1jAXPkyEhxK3gqNa
         4w9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Wed, 9 May 2018 16:20:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rakib Mullick <rakib.mullick@gmail.com>, "'linux-kernel@vger.kernel.org'"
 <linux-kernel@vger.kernel.org>
Subject: Re: for_each_cpu()  is buggy for UP kernel?
Message-Id: <20180509162027.95ffa21312f7363d13d5ea1e@linux-foundation.org>
In-Reply-To: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1600030537829045120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 9 May 2018 06:24:16 +0000 Dexuan Cui <decui@microsoft.com> wrote:

> In include/linux/cpumask.h, for_each_cpu is defined like this for UP kernel (CONFIG_NR_CPUS=1):
> 
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
> 
> Here 'mask' is ignored, but what if 'mask' contains 0 CPU? -- in this case, the for loop should not
> run at all, but with the current code, we run the loop once with cpu==0.
> 
> I think I'm seeing a bug in my UP kernel that is caused by the buggy for_each_cpu():
> 
> in kernel/time/tick-broadcast.c: tick_handle_oneshot_broadcast(), tick_broadcast_oneshot_mask
> contains 0 CPU, but due to the buggy for_each_cpu(), the variable 'next_event' is changed from
> its default value KTIME_MAX to "next_event = td->evtdev->next_event"; as a result,
> tick_handle_oneshot_broadcast () -> tick_broadcast_set_event() -> clockevents_program_event()
> -> pit_next_event() is programming the PIT timer by accident, causing an interrupt storm of PIT
> interrupts in some way: I'm seeing that the kernel is receiving ~8000 PIT interrupts per second for
> 1~5 minutes when the UP kernel boots, and it looks the kernel hangs, but in 1~5 minutes, finally
> somehow the kernel can recover and boot up fine. But, occasionally, the kernel just hangs there
> forever, receiving ~8000 PIT timers per second. 
> 
> With the below change in kernel/time/tick-broadcast.c, the interrupt storm will go away:
> 
> +#undef for_each_cpu
> +#define for_each_cpu(cpu, mask)                        \
> +       for ((cpu) = 0; (((cpu) < 1) && ((mask)[0].bits[0] & 1)); (cpu)++, (void)mask)
> 
> Should we fix the for_each_cpu() in include/linux/cpumask.h for UP?

I think so, yes.  That might reveal new peculiarities, but such is life.

I guess we should use bitmap_empty() rather than open-coding it.
