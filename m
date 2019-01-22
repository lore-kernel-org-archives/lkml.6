Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693ECC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C06220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nkpT+799"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAVWmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:42:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41072 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAVWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:42:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so160589ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzHT+Mi/lKQNfOgs/aVU2NNKYyy10ljw+560y+2HLfE=;
        b=nkpT+7992Vo9J21fZW/mSg6oz6CRFj5ZXdRN9P6jIudkS0S8414rfYMItXPJFNGpJt
         6CvzLY+qpx3pMWBqP8AYB1eavBOj/QnRQ2ztlwGe7LinBF4PxnMUsp7/uk7BTv+5zWiY
         gzEp7134yORwLFcYhd4My2p2xsGALN38ntyN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzHT+Mi/lKQNfOgs/aVU2NNKYyy10ljw+560y+2HLfE=;
        b=Em7ReVtZ5Qo3UrrZ6qSnLILE5NWMAcT0jJJqsPP4PEM5Z7eezs0FtGZ71LOpwA3N06
         2NKOJGVhmqh3h4eeEH5pd2AyNcdOjE2mwQENe5cQdZR9B8oWiyWfMczr3EcZbClY5VV2
         7n/6QAPhIA6ZPqhfggCXjNQqd7Hzaf/VTlOUgKWNTD1NiCpM17yDLRQexXHgMscjeaJy
         BIFRWKISKvGG5mjT/xnMkZmoOEZMYr7rqD7KsJJWuDfg3eBX0YthhXOJjqsejQkVdHe9
         S0Tusdm15zCpRd45SyZOp438c3RfcbSSqg3ACx8twtjRHxE7VwugoCvSRFEvfAmBkH6Z
         MBhg==
X-Gm-Message-State: AJcUukdk6XQTp4kl+ipwamdQtkKbxHLKImVXNmB5tYT78u9sScUi+HcY
        67wSWTrbAoFJ3amRR1X3hN3dAbz3Ag4=
X-Google-Smtp-Source: ALg8bN6/bEZwQdYzNJ4vHDE21VCqOvolmqsirGumJzTgT9fWMzTghd0y0ZyKQJjA+mNqdags8nVaKg==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr22017065lji.122.1548196960281;
        Tue, 22 Jan 2019 14:42:40 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i13-v6sm193296ljg.82.2019.01.22.14.42.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 14:42:39 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id c16so132448lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:42:38 -0800 (PST)
X-Received: by 2002:a19:d381:: with SMTP id k123mr22890969lfg.101.1548196958095;
 Tue, 22 Jan 2019 14:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-8-evgreen@chromium.org>
 <154785114149.169631.5500002081507832594@swboyd.mtv.corp.google.com>
In-Reply-To: <154785114149.169631.5500002081507832594@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 14:42:01 -0800
X-Gmail-Original-Message-ID: <CAE=gft51_0ReSWCWP1ysyBWsBXTER_HCAwr8zPi_+XY1tsX-HQ@mail.gmail.com>
Message-ID: <CAE=gft51_0ReSWCWP1ysyBWsBXTER_HCAwr8zPi_+XY1tsX-HQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] phy: qcom-qmp: Move UFS phy to phy_poweron/off
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 2:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2019-01-11 15:01:28)
> > For UFS, move the actual firing up of the PHY to phy_poweron and
> > phy_poweroff callbacks, rather than init/exit. UFS calls
> > phy_poweroff during suspend, so now all clocks and regulators for
> > the phy can be powered down during suspend.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > ---
> >
> >  drivers/phy/qualcomm/phy-qcom-qmp.c | 82 ++++++++---------------------
> >  1 file changed, 23 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > index eb1cac8f0fd4e..7766c6384d0a8 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > @@ -1224,7 +1223,6 @@ static int qcom_qmp_phy_init(struct phy *phy)
> >         int ret;
> >
> >         dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> > -
> >         if (cfg->has_ufsphy_reset) {
> >                 /*
> >                  * Get UFS reset, which is delayed until now to avoid a
>
> Nitpick: Drop this hunk.

Ok.

>
> > @@ -1360,7 +1353,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
> >
> >         /* Put PHY into POWER DOWN state: active low */
> >         qphy_clrbits(qphy->pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> > -
> >         if (cfg->has_lane_rst)
> >                 reset_control_assert(qphy->lane_rst);
> >
>
> And this hunk.

Ok.

>
> > @@ -1371,44 +1363,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
> >         return 0;
> >  }
> >
> > -static int qcom_qmp_phy_poweron(struct phy *phy)
> > -{
> > -       struct qmp_phy *qphy = phy_get_drvdata(phy);
> > -       struct qcom_qmp *qmp = qphy->qmp;
> > -       const struct qmp_phy_cfg *cfg = qmp->cfg;
> > -       void __iomem *pcs = qphy->pcs;
> > -       void __iomem *status;
> > -       unsigned int mask, val;
> > -       int ret = 0;
> > -
> > -       if (cfg->type != PHY_TYPE_UFS)
> > -               return 0;
> > -
> > -       /*
> > -        * For UFS PHY that has not software reset control, serdes start
> > -        * should only happen when UFS driver explicitly calls phy_power_on
> > -        * after it deasserts software reset.
> > -        */
> > -       if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
> > -           (qmp->init_count != 0)) {
> > -               /* start SerDes and Phy-Coding-Sublayer */
> > -               qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> > -
> > -               status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
> > -               mask = cfg->mask_pcs_ready;
> > -
> > -               ret = readl_poll_timeout(status, val, !(val & mask), 1,
> > -                                        PHY_INIT_COMPLETE_TIMEOUT);
>
> So we never need to poll this bit anymore?

We do poll that bit, we just do it in qcom_qmp_phy_enable now, since I
removed the conditional that exited early for UFS PHYs. It's almost
like someone copied and pasted the lower half of the function into
qcom_qmp_phy_poweron :)

>
> > -               if (ret) {
> > -                       dev_err(qmp->dev, "phy initialization timed-out\n");
> > -                       return ret;
> > -               }
> > -               qmp->phy_initialized = true;
> > -       }
> > -
> > -       return ret;
> > -}
> > -
> >  static int qcom_qmp_phy_set_mode(struct phy *phy,
> >                                  enum phy_mode mode, int submode)
> >  {
> > @@ -1658,9 +1612,15 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
> >  }
> >
> >  static const struct phy_ops qcom_qmp_phy_gen_ops = {
> > -       .init           = qcom_qmp_phy_init,
> > -       .exit           = qcom_qmp_phy_exit,
> > -       .power_on       = qcom_qmp_phy_poweron,
> > +       .init           = qcom_qmp_phy_enable,
> > +       .exit           = qcom_qmp_phy_disable,
> > +       .set_mode       = qcom_qmp_phy_set_mode,
> > +       .owner          = THIS_MODULE,
> > +};
> > +
> > +static const struct phy_ops qcom_qmp_ufs_ops = {
> > +       .power_on       = qcom_qmp_phy_enable,
> > +       .power_off      = qcom_qmp_phy_disable,
> >         .set_mode       = qcom_qmp_phy_set_mode,
> >         .owner          = THIS_MODULE,
> >  };
>
> So the UFS and the non-UFS phys will use the same single function, but
> the callers of the phys will see that phy_power_on() powers on the phy
> for UFS but does nothing for non-UFS devices? Do the users of this
> common phy call the API differently between drivers? Kishon, is there
> guidance on how phys are supposed to be used by drivers?
>

I'll leave that one for Kishon.
-Evan
