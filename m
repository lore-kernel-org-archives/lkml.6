Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EACB20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550782113;
	bh=D5uAlfH5MQ+LUH+dDsqRfPtFiwt8vEAS50I5eHRaTLA=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=FCQoMo/FFlBG8k3Slel9B/0JBqzRR/8LFqKViq7HQj5XOssXGJ2QBfBU5jYB3U5i0
	 dKSekADh5xotphzd8FDpJMsj9lakzupxf4T0BfmCrNchSVl0oqrpUHEvQQRsZZvsU/
	 QXhxzcn6t1O7sRKjWJUjA6/2z6So4aQZr5pSz8dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfBUUsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfBUUsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:48:30 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF47A206C0;
        Thu, 21 Feb 2019 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550782109;
        bh=D5uAlfH5MQ+LUH+dDsqRfPtFiwt8vEAS50I5eHRaTLA=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=FyZuSNgTkyV8pMBr7s41jFRncLjFM6I1iWWOcUGoEC1FjptbwxmEqN985s1eZXLhd
         WygzNYYT1q+IkCu8WIjsQmcSjIw3KaoEMaYJQIIWMgO4WbqElBgBAYN49+OhUmgTie
         4ZUoSMHr6b+1K4UG/OD3zPMgUMhT5WiStAGNX0TU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V4 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155078210899.77512.5319038009555276321@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com> <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550108915-574-2-git-send-email-Anson.Huang@nxp.com>
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
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Thu, 21 Feb 2019 12:48:28 -0800
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
> Changes since V3:
>         - use different clk ops for CPU clock to avoid runtime check in c=
lk_set_rate;
>         - use rsrc_id to determine whether it is CPU frequency change and=
 also to get
>           cluster ID for SMC call.

This directly conflicts with a patch to add get/set parent support from
Aisheng Dong. Can you please work together and rebase the patch on top
of that patch (which is in clk-next) and resend this?

