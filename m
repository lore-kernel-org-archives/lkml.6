Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE94C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066D2208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544825086;
	bh=NLwTeu7fdWAbV8YgHfUMzhi344wmzGw+2qdSCrS4GLM=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=tpwk3XMk/j7xkylA1W9yzhfpcbhX24Pjt8Rkq7nMyg7zuKQF1bAx78iU0fDOaUH3f
	 YaP2FQLIoqfWOVygrmGMg6XjO+j+ZP0c3NnYY6Bh3j21Q/9+fH/xUuew275yWxFeZa
	 iZOph96cgPgdnp6dJ25uEPtjRV51WXb19aubw56M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbeLNWEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730909AbeLNWEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:04:44 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BDD42080F;
        Fri, 14 Dec 2018 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544825084;
        bh=NLwTeu7fdWAbV8YgHfUMzhi344wmzGw+2qdSCrS4GLM=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=u9j7xXR+uTuo19BJ8loI1aqbYjhmWD48YyWABxmnXAf2uJkEGznTQFwhNB7N2/k3c
         NY0ynkm2D/N7xiD7iD4goNnj47aSIwWWFkHA2viPOcU0e91tAbc9vrdz20247aSkNu
         6a7LAoSg8FyKx1LqhEoyQi0ijx6IyLN69WCUSz0o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544176659-32022-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 2/3] clk: imx: imx7ulp: add arm hsrun mode clocks support
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com> <1544176659-32022-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154482508301.19322.1653003805163251008@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Fri, 14 Dec 2018 14:04:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-12-07 02:03:34)
> i.MX7ULP has a Cortex-A7 CPU which can run in RUN mode
> or HSRUN mode, it is controlled in SMC1 module. The RUN
> mode and HSRUN mode will use different clock source for
> ARM, "divcore" for RUN mode and "hsrun_divcore" for HSRUN
> mode, so the control bits in SMC1 module can be abstracted
> as a HW clock mux, this patch adds HSRUN mode related
> clocks in SCG1 module and adds "arm" clock in SMC1 module
> to support RUN mode and HSRUN mode switch.
>=20
> Latest clock tree in RUN mode as below:
>=20
>  firc                                 0        0        0    48000000    =
      0     0  50000
>     firc_bus_clk                      0        0        0    48000000    =
      0     0  50000
>     hsrun_scs_sel                     0        0        0    48000000    =
      0     0  50000
>        hsrun_divcore                  0        0        0    48000000    =
      0     0  50000
>=20
>  sosc                                 3        3        3    24000000    =
      0     0  50000
>     spll_pre_sel                      1        1        1    24000000    =
      0     0  50000
>        spll_pre_div                   1        1        2    24000000    =
      0     0  50000
>           spll                        1        1        2   528000000    =
      0     0  50000
>              spll_pfd0                1        1        1   500210526    =
      0     0  50000
>                 spll_pfd_sel          1        1        0   500210526    =
      0     0  50000
>                    spll_sel           1        1        0   500210526    =
      0     0  50000
>                       scs_sel         1        1        0   500210526    =
      0     0  50000
>                          divcore      1        1        0   500210526    =
      0     0  50000
>                             arm       1        1        0   500210526    =
      0     0  50000
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

