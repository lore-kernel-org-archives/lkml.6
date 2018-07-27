Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD6BC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BB920893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GfDdRp4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BB920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbeG0Kaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:30:39 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49902 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeG0Kaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:30:39 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1DAE491;
        Fri, 27 Jul 2018 11:09:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532682580;
        bh=Z/zesk2Wz6pgE2mbG3eII58/J2AFXpYyiSkgSoETSVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfDdRp4hMm3pqsctE2dIbBlY+R8bjcKfeBcoYqNBkY6Kz7gNt/F9YpWqVdBzl0ewR
         hfS0Is+BpxK8omWs+wVd080cnCNI/qtOt4lQ7gdX6HSnCgC/+2is88uMiLkDAQ71iM
         XCbIreeLIkRCIcvDj/Pd926GWnuKazdp8a7j5zcA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Marc Dietrich <marvin24@gmx.de>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Don't register as BUS IOMMU if machine doesn't have IPMMU-VMSA
Date:   Fri, 27 Jul 2018 12:10:15 +0300
Message-ID: <2725801.tsBI9ZhLPt@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180726211916.10264-1-digetx@gmail.com>
References: <20180726211916.10264-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

(CC'ing Geert and Magnus)

Thank you for the patch.

On Friday, 27 July 2018 00:19:16 EEST Dmitry Osipenko wrote:
> This fixes kernel crashing on NVIDIA Tegra if kernel is compiled in
> a multiplatform configuration and IPMMU-VMSA driver is enabled.
> 
> Cc: <stable@vger.kernel.org> # v3.20+
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9e8495762bc8..78c50db9cd71 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1109,12 +1109,19 @@ static struct platform_driver ipmmu_driver = {
> 
>  static int __init ipmmu_init(void)
>  {
> +	struct device_node *np;
>  	static bool setup_done;
>  	int ret;
> 
>  	if (setup_done)
>  		return 0;
> 
> +	np = of_find_matching_node(NULL, ipmmu_of_ids);
> +	if (!np)
> +		return 0;
> +
> +	of_node_put(np);
> +

While functionally correct, this will add some unnecessary overhead when 
iommu_init() is called from IOMMU_OF_DECLARE(). I'm OK with this fix as a 
temporary measure to solve your problem, but we need to address the underlying 
issue properly.

Geert, Magnus, the ipmmu-vmsa driver is a bit of a mess. We should brush it up 
and start using IOMMU_OF_DECLARE() on all platforms (and eventually get rid of 
bus_set_iommu() completely...). Do you have plans to address this ? If not, 
could you please add it to your to-do list ?

>  	ret = platform_driver_register(&ipmmu_driver);
>  	if (ret < 0)
>  		return ret;

-- 
Regards,

Laurent Pinchart



