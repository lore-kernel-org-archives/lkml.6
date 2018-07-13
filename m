Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8C0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C052208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAIt4Y8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C052208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbeGMWlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:41:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44276 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGMWlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:41:17 -0400
Received: by mail-lf0-f67.google.com with SMTP id g6-v6so17648178lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YT/ci7bISW46OonRpcVLl8DzedU068Qzzw6nDaIGqY=;
        b=dAIt4Y8tRDjBBr2zgyVpAcRp0J03KL1hMOQ5JNit6ZFL68q05bct2ENPblORoyXz/S
         qGVUyPIPBpmSWeaN/o0RqClo7g2N0hw8jrw3CNdoVXEjz6mdSLjQlf9WDjIWXmwgcY6v
         yn2mcJxNyZF9jGyuPPJo7THbZH4MIlizltbH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YT/ci7bISW46OonRpcVLl8DzedU068Qzzw6nDaIGqY=;
        b=OE2vtnuD3ZK/6XX2K9K7R7vlUI7h7fGYeSKb79OOsl/1gJBRWsNrwNnG9fYd76g9BS
         5JJwcpiqWXuwM6xqHPyoPpmQ4qVf81mOixjGjkcMB0fx/gExAszcDkOKjGERBCLdqPMa
         2JpB8n/HU7CMkRcCawQPLg7VZNS/UF0hlsecCRFjDv3Efi0k45Y5BRcQLTshjlpBn1XI
         kW4zTCPLjgeSNc2rhMlnlCuNcrERcEeWQyunAmzYbEHFpOKtwdIaGGvswZ8hAfrKCK1z
         PA3wK5SGee4aJgnvNdnu8fXl50O3zQ5vLEN2goyUF857uTrmozH3BSOzVoxLN/tobovX
         2SfQ==
X-Gm-Message-State: AOUpUlHtQAmf3oF/yDrsWp1uTPuQA0+Khbb9qeBu1EfDC02bjJaNW4EE
        srEVC6qR0hB4O5KoLcCNZM+wrMYCDDU=
X-Google-Smtp-Source: AAOMgpfLDumN7xeSk3HDAHDHRAZh4zISjPLvb/8IGXtN2keb2nC5DPQDbPg5JDXHMreBK3AXSnkHsQ==
X-Received: by 2002:a19:1888:: with SMTP id 8-v6mr5898534lfy.121.1531520680147;
        Fri, 13 Jul 2018 15:24:40 -0700 (PDT)
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com. [209.85.215.53])
        by smtp.gmail.com with ESMTPSA id 13-v6sm3756673ljx.2.2018.07.13.15.24.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 15:24:39 -0700 (PDT)
Received: by mail-lf0-f53.google.com with SMTP id l16-v6so28333276lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 15:24:38 -0700 (PDT)
X-Received: by 2002:a19:10c4:: with SMTP id 65-v6mr6538548lfq.113.1531520678196;
 Fri, 13 Jul 2018 15:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180709234937.176154-1-evgreen@chromium.org> <7bd24be2-e019-42f8-555f-719cd602dc40@codeaurora.org>
