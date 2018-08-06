Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21078C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DAD21A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oEoiSu99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DAD21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeHFThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:37:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42288 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeHFThF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:37:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so11217637ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rovdedEt9e5Dmj0OiGCA0JoJVLW6cati0/Now/IeSHo=;
        b=oEoiSu99ZhRYaXadwajHpLGlQNe19owljS288/ifMJz9FXEzn1XvferStzSs+1Vpfy
         JEcGGXxMIxZWAEF6nybHde8XE+o/8I0TFuIbdN/1+AeJJmTinKtYIfdLSNotzdxnr5/L
         KXa0Ffid2cSDmqloZ0kkKizkuyuXlU9sMcHkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rovdedEt9e5Dmj0OiGCA0JoJVLW6cati0/Now/IeSHo=;
        b=XgIVlk76cN2Y11zUjl1K9Pu4KbZFKUVMC5/6fIBD8iXAVoo08FAK7D0qkEyf97mBOD
         u2BIzV0qfPc5S9oF/Wq6oo2sA3LiAVeC9kRbaBv1FT5PWdiYp0LRnXTDEPe7uDzqLhTN
         pLpx4iNtygpjRqFVAiW67T4qHjwRm5lmhvK4rlFSiASFOZKFhIgp7IrxGt5gbzTVUWrA
         Yx/vZpp+HaYZsRaPuFE2vYlqD68LG8J5BlgUYNf3K96C9hPBhOXRo6R8pvkLRws7sHtT
         qBaLGECFJNVv6L7TA0hYwd1HC0n1yC+uLgE7KcUHvDN/vX5+tJqCBRm+WOM4Dv5OcD6b
         lxlw==
X-Gm-Message-State: AOUpUlHEG/JIXlFEqrONuLRXvU9aqq5CYgssM6eicJTd/UbC/6Co2gLO
        j/rwgumfyOLlBvIEMDFu1d2SOptBaJA=
X-Google-Smtp-Source: AAOMgpcs+fizs2vBkwr4oR7RWRxxOHclL/yqn0Ov3uRQKtgwPCgwm+WD47B12U79o63UEIXXq4W3Ew==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr11699716ljk.133.1533576418051;
        Mon, 06 Aug 2018 10:26:58 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q128-v6sm2338404ljq.72.2018.08.06.10.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 10:26:56 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id j8-v6so9642023lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:26:56 -0700 (PDT)
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr11475685lfi.126.1533576415734;
 Mon, 06 Aug 2018 10:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <1533113338-31750-1-git-send-email-sayalil@codeaurora.org> <1533113338-31750-2-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1533113338-31750-2-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 6 Aug 2018 10:26:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft6H2iYx59fXc2SHP+Rr9M07Vjk99-Rgk1Kx-GnVJT86DQ@mail.gmail.com>
Message-ID: <CAE=gft6H2iYx59fXc2SHP+Rr9M07Vjk99-Rgk1Kx-GnVJT86DQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] scsi: ufs: set the device reference clock setting
To:     sayalil@codeaurora.org
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sayali,

