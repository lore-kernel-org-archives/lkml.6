Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F443C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBD9218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkgm+xXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbeLUJDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:03:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38311 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLUJDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:03:24 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so3361651lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMDNDJEbhmw6cJ1gaXs4EtD5SDcFjmkJQrMnPqLksaw=;
        b=dkgm+xXZk74Cg2BNDCm/20NQdtrWMwIe0yoKv4DArWUbA22TL3cuEXSr9/CNqSHNVw
         mn5eLVbGIs56liR+SE1pEw2i5Odhz2ETGTAH/tJoXcBHFuAYmvUrTu57WR7JT2UX9hs/
         l+LuzaxwiUn9sq0tG688SBhVLLbwEY46BvoH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMDNDJEbhmw6cJ1gaXs4EtD5SDcFjmkJQrMnPqLksaw=;
        b=t0LVcuQH0TCDhcRddMaTBPtHgMeWTuD1e9U/elNTCY9bZtIu9n4QBirYoLZgMPTU5H
         jerZf05wBG09Os84Q0nqEBYzY+r1GUgh80wRq8Pi+0vIL5hGESaM37NTyn5lkELdkb6Q
         GHTgUfhNDcqiozYJdCbUVnh4vwAQrtMOZIAhHgU+xgv9V5drUVGq/mkKdwEEg/LODLRN
         96T1i6o/ahvbbcaLyyhlF9GMM9JSGAhpTF7AajzQbmQPKA42yDwtUY5qQSGi6yJw/Utl
         Pl0JDSzT/ucqer4zZALMNNQ7CXH7YgaCMDUn6/xD/r61ePYYQHPmGQ082aECEZz6d96f
         4Oww==
X-Gm-Message-State: AA+aEWarA/OBkouQCse6blaz389NjNXnYAizrW2YWy/ZjnTEfReH8EOd
        qK0d05yzHhuLtwv7nf+0+DpoU8cWps1+HsVOKzGltQ==
X-Google-Smtp-Source: AFSGD/WWHVd8zr/biKpKvHjmEj8TL5SWd9I6l53as8Xl+0kFHieFSstFXwVpLi6wMvEseHQRjbY3ODdLwJcmc1Rlkfg=
X-Received: by 2002:a19:5601:: with SMTP id k1mr781748lfb.99.1545383001128;
 Fri, 21 Dec 2018 01:03:21 -0800 (PST)
MIME-Version: 1.0
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com> <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181219164827.20985-8-wsa+renesas@sang-engineering.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 21 Dec 2018 17:03:09 +0800
Message-ID: <CAMz4kuLv_s6t6n0OfRP8EW3=z8QD0ezn2=45sKg9aXJs5Agrbg@mail.gmail.com>
Subject: Re: [PATCH 07/10] i2c: sprd: use core helper to mark adapter suspended
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, 20 Dec 2018 at 00:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Rejecting transfers should be handled by the core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Great to see the I2C core can handle this issue.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/i2c/busses/i2c-sprd.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
> index e266d8a713d9..961123529678 100644
> --- a/drivers/i2c/busses/i2c-sprd.c
> +++ b/drivers/i2c/busses/i2c-sprd.c
> @@ -86,7 +86,6 @@ struct sprd_i2c {
>         u32 count;
>         int irq;
>         int err;
> -       bool is_suspended;
>  };
>
>  static void sprd_i2c_set_count(struct sprd_i2c *i2c_dev, u32 count)
> @@ -284,9 +283,6 @@ static int sprd_i2c_master_xfer(struct i2c_adapter *i2c_adap,
>         struct sprd_i2c *i2c_dev = i2c_adap->algo_data;
>         int im, ret;
>
> -       if (i2c_dev->is_suspended)
> -               return -EBUSY;
> -
>         ret = pm_runtime_get_sync(i2c_dev->dev);
>         if (ret < 0)
>                 return ret;
> @@ -590,10 +586,7 @@ static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
>  {
>         struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = true;
> -       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_suspended(&i2c_dev->adap);
>         return pm_runtime_force_suspend(dev);
>  }
>
> @@ -601,10 +594,7 @@ static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
>  {
>         struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = false;
> -       i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_resumed(&i2c_dev->adap);
>         return pm_runtime_force_resume(dev);
>  }
>
> --
> 2.11.0
>


-- 
Baolin Wang
Best Regards
