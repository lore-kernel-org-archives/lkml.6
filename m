Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BFAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF292077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF292077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHWUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:32:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbeHWUcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:32:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 128922193AFC6;
        Fri, 24 Aug 2018 01:01:23 +0800 (CST)
Received: from [127.0.0.1] (10.210.171.241) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Fri, 24 Aug 2018
 01:01:16 +0800
Subject: Re: [PATCH] scsi: hisi_sas: Switch from msleep to usleep_range per
 timers-howto.txt
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <1535022539-10634-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a89bf6bd-9789-5e6e-40ba-7e82780422d2@huawei.com>
Date:   Thu, 23 Aug 2018 18:01:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1535022539-10634-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.241]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2018 12:08, Ding Xiang wrote:
> use usleep_range to sleep for 10us - 20ms
>

Hi,

Thanks for the patch.

According to the document, msleep(1) will be ~20ms. As such, some driver 
behaviour may depend on this now.

At this stage, the drivers have been extensively tested (v2+v3), so I 
would rather not introduce possible instability. In addition, v1 is all 
but dead, so I can't test. Finally, none of the sleeps are in the 
fastpath, so the extra sleep does not cause much harm.

John

> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 8 ++++----
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 +++---
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index 8f60f0e..0584f711 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -579,7 +579,7 @@ static int reset_hw_v1_hw(struct hisi_hba *hisi_hba)
>  		phy_ctrl |= PHY_CTRL_RESET_MSK;
>  		hisi_sas_phy_write32(hisi_hba, i, PHY_CTRL, phy_ctrl);
>  	}
> -	msleep(1); /* It is safe to wait for 50us */
> +	usleep_range(1000, 1100); /* It is safe to wait for 50us */
>
>  	/* Ensure DMA tx & rx idle */
>  	for (i = 0; i < hisi_hba->n_phy; i++) {
> @@ -632,7 +632,7 @@ static int reset_hw_v1_hw(struct hisi_hba *hisi_hba)
>  			     RESET_VALUE);
>  		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg + 4,
>  			     RESET_VALUE);
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg, &val);
>  		if (RESET_VALUE != (val & RESET_VALUE)) {
>  			dev_err(dev, "Reset failed\n");
> @@ -645,7 +645,7 @@ static int reset_hw_v1_hw(struct hisi_hba *hisi_hba)
>  			     RESET_VALUE);
>  		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg,
>  			     RESET_VALUE);
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg, &val);
>  		if (val & RESET_VALUE) {
>  			dev_err(dev, "De-reset failed\n");
> @@ -841,7 +841,7 @@ static void sl_notify_v1_hw(struct hisi_hba *hisi_hba, int phy_no)
>  	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
>  	sl_control |= SL_CONTROL_NOTIFY_EN_MSK;
>  	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
>  	sl_control &= ~SL_CONTROL_NOTIFY_EN_MSK;
>  	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 9c5c5a6..4ca5f77 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -1081,7 +1081,7 @@ static int reset_hw_v2_hw(struct hisi_hba *hisi_hba)
>  				reset_val);
>  		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg + 4,
>  				reset_val);
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg, &val);
>  		if (reset_val != (val & reset_val)) {
>  			dev_err(dev, "SAS reset fail.\n");
> @@ -1093,7 +1093,7 @@ static int reset_hw_v2_hw(struct hisi_hba *hisi_hba)
>  				reset_val);
>  		regmap_write(hisi_hba->ctrl, hisi_hba->ctrl_clock_ena_reg,
>  				reset_val);
> -		msleep(1);
> +		usleep_range(1000, 1100);
>  		regmap_read(hisi_hba->ctrl, hisi_hba->ctrl_reset_sts_reg,
>  				&val);
>  		if (val & reset_val) {
> @@ -1591,7 +1591,7 @@ static void sl_notify_v2_hw(struct hisi_hba *hisi_hba, int phy_no)
>  	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
>  	sl_control |= SL_CONTROL_NOTIFY_EN_MSK;
>  	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
>  	sl_control &= ~SL_CONTROL_NOTIFY_EN_MSK;
>  	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 08b503e2..8f57737 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -834,7 +834,7 @@ static void sl_notify_v3_hw(struct hisi_hba *hisi_hba, int phy_no)
>  	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
>  	sl_control |= SL_CONTROL_NOTIFY_EN_MSK;
>  	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
> -	msleep(1);
> +	usleep_range(1000, 1100);
>  	sl_control = hisi_sas_phy_read32(hisi_hba, phy_no, SL_CONTROL);
>  	sl_control &= ~SL_CONTROL_NOTIFY_EN_MSK;
>  	hisi_sas_phy_write32(hisi_hba, phy_no, SL_CONTROL, sl_control);
>


