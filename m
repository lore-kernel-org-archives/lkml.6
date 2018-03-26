Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AG47ELt7cHqzlABJiEIl53Um9I+/KAxgxi+iZ8sbdFWFybsk0VbptC6Mxt1a6m3X9peaUKNl0owB
ARC-Seal: i=1; a=rsa-sha256; t=1522093950; cv=none;
        d=google.com; s=arc-20160816;
        b=bub/veihsXj8w5sLhqwV0B9ISkQR4OITGAbCB1kJZBcVAfdoH45ahF+TPHjUPhlm4p
         WNx8+5lozuK5081+6objYf/lrU0dTDI/33Qb9Gx6fYmoFajvJJyqxe1yN/dNVxR8lkq1
         u2jtiSljQSaThQW0IqJY1/uxAKTaUrfmsu7OH85ehaqMzD3WSK+a0AUrGQhnjd26aWKJ
         Mp3xzWp1dpwavxa0eTKX3GmsC81jAPCc6biJQ6C1M8AwdtnGKRl6KYiy2MH4SXz7cRiz
         sV7oHAOzNmq//AaoXpzI1IPlAIL3si5Et3HETHLI0HgsPm4wBh5qgFVW3CzN8drr684c
         ffog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vGDwVZv4UHPohJ3wAm5JdwSUbe22IMYKd5Sba28lzEE=;
        b=UDFt0yv/5/90d7TxijjHh8inadtJobHmp3n9or2PmhXnzb9lfI9Rw8KWQ9F9bP/WZ6
         3QYbqS3TDZ3fnxCWE39Zgat3onnNPEN3LFd3l2hdgKMqSHefVXOa8SRhhe45Uy3UAs0x
         l2sJlvAZ9EEMAazsmD09UWtjPnLlpwdvgDkXMZqoJ4DdxwKYEjwb4y+9CgoupQthGNMi
         NLnqNuE1ug5u0x1W9Ya+8XFTBvaWUBOJOYbrqnhYv0ilFFpG7jj7DaBqubWAy9OZ//SG
         gqkmJjEQe7KUDkq+W2c452yDuOUq36O7rXHJHQOBv079akqfYuYksWFgvkKRwS+g1S1N
         U4yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Mon, 26 Mar 2018 12:52:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: v.narang@samsung.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Maninder Singh
 <maninder1.s@samsung.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Kate Stewart
 <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Michal Hocko <mhocko@suse.com>,
 "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>, "gomonovych@gmail.com"
 <gomonovych@gmail.com>, Ayush Mittal <ayush.m@samsung.com>, LKML
 <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux-MM <linux-mm@kvack.org>, AMIT SAHRAWAT <a.sahrawat@samsung.com>,
 PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: [PATCH v2] mm/page_owner: ignore everything below the IRQ entry
 point
Message-Id: <20180326125228.1f40abb9a52f3674b1491aea@linux-foundation.org>
In-Reply-To: <20180326141717epcms5p4064a0fd4f594b2ff434f9b05cd1ea5ad@epcms5p4>
References: <CACT4Y+Yfx+fTHyQ=d3T68bwfgQQsmqd+e72V67kaAHajo536JA@mail.gmail.com>
	<1522058304-35934-1-git-send-email-maninder1.s@samsung.com>
	<CGME20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41@epcms5p4>
	<20180326141717epcms5p4064a0fd4f594b2ff434f9b05cd1ea5ad@epcms5p4>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595993933133123096?=
X-GMAIL-MSGID: =?utf-8?q?1596031186634468024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Mar 2018 19:47:17 +0530 Vaneet Narang <v.narang@samsung.com> wrote:

> Hi Dmitry,
> 
> >Every user of stack_depot should filter out irq frames, without that
> >stack_depot will run out of memory sooner or later. so this is a
> >change in the right direction.
> > 
> >Do we need to define empty version of in_irqentry_text? Shouldn't only
> >filter_irq_stacks be used by kernel code?
> 
> We thought about this but since we were adding both the APIs filter_irq_stacks & in_irqentry_text 
> in header file so we thought of defining empty definition for both as both the APIs are accessible
> to the module who is going to include header file.
> 
> If you think empty definition of in_irqentry_text() is not requited then we will modify & resend the
> patch.
> 

filter_irq_stacks() is too large to be inlined.

The CONFIG_STACKTRACE=n versions should be regular C functions, not
macros.  But stacktrace.c decided to do them all as macros,
unfortunately.

in_irqentry_text() is probably too large to be inlined as well, and
should return bool.

Declarations for __irqentry_text_start and friends already exist in
include/asm-generic/sections.h (and, for some reason, also in
arch/arm/include/asm/traps.h) and should not be duplicated in
include/linux/stacktrace.h.
