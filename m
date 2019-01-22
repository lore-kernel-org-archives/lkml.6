Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0122AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94120866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nCd04wec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfAVWlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:41:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39730 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAVWlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:41:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so168283ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llLReD4qXPJr43BL7RQyUXpT+nnzxU4MNu+0Lxyg34M=;
        b=nCd04wecy54QOt4rRkX8Qx3YKQQYUVPJwW4OKJ/I16hPZMiQQhwAjimbH2q30SX29N
         Cvb5SOv41OxK6mgoFGdp8ocPjLi+q3khAXIxeR9zN0okTBxcPlmg88a8JZTsQrTFqtYs
         ZZKMqjkJ2YSN7InEnALfKZjIC93IljsbbKAQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llLReD4qXPJr43BL7RQyUXpT+nnzxU4MNu+0Lxyg34M=;
        b=qaOE5oMbB2tKRjDW/NQlsGyfOkuJrWiGhh3oblhY1h6iyRvE3mhpQUAhp1YgOtReOr
         9wNbepYAh/gop+46UGBTRwSDVRPRtDLM0VstFQYXmDEAJerW464bej7XBzq4I8bJzi4F
         S1sRdxA3RKC8dcpg5hpQX17urF10GdGvun6ny7cRM42hsJ1lCg/C66R+p2xTv/x6gVa3
         DPnca/C1uSDxAceFbPzpbo0VImK4Rp8zw2iDKc4iGdzvcNoApJTsYIOkgGPfTeWmO7vI
         U1DrRFP0I+fc2X18bhU7CUgY9Zvu/002MNRzI48DkYpj89uPX/3rkgUFfV4/y3FPWGC+
         7Yhg==
X-Gm-Message-State: AJcUukcAQNGpj2xAROpVgIMLx+YV4diPXOlqy9k9t2k0b/C9tci5pIsZ
        D0MaY+PUTZZ+WaYob39xxwRc05/uPZc=
X-Google-Smtp-Source: ALg8bN7BFLj/+o/bkpSms3xxLcSP8k7GyowBepSYEJMh65dAWPQxjVmWgoIflZSaUdqXzT7bnTmvSA==
X-Received: by 2002:a2e:9bc3:: with SMTP id w3-v6mr21357763ljj.70.1548196893187;
        Tue, 22 Jan 2019 14:41:33 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v5-v6sm198527lje.78.2019.01.22.14.41.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 14:41:31 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id t18-v6so179613ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:41:31 -0800 (PST)
X-Received: by 2002:a2e:7011:: with SMTP id l17-v6mr23187415ljc.147.1548196891209;
 Tue, 22 Jan 2019 14:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-6-evgreen@chromium.org>
 <154785066196.169631.9228316876601255899@swboyd.mtv.corp.google.com>
In-Reply-To: <154785066196.169631.9228316876601255899@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 14:40:54 -0800
X-Gmail-Original-Message-ID: <CAE=gft5-96uyFhU-15MmQKKdYQn2mO2oRfg5P+OAt+J-eAze8g@mail.gmail.com>
Message-ID: <CAE=gft5-96uyFhU-15MmQKKdYQn2mO2oRfg5P+OAt+J-eAze8g@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] scsi: ufs: qcom: Expose the reset controller for PHY
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 2:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-11 15:01:26)
> > diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> > index 3aeadb14aae1e..db46f9a64b54c 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.c
> > +++ b/drivers/scsi/ufs/ufs-qcom.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy/phy.h>
> > +#include <linux/reset.h>
>
> Shouldn't this be <linux/reset-controller.h>?

Oh, actually I don't need this at all since ufs-qcom.h includes
reset-controller.h. Will remove.

