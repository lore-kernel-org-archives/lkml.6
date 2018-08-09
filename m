Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F360C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C6D21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HB+xDaGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C6D21F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHIU1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:27:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34553 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHIU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:27:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so5192519ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBRePFpH+4fbpwPfUjYWaEb9JltpG94wdW7GpUjFunw=;
        b=HB+xDaGMmXm9S6ESbIta0U68N/z1+YUs5uYr3Bo65FIIWEJZkfm9lC9MyDyBNxitJn
         QqYgpnEDUdyURIYq5xktKaK6Q1/DV4k1Q6hM/PsgadU6N7/aMLJO31ehIQn5SPFxdsAZ
         MqRPJD7JHG/zC9LG5pquXLca3ofcBDui1fgeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBRePFpH+4fbpwPfUjYWaEb9JltpG94wdW7GpUjFunw=;
        b=aa0kQyC0Bqi7OHZ9QbAe9ZeaQndNVOfSqegSRAWytjzQijOozwW770I9CRQ508MUni
         5GKi3Wzi42ng+VimuwzUZLOkvETChEv+Yz5PLjKzUTF0VryBKlgEaoveeSieN3vNnLQF
         /NAQMEZFtbcC1qFmvQhZt+7NfX5eQMLlrqnNno6kR4MdtN+s8V0JtecTix21BDBrnhQ7
         7W2emDderbWpofqnJMrcv1FtzBnCAvnE7+LNMcITvpvVCecg9AiIfx7vRUVqK13swZxq
         KnQBQedvJJd+IWtC37RgTg8FXscTsvZCBMj1uliRxVTeKEXU0AoikKIk1p+EqG5xkdDg
         /Iww==
X-Gm-Message-State: AOUpUlFp3M+smVZZn549MipAnQg3L3THgylpTGLPc1vWkcX0ydiCUJBj
        xEZKA7z0K24dXTlEGPbOkWon+rXMZME=
X-Google-Smtp-Source: AA+uWPyBCAH45N12zoAzY5TKXaxtI+kSFObqZMP1v99G7BMytYvVwp02WGnjBRyeIeA/8yGhAdMT+g==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr2333202lji.78.1533837676189;
        Thu, 09 Aug 2018 11:01:16 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u10-v6sm1223017ljk.83.2018.08.09.11.01.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:01:15 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v9-v6so5175316ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:01:14 -0700 (PDT)
X-Received: by 2002:a2e:540d:: with SMTP id i13-v6mr2280866ljb.51.1533837673545;
 Thu, 09 Aug 2018 11:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180731100914.19856-1-cang@codeaurora.org> <20180731100914.19856-5-cang@codeaurora.org>
In-Reply-To: <20180731100914.19856-5-cang@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 9 Aug 2018 11:00:37 -0700
X-Gmail-Original-Message-ID: <CAE=gft4xCk2MD-oOAuCRwWz6J9mMvZGFR2J+E7vcu06+3xBZRQ@mail.gmail.com>
Message-ID: <CAE=gft4xCk2MD-oOAuCRwWz6J9mMvZGFR2J+E7vcu06+3xBZRQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] scsi: ufs: Power on phy after it is initialized
To:     cang@codeaurora.org
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 3:09 AM Can Guo <cang@codeaurora.org> wrote:
>
> Before UFS PHY is initialized, powering on it has no effect but increases
> the PHY's power on count. Then when power on PHY to enable it after phy
> initialization where it is really needed, as PHY's power on count is not
> zero, again it would do nothing but directly return and leaves the PHY
> disabled. This change adds condition checks to phy power on calls which
> happen before phy initialization.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 4 +++-
>  drivers/scsi/ufs/ufs-qcom.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 2b38db2..4e9d526 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -288,6 +288,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>                         __func__, ret);
>                 goto out;
>         }
> +       host->is_phy_init = true;
>
>         /* De-assert PHY reset and start serdes */
>         ufs_qcom_deassert_reset(hba);
> @@ -1147,7 +1148,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>                 return 0;
>
>         if (on && (status == POST_CHANGE)) {
> -               phy_power_on(host->generic_phy);
> +               if (host->is_phy_init)
> +                       phy_power_on(host->generic_phy);
>
>                 /* enable the device ref clock for HS mode*/
>                 if (ufshcd_is_hs_mode(&hba->pwr_info))
> diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
> index 295f4be..5747aa3 100644
> --- a/drivers/scsi/ufs/ufs-qcom.h
> +++ b/drivers/scsi/ufs/ufs-qcom.h
> @@ -242,6 +242,7 @@ struct ufs_qcom_host {
>         /* Bitmask for enabling debug prints */
>         u32 dbg_print_en;
>         struct ufs_qcom_testbus testbus;
> +       bool is_phy_init;
>  };
>
>  static inline u32
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Evan Green <evgreen@chromium.org>
