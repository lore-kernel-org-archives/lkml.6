Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A7C204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A7C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJ2XVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:21:06 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10540 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeJ2XVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:21:06 -0400
X-IronPort-AV: E=Sophos;i="5.54,440,1534834800"; 
   d="scan'208";a="23245804"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 07:32:03 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Mon, 29 Oct 2018
 07:32:02 -0700
Date:   Mon, 29 Oct 2018 15:32:10 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 5/5] pinctrl: pinctrl-at91-pio4: simplify getting
 .driver_data
Message-ID: <20181029143210.m3ymirqjkhoty2wu@M43218.corp.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
 <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00:31PM +0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/pinctrl/pinctrl-at91-pio4.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 5a850491a5cb..4ee135d7b883 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -868,8 +868,7 @@ static struct pinctrl_desc atmel_pinctrl_desc = {
>  
>  static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
> +	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
>  	int i, j;
>  
>  	/*
> @@ -897,8 +896,7 @@ static int __maybe_unused atmel_pctrl_suspend(struct device *dev)
>  
>  static int __maybe_unused atmel_pctrl_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
> +	struct atmel_pioctrl *atmel_pioctrl = dev_get_drvdata(dev);
>  	int i, j;
>  
>  	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
> -- 
> 2.19.0
> 
