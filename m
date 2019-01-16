Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AB120651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393124AbfAPNUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:20:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbfAPNUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:20:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F08DB20955; Wed, 16 Jan 2019 14:20:41 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id A2731207AC;
        Wed, 16 Jan 2019 14:20:31 +0100 (CET)
Date:   Wed, 16 Jan 2019 14:20:31 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: use WP GPIO in sdhci_check_ro()
Message-ID: <20190116142031.54bc0f9a@windsurf>
In-Reply-To: <d92a5588-ffdd-5198-b985-04d9b8dae601@intel.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
        <20190115162837.5399-2-thomas.petazzoni@bootlin.com>
        <d92a5588-ffdd-5198-b985-04d9b8dae601@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

On Wed, 16 Jan 2019 14:59:32 +0200, Adrian Hunter wrote:

> > The below patch simply changes sdhci_check_ro() to use the value of
> > the WP GPIO if available. We need to adjust the prototype of the
> > function to use a mmc_host* as argument instead of sdhci_host*, since
> > the mmc_can_gpio_ro() and mmc_gpio_get_ro() helpers take a mmc_host*.  
> 
> Why not just use host->mmc

Could do that. I just found it weird that the calling function has the
mmc_host structure, does some gymnastic to find sdhci_host, and then in
the called function, we do the opposite gymnastic to find mmc_host from
sdhci_host. But if that's the preference, I'm happy to change the patch
accordingly.


> >  	if (host->flags & SDHCI_DEVICE_DEAD)
> >  		is_readonly = 0;
> > +	else if (mmc_can_gpio_ro(mmc))
> > +		is_readonly = mmc_gpio_get_ro(mmc);  
> 
> Perhaps host->ops->get_ro should be checked before mmc_can_gpio_ro()?

That is actually a good point, using ->get_ro() should come before
using the GPIO. Indeed, some drivers may potentially have a ->get_ro
with custom logic *and* a WP GPIO, and in this case, we want ->get_ro
to take precedence. I'll send a v2 with this, once you let me know your
decision about the previous point.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


