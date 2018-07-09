Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8ECC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F434208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z5d2JtVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F434208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeGIRMg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933367AbeGIRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:12:34 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FD920871;
        Mon,  9 Jul 2018 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531156354;
        bh=BOCCRXfkCiC+mRfGJeTvgk7c8nso9AZbCvQfZLKJtOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5d2JtVrNfW6tDWTHY36m6N065IZQdN1LmRJ/5Ck4Ahof3ZYrvCsK6RIUv/cdH6PI
         GajiAQ5gXzjszyMItMOJLWmUlNwe4b7FofcYu4R8Ghp42uxrq2U/dHZXbgij+sNPVH
         prTGtSP2HxZA1PxTTJTedJjPwUzYMTIcn+vki0tg=
Date:   Mon, 9 Jul 2018 22:42:26 +0530
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
Subject: Re: [PATCH 05/14] dmaengine: dma-jz4780: Add support for the JZ4740
 SoC
Message-ID: <20180709171226.GK22377@vkoul-mobl>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-6-paul@crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 14:32, Paul Cercueil wrote:

>  enum jz_version {
> +	ID_JZ4740,
>  	ID_JZ4770,
>  	ID_JZ4780,
>  };
> @@ -247,6 +248,7 @@ static void jz4780_dma_desc_free(struct virt_dma_desc *vdesc)
>  }
>  
>  static const unsigned int jz4780_dma_ord_max[] = {
> +	[ID_JZ4740] = 5,
>  	[ID_JZ4770] = 6,
>  	[ID_JZ4780] = 7,
>  };
> @@ -801,11 +803,13 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>  }
>  
>  static const unsigned int jz4780_dma_nb_channels[] = {
> +	[ID_JZ4740] = 6,
>  	[ID_JZ4770] = 6,
>  	[ID_JZ4780] = 32,
>  };

I feel these should be done away with if we describe hardware in DT

>  
>  static const struct of_device_id jz4780_dma_dt_match[] = {
> +	{ .compatible = "ingenic,jz4740-dma", .data = (void *)ID_JZ4740 },

adding .compatible should be the only thing required, if at all for this
addition :)

-- 
~Vinod
