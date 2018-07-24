Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8438C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7D220875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQL/j7yH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7D220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeGXO3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388295AbeGXO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:29:36 -0400
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F8F20852;
        Tue, 24 Jul 2018 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532438588;
        bh=5gMAuvLfwZnQAzioqK7tm85OE6ffyBDtYnpSQyDE6O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQL/j7yHmAr7DiGBY3/zN/coXs8/82ng1Lzyi5zEAAuScUHcEWE+iM0NmJKwLT6RR
         45cYEZcJWx2uFb1TgwXR0YOMvkQnLD0wgD21/FZL0Z1PxMedlinyB6HQ2XmvvGlqSd
         3YX7Dcl2XnUbuxx+hhClPiuERVtn0vC7CT6+Zd6U=
Date:   Tue, 24 Jul 2018 18:52:59 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 03/18] dmaengine: dma-jz4780: Avoid hardcoding number
 of channels
Message-ID: <20180724132259.GF3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-4-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-18, 13:06, Paul Cercueil wrote:

> +static const struct jz4780_dma_soc_data jz4780_dma_soc_data[] = {
> +	[ID_JZ4780] = { .nb_channels = 32, },

why the array of structs?

> +};
> +
> +static const struct of_device_id jz4780_dma_dt_match[] = {
> +	{ .compatible = "ingenic,jz4780-dma", .data = (void *)ID_JZ4780 },

the data should be jz4780_dma_soc_data? as you would add more data
later.. and not the enum..

> -	jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
> +	version = (enum jz_version)of_id->data;
> +	soc_data = &jz4780_dma_soc_data[version];

this can be simplified if we do:

        soc_data = device_get_match_data(pdev);

with:

static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
        .nb_channels = 32,
};

and
        { .compatible = "ingenic,jz4780-dma", .data = (void *)jz4780_dma_soc_data },

You add more parameters in future patches and store soc_data in driver
object and use as is..

> +	jzdma = devm_kzalloc(dev, sizeof(*jzdma)
> +				+ sizeof(*jzdma->chan) * soc_data->nb_channels,
> +				GFP_KERNEL);
>  	if (!jzdma)
>  		return -ENOMEM;
>  
> +	jzdma->soc_data = soc_data;
> +	jzdma->version = version;

why do you need to store version, driver should handle values and not
versions..

-- 
~Vinod
