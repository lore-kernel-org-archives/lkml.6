Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740AEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2363A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gdfKLjiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2363A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeGKDkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:40:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53550 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbeGKDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:40:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6B3cXQn017968;
        Tue, 10 Jul 2018 22:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531280313;
        bh=lWiNtcL97o5HgbEctPciLtIdjYerpMO/Vn3XlZyNc1Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gdfKLjiE6CK7m+/zf/exQ20aCW/9twL5JdMmJnSWt6HzqdxR7m0WahJb9M7bKimey
         MzdY60DrfLsclkjUV1e4u5vmPt8cJx9ZWdftk+WaG8Qq1taRg5rAnrnPiof1UcAVVN
         lrTdTWeBM3Xa2CYIe9XDz//PSziphsD/yeiLKpuY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B3cXQL000841;
        Tue, 10 Jul 2018 22:38:33 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 22:38:33 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 22:38:33 -0500
Received: from [172.22.218.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B3cTUN003212;
        Tue, 10 Jul 2018 22:38:30 -0500
Subject: Re: [PATCH 04/14] thermal: ti-soc-thermal: cleanup COUNTER feature
 handling for OMAP5
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114319epcas1p1921a83c1baaaf1e6f94283f462022dc5@epcas1p1.samsung.com>
 <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <51799355-1a39-7f2f-6a20-a1718b9e0a64@ti.com>
Date:   Wed, 11 Jul 2018 09:08:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526298141-14045-5-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> OMAP5 sensors don't claim COUNTER feature support (they use
> COUNTER_DELAY feature instead) so there is no need to set fields
> of struct temp_sensor_registers which are only used for COUNTER
> feature.
> 
> There should be no functional changes caused by this patch.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/omap5-thermal-data.c | 9 ---------
>   drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h   | 3 ---
>   2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> index 8191bae..e384be1 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
> @@ -41,9 +41,6 @@
>   	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
>   	.mask_freeze_mask = OMAP5430_MASK_FREEZE_MPU_MASK,
>   
> -	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
> -	.counter_mask = OMAP5430_COUNTER_MASK,
> -
>   	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
>   	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
>   	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
> @@ -77,9 +74,6 @@
>   	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
>   	.mask_freeze_mask = OMAP5430_MASK_FREEZE_GPU_MASK,
>   
> -	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
> -	.counter_mask = OMAP5430_COUNTER_MASK,
> -
>   	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
>   	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
>   	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
> @@ -114,9 +108,6 @@
>   	.mask_counter_delay_mask = OMAP5430_MASK_COUNTER_DELAY_MASK,
>   	.mask_freeze_mask = OMAP5430_MASK_FREEZE_CORE_MASK,
>   
> -	.bgap_counter = OMAP5430_BGAP_CTRL_OFFSET,
> -	.counter_mask = OMAP5430_COUNTER_MASK,
> -
>   	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
>   	.threshold_thot_mask = OMAP5430_T_HOT_MASK,
>   	.threshold_tcold_mask = OMAP5430_T_COLD_MASK,
> diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> index dcbf903..223c7a8 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> @@ -93,9 +93,6 @@
>   #define OMAP5430_MASK_HOT_MPU_MASK			BIT(1)
>   #define OMAP5430_MASK_COLD_MPU_MASK			BIT(0)
>   
> -/* OMAP5430.BANDGAP_COUNTER */
> -#define OMAP5430_COUNTER_MASK				(0xffffff << 0)
> -
>   /* OMAP5430.BANDGAP_THRESHOLD */
>   #define OMAP5430_T_HOT_MASK				(0x3ff << 16)
>   #define OMAP5430_T_COLD_MASK				(0x3ff << 0)
> 
