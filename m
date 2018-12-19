Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D9521841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeLSOez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:34:55 -0500
Received: from 8bytes.org ([81.169.241.247]:54792 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbeLSOex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:34:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D2CEB3F4; Wed, 19 Dec 2018 15:34:51 +0100 (CET)
Date:   Wed, 19 Dec 2018 15:34:51 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Message-ID: <20181219143451.GY16835@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
 <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
 <20181211150513.15161-4-joro@8bytes.org>
 <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

thanks for the report!

On Wed, Dec 19, 2018 at 10:54:18AM +0100, Marek Szyprowski wrote:
> On 2018-12-11 16:05, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > Make sure to invoke this call-back through the proper
> > function of the IOMMU-API.
> >
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  drivers/iommu/of_iommu.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index c5dd63072529..4d4847de727e 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  		ops = dev->iommu_fwspec->ops;
> >  	/*
> >  	 * If we have reason to believe the IOMMU driver missed the initial
> > -	 * add_device callback for dev, replay it to get things in order.
> > +	 * probe for dev, replay it to get things in order.
> >  	 */
> > -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
> > -		err = ops->add_device(dev);
> > +	if (dev->bus && !dev->iommu_group)
> > +		err = iommu_probe_device(dev);
> 
> This change removes a check for NULL ops, what causes NULL pointer
> exception on first device without IOMMU.

Bummer, this check was supposed to be in iommu_probe_device(), but
apparently it got lost. Does the attached patch fix it?

> I'm also not sure if this is a good idea to call iommu_probe_device(),
> which comes from dev->bus->iommu_ops, which might be different from ops
> from local variable.

The local variable comes from dev->iommu_fwspec->ops, which should be
exactly the same as dev->bus->iommu_ops. I'll leave that for now until
it turns out to be a problem (which I don't expect).


Regards,

	Joerg

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a2131751dcff..3ed4db334341 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -114,10 +114,14 @@ void iommu_device_unregister(struct iommu_device *iommu)
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	int ret = -EINVAL;
 
 	WARN_ON(dev->iommu_group);
 
-	return ops->add_device(dev);
+	if (ops)
+		ret = ops->add_device(dev);
+
+	return ret;
 }
 
 void iommu_release_device(struct device *dev)
