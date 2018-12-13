Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE12C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16A42145D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f4l+I+Fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16A42145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeLMJFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:05:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeLMJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:05:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so1120343wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jPsdLOhWZrFU4+GfwGe38ibFTnPqFP1yrEyPZeAAE4g=;
        b=f4l+I+Fhiqcbs2Kg5WrCHxMquiczKPhyM1m7JkTs6cZtjMCsTakSv87uP1ZfLkksuT
         NdMaXiZZQ0yXVHkjiDUbHVPr61cKGrth+lmaK/leweZcdek/S7euyustUGs3o5Ui/wP2
         EghSGc/ebTWk8ojuBv8rJqhjUiuCbZH+QYqveL+J51Sr0NJJFg6n75Qwmx4NxAMeGNnw
         +XwfQhGajCc4q5qqqTUJlp+7ZWqa/HWdxXCfQGEgcBTd0+tQThIuPncLs/vhvPAjYMk3
         VhfvQkV3kDbzWtCT9qAIyhTF0VLV1eCqc7r37NY2/ke+egjtGzlrqiy6u/mWCkQPqQfS
         eskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jPsdLOhWZrFU4+GfwGe38ibFTnPqFP1yrEyPZeAAE4g=;
        b=ZJCMiZYARU3TOcvFiwkKXrqIxFX863vn/w652yds1fYUWPz23p/KpgQcUJb98A3wzY
         RomM2E9o1uQGO5j1tKOtpZ/ir8LEts5xg0UIjxxtGGx5qaK+e13Z5CZsUCPHj5Shn6cT
         VgC7TdEM8L5o3eybaL2JfBhksUWQIY3IfYlRuV+gkDC1GDMO6kQKFD1RcwXrSmvI0NMR
         XgGMVIIfoe9H64V5owMmFV3HWMtGS1nLLV+lAiQqEsubqGl6+QNh8A8XVNKBGTDgCFuD
         ssIg9smmMLwxISQa8exX1I3mqO7PFsG2PVgYXtBYMpyNjmidmdJ4j5j9JuUhVfZuMw+c
         8Qew==
X-Gm-Message-State: AA+aEWbvzNt9xrZANgX0EjnGQVvi9qYfAZGNpumZAwUk6s+0NabdiWJs
        Y12YB4YdcqSNOJCrsVEeKxbcOQ==
X-Google-Smtp-Source: AFSGD/UqSfrsIOYqBArAnoEkSzRdOyDlCp74MmgGNAspvy0KzMVR+x5le8CZd6rUMgcWJjT5ZguViA==
X-Received: by 2002:adf:9246:: with SMTP id 64mr3728393wrj.130.1544691898882;
        Thu, 13 Dec 2018 01:04:58 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id k128sm1547947wmd.37.2018.12.13.01.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:04:58 -0800 (PST)
Message-ID: <af721e7a752ca468046de0a4ad1ac4a0c220360c.camel@baylibre.com>
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Dec 2018 10:04:56 +0100
In-Reply-To: <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
         <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 16:39 +0800, Sunny Luo wrote:
> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
> signal lines through the idle state (between two transmission operation),
> which avoid the signals floating in unexpected state.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/spi/spi-meson-spicc.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
> index b56249d..0384c28 100644
> --- a/drivers/spi/spi-meson-spicc.c
> +++ b/drivers/spi/spi-meson-spicc.c
> @@ -115,6 +115,13 @@
>  
>  #define SPICC_DWADDR	0x24	/* Write Address of DMA */
>  
> +#define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
> +#define SPICC_ENH_MOSI_OEN		BIT(25)
> +#define SPICC_ENH_CLK_OEN		BIT(26)
> +#define SPICC_ENH_CS_OEN		BIT(27)
> +#define SPICC_ENH_CLK_CS_DELAY_EN	BIT(28)
> +#define SPICC_ENH_MAIN_CLK_AO		BIT(29)
> +
>  #define writel_bits_relaxed(mask, val, addr) \
>  	writel_relaxed((readl_relaxed(addr) & ~(mask)) | (val), addr)
>  
> @@ -123,6 +130,7 @@
>  
>  struct meson_spicc_data {
>  	unsigned int			max_speed_hz;
> +	bool				has_oen;
>  };
>  
>  struct meson_spicc_device {
> @@ -145,6 +153,19 @@ struct meson_spicc_device {
>  	bool				is_last_burst;
>  };
>  
> +static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
> +{
> +	u32 conf;
> +
> +	if (!spicc->data->has_oen)
> +		return;
> +
> +	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
> +		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
> +
> +	writel_relaxed(conf, spicc->base + SPICC_ENH_CTL0);
> +}
> +
>  static inline bool meson_spicc_txfull(struct meson_spicc_device *spicc)
>  {
>  	return !!FIELD_GET(SPICC_TF,
> @@ -453,6 +474,8 @@ static int meson_spicc_prepare_message(struct spi_master
> *master,
>  
>  	writel_bits_relaxed(BIT(24), BIT(24), spicc->base + SPICC_TESTREG);
>  
> +	meson_spicc_oen_enable(spicc);
> +

Any specific reason for doing this in prepare_message() ? It looks like
something that could/should be done during the probe ?

>  	return 0;
>  }
>  
> @@ -610,11 +633,12 @@ static int meson_spicc_remove(struct platform_device
> *pdev)
>  }
>  
>  static const struct meson_spicc_data meson_spicc_gx_data = {
> -	.max_speed_hz	= 30000000,
> +	.max_speed_hz		= 30000000,
>  };
>  
>  static const struct meson_spicc_data meson_spicc_axg_data = {
> -	.max_speed_hz	= 80000000,
> +	.max_speed_hz		= 80000000,
> +	.has_oen		= true,
>  };
>  
>  static const struct of_device_id meson_spicc_of_match[] = {


