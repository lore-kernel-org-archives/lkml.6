Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B18C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8001F2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBGU6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:58:16 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:53414 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfBGU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:58:15 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-102-43-nat.elisa-mobile.fi [85.76.102.43])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 1879D400C8;
        Thu,  7 Feb 2019 22:58:12 +0200 (EET)
Date:   Thu, 7 Feb 2019 22:58:12 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, tomli@tomli.me,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH] irqchip/i8259: fix shutdown order by moving syscore_ops
 registration
Message-ID: <20190207205812.GA11315@darkstar.musicnaut.iki.fi>
References: <20190206212608.27189-1-aaro.koskinen@iki.fi>
 <8492440b-b489-0ce1-865c-4505042cb061@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8492440b-b489-0ce1-865c-4505042cb061@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 07, 2019 at 08:56:37AM +0000, Marc Zyngier wrote:
> On 06/02/2019 21:26, Aaro Koskinen wrote:
> >  static void init_8259A(int auto_eoi)
> >  {
> >  	unsigned long flags;
> > @@ -332,6 +324,7 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
> >  		panic("Failed to add i8259 IRQ domain");
> >  
> >  	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
> > +	register_syscore_ops(&i8259_syscore_ops);
> >  	return domain;
> >  }
> >  
> > 
> 
> Given that this is a change of behaviour that is likely to affect other
> platforms (I see at least another 6 MIPS machines using the i8259),
> could someone make sure that this doesn't cause any regression? This is
> unlikely to affect the SGI boxes, as they predate any notion of power
> management, but something like Malta could potentially be affected.

For shutdown, I don't think there are many syscore_ops users on these
platforms. Actually I could find only two that I think could be used:
	- cpufreq (issue fixed by this patch, and Loongson is the only user
	  anyway)
	- leds-trigger

Then suspend/resume: i8259 doesn't implement suspend, so there is no
change in behaviour. In resume it does PIC re-init, but syscore_resume()
is done with interrupts disabled so the order shouldn't matter.

A.