>
> >
> >  #include "ufshcd.h"
> >  #include "ufshcd-pltfrm.h"
> > @@ -255,11 +261,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >         if (is_rate_B)
> >                 phy_set_mode(phy, PHY_MODE_UFS_HS_B);
> >
> > -       /* Assert PHY reset and apply PHY calibration values */
> > -       ufs_qcom_assert_reset(hba);
> > -       /* provide 1ms delay to let the reset pulse propagate */
> > -       usleep_range(1000, 1100);
> > -
> >         /* phy initialization - calibrate the phy */
> >         ret = phy_init(phy);
> >         if (ret) {
> > @@ -268,15 +269,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >                 goto out;
> >         }
> >
> > -       /* De-assert PHY reset and start serdes */
> > -       ufs_qcom_deassert_reset(hba);
> > -
> > -       /*
> > -        * after reset deassertion, phy will need all ref clocks,
> > -        * voltage, current to settle down before starting serdes.
> > -        */
> > -       usleep_range(1000, 1100);
> > -
> >         /* power on phy - start serdes and phy's power and clocks */
> >         ret = phy_power_on(phy);
> >         if (ret) {
> > @@ -290,7 +282,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >         return 0;
> >
> >  out_disable_phy:
> > -       ufs_qcom_assert_reset(hba);
> >         phy_exit(phy);
> >  out:
> >         return ret;
> > @@ -554,21 +545,10 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> >                 ufs_qcom_disable_lane_clks(host);
> >                 phy_power_off(phy);
> >
> > -               /* Assert PHY soft reset */
> > -               ufs_qcom_assert_reset(hba);
> > -               goto out;
> > -       }
> > -
> > -       /*
> > -        * If UniPro link is not active, PHY ref_clk, main PHY analog power
> > -        * rail and low noise analog power rail for PLL can be switched off.
>
> We lost this comment?

Yeah. These are all phy implementation choices, and phy-qcom-qmp
wasn't even doing any of this, so it didn't seem like an appropriate
comment for the UFS controller code.

>
> > -        */
> > -       if (!ufs_qcom_is_link_active(hba)) {
> > +       } else if (!ufs_qcom_is_link_active(hba)) {
> >                 ufs_qcom_disable_lane_clks(host);
> > -               phy_power_off(phy);
>
> And now this looks similar to the above if statement, so can they be
> combined?

well, the if statement above has an extra phy_power_off in it... the
only possible combining I see is this, which looks worse, doesn't it?

if (ufs_qcom_is_link_off(hba) || !ufs_qcom_is_link_active(hba)) {
    ufs_qcom_disable_lane_clocks(host);
    if (ufs_qcom_is_link_off(hba)) {
        phy_power_off(phy);
    }
}

>
> >
> > -out:
> >         return ret;
> >  }
> >
> > @@ -578,21 +558,26 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> >         struct phy *phy = host->generic_phy;
> >         int err;
> >
> > -       err = phy_power_on(phy);
> > -       if (err) {
> > -               dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
> > -                       __func__, err);
> > -               goto out;
> > -       }
> > +       if (ufs_qcom_is_link_off(hba)) {
> > +               err = phy_power_on(phy);
> > +               if (err) {
> > +                       dev_err(hba->dev, "%s: failed enabling regs, err = %d\n",
>
> Not a problem with this translation, but I would expect this error to
> say something more like 'failed to power on phy' instead of 'enabling
> regs'.

Oh yeah. Will fix.

>
> > +                               __func__, err);
> > +                       return err;
> > +               }
> >
> > -       err = ufs_qcom_enable_lane_clks(host);
> > -       if (err)
> > -               goto out;
> > +               err = ufs_qcom_enable_lane_clks(host);
> > +               if (err)
> > +                       return err;
> >
> > -       hba->is_sys_suspended = false;
> > +       } else if (!ufs_qcom_is_link_active(hba)) {
> > +               err = ufs_qcom_enable_lane_clks(host);
> > +               if (err)
> > +                       return err;
> > +       }
> >
> > -out:
> > -       return err;
> > +       hba->is_sys_suspended = false;
> > +       return 0;
> >  }
> >
> >  struct ufs_qcom_dev_params {
> > @@ -1118,8 +1103,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> >                 return 0;
> >
> >         if (on && (status == POST_CHANGE)) {
> > -               phy_power_on(host->generic_phy);
> > -
>
> How is it ok to remove this call here?
>
> >                 /* enable the device ref clock for HS mode*/
> >                 if (ufshcd_is_hs_mode(&hba->pwr_info))
> >                         ufs_qcom_dev_ref_clk_ctrl(host, true);
> > @@ -1131,9 +1114,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> >                 if (!ufs_qcom_is_link_active(hba)) {
> >                         /* disable device ref_clk */
> >                         ufs_qcom_dev_ref_clk_ctrl(host, false);
> > -
> > -                       /* powering off PHY during aggressive clk gating */
> > -                       phy_power_off(host->generic_phy);
>
> And here?

This pair was calling phy_power_on and phy_power_off during clock
gating (and init). For SDM845/phy-qcom-qmp, this did nothing, since
there was no phy_power_off. In fact they needed an extra patch to not
call phy_power_on too early during init because of this function [1].
So for sdm845 this is a noop, since the phy will already be powered on
in ufs_qcom_power_up_sequence.

For msm8996/phy-qcom-ufs, it may change behavior a bit. Where we used
to end up in ufs_qcom_phy_power_off during clock gating, this change
is now not doing that. So regulators and a couple clocks are being
left on during clock gating. The phy power off now happens in suspend
if usermode selects that level. It seemed weird to be doing a bunch of
regulator and power down stuff in something called "clock gating".

Although looking at it now, I'm not even sure if these calls really
did do anything, since phy_power_on is reference counted, and
ufs_qcom_power_up_sequence called it... so it's possible ever since
commit 052553af6a31 ("ufs/phy: qcom: Refactor to use phy_init call")
in late 2017 this hasn't been doing anything at all.

[1] https://lkml.org/lkml/2018/9/21/204

>
> >                 }
> >
> >                 vote = host->bus_vote.min_bw_vote;
> > @@ -1147,6 +1127,39 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
> >         return err;
> >  }
> >
> > +static int
> > +ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +       struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> > +
> > +       WARN_ON(id);
>
> Nitpick: Add a comment explaining that there's only one reset expected?

Will do.

>
> > +       ufs_qcom_assert_reset(host->hba);
> > +       /* provide 1ms delay to let the reset pulse propagate */
> > +       usleep_range(1000, 1100);
> > +       return 0;
> > +}
> > +
> > +static int
> > +ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> > +{
> > +       struct ufs_qcom_host *host = rcdev_to_ufs_host(rcdev);
> > +
> > +       WARN_ON(id);
>
> Same nitpick.

Yep.

>
> > +       ufs_qcom_deassert_reset(host->hba);
> > +
> > +       /*
> > +        * after reset deassertion, phy will need all ref clocks,
> > +        * voltage, current to settle down before starting serdes.
> > +        */
> > +       usleep_range(1000, 1100);
> > +       return 0;
> > +}
> > +
> > +const struct reset_control_ops ufs_qcom_reset_ops = {
>
> Can it be static?

Yes!

>
> > +       .assert = ufs_qcom_reset_assert,
> > +       .deassert = ufs_qcom_reset_deassert,
> > +};
> > +
> >  #define        ANDROID_BOOT_DEV_MAX    30
> >  static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> >
