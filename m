Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13629218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axRFnRRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfBASno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:43:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36149 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfBASno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:43:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so3642711pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=4z8jRORzxUXlOXDnGZLxDvdXXm0SC8BPoBiX0fbP1Dg=;
        b=axRFnRRJJ08JGUNoP6dHPhvvIqVGR8ID+S2gHAJKbMaM8YAJI98tfzdw+Z4d+ekxLm
         DZ75gm5yeDhUyP+RMDO2C3/q//pkOhnfoi6kU4WlRx6CrxrpuZC4LGkVXKQZ9RA7f7SQ
         9sBEijB0fthjCQEkOa1EDCDYO1UJnv6euo3+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=4z8jRORzxUXlOXDnGZLxDvdXXm0SC8BPoBiX0fbP1Dg=;
        b=jEH40fi8le4nzZKhTobi9Y2KBsND9mgSUxufgTE7huY1VKfbMgKFkPc1GF6aM/99hs
         lYdPCcP1kl5QSYixFjByabmRnYGjuueyrjh4S/Bj21hT4AElmbXAbX4S+TjwlFSgmujm
         oSpbciACNLwLx+2sHdn9hL4GalkwYfbPDYeFKwk0/C5hG5G0rVQxjpttpo2RYpVcSHOg
         2xMrhyEj3Lny5zbmwN0OPTkrwi8LvxdouclLKYEmxFmz/vxYm7ZGKkcUijH4xfjWsHnj
         pp4uDmg50eUc5Ns/CMEMlRat+RfUHXzZZg5skY1etnvcw8v7OIMYQJI5wH2ZvEZ4BKGK
         L6QQ==
X-Gm-Message-State: AJcUukfPgklir+/qAHDhNxU1Gp7utsyBSbOJFAxy3KI98UCqD14Ic81e
        vfr8tcKNIZoXZH0tfz82232DLQ==
X-Google-Smtp-Source: ALg8bN4ETF0p2J8FfwKpWGxLUW9IWV0seeHYrdGTIVipnQcxDpiXzDIhZ4MZb9XYohTfpRXDseyayg==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr40494008pff.211.1549046622836;
        Fri, 01 Feb 2019 10:43:42 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h10sm11778781pgn.11.2019.02.01.10.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:43:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 9/9] phy: qcom-ufs: Refactor all init steps into phy_poweron
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154904662124.169292.12336150037537548096@swboyd.mtv.corp.google.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-10-evgreen@chromium.org>
User-Agent: alot/0.8
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190123221137.41722-10-evgreen@chromium.org>
Date:   Fri, 01 Feb 2019 10:43:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-23 14:11:37)
> The phy code was using implicit sequencing between the PHY driver
> and the UFS driver to implement certain hardware requirements.
> Specifically, the PHY reset register in the UFS controller needs
> to be deasserted before serdes start occurs in the PHY.
>=20
> Before this change, the code was doing this by utilizing the two
> phy callbacks, phy_init and phy_poweron, as "init step 1" and

Nitpick: Can you please indicate functions with () and variables with
''? So write phy_init() and phy_poweron(), etc.

> "init step 2", where the UFS driver would deassert reset between
> these two steps.
>=20
> This makes it challenging to power off the regulators in suspend,
> as regulators are initialized in init, not in poweron, but only
> poweroff is called during suspend, not exit.
>=20
> Consolidate the initialization code into phy_poweron, and utilize
> the reset controller exported from the UFS driver to explicitly
> perform all the steps needed to initialize the PHY.

Also mention that a new callback is introduced, 'calibrate', that=20
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>

> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm=
/phy-qcom-ufs-i.h
> index f798fb64de94e..109ddd67be829 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>

Just forward declare struct reset_control instead of including this.

>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> @@ -96,11 +97,10 @@ struct ufs_qcom_phy {
>         char name[UFS_QCOM_PHY_NAME_LEN];
>         struct ufs_qcom_phy_calibration *cached_regs;
>         int cached_regs_table_size;
> -       bool is_powered_on;
> -       bool is_started;
>         struct ufs_qcom_phy_specific_ops *phy_spec_ops;
> =20
>         enum phy_mode mode;
> +       struct reset_control *ufs_reset;
>  };
> =20
>  /**

For some reason I get the feeling that this patch should be combined
with something else from the controller. Does this complete the
conversion but the patches before this one sort of wreck the state of
reset and init/poweron phases so that they can't stand on their own?
Maybe if the reset was introduced, and then a patch to get the resets
was put in place, and then a final patch to rewrite the phy and
controller at the same time would make more sense to read.

