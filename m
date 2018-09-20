Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2CB21535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVjsVxUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2CB21535
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbeIUEcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:32:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeIUEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DMU5e/IyLnXahIblBmiXzcXrsWG7OaRSbqu761jCR3Y=; b=gVjsVxUYstoi63dwqm8NycHse
        RnZNWhHiq22PAROdrVRfDaCZ8z3AlRZ5RSxuz5hp2uX/TRjYPTjskbdAZz5PXFGDtcylfD+nTHdPi
        grVjiT7QupK4yYN1CjOOpxiCi1EhmfqURDHyrO2CO1woThhspDf0u/mMDODox3BRhpBQQudJo3/Zb
        aYwVSuh+ZcGbPVfEVAHywdCbnpddGmuJZmwSNfx6AVDsLZHcuzOzhYQgtPn6QMxi3m/TDNwxdhPs0
        y0WFapsyBF6s206HykXKI7n/VfusqfVUWkOB1CcLtH+wOPnrna6+XPt/tMtedHHnxTR+E085hJ0y0
        0iW/eZWLA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g37iN-00022o-2c; Thu, 20 Sep 2018 22:46:27 +0000
Subject: Re: [PATCH v2 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
To:     Ryan Case <ryandcase@chromium.org>, Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <20180920224055.164856-2-ryandcase@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b7c090f-42ef-1b5d-0708-0b3b52d49302@infradead.org>
Date:   Thu, 20 Sep 2018 15:46:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180920224055.164856-2-ryandcase@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just curious:

On 9/20/18 3:40 PM, Ryan Case wrote:
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index de03d67bcd2b..36922e12c3b0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -549,6 +549,12 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>  
> +config SPI_QCOM_QSPI
> +	tristate "QTI QPSPI controller"

	Is that       QPSPI correct?
	This is the only place that QPSPI or PSPI is used in this patch.


> +	depends on ARCH_QCOM
> +	help
> +	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
> +
>  config SPI_QUP
>  	tristate "Qualcomm SPI controller with QUP interface"
>  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)


-- 
~Randy
