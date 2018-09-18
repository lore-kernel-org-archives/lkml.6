Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B8ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1257F21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TdmMEjn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257F21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeISCcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:32:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42209 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:32:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so3018106ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2QjD39YllfNmmCFb12oPBzC0EYIqSe9VVN6FzHG3lI=;
        b=TdmMEjn1gPrfv0HzetJ7zczhQVgwZ/Op7ielDAC+pnk6DiBDBPPDqrO3Lds7SEDuix
         MmtMTqyWeIgVNykh2Tkn/P7HVgQM9NtT5jTXPMkxcXRP1elGAqkBsrXLUhLpWEJQGvxd
         9MD10LOTFuG9mDAxzsCiiZJAOPAjDBYuYtVoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2QjD39YllfNmmCFb12oPBzC0EYIqSe9VVN6FzHG3lI=;
        b=Nhjh9l7Z5F68eZ9M2VWMXacEtu4KxS6I33agO1OTA8okdYeu/P8Vbp7bfFxSekeiC5
         UOXaTw3Wly0y68HLFBgZ+gvm1/M70IVM9eMtdeMG25uTLlezb70CHpxuoKm1Dk0KY/SU
         UrLQTLQfAc1HRhjbgXNi/2iEh53rMYhCCJsYG5BuhZcvL6Z6Ta5GxWQ1Bp3syK44lgD8
         Xffyeu/FECFuN624wFcAmwpcmbU9Jmcnv2ukf2R1LzwBXKx+vI49gCzqg3oSJA7duofU
         D3BeRy53rG1Ig3ySzx7XnbCx30tciaV0xIwFg7zcXKNXmz6o9qKX9VfnfMjy6SsS8RLa
         LAKA==
X-Gm-Message-State: APzg51CtJuJ03Ba3QgCqh23YzE0HNGVzev4cj5eYVw9tVelP+Ed99Rfm
        vQTZBGZfsvN0X30KfzuFDmfjS1wPwWI=
X-Google-Smtp-Source: ANB0VdYkaqrGrugRm9hrbCcodU36A3azuVOfe/Pv6n+BEGZ1Uk+cO07iE8Kw1BRmCueggLXkt9M7wA==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr2848170ljv.113.1537304269315;
        Tue, 18 Sep 2018 13:57:49 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c198-v6sm659668lfg.95.2018.09.18.13.57.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 13:57:48 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id s12-v6so3046268ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 13:57:47 -0700 (PDT)
X-Received: by 2002:a2e:8103:: with SMTP id d3-v6mr18563758ljg.3.1537304267476;
 Tue, 18 Sep 2018 13:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <1536918159-311-1-git-send-email-sayalil@codeaurora.org> <1536918159-311-2-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1536918159-311-2-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 18 Sep 2018 13:57:09 -0700
X-Gmail-Original-Message-ID: <CAE=gft7UFMSyJrZ36iNay-nt6jywzucd4MOeAcErEJg9vpRhwQ@mail.gmail.com>
Message-ID: <CAE=gft7UFMSyJrZ36iNay-nt6jywzucd4MOeAcErEJg9vpRhwQ@mail.gmail.com>
Subject: Re: [PATCH V13 1/2] scsi: ufs: set the device reference clock setting
To:     sayali <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, adrian.hunter@intel.com,
        Joel Becker <jlbec@evilplan.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 2:43 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
>
> From: Subhash Jadavani <subhashj@codeaurora.org>
>
> UFS host supplies the reference clock to UFS device and UFS device
> specification allows host to provide one of the 4 frequencies (19.2 MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
> device reference clock frequency setting in the device based on what
> frequency it is supplying to UFS device.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs.h           | 14 +++++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c |  2 +
>  drivers/scsi/ufs/ufshcd.c        | 90 ++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h        |  2 +
>  4 files changed, 108 insertions(+)
>
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index 14e5bf7..a2e76b1 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -378,6 +378,20 @@ enum query_opcode {
>         UPIU_QUERY_OPCODE_TOGGLE_FLAG   = 0x8,
>  };
>
> +/* bRefClkFreq attribute values */
> +enum ufs_ref_clk_freq {
> +       REF_CLK_FREQ_19_2_MHZ   = 0,
> +       REF_CLK_FREQ_26_MHZ     = 1,
> +       REF_CLK_FREQ_38_4_MHZ   = 2,
> +       REF_CLK_FREQ_52_MHZ     = 3,
> +       REF_CLK_FREQ_INVAL      = -1,
> +};
> +
> +struct ufs_ref_clk {
> +       u32 freq_hz;
> +       enum ufs_ref_clk_freq val;
> +};
> +
>  /* Query response result code */
>  enum {
>         QUERY_RESULT_SUCCESS                    = 0x00,
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index e82bde0..0953563 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -343,6 +343,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
>
> +       ufshcd_parse_dev_ref_clk_freq(hba);
> +
>         ufshcd_init_lanes_per_dir(hba);
>
>         err = ufshcd_init(hba, mmio_base, irq);
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c5b1bf1..e01cdc0 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6296,6 +6296,89 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>         hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>  }
>
> +static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
> +       {19200000, REF_CLK_FREQ_19_2_MHZ},
> +       {26000000, REF_CLK_FREQ_26_MHZ},
> +       {38400000, REF_CLK_FREQ_38_4_MHZ},
> +       {52000000, REF_CLK_FREQ_52_MHZ},
> +       {0, REF_CLK_FREQ_INVAL},
> +};
> +
> +static inline enum ufs_ref_clk_freq
> +ufs_get_bref_clk_from_hz(u32 freq)
> +{
> +       int i = 0;
> +
> +       while (ufs_ref_clk_freqs[i].freq_hz != freq) {
> +               if (!ufs_ref_clk_freqs[i].freq_hz)
> +                       return REF_CLK_FREQ_INVAL;
> +               i++;
> +       }
> +
> +       return ufs_ref_clk_freqs[i].val;
> +}
> +
> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
> +{
> +       struct device *dev = hba->dev;
> +       struct device_node *np = dev->of_node;
> +       struct clk *refclk = NULL;
> +       u32 freq = 0;
> +
> +       if (!np)
> +               return;
> +
> +       refclk = of_clk_get_by_name(np, "ref_clk");
> +       if (!refclk)
> +               return;
> +
> +       freq = clk_get_rate(refclk);
> +
> +       hba->dev_ref_clk_freq =
> +               ufs_get_bref_clk_from_hz(freq);
> +
> +       if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
> +               dev_err(hba->dev,
> +               "%s: invalid ref_clk setting = %d\n",
> +               __func__, freq);
> +}
> +
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
> +{
> +       int err, ref_clk = -1;
> +       u32 freq = hba->dev_ref_clk_freq;
> +
> +       err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
> +
> +       if (err) {
> +               dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
> +                        __func__, err);
> +               goto out;
> +       }
> +
> +       if (ref_clk == hba->dev_ref_clk_freq)
> +               goto out; /* nothing to update */
> +
> +       err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &freq);
> +
> +       if (err) {
> +               dev_err(hba->dev, "%s: bRefClkFreq setting to %u Hz failed\n",
> +               __func__, ufs_ref_clk_freqs[freq].freq_hz);
> +               goto out;
> +       }
> +       /*
> +        * It is good to print this out here to debug any later failures
> +        * related to gear switch.
> +        */
> +       dev_dbg(hba->dev, "%s: bRefClkFreq setting to %u Hz succeeded\n",
> +               __func__, ufs_ref_clk_freqs[freq].freq_hz);
> +

The comment above doesn't add any value in my opinion. Other than that:

Reviewed-by: Evan Green <evgreen@chromium.org>
