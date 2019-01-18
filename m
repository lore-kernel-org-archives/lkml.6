Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED4C20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="uB1SVz8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfARM1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:27:18 -0500
Received: from onstation.org ([52.200.56.107]:59638 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfARM1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:27:17 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 83FCB14D;
        Fri, 18 Jan 2019 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547814436;
        bh=CN2d4fYXraEjnNwxtQKWsPyJFGmTxwWiI3iKLZ9tX4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uB1SVz8BhLPWr0HGYr8o95RLYovz8qvbvyl4TV8+UC2XgTFMze3i+J2ElrBX41SBd
         /Eo2KAp/jmkD1sjL7q9q7wBOofLUG/7s+xIAM5bmeYGCRSo3muKFn8fCbU706VeAO/
         9uOUv0LtMptFqJWOMwMtVIfcfz9xB/lZ2HIbLDHk=
Date:   Fri, 18 Jan 2019 07:27:16 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/14] spmi: pmic-arb: convert to v2 irq interfaces to
 support hierarchical IRQ chips
Message-ID: <20190118122716.GA32143@basecamp>
References: <20190117003234.22127-1-masneyb@onstation.org>
 <20190117003234.22127-5-masneyb@onstation.org>
 <d2e3c91c-2a54-e130-7512-e4a65bf2794d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e3c91c-2a54-e130-7512-e4a65bf2794d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jan 17, 2019 at 11:22:59AM +0000, Marc Zyngier wrote:
> > -static int qpnpint_irq_domain_map(struct irq_domain *d,
> > -				  unsigned int virq,
> > -				  irq_hw_number_t hwirq)
> > -{
> > -	struct spmi_pmic_arb *pmic_arb = d->host_data;
> >  
> > +static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
> > +				   struct irq_domain *domain, unsigned int virq,
> > +				   irq_hw_number_t hwirq)
> > +{
> >  	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
> >  
> > -	irq_set_chip_and_handler(virq, &pmic_arb_irqchip, handle_level_irq);
> > -	irq_set_chip_data(virq, d->host_data);
> > -	irq_set_noprobe(virq);
> > +	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
> > +			    handle_level_irq, NULL, NULL);
> 
> I understand you haven't changed the existing semantic here by always
> setting the handler to handle_level_irq. But is that guaranteed to
> always be the case? See below.
> 
> > +}
> > +
> > +static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
> > +				    unsigned int virq, unsigned int nr_irqs,
> > +				    void *data)
> > +{
> > +	struct spmi_pmic_arb *pmic_arb = domain->host_data;
> > +	struct irq_fwspec *fwspec = data;
> > +	irq_hw_number_t hwirq;
> > +	unsigned int type;
> > +	int ret, i;
> > +
> > +	ret = qpnpint_irq_domain_translate(domain, fwspec, &hwirq, &type);
> 
> Here, you extract the trigger from DT.
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < nr_irqs; i++)
> > +		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i);
> 
> Shouldn't you propagate it into the mapping function so that the handler
> can be selected accordingly? Or does the interrupt controller convert
> edge signals to level somehow?

qpnpint_irq_set_type() calls irq_set_handler_locked() to set the hander
to be either handle_edge_irq() or handle_level_irq(). So the handler is
initially setup incorrectly in some cases, but then setup correctly (via
__irq_set_trigger) when __setup_irq() is called by
request_threaded_irq().

It looks like that this will cause problems with shared IRQs to work as
expected.

I can rework this code and get this fixed.

Brian
