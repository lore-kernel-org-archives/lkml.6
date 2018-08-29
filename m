Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC000C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FC120647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FC120647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeH2Xtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:49:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeH2Xtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:49:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BE1A870490AB6;
        Thu, 30 Aug 2018 03:51:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Thu, 30 Aug 2018
 03:51:06 +0800
Subject: Re: [PATCH] serial: 8250_of: Fix for lack of interrupt support
To:     <gregkh@linuxfoundation.org>, <alexander.sverdlin@nokia.com>
References: <1535555277-102256-1-git-send-email-john.garry@huawei.com>
CC:     <jslaby@suse.com>, <robh@kernel.org>, <joel@jms.id.au>,
        <kurt@linutronix.de>, <yamada.masahiro@socionext.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3ceebf21-7de2-dbd7-fffe-f5e805b5abab@huawei.com>
Date:   Wed, 29 Aug 2018 20:50:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1535555277-102256-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2018 16:07, John Garry wrote:
> In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
> check was added for the UART driver being probed prior to the parent IRQ
> controller.
>
> Unfortunately this breaks certain boards which have no interrupt support,
> like Huawei D03.
>
> Indeed, the 8250 DT bindings state that interrupts should be supported -
> not must.
>
> To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
> does relay whether the IRQ host controller domain is not ready, i.e.
> defer probe, instead of assuming it.
>
> Fixes: c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Note: I think that it would better if we could try to get the interrupt
> 	  before clk+pm enabling, so we don't need to disable later when
> 	  deferring, but this is not a fix.
>
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index af8beef..c370e776 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -58,7 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  	struct resource resource;
>  	struct device_node *np = ofdev->dev.of_node;
>  	u32 clk, spd, prop;
> -	int ret;
> +	int ret, irq;
>
>  	memset(port, 0, sizeof *port);
>
> @@ -143,21 +143,27 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  	if (ret >= 0)
>  		port->line = ret;
>
> -	port->irq = irq_of_parse_and_map(np, 0);
> -	if (!port->irq) {
> -		ret = -EPROBE_DEFER;
> -		goto err_unprepare;
> +	irq = of_irq_get(np, 0);
> +	if (irq < 0) {
> +		if (port->irq == -EPROBE_DEFER) {

This check is not corrrct. It should be:
		if (irq == -EPROBE_DEFER) {

I'll send a v2.

@Alexander Sverdlin, Can you test this also please?

Thanks,
John

> +			ret = -EPROBE_DEFER;
> +			goto err_unprepare;
> +		}
> +		/* IRQ support not mandatory */
> +		irq = 0;
>  	}
>
> +	port->irq = irq;
> +
>  	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
>  	if (IS_ERR(info->rst)) {
>  		ret = PTR_ERR(info->rst);
> -		goto err_dispose;
> +		goto err_unprepare;
>  	}
>
>  	ret = reset_control_deassert(info->rst);
>  	if (ret)
> -		goto err_dispose;
> +		goto err_unprepare;
>
>  	port->type = type;
>  	port->uartclk = clk;
> @@ -184,8 +190,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		port->handle_irq = fsl8250_handle_irq;
>
>  	return 0;
> -err_dispose:
> -	irq_dispose_mapping(port->irq);
>  err_unprepare:
>  	clk_disable_unprepare(info->clk);
>  err_pmruntime:
>


