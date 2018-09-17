Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416C7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047DD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047DD2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeIQUXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:23:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728311AbeIQUXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:23:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2317FDD3145CC;
        Mon, 17 Sep 2018 22:55:35 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 22:55:25 +0800
Subject: Re: [PATCH v2] serial: 8250_of: Fix for lack of interrupt support
To:     <gregkh@linuxfoundation.org>
References: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
 <055f5ee8-4905-c229-0e33-6379cf65dfbc@nokia.com>
CC:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        <jslaby@suse.com>, <robh@kernel.org>, <joel@jms.id.au>,
        <kurt@linutronix.de>, <yamada.masahiro@socionext.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2064e8da-d0da-6d55-e700-af3f428b348d@huawei.com>
Date:   Mon, 17 Sep 2018 15:55:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <055f5ee8-4905-c229-0e33-6379cf65dfbc@nokia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2018 19:21, Alexander Sverdlin wrote:
> Hello John!
>

Hi Greg,

Can you kindly consider picking up this patch?

It still applies to the branches today in your tty git, but let me know 
if you still rather I resend.

Thanks,
John

> On 30/08/2018 11:08, John Garry wrote:
>> In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
>> check was added for the UART driver being probed prior to the parent IRQ
>> controller.
>>
>> Unfortunately this breaks certain boards which have no interrupt support,
>> like Huawei D03.
>>
>> Indeed, the 8250 DT bindings state that interrupts should be supported -
>> not must.
>>
>> To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
>> does relay whether the IRQ host controller domain is not ready, i.e.
>> defer probe, instead of assuming it.
>>
>> Fixes: c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> This indeed looks like a proper way to handle both cases:
>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
>> ---
>>
>> Change in v2:
>> - fix check on irq value
>>
>> Note: I think that it would better if we could try to get the interrupt
>> 	  before clk+pm enabling, so we don't need to disable later when
>> 	  deferring, but this is not a fix.
>>
>> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
>> index af8beef..877fd7f 100644
>> --- a/drivers/tty/serial/8250/8250_of.c
>> +++ b/drivers/tty/serial/8250/8250_of.c
>> @@ -58,7 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>  	struct resource resource;
>>  	struct device_node *np = ofdev->dev.of_node;
>>  	u32 clk, spd, prop;
>> -	int ret;
>> +	int ret, irq;
>>
>>  	memset(port, 0, sizeof *port);
>>
>> @@ -143,21 +143,27 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>  	if (ret >= 0)
>>  		port->line = ret;
>>
>> -	port->irq = irq_of_parse_and_map(np, 0);
>> -	if (!port->irq) {
>> -		ret = -EPROBE_DEFER;
>> -		goto err_unprepare;
>> +	irq = of_irq_get(np, 0);
>> +	if (irq < 0) {
>> +		if (irq == -EPROBE_DEFER) {
>> +			ret = -EPROBE_DEFER;
>> +			goto err_unprepare;
>> +		}
>> +		/* IRQ support not mandatory */
>> +		irq = 0;
>>  	}
>>
>> +	port->irq = irq;
>> +
>>  	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
>>  	if (IS_ERR(info->rst)) {
>>  		ret = PTR_ERR(info->rst);
>> -		goto err_dispose;
>> +		goto err_unprepare;
>>  	}
>>
>>  	ret = reset_control_deassert(info->rst);
>>  	if (ret)
>> -		goto err_dispose;
>> +		goto err_unprepare;
>>
>>  	port->type = type;
>>  	port->uartclk = clk;
>> @@ -184,8 +190,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>>  		port->handle_irq = fsl8250_handle_irq;
>>
>>  	return 0;
>> -err_dispose:
>> -	irq_dispose_mapping(port->irq);
>>  err_unprepare:
>>  	clk_disable_unprepare(info->clk);
>>  err_pmruntime:
>>
>


