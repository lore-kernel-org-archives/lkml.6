Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE9FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFBA214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ik1e5SeO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFBA214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbeIXXXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:23:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39635 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732900AbeIXXXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:23:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85-v6so6379429pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8JImbrRyqpZA96HF1pLyQ2wb5Jmh0lDR2sdd0zKp+JE=;
        b=ik1e5SeOf2CCJ2iJXS2EZZiFi5LBLF2KDFzswuXoYB3QK85hkc5tUZvogfklcVBO4Y
         FpxoTSVJADAb01MxLco4MRsCsqWijUzdfJk77c96o6TekFQbfJxpIdja34oPC706U86U
         Xz6H6shM1eKOrFeEsTQOTp2uFC5IW93DD2pT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8JImbrRyqpZA96HF1pLyQ2wb5Jmh0lDR2sdd0zKp+JE=;
        b=ReJIJBSnPr+Y5sUZP/WTTdKX4e8X4t2AEUB6iNfLKZo5snEI5SdODxB7wW0Gswbpc3
         10RESv0Hi0Ol9Z6pqq+UYaTu01s8Vxf8CoQeQkvl7U9KHhYkP38yqDQXAwlPBHWHvzOe
         imhMQbqgak01THIKEp5+l5w7m2Rz8uUxjoA3oUY8m1K3jbdTGEtgTFOCYC3wQaGBVEd7
         Lq4E/PO/wbEwJkTXmJ+GrGt/8oJ6mAsXh9Yx4juVTcv29ZTm935Nw9qcb6gVLNDkVLR3
         uavEA857L5zn8VgIlvVUNP6ZCmm+W/BCRL3bfnpf/ztF90Rg28FpOfftyScfnmlUWyKX
         wdgw==
X-Gm-Message-State: ABuFfoiT2gnCzi1xY34op9ts5pGYMJpoUtXoZQKKlD5WJCfQyeaA/o+h
        JIgkk0HKUPHa2A5ihOGUtZVlDQ==
X-Google-Smtp-Source: ACcGV6180RcAm36zWZqi6OXmVC4sDyQmcpop1zy7m+quOpDoSmfqTY+ZfMbpUrafO2LwbDuzw9GQaQ==
X-Received: by 2002:a63:380d:: with SMTP id f13-v6mr10355574pga.124.1537809612740;
        Mon, 24 Sep 2018 10:20:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p4-v6sm52533096pfd.65.2018.09.24.10.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:20:12 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:24:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, subhashj@codeaurora.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from
 host
Message-ID: <20180924172432.GL1367@tuxbook-pro>
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
 <20180904101719.18049-3-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904101719.18049-3-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Sep 03:17 PDT 2018, Vivek Gautam wrote:

> The host makes direct calls into phy using ufs_qcom_phy_*()
> APIs. These APIs are only defined for 20nm qcom-ufs-qmp phy
> which is not being used by any architecture as yet. Future
> architectures too are not going to use 20nm ufs phy.
> So remove these ufs_qcom_phy_*() calls from host to let further
> change declare the 20nm phy as broken.
> Also remove couple of stale enum defines for ufs phy.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-ufs-i.h |  2 +-
>  drivers/scsi/ufs/ufs-qcom.c           | 28 +---------------------------
>  drivers/scsi/ufs/ufs-qcom.h           |  5 -----
>  include/linux/phy/phy-qcom-ufs.h      | 24 ------------------------
>  4 files changed, 2 insertions(+), 57 deletions(-)
>  delete mode 100644 include/linux/phy/phy-qcom-ufs.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> index 822c83b8efcd..681644e43248 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> @@ -17,9 +17,9 @@
>  
>  #include <linux/module.h>
>  #include <linux/clk.h>
> +#include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> -#include <linux/phy/phy-qcom-ufs.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 75ee5906b966..3dc4501c6945 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -16,7 +16,6 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> -#include <linux/phy/phy-qcom-ufs.h>
>  
>  #include "ufshcd.h"
>  #include "ufshcd-pltfrm.h"
> @@ -189,22 +188,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>  
>  static int ufs_qcom_link_startup_post_change(struct ufs_hba *hba)
>  {
> -	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct phy *phy = host->generic_phy;
>  	u32 tx_lanes;
> -	int err = 0;
> -
> -	err = ufs_qcom_get_connected_tx_lanes(hba, &tx_lanes);
> -	if (err)
> -		goto out;
>  
> -	err = ufs_qcom_phy_set_tx_lane_enable(phy, tx_lanes);
> -	if (err)
> -		dev_err(hba->dev, "%s: ufs_qcom_phy_set_tx_lane_enable failed\n",
> -			__func__);
> -
> -out:
> -	return err;
> +	return ufs_qcom_get_connected_tx_lanes(hba, &tx_lanes);
>  }
>  
>  static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
> @@ -932,10 +918,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  {
>  	u32 val;
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct phy *phy = host->generic_phy;
>  	struct ufs_qcom_dev_params ufs_qcom_cap;
>  	int ret = 0;
> -	int res = 0;
>  
>  	if (!dev_req_params) {
>  		pr_err("%s: incoming dev_req_params is NULL\n", __func__);
> @@ -1002,12 +986,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  		}
>  
>  		val = ~(MAX_U32 << dev_req_params->lane_tx);
> -		res = ufs_qcom_phy_set_tx_lane_enable(phy, val);
> -		if (res) {
> -			dev_err(hba->dev, "%s: ufs_qcom_phy_set_tx_lane_enable() failed res = %d\n",
> -				__func__, res);
> -			ret = res;
> -		}
>  
>  		/* cache the power mode parameters to use internally */
>  		memcpy(&host->dev_req_params,
> @@ -1264,10 +1242,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  		}
>  	}
>  
> -	/* update phy revision information before calling phy_init() */
> -	ufs_qcom_phy_save_controller_version(host->generic_phy,
> -		host->hw_ver.major, host->hw_ver.minor, host->hw_ver.step);
> -
>  	err = ufs_qcom_init_lane_clks(host);
>  	if (err)
>  		goto out_variant_clear;
> diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
> index 295f4bef6a0e..c114826316eb 100644
> --- a/drivers/scsi/ufs/ufs-qcom.h
> +++ b/drivers/scsi/ufs/ufs-qcom.h
> @@ -129,11 +129,6 @@ enum {
>  	MASK_CLK_NS_REG                     = 0xFFFC00,
>  };
>  
> -enum ufs_qcom_phy_init_type {
> -	UFS_PHY_INIT_FULL,
> -	UFS_PHY_INIT_CFG_RESTORE,
> -};
> -
>  /* QCOM UFS debug print bit mask */
>  #define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
>  #define UFS_QCOM_DBG_PRINT_ICE_REGS_EN	BIT(1)
> diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
> deleted file mode 100644
> index 9dd85071bcce..000000000000
> --- a/include/linux/phy/phy-qcom-ufs.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * Copyright (c) 2013-2015, Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#ifndef PHY_QCOM_UFS_H_
> -#define PHY_QCOM_UFS_H_
> -
> -#include "phy.h"
> -
> -int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
> -void ufs_qcom_phy_save_controller_version(struct phy *phy,
> -			u8 major, u16 minor, u16 step);
> -
> -#endif /* PHY_QCOM_UFS_H_ */
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
