Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9036C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B461520700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550862493;
	bh=zn5gREfnAEgVz2BI4KrdGye4NvLUosAjzJ0G//JMftY=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=x7XrL95im5ZTIBMxhcQu+ykVoEl988ZDYh7lDiYhf6JEfS0ygejREv6Mk1aCjFR5A
	 f77WhVvzX+FVv426mx9I7EaMHwt4HImw69mwPnbvwl25RPx+EWdKulVyqqf/c/tI5e
	 K5iQ7To4bMA9ElR/DRWRyeF2g2evO4rV1PgfFuD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfBVTIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:08:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfBVTIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:08:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D23B3206BB;
        Fri, 22 Feb 2019 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550862490;
        bh=zn5gREfnAEgVz2BI4KrdGye4NvLUosAjzJ0G//JMftY=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=rvJ71P0vQdSAFNlEJjZ4Pe8azzNtfsV9AtdZmcTkrOuZxK9geLTwKtG7YAf3l8Vwm
         qWX1lnThkUN9xUae0vOKy2p3arrmCbUPxQZo2AWLVfKPqH/orPjaPlLAAxHIC359l6
         YxCnzqmv8kafRdWDmgPjp8LHeKyvH7XdIBIXTvIQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com> <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 22 Feb 2019 11:08:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-21 18:32:10)
> On NXP's i.MX SoCs with system controller inside, CPU frequency
> scaling can ONLY be done by system controller firmware, and it
> can ONLY be requested from secure mode, so Linux kernel has to
> call ARM SMC to trap to ARM-Trusted-Firmware to request system
> controller firmware to do CPU frequency scaling.
>=20
> This patch adds i.MX system controller CPU frequency scaling support,
> it reuses cpufreq-dt driver and implement the CPU frequency scaling
> inside SCU clock driver.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Ah I missed one thing, see below.

> @@ -180,6 +185,23 @@ static long clk_scu_round_rate(struct clk_hw *hw, un=
signed long rate,
>         return rate;
>  }
> =20
> +static int clk_scu_atf_set_cpu_rate(struct clk_hw *hw, unsigned long rat=
e,
> +                                   unsigned long parent_rate)
> +{
> +       struct clk_scu *clk =3D to_clk_scu(hw);
> +       struct arm_smccc_res res;
> +       unsigned long cluster_id;
> +
> +       if (clk->rsrc_id =3D=3D IMX_SC_R_A35)
> +               cluster_id =3D 0;

Do we still need to check this anymore? Why not just always use
cluster_id 0?

> +
> +       /* CPU frequency scaling can ONLY be done by ARM-Trusted-Firmware=
 */
> +       arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
> +                     cluster_id, rate, 0, 0, 0, 0, &res);

Because not checking would make this work, vs. checking causes this code
to sometimes use an uninitialized value from the stack.

> +
> +       return 0;
> +}
> +
