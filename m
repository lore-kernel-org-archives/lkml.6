Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x227trZPoWmBVvRLAL8PWNiVQY08DmMoipxL7MmYl91wlKr7ftGCfG+7dJ8V1Mmpbilb9fwip
ARC-Seal: i=1; a=rsa-sha256; t=1518538820; cv=none;
        d=google.com; s=arc-20160816;
        b=RjvUAXAubi1v67NQnLCBLSQqzXCWEcplYafozVxGYZoPOFMAPlCpyFbeKUURJ/bV2Y
         ObgCS77K59LDaTvGJ3K6ExTqfLfVBTl3Q30CeQ2iWFpHMrXU/kJjwOsgTEQvlZB6TrJq
         gJ4mZmQ7swulb5pyBnezn/gA0IXv+LR997pgc6E4C4PeG+q2/ODCld8ygmnkNpgMnNuZ
         p1mNHgOvoRBL+rKgozM+JaX3FdYUK95xjVA26bMUOCA41GVXVgb2oJwaxXkXgb36NCdp
         zQnuasGU58WkybJrzFk5tLvggH0MDn66oGAlBUAiZhXIbMZ3aAM8w1sOou0vRCh3zX0C
         9+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=gGdHBqC4X3mhiupYGZvUETzxn4pUaKfXbksop+82g6I=;
        b=RolXxap3N7O1fWD8wdyCEUdQNoqt4x/k86TE9x4IBnjRROX/MQLGyv/9dca3+1CxJm
         uX9mEVUz7Mg2/yRLZwYm1Y5VfSicDpJRtujkZW9H+HaqPUL24ityYyq8UeXrKz/IklrK
         Akv8nBlEqidAst/CDYAIJnzBcLn5EsCFJIaXtS1yGT4c0smNJ5FyJmGqKzgKskfcXcp0
         4eMQ45v0CDG1lk8HXcTjOke3cjxUYOvVLWZAcS4x0R55OCOuP8Y8eFlxqAK77VZWZqTc
         PjdYnd1mCqseeZY+TgXFNQT0Kb/a1f+7n+v4i/q/eDUSP2wKpfuG0C6qiiMWI3/p1XFH
         4iAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Tue, 13 Feb 2018 17:20:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@kernel.org>
cc: Jia-Ju Bai <baijiaju1990@gmail.com>, mingo@redhat.com, hpa@zytor.com,
    jgross@suse.com, douly.fnst@cn.fujitsu.com, kkamagui@gmail.com,
    gregkh@linuxfoundation.org, mka@chromium.org, linux-kernel@vger.kernel.org,
    x86@kernel.org
Subject: Re: [PATCH] kernel: x86: apic: Replace GFP_ATOMIC with GFP_KERNEL
 in __add_pin_to_irq_node
In-Reply-To: <20180213161659.aribhtrooupdv4m4@gmail.com>
Message-ID: <alpine.DEB.2.21.1802131720030.1130@nanos.tec.linutronix.de>
References: <1516758015-7236-1-git-send-email-baijiaju1990@gmail.com> <20180213155604.62ulolc34snh5n3p@gmail.com> <alpine.DEB.2.21.1802131705050.1130@nanos.tec.linutronix.de> <20180213161659.aribhtrooupdv4m4@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590435774374304646?=
X-GMAIL-MSGID: =?utf-8?q?1592303362365672211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Feb 2018, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 13 Feb 2018, Ingo Molnar wrote:
> > > * Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> > > 
> > > > The function __add_pin_to_irq_node is not called in atomic context.
> > > > Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> > > > 
> > > > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > > > ---
> > > >  arch/x86/kernel/apic/io_apic.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> > > > index 201579d..665c013 100644
> > > > --- a/arch/x86/kernel/apic/io_apic.c
> > > > +++ b/arch/x86/kernel/apic/io_apic.c
> > > > @@ -379,7 +379,7 @@ static int __add_pin_to_irq_node(struct mp_chip_data *data,
> > > >  		if (entry->apic == apic && entry->pin == pin)
> > > >  			return 0;
> > > >  
> > > > -	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
> > > > +	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_KERNEL, node);
> > > >  	if (!entry) {
> > > >  		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
> > > >  		       node, apic, pin);
> > > 
> > > NAK: this is called in an atomic section: with IRQs disabled ...
> > 
> > The only invocation where this happens with IRQs disabled is the early
> > check_timer() code which runs _before_ the scheduler is working. GFP_KERNEL
> > is valid during that phase. All other call sites have interrupts enabled.
> 
> Yeah, so at minimum there's a mismatch between the changelog:
> 
> > > > The function __add_pin_to_irq_node is not called in atomic context.
> 
> ... and actual behavior. What you wrote should be part of the changelog I suspect.

Fair enough.
