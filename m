Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979221852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551204522;
	bh=6luI78bJ4FYRrCrd9j5W8oBLzCAaME+1lLXedunPT7k=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=PiFEGXmImG8klOFBr39fdliS3pk8RspOzBtITNE+gs+AhHbdHL1bXEp7QD8MTPUk3
	 hgQbobH7W2h07KisUf+lLBJbBfu5zryEztoTgbIO2Z6pEDBWYjhmPpDRJpJc8SuWR+
	 CVyHL6kClvhRYuoSPS0wpMiorZ3Q0sOvj2OGuv2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfBZSIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfBZSIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:08:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2468217F5;
        Tue, 26 Feb 2019 18:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551204519;
        bh=6luI78bJ4FYRrCrd9j5W8oBLzCAaME+1lLXedunPT7k=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=K011+sfjrQJFpSVn8+2/GWdhhs+yGwngpiYn1zyWAriEJmyHOWTTPseavnAwEhJHK
         Zv+MsW7R2fUw598EUTTPROoUbCwOlkPzjBM7Wso31A7Xb/WHxhlrznT1PB2bApUEbx
         pB/YjiLWlr1VK2GY+g29bIr8S4+px8Yw0rOmHG9w=
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
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com> <1551157967-30925-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <155120451899.260864.1060210942751564859@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 2/2] clk: imx: scu: add cpu frequency scaling support
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1551157967-30925-2-git-send-email-Anson.Huang@nxp.com>
Date:   Tue, 26 Feb 2019 10:08:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-25 21:17:36)
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

Applied to clk-next

