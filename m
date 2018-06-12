Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5D3DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErJCxlwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B05D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeFLF2K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:28:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeFLF2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Niuty6Rd1UKGc15SZU1aSQEewVXQqxfBrG2PybWN0SI=; b=ErJCxlwihWlknzAC2t0VusN+M
        RFsn3IsHuJ7NNQWXOCRPdzZHQdTa/rG26sorZUR2+nqLNsK9ZwMUy1nokDFbCLe0jD63E64SIr8Vs
        btvvfvjMYnGFo/htqpoxWW2c4TElK2/TZIn4rDi0jFykbbqSMydy9u/vnbVMCKjVAG/TJjJYNp3sA
        4WkHp0Vat3puRZ970laZDWhBNtjU8JH2FgycutyIZYgN7k34qTh+lUur6o44c8bHsnTQubPezTupU
        TiycGVHvpsMdKZBuocnUkMyycVvOxFLWeT5dcIuh2tWllWbZiY+/6oe0cDvE0Z1Z30Tic4CYp2aw1
        WUJHXm2hw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSbqe-0007Fb-8F; Tue, 12 Jun 2018 05:28:04 +0000
Subject: Re: [PATCH 2/2] nvmem: Add Spreadtrum SC27XX efuse support
To:     Baolin Wang <baolin.wang@linaro.org>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     broonie@kernel.org, freeman.liu@spreadtrum.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0a5444dd0646f4e1f1d8ce51870afe6cc864219e.1528780670.git.baolin.wang@linaro.org>
 <0ebf526fa755231c8871a57baab641cebaed7820.1528780670.git.baolin.wang@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70fffa09-5c70-be61-49b8-e78015fff547@infradead.org>
Date:   Mon, 11 Jun 2018 22:27:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0ebf526fa755231c8871a57baab641cebaed7820.1528780670.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 10:24 PM, Baolin Wang wrote:
> From: Freeman Liu <freeman.liu@spreadtrum.com>
> 
> This patch add the efuse driver which is embeded in Spreadtrum SC27XX
> series PMICs. The sc27xx efuse contains 32 blocks and each block's
> data width is 16 bits.
> 
> Signed-off-by: Freeman Liu <freeman.liu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/nvmem/Kconfig        |   11 ++
>  drivers/nvmem/Makefile       |    3 +-
>  drivers/nvmem/sc27xx-efuse.c |  263 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 276 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/nvmem/sc27xx-efuse.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 54a3c29..3dca608 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -181,4 +181,15 @@ config RAVE_SP_EEPROM
>  	help
>  	  Say y here to enable Rave SP EEPROM support.
>  
> +config SC27XX_EFUSE
> +	tristate "Spreadtrum SC27XX eFuse Support"
> +	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This is a simple drive to dump specified values of Spreadtrum

	                   driver

> +	  SC27XX PMICs from eFuse.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-sc27xx-efuse.
> +
>  endif


-- 
~Randy
