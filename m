Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F1EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4973D21534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km3fEJTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4973D21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbeHBSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeHBSwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:52:50 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDD121534;
        Thu,  2 Aug 2018 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533229250;
        bh=rVuTuM03p9b5+piNOElg/bdhN0XUo3PaPT4/QPNrISQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Km3fEJTuMXATt3Gq/s0O1/9z6lbmw1zI1QsHU/lCDDGi/P9iIMCGYVQkikcWkXzen
         z7meH9x/LBuMSdIMJ5P8w/kKLk8eEhwD96ntTE4Xgb4uXzDQMCfOKMeb3ltb+rz5l7
         CoVTxjwBRHjIJajYeYdPiXxiuXM6fBZVVNM21R6Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532942540-2814-2-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1532942540-2814-1-git-send-email-anischal@codeaurora.org>
 <1532942540-2814-2-git-send-email-anischal@codeaurora.org>
Message-ID: <153322925025.10763.7919558124009549240@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: qcom: Add camera clock controller driver for SDM845
Date:   Thu, 02 Aug 2018 10:00:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-30 02:22:20)
> diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm=
845.c
> new file mode 100644
> index 0000000..702ca66
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-sdm845.c
> @@ -0,0 +1,1744 @@
> +       },
> +};
> +
> +static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] =3D {
> +       F(19200000, P_BI_TCXO, 1, 0, 0),
> +       F(100000000, P_CAM_CC_PLL0_OUT_EVEN, 6, 0, 0),
> +       F(200000000, P_CAM_CC_PLL0_OUT_EVEN, 3, 0, 0),
> +       F(404000000, P_CAM_CC_PLL1_OUT_EVEN, 2, 0, 0),
> +       F(480000000, P_CAM_CC_PLL2_OUT_EVEN, 1, 0, 0),
> +       F(600000000, P_CAM_CC_PLL0_OUT_EVEN, 1, 0, 0),
> +       { }
> +};
> +
> +/*
> + * As per HW design, some of the CAMCC RCGs needs to
> + * move to XO clock during their clock disable so using

Per hw design sure, but what about hw design is causing this?

> + * clk_rcg2_shared_ops for such RCGs.
> + * Also, use CLK_SET_RATE_PARENT flag for the RCGs which
> + * have non-fixed PLL as parent source and requires

Mention the PLL that isn't fixed?

> + * reconfiguration of the PLL frequency.
> + */
> +static struct clk_rcg2 cam_cc_bps_clk_src =3D {
> +       .cmd_rcgr =3D 0x600c,
> +       .mnd_width =3D 0,
