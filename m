Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1CAC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F9F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpDFWeT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F9F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbeKGDNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389666AbeKGDNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:13:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7FF20827;
        Tue,  6 Nov 2018 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541526435;
        bh=T314a9ZB/KhWNBTPo3mjeM0r3nEsbL/AbyamU6W1v4w=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YpDFWeT2dGMzd607RGHk29qCmTPehotA9VEJnVF6brpn7gagNm8jkbgYXIaW6+RP1
         b7zNN2b+it+T7P3AZXqx8AWNEg50TCaSLpg9/nryZtQpbGFKj4kWMHtKiuowgYy5xa
         Rxl7cz/92n4z/zpiMgxpbakVCnFt7Su41CHh93/U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181103070002.19106-1-bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
References: <20181103070002.19106-1-bjorn.andersson@linaro.org>
Message-ID: <154152643447.88331.15663665572409943424@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: smd: Add support for QCS404 rpm clocks
Date:   Tue, 06 Nov 2018 09:47:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-03 00:00:02)
> From: Taniya Das <tdas@codeaurora.org>
> =

> Add rpm smd clocks, PMIC and bus clocks which are required on QCS404
> for clients to vote on.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> [bjorn: Dropped cxo, voter clocks and static initialization]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Patch looks OK.

Applied to clk-next, with a complaint below.

> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rp=
m.c
> index 850c02a52248..d3aadaeb2903 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -611,10 +611,55 @@ static const struct rpm_smd_clk_desc rpm_clk_msm899=
6 =3D {
>         .num_clks =3D ARRAY_SIZE(msm8996_clks),
>  };
>  =

> +/* QCS404 */
> +DEFINE_CLK_SMD_RPM_QDSS(qcs404, qdss_clk, qdss_a_clk, QCOM_SMD_RPM_MISC_=
CLK, 1);
> +
> +DEFINE_CLK_SMD_RPM(qcs404, pnoc_clk, pnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0=
);
> +DEFINE_CLK_SMD_RPM(qcs404, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1=
);

Just curious, do we need to keep redefining these clks for each SoC?
Perhaps we should try to consolidate the clks that are common among SoCs
so we can reduce the number of static structs lying around in this
driver.

