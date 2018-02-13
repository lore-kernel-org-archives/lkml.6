Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x226J6zpgOkeCO8Zq0NotpUqvAzU5ystWrdVeyrPmmgOVmKzQ7DI5AUbQAZSFEG3OtmORIA+a
ARC-Seal: i=1; a=rsa-sha256; t=1518538366; cv=none;
        d=google.com; s=arc-20160816;
        b=jkr4/VJT0XsltBD6pS2CMb5ZiLco2i916QUc6vgXGIkw3gS9iCvNRA60fcekHSCO0K
         scauwMvNSU9+8lpxXXaCyIDtPXIBxNs4h4q6ODTYz0uNowZ/biHoHMIRF2uDP08fGeTv
         PfqMVzeoUY4ZEY/2PAT7KDLQqINmhAFdoxRowC8+HJtuSpMB+//MqSbPcDjbfc5F0ZP7
         +YnEyDliQpcL5BCFwrUpy9SdohkyZOBdwjZWlMDAFJ39TCf5cIjSE05gDTPRyW2cZPge
         dVPcvgtVIjhEhLG2ex3t3QTePXF3Kd6hLuUOik7LyYwO8PL4is5m/zgHYBatHpwZCVso
         wShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=qxglXru7chsQYzFkVctFcGD8dEsQVAhqbBLYyDDW9/Q=;
        b=H0ViaYcPmg0+i3i8KrMB3TbL4Sbwro7OqhTEJaGYnHhfoV1rchg1LhDyAILv3VgCfQ
         jgU5pHMgbOPi3Z98qxIe1YRMTaC3yErfYS7/Mz9GDogpB7sxEQHbhSDqu2tMykdiV/9H
         KYMWlY6VLrDn5hCvmZaX6LRptZOd23B/utcDEnehuDcYIhgHYlgjsflZgum1qk2i0bqe
         X1WNXmMV/oUib2QdhPQpNrwR7VcOAq8DHBJk/K0FHPTCGiNrzr2VY4zI/m35kdgbJUV1
         KDLJrk2AU4850+bKbHYi9+qn/vlWSMW2hmYdzhUyXHeolYBubA2084qQ/Ct39f7O6HzT
         hXww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Tue, 13 Feb 2018 17:12:08 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
cc: Jia-Ju Bai <baijiaju1990@gmail.com>, mingo@redhat.com, hpa@zytor.com,
    jgross@suse.com, douly.fnst@cn.fujitsu.com, kkamagui@gmail.com,
    gregkh@linuxfoundation.org, mka@chromium.org, linux-kernel@vger.kernel.org,
    x86@kernel.org
Subject: Re: [PATCH] kernel: x86: apic: Replace GFP_ATOMIC with GFP_KERNEL
 in __add_pin_to_irq_node
In-Reply-To: <20180213155604.62ulolc34snh5n3p@gmail.com>
Message-ID: <alpine.DEB.2.21.1802131705050.1130@nanos.tec.linutronix.de>
References: <1516758015-7236-1-git-send-email-baijiaju1990@gmail.com> <20180213155604.62ulolc34snh5n3p@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590435774374304646?=
X-GMAIL-MSGID: =?utf-8?q?1592302885771068374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018, Ingo Molnar wrote:
> * Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> 
> > The function __add_pin_to_irq_node is not called in atomic context.
> > Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> > 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > ---
> >  arch/x86/kernel/apic/io_apic.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> > index 201579d..665c013 100644
> > --- a/arch/x86/kernel/apic/io_apic.c
> > +++ b/arch/x86/kernel/apic/io_apic.c
> > @@ -379,7 +379,7 @@ static int __add_pin_to_irq_node(struct mp_chip_data *data,
> >  		if (entry->apic == apic && entry->pin == pin)
> >  			return 0;
> >  
> > -	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
> > +	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_KERNEL, node);
> >  	if (!entry) {
> >  		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
> >  		       node, apic, pin);
> 
> NAK: this is called in an atomic section: with IRQs disabled ...

The only invocation where this happens with IRQs disabled is the early
check_timer() code which runs _before_ the scheduler is working. GFP_KERNEL
is valid during that phase. All other call sites have interrupts enabled.

Thanks,

	tglx