On Wed, Aug 1, 2018 at 1:49 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
>  drivers/scsi/ufs/ufs.h           |  8 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c |  2 +
>  drivers/scsi/ufs/ufshcd.c        | 84 ++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h        |  2 +
>  4 files changed, 96 insertions(+)
>
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index 14e5bf7..89e0a33 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -378,6 +378,14 @@ enum query_opcode {
>         UPIU_QUERY_OPCODE_TOGGLE_FLAG   = 0x8,
>  };
>
> +/* bRefClkFreq attribute values */
> +enum ref_clk_freq {
> +       REF_CLK_FREQ_19_2_MHZ   = 19200000,
> +       REF_CLK_FREQ_26_MHZ     = 26000000,
> +       REF_CLK_FREQ_38_4_MHZ   = 38400000,
> +       REF_CLK_FREQ_52_MHZ     = 52000000,
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
> index c5b1bf1..619313b 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6296,6 +6296,84 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>         hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>  }
>
> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
> +{
> +       struct device *dev = hba->dev;
> +       struct device_node *np = dev->of_node;
> +       struct clk *refclk = NULL;
> +
> +       if (!np)
> +               return;
> +
> +       refclk = of_clk_get_by_name(np, "ref_clk");
> +       if (refclk)
> +               hba->dev_ref_clk_freq  = clk_get_rate(refclk);
> +       else if (!refclk ||
> +               (hba->dev_ref_clk_freq > REF_CLK_FREQ_52_MHZ)) {

What is this logic? The !refclk condition will always be true since
you're in the else case of if (refclk). Also, even if the second part
were executed somehow, you haven't assigned dev_ref_clk_freq yet, so
how can its value be anything other than 0? Maybe that whole
conditional was just not supposed to be an "else" at all, but a
standalone if?

> +               dev_err(hba->dev,
> +               "%s: invalid ref_clk setting = %u\n",
> +               __func__, hba->dev_ref_clk_freq);

There's probably no need to complain if the clock simply couldn't be
found, only if an unexpected value was found.

> +               hba->dev_ref_clk_freq = 0;
> +       }
> +}
> +
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
> +{
> +       int err = 0;
> +       int ref_clk = -1;
> +       static const char * const ref_clk_freqs[] = {"19.2 MHz", "26 MHz",
> +                                                    "38.4 MHz", "52 MHz"};
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
> +       switch (hba->dev_ref_clk_freq) {
> +       case REF_CLK_FREQ_19_2_MHZ:
> +               hba->dev_ref_clk_freq = 0x0;
> +               break;
> +       case REF_CLK_FREQ_26_MHZ:
> +               hba->dev_ref_clk_freq = 0x1;
> +               break;
> +       case REF_CLK_FREQ_38_4_MHZ:
> +               hba->dev_ref_clk_freq = 0x2;
> +               break;
> +       case REF_CLK_FREQ_52_MHZ:
> +               hba->dev_ref_clk_freq = 0x3;
> +               break;
> +       default:
> +               dev_err(hba->dev,
> +               "%s: invalid ref_clk setting = %u\n",
> +               __func__, hba->dev_ref_clk_freq);
> +               goto out;
> +       }

Please don't assign two different things (frequency in Hertz and
bref_clk value) into the same structure member.

I think rather than having this switch statement you should iterate
through a table that contains elements of {freq_hz, bref_clk, string}.
I think you should do this up in ufshcd_parse_dev_ref_clk_freq so that
you don't have to redo that calculation on every rescan. Then store
the final bRefClkFreq value (or -1 if no definitive answer could be
reached) in your new structure member. Then all this function does is
1) Nothing if dev_ref_clk_freq is -1, or 2) read and maybe write the
attribute.

> +
> +       if (ref_clk == hba->dev_ref_clk_freq)
> +               goto out; /* nothing to update */
> +
> +       err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
> +                       &hba->dev_ref_clk_freq);
> +
> +       if (err)
> +               dev_err(hba->dev, "%s: bRefClkFreq setting to %s failed\n",
> +                       __func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
> +       /*
> +        * It is good to print this out here to debug any later failures
> +        * related to gear switch.
> +        */
> +       dev_dbg(hba->dev, "%s: bRefClkFreq setting to %s succeeded\n",
> +                       __func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
> +
> +out:
> +       return err;
> +}
> +
>  /**
>   * ufshcd_probe_hba - probe hba to detect device and initialize
>   * @hba: per-adapter instance
> @@ -6361,6 +6439,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>                         "%s: Failed getting max supported power mode\n",
>                         __func__);
>         } else {
> +               /*
> +                * Set the right value to bRefClkFreq before attempting to
> +                * switch to HS gears.
> +                */
> +               if (hba->dev_ref_clk_freq)
> +                       ufshcd_set_dev_ref_clk(hba);
>                 ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
>                 if (ret) {
>                         dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 8110dcd..101a75c 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -548,6 +548,7 @@ struct ufs_hba {
>         void *priv;
>         unsigned int irq;
>         bool is_irq_enabled;
> +       u32 dev_ref_clk_freq;

If you followed my suggestion of this storing _only_ the bRefClkFreq
value or -1 if unset, then this would need to be signed, and
initialized somewhere so that 0 wasn't accidentally taken to be a
parsed value.

>
>         /* Interrupt aggregation support is broken */
>         #define UFSHCD_QUIRK_BROKEN_INTR_AGGR                   0x1
> @@ -746,6 +747,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
>  int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
>                                 u32 val, unsigned long interval_us,
>                                 unsigned long timeout_ms, bool can_sleep);
> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba);
>
>  static inline void check_upiu_size(void)
>  {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
