Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A7EC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36CC2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CfjBQb3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36CC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeLKWBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:01:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37769 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKWBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:01:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so7284573pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=sbQL7SltHDLryPImk/WCQHIX5qDycqTAd4eiqVNUiKs=;
        b=CfjBQb3Td1HzPTk0RRC7rpQDEQZ5o86e81TPr1m8nTz94CxGhDhyca0621uy4MIDxt
         Jqor7SZSzir3SrhNkmJXbxfsuyT7DBVP0kLEax36NGogFR8gXvSuqdiKPP9EeUunHsoy
         180YFoQS16QPLYWCA2So5Oevk1WyE3muCnrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=sbQL7SltHDLryPImk/WCQHIX5qDycqTAd4eiqVNUiKs=;
        b=EIoAFsq3GsxLDtVeg+Yyjin35BAegnfGLNXTnt3z6ewfOG8rKalEw/yH62/uk9iIvL
         FKhnLim9iWcx6ZRDXWymrQk6kFlESMUgnQ4/n0EulUfYAWKBSCTxKgV46rePrUeiA6XW
         ABp8yWmtTgVdXLUjAVS7PY+QqUplhrYZc+wplFlvxuIg5Hpv17+OhiTSQWwTUjf/dUff
         P3+IDlr0sWYwj+ZSu5ksHVGbfcb+2f0VWw8sERDL9NONojk3v4bY61PDHHqac0kCq+xX
         b6fYAFQdAVU8ojtOFBM/kfkz0tYvUe0RSmq9Ah9f7U31Lp4OcZsyPZN739iE7Z2/+wgC
         Mx5w==
X-Gm-Message-State: AA+aEWaEtNu5auzIM7HbBtsMkE03mCbQtGoRyW6RCvP9Gb8bIReY9lW1
        fBT98PmMqbKspWAGe+opTEYbLw==
X-Google-Smtp-Source: AFSGD/W6WCCeF6V8WQbMfCqYX3BaxvuQcqfGrPTECOPYwZ2vXu7fGOb5tOkX5Fja5qL9O2Cn82mq9Q==
X-Received: by 2002:a65:6645:: with SMTP id z5mr16285409pgv.351.1544565663502;
        Tue, 11 Dec 2018 14:01:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 125sm25540313pfx.159.2018.12.11.14.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:01:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-7-rnayak@codeaurora.org>
Message-ID: <154456566209.17204.2943300246902710989@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 06/10] soc: qcom: rpmhpd: Add RPMh power domain driver
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-7-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 14:01:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:34)
> The RPMh power domain driver aggregates the corner votes from various
> consumers for the ARC resources and communicates it to RPMh.
>=20
> With RPMh we use 2 different numbering space for corners, one used
> by the clients to express their performance needs, and another used
> to communicate to RPMh hardware.
>=20
> The clients express their performance requirements using a sparse
> numbering space which are mapped to meaningful levels like RET, SVS,
> NOMINAL, TURBO etc which then get mapped to another number space
> between 0 and 15 which is communicated to RPMh. The sparse number space,
> also referred to as vlvl is mapped to the continuous number space of 0
> to 15, also referred to as hlvl, using command DB.
>=20
> Some power domain clients could request a performance state only while
> the CPU is active, while some others could request for a certain
> performance state all the time regardless of the state of the CPU.
> We handle this by internally aggregating the votes from both type of
> clients and then send the aggregated votes to RPMh.
>=20
> There are also 3 different types of Votes that are comunicated to RPMh

Why capitalize vote?

> for every resource.
> 1. ACTIVE_ONLY: This specifies the requirement for the resource when the
> CPU is active
> 2. SLEEP: This specifies the requirement for the resource when the CPU
> is going to sleep
> 3. WAKE_ONLY: This specifies the requirement for the resource when the
> CPU is coming out of sleep to active state

Can you tab these in?

>=20
> We add data for all power domains on sdm845 SoC as part of the patch.
> The driver can be extended to support other SoCs which support RPMh
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Just minor nitpicks ahead and a warning.

> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index f1b25fdcf2ad..dd6ca92985ee 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -22,3 +22,4 @@ obj-$(CONFIG_QCOM_APR) +=3D apr.o
>  obj-$(CONFIG_QCOM_LLCC) +=3D llcc-slice.o
>  obj-$(CONFIG_QCOM_SDM845_LLCC) +=3D llcc-sdm845.o
>  obj-$(CONFIG_QCOM_RPMPD) +=3D rpmpd.o
> +obj-$(CONFIG_QCOM_RPMHPD) +=3D rpmhpd.o

Put this before RPMPD? At least it would be semi-sorted then.

> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> new file mode 100644
> index 000000000000..f993a86be48c
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -0,0 +1,417 @@
[..]
> +
> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
> +{
> +       u8 buf[RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE];
> +       int i, j, len, ret;
> +
> +       len =3D cmd_db_read_aux_data_len(rpmhpd->res_name);
> +       if (len <=3D 0)
> +               return len;
> +       else if (len > RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE)
> +               return -EINVAL;
> +
> +       ret =3D cmd_db_read_aux_data(rpmhpd->res_name, buf, len);
> +       if (ret < 0)
> +               return ret;

I've changed cmd_db_read_aux_data() and that change is winding through
the arm-soc tree. This will break in the compilation phase in
linux-next.

> +
> +       rpmhpd->level_count =3D len / RPMH_ARC_LEVEL_SIZE;
> +
> +       for (i =3D 0; i < rpmhpd->level_count; i++) {
> +               rpmhpd->level[i] =3D 0;
> +               for (j =3D 0; j < RPMH_ARC_LEVEL_SIZE; j++)
> +                       rpmhpd->level[i] |=3D
> +                               buf[i * RPMH_ARC_LEVEL_SIZE + j] << (8 * =
j);
> +
> +               /*
> +                * The AUX data may be zero padded.  These 0 valued entri=
es at
> +                * the end of the map must be ignored.
> +                */
> +               if (i > 0 && rpmhpd->level[i] =3D=3D 0) {
> +                       rpmhpd->level_count =3D i;
> +                       break;
> +               }
> +               pr_debug("%s: ARC hlvl=3D%2d --> vlvl=3D%4u\n", rpmhpd->r=
es_name, i,
> +                        rpmhpd->level[i]);
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmhpd_probe(struct platform_device *pdev)
> +{
> +       int i, ret;
> +       size_t num_pds;
> +       struct device *dev =3D &pdev->dev;
> +       struct genpd_onecell_data *data;
> +       struct rpmhpd **rpmhpds;
> +       const struct rpmhpd_desc *desc;
> +
> +       desc =3D of_device_get_match_data(dev);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       rpmhpds =3D desc->rpmhpds;
> +       num_pds =3D desc->num_pds;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->domains =3D devm_kcalloc(dev, num_pds, sizeof(*data->domain=
s),
> +                                    GFP_KERNEL);
> +       if (!data->domains)
> +               return -ENOMEM;
> +
> +       data->num_domains =3D num_pds;
> +
> +       ret =3D cmd_db_ready();

Does this matter? I thought we forced cmd_db_ready() in the rpmh driver
probe, and that was the parent of all rpmh devices so we should be fine
to not need to check it again here?

> +       if (ret) {
> +               if (ret !=3D -EPROBE_DEFER)
> +                       dev_err(dev, "Command DB unavailable, ret=3D%d\n"=
, ret);
> +               return ret;
> +       }
> +
