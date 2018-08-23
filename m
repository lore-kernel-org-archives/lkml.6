Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ED5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73EE20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z97+KXh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73EE20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHWUue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:50:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41230 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeHWUue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:50:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so4749058ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LArb4wWEhYYayDbIbmrNGSJr8IVBc/t6rm9+PCajr8U=;
        b=Z97+KXh/b5KPF0gPPp/tV8KF37QH6QnpMqP/VYpW988WmL5ncf2X1yMLy+gwdguv+d
         ZcoKm7OKEwFCtEWfRDaYrDyxWldFdp2pl041YhNbpzkiXO9PLBDUWsHAHGa+O1FGASGU
         fHdg4WCCLu0bK+ELQmTkxe4fEntOKEp2jbQZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LArb4wWEhYYayDbIbmrNGSJr8IVBc/t6rm9+PCajr8U=;
        b=iP1zOnL1DBFWhf8SqQxRp0B1wuTUvzdVYzBlbFMfj7pNckwYjW6+P2cBsJthVots2r
         OZY4icORAH/t0yImu12uZDyxxcDdEYRzlittx1Kh7kPQ+JhdHnrdGknbK+tnzX6mf+Cf
         515EaOnmjATC1w5Hhvl5ORaLBJ2kc10G0ugbY5J29SXmuNNDE4Wk3yllLX6w2iVoOWHI
         1ryMGixbhMgBVb4PaFakZfhxt1DeXKfYQlBUHFFpnLphKl4jbj/OzAcVzOH2Eu7z1sNK
         DBehPe7eE8tZDRa4jpWcnWObM0OiiEIWFY9Z9NcAzkOhu350haHrcwZqU+a6LQr3tAlX
         2YYw==
X-Gm-Message-State: AOUpUlGLBrjKqbaZWQIk0dH9hY/0KjqPvCxjJ2omPXLcJDUTMjsetieX
        hgbDEYDs8utUm7Ogcd73d9H2Zr5byFY=
X-Google-Smtp-Source: AA+uWPwuNhJTsqAc78RLTkcbJfuozNjCDkX6dVggDX5hQ3oaD9nSnJvWFiblF0tYtP1AxJZPsizUuw==
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr42674352lji.11.1535044790961;
        Thu, 23 Aug 2018 10:19:50 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y65-v6sm922794lfa.97.2018.08.23.10.19.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 10:19:49 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u83-v6so4733574lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:19:48 -0700 (PDT)
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr39240782ljj.53.1535044788083;
 Thu, 23 Aug 2018 10:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <1534846649-2456-1-git-send-email-sayalil@codeaurora.org> <1534846649-2456-2-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1534846649-2456-2-git-send-email-sayalil@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Aug 2018 10:19:11 -0700
X-Gmail-Original-Message-ID: <CAE=gft6tA=B008oS-TP2e-aJ80ZQT_tF3Ngf6Ly5f5r=QqpBng@mail.gmail.com>
Message-ID: <CAE=gft6tA=B008oS-TP2e-aJ80ZQT_tF3Ngf6Ly5f5r=QqpBng@mail.gmail.com>
Subject: Re: [PATCH V9 1/2] scsi: ufs: set the device reference clock setting
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

On Tue, Aug 21, 2018 at 3:18 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
>  drivers/scsi/ufs/ufs.h    | 14 ++++++++
>  drivers/scsi/ufs/ufshcd.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h |  2 ++
>  3 files changed, 108 insertions(+)
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
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c5b1bf1..e946844 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6296,6 +6296,91 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
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
> +ufs_get_bref_clk_for_ref_clk_freq_hz(u32 freq)

This name is a little hairy. Maybe ufs_get_bref_clk_from_hz, or
ufs_hz_to_bref_clk?

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
> +       hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
> +
> +       refclk = of_clk_get_by_name(np, "ref_clk");
> +       if (!refclk)
> +               return;
> +
> +       freq = clk_get_rate(refclk);
> +       if (freq > REF_CLK_FREQ_52_MHZ) {

freq is in Hertz, but the enum value will be something like 3. I think
you should just call your function below, and then check the return
value of it for the error case you're trying to do here.

> +               dev_err(hba->dev,
> +               "%s: invalid ref_clk setting = %d\n",
> +               __func__, freq);
> +               return;
> +       }
> +
> +       hba->dev_ref_clk_freq =
> +               ufs_get_bref_clk_for_ref_clk_freq_hz(freq);
> +}
> +
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
> +{
> +       int err = 0;

You don't need to initialize this since you immediately assign it below.

> +       int ref_clk = -1;
> +       u32 freq = (u32)hba->dev_ref_clk_freq;

Is the cast necessary?

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
> +       if (err)
> +               dev_err(hba->dev, "%s: bRefClkFreq setting to %u Hz failed\n",
> +               __func__, ufs_ref_clk_freqs[freq].freq_hz);
> +       /*
> +        * It is good to print this out here to debug any later failures
> +        * related to gear switch.
> +        */
> +       dev_dbg(hba->dev, "%s: bRefClkFreq setting to %u Hz succeeded\n",
> +               __func__, ufs_ref_clk_freqs[freq].freq_hz);

In the error case you print out both the failed message and the success message?

> +
> +out:
> +       return err;
> +}
> +
>  /**
>   * ufshcd_probe_hba - probe hba to detect device and initialize
>   * @hba: per-adapter instance
> @@ -6361,6 +6446,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>                         "%s: Failed getting max supported power mode\n",
>                         __func__);
>         } else {
> +               /*
> +                * Set the right value to bRefClkFreq before attempting to
> +                * switch to HS gears.
> +                */
> +               if (hba->dev_ref_clk_freq != REF_CLK_FREQ_INVAL)
> +                       ufshcd_set_dev_ref_clk(hba);
>                 ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
>                 if (ret) {
>                         dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
> @@ -7693,6 +7784,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
>
>         INIT_LIST_HEAD(&hba->clk_list_head);
>
> +       ufshcd_parse_dev_ref_clk_freq(hba);

I get an uncomfortable feeling about calling this function from
alloc_host, given that everybody else calls their parse functions from
ufshcd_pltfrm_init. I wonder if you should just initialize the new
member here in alloc_host to the invalid value, and then move the call
to the parse function where you had it before in ufshcd_pltfrm_init.
That way you don't have the problems in the previous series with
leaving the value uninitialized, but you're also not calling of_
functions from alloc_host, which seems like an abuse of alloc_host.

-Evan
