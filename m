Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5F7DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBEF208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBEF208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeFLFyE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:54:04 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:35833 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932357AbeFLFyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:54:03 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2018 01:54:02 EDT
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id D358527A5CC;
        Tue, 12 Jun 2018 07:45:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 8A5691A59B9;
        Tue, 12 Jun 2018 07:45:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XHbGp3aySHZI; Tue, 12 Jun 2018 07:45:11 +0200 (CEST)
Received: from ws-stein.localnet (ws-stein.systec.local [192.168.10.92])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id C97811A59B8;
        Tue, 12 Jun 2018 07:45:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        t-kristo@ti.com
Subject: Re: [PATCH v2 1/2] gpio: davinci: Shuffle IRQ resource fetching from DT to beginning of probe
Date:   Tue, 12 Jun 2018 07:45:08 +0200
Message-ID: <2368406.Am5sO8QqEf@ws-stein>
In-Reply-To: <1528781273-18098-1-git-send-email-j-keerthy@ti.com>
References: <1528781273-18098-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 12, 2018, 7:27:52 AM CEST Keerthy wrote:
> This is needed in case of PROBE_DEFER if IRQ resource is not yet ready.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> [...]
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> [...]
> @@ -168,7 +168,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  {
>  	static int ctrl_num, bank_base;
>  	int gpio, bank, ret = 0;
> -	unsigned ngpio, nbank;
> +	unsigned ngpio, nbank, bank_irq;

bank_irq should be an int, not unsigned, no?

>  	struct davinci_gpio_controller *chips;
>  	struct davinci_gpio_platform_data *pdata;
>  	struct device *dev = &pdev->dev;
> @@ -209,6 +209,12 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>  	if (IS_ERR(gpio_base))
>  		return PTR_ERR(gpio_base);
>  
> +	bank_irq = platform_get_irq(pdev, 0);
> +	if (bank_irq < 0) {

This won't work using an unsigned.

Best regards,
Alexander



