Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69FC2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBTJPn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:15:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfBTJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:15:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 661B4EBD;
        Wed, 20 Feb 2019 01:15:42 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9D53F720;
        Wed, 20 Feb 2019 01:15:41 -0800 (PST)
Date:   Wed, 20 Feb 2019 09:15:37 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] genirq/irqdomain: fall back to default domain
 when creating hierarchy domain
Message-ID: <20190220091537.4cf01191@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219174829.26576a5b6bf62cd99adf294a@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
        <20190219155728.19163-10-tbogendoerfer@suse.de>
        <20190219162716.04b0a54b@why.wild-wind.fr.eu.org>
        <20190219174829.26576a5b6bf62cd99adf294a@suse.de>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 17:48:29 +0100
Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:

> On Tue, 19 Feb 2019 16:27:16 +0000
> Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> > On Tue, 19 Feb 2019 16:57:23 +0100
> > Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
> > 
> > Hi Thomas,
> >   
> > > When creating hierarchy domains use irq_default_domain as parent, if no
> > > parent was given by the caller. This avoids adding helper code for
> > > querying the underlying platform irq domain.
> > > 
> > > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > > ---
> > >  kernel/irq/irqdomain.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > > index 8b0be4bd6565..617c482d0778 100644
> > > --- a/kernel/irq/irqdomain.c
> > > +++ b/kernel/irq/irqdomain.c
> > > @@ -1021,7 +1021,10 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
> > >  	else
> > >  		domain = irq_domain_create_tree(fwnode, ops, host_data);
> > >  	if (domain) {
> > > -		domain->parent = parent;
> > > +		if (parent)
> > > +			domain->parent = parent;
> > > +		else
> > > +			domain->parent = irq_default_domain;
> > >  		domain->flags |= flags;
> > >  	}
> > >    
> > 
> > I'm really not keen on this. The whole "default domain" made sense at a
> > distant point in time (when irqdomains were new and platform code was
> > blissfully ignoring it), but it really looks like a sore spot in the
> > hierarchy code, which assumes that you always know what you're building
> > your hierarchy on top of.
> > 
> > It also create a small issue in the sense that you can create a root
> > domain using irq_domain_create_hierarchy() by passing NULL as the
> > parent. With this patch, the new domain now points to the default one,
> > with unexpected consequences.
> > 
> > So let's come back to first principles: How comes you can't obtain the
> > parent domain at creation time? Because I'd rather give you a way to
> > retrieve it instead if this.  
> 
> the bridge irq domain could be stacked on different underlying irq domains
> for different platforms (HUB is IP27, HEART for IP30 and BEDROCK for IP35).
> And my idea was to set a irq default domain in the IP27/IP30/IP35 platform
> code so that bridge code will pick up the correct underlying irq domain.
> As there is no device tree I haven't found an already implemented other way.

Ah, right. We have ways to solve this kind of problem without DT
(cough... ACPI cough...), but this requires the bridge code to at least
know *something* about the underlying domain (see the use of struct
fwnode in the ACPI IORT code, and the way it uses the routing
informations to build and retrieve fwnodes that are used to match
irq domains).

Do you have such firmware tables that could be used to store sideband
data and allow the bridge code to retrieve the corresponding pointer? I
appreciate this could be quite a lot of work for a platform that has
little future...

> Right now I have two idea to solve my problem without this patch:
> 
> - implement a SGI specific helper for getting the underlying irq domain
> - use a helper function to read irq_default_domain
> 
> What do you prefer ? Or do you see something else ?

Well, short of doing the above, I'd rather have something in the common
code that allows the default domain to be retrieved. How about the
patch below?

Thanks,

	M.

From 3a9e44941c203ef2ed659838f218a0203c963828 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 20 Feb 2019 08:59:23 +0000
Subject: [PATCH] irqdomain: Allow the default irq domain to be retrieved

The default irq domain allows legacy code to create irqdomain
mappings without having to track the domain it is allocating
from. Setting the default domain is a one shot, fire and forget
operation, and no effort was made to be able to retrieve this
information at a later point in time.

Newer irqdomain APIs (the hierarchical stuff) relies on both
the irqchip code to track the irqdomain it is allocating from,
as well as some form of firmware abstraction to easily identify
which piece of HW maps to which irq domain (DT, ACPI).

For systems without such firmware (or legacy platform that are
getting dragged into the 21st century), things are a bit harder.
For these cases (and these cases only!), let's provide a way
to retrieve the default domain, allowing the use of the v2 API
without having to resort to platform-specific hacks.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h |  1 +
 kernel/irq/irqdomain.c    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 35965f41d7be..d2130dc7c0e6 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -265,6 +265,7 @@ extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern bool irq_domain_check_msi_remap(void);
 extern void irq_set_default_host(struct irq_domain *host);
+extern struct irq_domain *irq_get_default_host(void);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node,
 				  const struct irq_affinity_desc *affinity);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8b0be4bd6565..80818764643d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -458,6 +458,20 @@ void irq_set_default_host(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_set_default_host);
 
+/**
+ * irq_get_default_host() - Retrieve the "default" irq domain
+ *
+ * Returns: the default domain, if any.
+ *
+ * Modern code should never use this. This should only be used on
+ * systems that cannot implement a firmware->fwnode mapping (which
+ * both DT and ACPI provide).
+ */
+struct irq_domain *irq_get_default_host(void)
+{
+	return irq_default_domain;
+}
+
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
-- 
2.20.1


-- 
Without deviation from the norm, progress is not possible.
