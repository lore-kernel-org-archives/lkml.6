Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518538623; cv=none;
        d=google.com; s=arc-20160816;
        b=ay888vhtdP2Guho/vdF3ojTrrYsXOKO4MPSZAHvYOL/pmvT7Cqe8J0g9Byo7vb2URt
         OjdvrMy9osg/SD8UGvaWZsYNwfva6Zrilvacl6+gu67lxVjnIIokt+n52RMHZuuUFrDy
         sCvcmJ4VLg/5dMUK6swCHCZld86qWg2dI8See5VgRYY2A7lDCad06pIaqnxWGZuZpY+h
         inaOIXo9Qb/Q0pbxa8gEg09O4pOeCA+wvoD7WIODigI+df0v/+Ep0FfniORdJ7ekki77
         8bLVK9ldnDMsawepUikwhSnv1S3H954TToYCIhtEFP6R4tlFo2JxSjYT1LDlANHpJ4Q0
         g54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=M24TwwPQ7cQgcqmevMAGtonpCmjVPHwUcpu6oAhwpCM=;
        b=YYWxcSh3sYMzfws/bftgQorCWVj5UoEomy17YZPi6a8vmM8QAFkUaF+vERA6CYi50R
         EPGR6znMaOmipqn5mIagtbFDOrnR7moaSLDXtupYHa56SKq9cTYmNsUJn6D48/d2ZkvA
         m1Y6UOgJ2cS5Q3AuQZV0DT4aZdC8wnE1ZJMsVHaCnc0LQxiVnkS8wNnA1Rmr6xMoUA74
         71mgWeYwyBq1LrHR6Uoowm++U9MqeIv/iShGe6t8zMfg0GZFEujSvF8yR9/kuV50EbIM
         i/puxG+k0mm0KSTDhJ/kkUydCxMf5Ad577Sa486284pEOOhT17S99IUtLwDGCrBkda86
         TL6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UBkMo82v;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UBkMo82v;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x224Bu+CFTkOWFWFRIM1BCQ3lehnG++rZsJHE3UrWMYW9fsUSBl1rZNaia1YD3GfEPeamYHxvnA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 13 Feb 2018 17:16:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, mingo@redhat.com, hpa@zytor.com,
	jgross@suse.com, douly.fnst@cn.fujitsu.com, kkamagui@gmail.com,
	gregkh@linuxfoundation.org, mka@chromium.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] kernel: x86: apic: Replace GFP_ATOMIC with GFP_KERNEL in
 __add_pin_to_irq_node
Message-ID: <20180213161659.aribhtrooupdv4m4@gmail.com>
References: <1516758015-7236-1-git-send-email-baijiaju1990@gmail.com>
 <20180213155604.62ulolc34snh5n3p@gmail.com>
 <alpine.DEB.2.21.1802131705050.1130@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802131705050.1130@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590435774374304646?=
X-GMAIL-MSGID: =?utf-8?q?1592303155542160983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 13 Feb 2018, Ingo Molnar wrote:
> > * Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> > 
> > > The function __add_pin_to_irq_node is not called in atomic context.
> > > Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> > > 
> > > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > > ---
> > >  arch/x86/kernel/apic/io_apic.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> > > index 201579d..665c013 100644
> > > --- a/arch/x86/kernel/apic/io_apic.c
> > > +++ b/arch/x86/kernel/apic/io_apic.c
> > > @@ -379,7 +379,7 @@ static int __add_pin_to_irq_node(struct mp_chip_data *data,
> > >  		if (entry->apic == apic && entry->pin == pin)
> > >  			return 0;
> > >  
> > > -	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
> > > +	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_KERNEL, node);
> > >  	if (!entry) {
> > >  		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
> > >  		       node, apic, pin);
> > 
> > NAK: this is called in an atomic section: with IRQs disabled ...
> 
> The only invocation where this happens with IRQs disabled is the early
> check_timer() code which runs _before_ the scheduler is working. GFP_KERNEL
> is valid during that phase. All other call sites have interrupts enabled.

Yeah, so at minimum there's a mismatch between the changelog:

> > > The function __add_pin_to_irq_node is not called in atomic context.

... and actual behavior. What you wrote should be part of the changelog I suspect.

Thanks,

	Ingo
