Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A820521773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfBSQsb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:48:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:60984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfBSQsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:48:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 029C3AE26;
        Tue, 19 Feb 2019 16:48:29 +0000 (UTC)
Date:   Tue, 19 Feb 2019 17:48:29 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] genirq/irqdomain: fall back to default domain
 when creating hierarchy domain
Message-Id: <20190219174829.26576a5b6bf62cd99adf294a@suse.de>
In-Reply-To: <20190219162716.04b0a54b@why.wild-wind.fr.eu.org>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
        <20190219155728.19163-10-tbogendoerfer@suse.de>
        <20190219162716.04b0a54b@why.wild-wind.fr.eu.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 16:27:16 +0000
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On Tue, 19 Feb 2019 16:57:23 +0100
> Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
> 
> Hi Thomas,
> 
> > When creating hierarchy domains use irq_default_domain as parent, if no
> > parent was given by the caller. This avoids adding helper code for
> > querying the underlying platform irq domain.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
> >  kernel/irq/irqdomain.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > index 8b0be4bd6565..617c482d0778 100644
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -1021,7 +1021,10 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> >  	else
> >  		domain = irq_domain_create_tree(fwnode, ops, host_data);
> >  	if (domain) {
> > -		domain->parent = parent;
> > +		if (parent)
> > +			domain->parent = parent;
> > +		else
> > +			domain->parent = irq_default_domain;
> >  		domain->flags |= flags;
> >  	}
> >  
> 
> I'm really not keen on this. The whole "default domain" made sense at a
> distant point in time (when irqdomains were new and platform code was
> blissfully ignoring it), but it really looks like a sore spot in the
> hierarchy code, which assumes that you always know what you're building
> your hierarchy on top of.
> 
> It also create a small issue in the sense that you can create a root
> domain using irq_domain_create_hierarchy() by passing NULL as the
> parent. With this patch, the new domain now points to the default one,
> with unexpected consequences.
> 
> So let's come back to first principles: How comes you can't obtain the
> parent domain at creation time? Because I'd rather give you a way to
> retrieve it instead if this.

the bridge irq domain could be stacked on different underlying irq domains
for different platforms (HUB is IP27, HEART for IP30 and BEDROCK for IP35).
And my idea was to set a irq default domain in the IP27/IP30/IP35 platform
code so that bridge code will pick up the correct underlying irq domain.
As there is no device tree I haven't found an already implemented other way.
Right now I have two idea to solve my problem without this patch:

- implement a SGI specific helper for getting the underlying irq domain
- use a helper function to read irq_default_domain

What do you prefer ? Or do you see something else ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
