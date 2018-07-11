Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EDEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FFB208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SyhxrZnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FFB208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732393AbeGKCVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:21:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48396 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGKCVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:21:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6B2Jl8g004696;
        Tue, 10 Jul 2018 21:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531275587;
        bh=gKVWEeHoQcaIOk7QE3ts2CyOoQ6n2PbiaaLiusMRs5g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SyhxrZnjPLRWuKsf9P0hrTw35mx2se9VnjtH36DW1X2ckC+jPKdKFsnetN4XTjHEf
         sf+qu0kivfkdweRTARF/9cO3JUmdnvoINIgCPxXd0xHRMN7rXgLpJ3PuTB8hW0BvuI
         cob183Lm6izQZGCQZTesF9zW9QWWdm2l/cnu4T2c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B2JlGW004980;
        Tue, 10 Jul 2018 21:19:47 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 21:19:46 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 21:19:47 -0500
Received: from [172.22.218.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B2JgSX016422;
        Tue, 10 Jul 2018 21:19:43 -0500
Subject: Re: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling
 for DRA752
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114302epcas1p1890ad3296302900a736262b5d67aa10e@epcas1p1.samsung.com>
 <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <fd458da1-75d6-84ed-838a-0495045fad77@ti.com>
Date:   Wed, 11 Jul 2018 07:49:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> .report_temperature is not set in dra752_data which
> results in temperature updates not being propagated by
> ti_bandgap_talert_irq_handler() (it doesn't make much
> sense to handle TALERT IRQ without reporting temperature
> updates to the thermal core). Fix it.

ATM no one is using TALERT as the thermal software polls on the 
temperature. No real benefit from TALERT.

TALERT is set at different temperature and software polling thresholds 
come from Device tree and i believe its best for software to go by 
polling and then act on trip points.

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/dra752-thermal-data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> index 33a3030..e8ab7e5 100644
> --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> @@ -338,6 +338,7 @@
>   	.adc_end_val = DRA752_ADC_END_VALUE,
>   	.expose_sensor = ti_thermal_expose_sensor,
>   	.remove_sensor = ti_thermal_remove_sensor,
> +	.report_temperature = ti_thermal_report_sensor_temperature,
>   	.sensors = {
>   		{
>   		.registers = &dra752_mpu_temp_sensor_registers,
> 