In-Reply-To: <7bd24be2-e019-42f8-555f-719cd602dc40@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 13 Jul 2018 15:24:01 -0700
X-Gmail-Original-Message-ID: <CAE=gft5R+heM3GUH8MPgt5TA6q3FkgrfCbhaGW_iWhqvuB1RTA@mail.gmail.com>
Message-ID: <CAE=gft5R+heM3GUH8MPgt5TA6q3FkgrfCbhaGW_iWhqvuB1RTA@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix suspend clock handling
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, Doug Anderson <dianders@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:21 PM Karthik Ramasubramanian
<kramasub@codeaurora.org> wrote:
>
>
>
> On 7/9/2018 5:49 PM, Evan Green wrote:
> > pm_runtime_suspended can return 0 even if the last runtime power
> > management function called in the device was a suspend call. This
> > trips up the i2c-qcom-geni's suspend_noirq accounting, which was
> > trying to use the function to determine if it should disable clocks
> > or if that had already been done.
> >
> > The fix is to track whether or not clocks have been enabled explicitly
> > in the driver with a new member. While in there, also honor the return
> > value of geni_se_resources_off, which can technically fail.
> >
> > An example of the warning generated during suspend:
> > [   68.314733] WARNING: CPU: 0 PID: 1990 at drivers/clk/clk.c:595 clk_core_disable+0x28/0x200
> > [   68.464576] Call trace:
> > [   68.554410] [<ffffff80083f0ed0>] clk_core_disable+0x28/0x200
> > [   68.560244] [<ffffff80083f349c>] clk_disable+0x38/0x4c
> > [   68.565541] [<ffffff8008408910>] geni_se_resources_off+0x40/0x74
> > [   68.571731] [<ffffff800862aadc>] geni_i2c_runtime_suspend+0x2c/0x3c
> > [   68.578185] [<ffffff800862ae6c>] geni_i2c_suspend_noirq+0x38/0x68
> > [   68.584475] [<ffffff800852bd40>] dpm_run_callback+0x104/0x210
> > [   68.590404] [<ffffff800852c3d4>] __device_suspend_noirq+0x158/0x1a8
> > [   68.596859] [<ffffff800852dff0>] dpm_noirq_suspend_devices+0x180/0x38c
> > [   68.603594] [<ffffff80080fdebc>] suspend_devices_and_enter+0x49c/0x964
> > [   68.610321] [<ffffff80080fea14>] pm_suspend+0x690/0x6e0
> > [   68.615712] [<ffffff80080fc930>] state_store+0xd4/0xf8
> > [   68.621014] [<ffffff80088a57f0>] kobj_attr_store+0x18/0x28
> > [   68.626672] [<ffffff8008297a54>] sysfs_kf_write+0x5c/0x68
> > [   68.632240] [<ffffff8008296a00>] kernfs_fop_write+0x174/0x1b8
> > [   68.638177] [<ffffff800821a2c4>] __vfs_write+0x58/0x160
> > [   68.643567] [<ffffff800821a5d8>] vfs_write+0xcc/0x184
> > [   68.648780] [<ffffff800821a850>] SyS_write+0x64/0xb4
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > This change applies atop Karthik's patch [1], which as far as I can tell
> > technically hasn't landed yet, but also hasn't had feedback in awhile
> > either. I opted to submit this as a separate patch, but if the maintainers
> > prefer it's fine with me if this get folded in to another spin of the
> > base series.
> >
> > [1] https://patchwork.kernel.org/patch/10460819/
> >
> >  drivers/i2c/busses/i2c-qcom-geni.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > index 54bcd1a79cc5..90c4cbfa22d8 100644
> > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > @@ -85,6 +85,7 @@ struct geni_i2c_dev {
> >       spinlock_t lock;
> >       u32 clk_freq_out;
> >       const struct geni_i2c_clk_fld *clk_fld;
> > +     int suspended;
> >  };
> >
> >  struct geni_i2c_err_log {
> > @@ -567,9 +568,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
> >       geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
> >       geni_se_config_packing(&gi2c->se, BITS_PER_BYTE, PACKING_BYTES_PW,
> >                                                       true, true, true);
> > -     geni_se_resources_off(&gi2c->se);
> > +     ret = geni_se_resources_off(&gi2c->se);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Error turning off resources %d\n", ret);
> > +             return ret;
> > +     }
> > +
> >       dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
> >
> > +     gi2c->suspended = 1;
> >       pm_runtime_set_suspended(gi2c->se.dev);
> >       pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
> >       pm_runtime_use_autosuspend(gi2c->se.dev);
> > @@ -590,10 +597,19 @@ static int geni_i2c_remove(struct platform_device *pdev)
> >
> >  static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
> >  {
> > +     int ret;
> >       struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> >
> >       disable_irq(gi2c->irq);
> > -     geni_se_resources_off(&gi2c->se);
> > +     ret = geni_se_resources_off(&gi2c->se);
> > +     if (ret) {
> > +             enable_irq(gi2c->irq);
> > +             return ret;
> > +
> > +     } else {
> > +             gi2c->suspended = 1;
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -607,12 +623,15 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
> >               return ret;
> >
> >       enable_irq(gi2c->irq);
> > +     gi2c->suspended = 0;
> >       return 0;
> >  }
> >
> >  static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
> >  {
> > -     if (!pm_runtime_suspended(dev)) {
> > +     struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
> > +
> > +     if (!gi2c->suspended) {
> >               geni_i2c_runtime_suspend(dev);
> >               pm_runtime_disable(dev);
> >               pm_runtime_set_suspended(dev);
> >
> Reviewed-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>

Sounds good to me, Wolfram. Thanks for the review, Karthik.
-Evan
