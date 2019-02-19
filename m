Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5042C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A4521738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbfBSQ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:27:22 -0500
Received: from foss.arm.com ([217.140.101.70]:47160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSQ1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:27:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE75EBD;
        Tue, 19 Feb 2019 08:27:21 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700EA3F690;
        Tue, 19 Feb 2019 08:27:20 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:27:16 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] genirq/irqdomain: fall back to default domain
 when creating hierarchy domain
Message-ID: <20190219162716.04b0a54b@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219155728.19163-10-tbogendoerfer@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
        <20190219155728.19163-10-tbogendoerfer@suse.de>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 16:57:23 +0100
Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:

Hi Thomas,

> When creating hierarchy domains use irq_default_domain as parent, if no
> parent was given by the caller. This avoids adding helper code for
> querying the underlying platform irq domain.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  kernel/irq/irqdomain.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 8b0be4bd6565..617c482d0778 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1021,7 +1021,10 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
>  	else
>  		domain = irq_domain_create_tree(fwnode, ops, host_data);
>  	if (domain) {
> -		domain->parent = parent;
> +		if (parent)
> +			domain->parent = parent;
> +		else
> +			domain->parent = irq_default_domain;
>  		domain->flags |= flags;
>  	}
>  

I'm really not keen on this. The whole "default domain" made sense at a
distant point in time (when irqdomains were new and platform code was
blissfully ignoring it), but it really looks like a sore spot in the
hierarchy code, which assumes that you always know what you're building
your hierarchy on top of.

It also create a small issue in the sense that you can create a root
domain using irq_domain_create_hierarchy() by passing NULL as the
parent. With this patch, the new domain now points to the default one,
with unexpected consequences.

So let's come back to first principles: How comes you can't obtain the
parent domain at creation time? Because I'd rather give you a way to
retrieve it instead if this.

	M. (who wish he had an IP27!)
-- 
Without deviation from the norm, progress is not possible.
