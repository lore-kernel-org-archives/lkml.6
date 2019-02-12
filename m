Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51890C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C291217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UCWrlEBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfBLQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:47:28 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45898 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbfBLQr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:47:28 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C5AA85;
        Tue, 12 Feb 2019 17:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1549990046;
        bh=RMe6HNrTRYUpUQJj3Fbr9RVOF/nXgN+ho+3WaE3Ju5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCWrlEBNv3KLGiF4VZgn9d+/bIboCHT2wp+RvxCqurcrazmrvGhKsmZa4g+/tVnzi
         YkSCiB2yB984MqrI5wCh73VveeMg0k7E/UusW8waQR+LMM5zIcr/xPKSzd9Picr3ny
         B8bWzRbAkLZFrvXHD/DM8XqfNG4aIJt5FSrK57VI=
Date:   Tue, 12 Feb 2019 18:47:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
Cc:     wen yang <yellowriver2010@hotmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Magnus Damm <damm+renesas@opensource.se>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: fix device reference leaks
Message-ID: <20190212164722.GT6279@pendragon.ideasonboard.com>
References: <HK0PR02MB3634F6AE1FAE6B86EF82B291B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
 <20190211102414.GZ32526@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211102414.GZ32526@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Wen, thank you for the patch.

On Mon, Feb 11, 2019 at 11:24:15AM +0100, joro@8bytes.org wrote:
> Adding a few more people to Cc.
> 
> On Sun, Feb 03, 2019 at 10:27:09AM +0000, wen yang wrote:
> > Make sure to drop the reference to the device taken by
> > of_find_device_by_node() on driver unbind.
> > 
> > Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: iommu@lists.linux-foundation.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/iommu/ipmmu-vmsa.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index 7a4529c..cebf56d 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -756,6 +756,9 @@ static int ipmmu_init_platform_device(struct device *dev,
> >  
> >  	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
> >  
> > +	if (!fwspec->iommu_priv)
> > +		put_device(&ipmmu_pdev->dev);
> > +

This doesn't seem to match the patch's subject, and doesn't seem to fix
the problem.

> >  	return 0;
> >  }
> >  

-- 
Regards,

Laurent Pinchart
