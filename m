Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44153C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDEC21A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DbFFfy7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDEC21A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbeHFVTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:19:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56618 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbeHFVTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Y/up8EsN7es9CARN8yQqpLB9OM1ehpEt8Y5qAmgR1v0=;
        b=DbFFfy7NnwuLrlmk5QDZxacpSZfok4iUekrchOZ1iddfRu3+VldA+M4yagxgMee8k+PxPIQ2/t2eSH9zpF6WuSVmRf8cSWN0M2wgNo0AS8kZyD6t9IMFxgQnjuSfTME4xM67c+XrpWwOZ//HCkmARuXYVv+k5kEogJPB9O/dtWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fmksS-0003q1-9u; Mon, 06 Aug 2018 21:09:12 +0200
Date:   Mon, 6 Aug 2018 21:09:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Kosta Zertsekel <zertsekel@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: Re: [PATCH] spi: orion: cosmetics - alias long direct_access
 variables
Message-ID: <20180806190912.GJ9372@lunn.ch>
References: <20180806185158.2382-1-zertsekel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806185158.2382-1-zertsekel@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>  
>  	/* Scan all SPI devices of this controller for direct mapped devices */
>  	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		struct orion_direct_acc *dacc;

I would prefer direct_access, but it looks like this is too long to
put the devm_ioremap on one line. But it should be enough to fix the
odd indentation of r->start and PAGE_SIZE.

    Andrew

>  		u32 cs;
>  
>  		/* Get chip-select number from the "reg" property */
> @@ -711,14 +712,13 @@ static int orion_spi_probe(struct platform_device *pdev)
>  		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
>  		 * support, once this gets implemented.
>  		 */
> -		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
> -							    r->start,
> -							    PAGE_SIZE);
> -		if (!spi->child[cs].direct_access.vaddr) {
> +		dacc = &spi->child[cs].direct_access;
> +		dacc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
> +		if (!dacc->vaddr) {
>  			status = -ENOMEM;
>  			goto out_rel_axi_clk;
>  		}
> -		spi->child[cs].direct_access.size = PAGE_SIZE;
> +		dacc->size = PAGE_SIZE;
>  
>  		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>  	}
> -- 
> 2.17.1
> 
