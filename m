Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970C9C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6628820652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEOINQqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfARXuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:50:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41033 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfARXuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:50:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so7324749pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 15:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=ErY6KJhF8pEqsz+V5ps1QCKORaU3Ii9dc3oBe/fGpCg=;
        b=NEOINQqY2w/hCNT981qIQHcwKeZa/YPMWRIhFpti4Ayqc9vYC01z+MlL1UDgeKgMWx
         5St+DcGYJBcFGyGWHu+feuM1BwvXLPz81X5mmsEK1uSg8s5bGiIdSesCGEuE+g9KY2Tk
         sKUnlcYzwMq6LBKqsP/uM4II0+cJmvzOjZifI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=ErY6KJhF8pEqsz+V5ps1QCKORaU3Ii9dc3oBe/fGpCg=;
        b=lTsJMCpWXieq4nBg98qKNivceHHKPFBhNYIOK4rU4QCVXQ9CyZh7puFJDUpQL0KpzT
         +ZzEtWKJspbv6NPdV8guiFnQtUEyX9Clyw/TSUCOo/DFTJjrS1J/EJmVkMUM3y3Jvmy5
         HKQVMLPHqD1yeHcs4Nfx1s36R5lIiKbgfdHQtmRDmpPqlLeMBtW7/J1CYKdcdHZfdC6k
         ieYzg8x6IQz17AsFXhE+1wQxdKG4sQwFHGCnnOUcu3jYGJMySHaIo6SbIkWW1TAo5FE9
         7vHcmwDmFy2gpDnbBj+ipDLVLu4NfOj3DOhEVLLf6iqO/HY1yJfiDPWst4VFEDTHyV4T
         h8iA==
X-Gm-Message-State: AJcUukddKqEF2WKD810JM+EhGIq+lqwN48uthvjjc0zwuK2VbGqomLcN
        ujJ+3peMUkGZhO17ev6XrGGX3g==
X-Google-Smtp-Source: ALg8bN4XF1pex5G9xBENxU7DqP25zd3ow6pahNJvpr5T45aLBYMGJjdzQUEafvaFAAl9Y0DkCfGjog==
X-Received: by 2002:a63:6006:: with SMTP id u6mr19890209pgb.176.1547855407806;
        Fri, 18 Jan 2019 15:50:07 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c72sm10796477pfb.107.2019.01.18.15.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 15:50:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 8/8] phy: qcom-ufs: Refactor all init steps into phy_poweron
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-9-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-9-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154785540598.169631.18430427073255279078@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 15:50:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:29)
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/p=
hy-qcom-ufs.c
> index f2979ccad00a3..a4cff17fef925 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
> @@ -147,6 +147,21 @@ struct phy *ufs_qcom_phy_generic_probe(struct platfo=
rm_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(ufs_qcom_phy_generic_probe);
> =20
> +static int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common)
> +{
> +       struct reset_control *reset;
> +
> +       if (phy_common->ufs_reset)
> +               return 0;
> +
> +       reset =3D of_reset_control_get_by_index(phy_common->dev->of_node,=
 0);

Same question about using non-DT specific APIs to get the reset control
here.

> +       if (IS_ERR(reset))
> +               return PTR_ERR(reset);
> +
> +       phy_common->ufs_reset =3D reset;
> +       return 0;
> +}
> +
>  static int __ufs_qcom_phy_clk_get(struct device *dev,
>                          const char *name, struct clk **clk_out, bool err=
_print)
>  {
> @@ -528,23 +543,42 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
>  {
>         struct ufs_qcom_phy *phy_common =3D get_ufs_qcom_phy(generic_phy);
>         struct device *dev =3D phy_common->dev;
> +       bool is_rate_B =3D false;
>         int err;
> =20
> -       if (phy_common->is_powered_on)
> -               return 0;
> +       err =3D ufs_qcom_phy_get_reset(phy_common);
> +       if (err)
> +               return err;
> =20
> -       if (!phy_common->is_started) {
> -               err =3D ufs_qcom_phy_start_serdes(phy_common);
> +       if (phy_common->ufs_reset) {
> +               err =3D reset_control_assert(phy_common->ufs_reset);
>                 if (err)
>                         return err;
> +       }
> =20
> -               err =3D ufs_qcom_phy_is_pcs_ready(phy_common);
> -               if (err)
> -                       return err;
> +       if (phy_common->mode =3D=3D PHY_MODE_UFS_HS_B)
> +               is_rate_B =3D true;
> =20
> -               phy_common->is_started =3D true;
> +       err =3D phy_common->phy_spec_ops->calibrate(phy_common, is_rate_B=
);

Is there always a calibrate phys_spec_ops function assigned?

> +       if (err)
> +               return err;
> +
> +       if (phy_common->ufs_reset) {
> +               err =3D reset_control_deassert(phy_common->ufs_reset);
> +               if (err) {
> +                       dev_err(dev, "Failed to assert UFS PHY reset");
> +                       return err;
> +               }
>         }
