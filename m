Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14185C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4507222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550275097;
	bh=BfU4WavOYfi3MPmDfbJX3CcKcX+lXKGVU1t5skS5/fI=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=hQZ2qvUoncf9LpqrOkg3LFlfParKLHCf9wquq0duuyPrUibFv8nWXQk5yvGG9Dt+E
	 fF6pwtqGR7vK9TPUSz16jj/DD+Ji3hOyvH1dH+pSZ1+Fa+2FpnHnv/SmrfYSHQkTDy
	 8DQJ0KN7X1fFTMfnZToUnBrDA9GQy7XOAyTHFDic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbfBOX6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387546AbfBOX6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:58:15 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB0E222DE;
        Fri, 15 Feb 2019 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550275094;
        bh=BfU4WavOYfi3MPmDfbJX3CcKcX+lXKGVU1t5skS5/fI=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=2FCedOluOuGkg9IxR0raQFOv4/izoplGS/L98dkL0Gxgz0A7OGFoqAIQ4Lpmd+PxS
         gobrpdOJfzCzU3ahzEft9gtvMDabOpHfVy34lLI7/1pfHR1ZaryVoC7ObBRXsLdgOf
         RnjJ18GAv4uyfd8R98cuOaU46bN2/FpD3vEX/3Bo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: alot/0.8
Subject: Re: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155027509324.115909.9001648696808985832@swboyd.mtv.corp.google.com>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com> <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 15 Feb 2019 15:58:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-13 17:54:08)
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
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

Unless you wanted me to pick this patch up into clk-next?
