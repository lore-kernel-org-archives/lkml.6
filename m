Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280FC21A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="oIoUY7DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfBONrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:47:35 -0500
Received: from onstation.org ([52.200.56.107]:42026 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfBONrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:47:35 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 7D6E3153;
        Fri, 15 Feb 2019 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1550238453;
        bh=JbP9NlSPwXu9H9IFTAWffrQWZ+V9cNbvWdpcpe45o1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oIoUY7DChci+aLI8quy1zsdSFOny04kwPpDqs0xcg+cZuD7tEqclI1u06KsftcxAk
         YYcrm2COyyuBgvhw/3ky/cyW61ColsLxOT09Yd5VNh5mnvRKURvPaPuMp/rRLAlAan
         6VhSJmLhnrI6MxoDZ3n8gO3nMk8RGyDdJNPN2fOQ=
Date:   Fri, 15 Feb 2019 08:47:33 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq
 mapping already exists
Message-ID: <20190215134733.GA21208@basecamp>
References: <20190208021631.30252-1-masneyb@onstation.org>
 <20190208021631.30252-6-masneyb@onstation.org>
 <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:51:26PM -0800, Stephen Boyd wrote:
> > diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> > index 8eb2528793f9..2f99a98ccee5 100644
> > --- a/drivers/mfd/qcom-pm8xxx.c
> > +++ b/drivers/mfd/qcom-pm8xxx.c
> > @@ -380,6 +380,12 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
> >                                   struct irq_domain *domain, unsigned int irq,
> >                                   irq_hw_number_t hwirq, unsigned int type)
> >  {
> > +       unsigned int old_virq;
> > +
> > +       old_virq = irq_find_mapping(domain, hwirq);
> > +       if (old_virq)
> > +               irq_domain_disassociate(domain, old_virq);
> 
> Is it possible to pass 'true' for the 'realloc' argument to
> __irq_domain_alloc_irqs() and then this disassociate change isn't
> needed?

The kernel doc for __irq_domain_alloc_irqs() says that the realloc
parameter is mainly to support legacy IRQs. I don't think its a good
idea to add new code that'll stay past the end of this patch series
on top of that legacy interface.

Brian
