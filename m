Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F0C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337C8218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X1zVWglR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfBFWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:04:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42176 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFWES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:04:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3535162pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=3FKj50cnBV7mXYIaVQIe+ttTaK6DyS8ngGDtzG+5HL4=;
        b=X1zVWglReizCmDG4xBQvVKblfPrvlzfHRATobDQtjpWmnPxd0K6SgPylzEsXxL7vd8
         IG21s2QOK4tK96BnxbYonyv+3U9nzjPqupRHDgB69kjoaLCdfQ56+fABZGVlVNyycTta
         5wl+DK/fS7GIltL64psgKTg2wlIW5RXcl0+DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=3FKj50cnBV7mXYIaVQIe+ttTaK6DyS8ngGDtzG+5HL4=;
        b=HtqQAS8kIB0tCqXuzxkaYsdZoFE7MTgMQPp7clmaxKOmIWhmMIzVRZpGsr2hgCBVza
         Rqcu67UiUI+FQSVSVMjV0pDVMKIlEPixu5axHdthhYnMG/bqyGQy/1QSVDxvZ01+1c5y
         Y7RJrqsB6j2FcXWQhLilGAaTh7JH2NJSzWWG14LHl6hvlgtmjJUNFVV18vXgYJm5AJ+e
         bHu3Yff3VWh6wVlXzQq00fpgrHg3cT2PjQG+lt0/KDxcrTYaxoHUn2Syn1RtR0dWHSlv
         LA5u4hY3Q8Myd1lLxNTvK8md9HESk3Eu1ldDOdop3DX2wIlq3JdozoILl4X8lV1ZDE4D
         v9Lg==
X-Gm-Message-State: AHQUAub//ucomNtwB5s5sCvEJ5gUwb4nYwEYGo18SrRirFoz34rXO+tX
        0tS2u/HXcwhjA5QfNPSVGxL3Ug==
X-Google-Smtp-Source: AHgI3IYJ5wX5feeGW6SLOkcNdX6rPcqLj4t0WmD1CP/I8ZI1akmSpnlEkEpTqxTOh7+vAKFktHYW+g==
X-Received: by 2002:a63:da14:: with SMTP id c20mr11253242pgh.233.1549490657074;
        Wed, 06 Feb 2019 14:04:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t67sm18527751pfd.90.2019.02.06.14.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 14:04:16 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20190205185902.106085-9-evgreen@chromium.org>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 8/8] phy: ufs-qcom: Refactor all init steps into phy_poweron
Message-ID: <154949065550.115909.10216592012769136925@swboyd.mtv.corp.google.com>
References: <20190205185902.106085-1-evgreen@chromium.org> <20190205185902.106085-9-evgreen@chromium.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 06 Feb 2019 14:04:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-02-05 10:59:02)
> The phy code was using implicit sequencing between the PHY driver
> and the UFS driver to implement certain hardware requirements.
> Specifically, the PHY reset register in the UFS controller needs
> to be deasserted before serdes start occurs in the PHY.
>=20
> Before this change, the code was doing this by utilizing the two
> phy callbacks, phy_init() and phy_poweron(), as "init step 1" and
> "init step 2", where the UFS driver would deassert reset between
> these two steps.
>=20
> This makes it challenging to power off the regulators in suspend,
> as regulators are initialized in init, not in poweron(), but only
> poweroff() is called during suspend, not exit().
>=20
> For UFS, move the actual firing up of the PHY to phy_poweron() and
> phy_poweroff() callbacks, rather than init()/exit(). UFS calls
> phy_poweroff() during suspend, so now all clocks and regulators for
> the phy can be powered down during suspend.
>=20
> QMP is a little tricky because the PHY is also shared with PCIe and
> USB3, which have their own definitions for init() and poweron(). Rename
> the meaty functions to _enable() and _disable() to disentangle from the
> PHY core names, and then create two different ops structures: one for
> UFS and one for the other PHY types.
>=20
> In phy-qcom-ufs, remove the 'is_powered_on' and 'is_started' guards,
> as the generic PHY code does the reference counting. The
> 14/20nm-specific init functions get collapsed into the generic power_on()
> function, with the addition of a calibrate() callback specific to 14/20nm.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

although it may change if the patch before this is changed
significantly.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/p=
hy-qcom-qmp.c
> index 2861c64b9bcc..3597c4c0e50f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1341,8 +1341,7 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *q=
mp)
>         return 0;
>  }
> =20
> -/* PHY Initialization */
> -static int qcom_qmp_phy_init(struct phy *phy)
> +static int qcom_qmp_phy_enable(struct phy *phy)
>  {
>         struct qmp_phy *qphy =3D phy_get_drvdata(phy);
>         struct qcom_qmp *qmp =3D qphy->qmp;
> @@ -1423,14 +1422,6 @@ static int qcom_qmp_phy_init(struct phy *phy)
>                         goto err_lane_rst;
>         }
> =20
> -       /*
> -        * UFS PHY requires the deassert of software reset before serdes =
start.
> -        * For UFS PHYs that do not have software reset control bits, def=
er
> -        * starting serdes until the power on callback.
> -        */
> -       if ((cfg->type =3D=3D PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
> -               goto out;
> -
>         /*
>          * Pull out PHY from POWER DOWN state.
>          * This is active low enable signal to power-down PHY.
> @@ -1442,7 +1433,9 @@ static int qcom_qmp_phy_init(struct phy *phy)
>                 usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
> =20
>         /* Pull PHY out of reset state */
> -       qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +       if (!cfg->no_pcs_sw_reset)
> +               qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +
>         if (cfg->has_phy_dp_com_ctrl)
>                 qphy_clrbits(dp_com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> =20

This is non-obvious, but OK I can see now that it's fine that everything
is combined into one function. I didn't realize that phy_init() was
polling the ready bit in addition to power on doing that under certain
circumstances.

Quite honestly, I find the whole implementation to be obtuse; combining
all the phy code together into one function and then changing the
execution paths via booleans and the 'type' member. It makes following
and reviewing this code really painful. We should make phy ops for each
type of phy: USB, USB+DP, PCIE, UFS, etc. and then have those ops call
simpler building block functions that do the common things. Then
reviewers don't have to untangle the execution paths in their minds to
make sure that nothing goes wrong when a stray 'if (my_phy_flag)' is
thrown into the init function and have to wonder if that causes problems
for something else.

