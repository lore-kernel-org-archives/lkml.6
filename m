Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0962ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874B21529
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1YAAy6U/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B874B21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJQXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbeJQXWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:22:45 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D766321527;
        Wed, 17 Oct 2018 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539789993;
        bh=AxayswVADNuOS65eJITuNANdHZhcl4q0uIAb465Ys10=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1YAAy6U/Xcv4kA+uLPx3IRDj3LpXmKVPxfTNfae3mYY7f+iz+7aqu2CUFtE4KlsrR
         rZzFreAoJq9Z5vJ8iVPU3OefXvVlnmzqAKNIUz2coiF4QQ6KY/kTqHU96XgFuMXO2m
         WerVlv6egENUOvNcHacNUKCwMZihlyipwX5JB+MU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539756441-18776-2-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
 <1539756441-18776-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <153978999232.5275.9499110259610344794@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: imx7d: remove CLK_IS_CRITICAL flag for arm_a7_root_clk
Date:   Wed, 17 Oct 2018 08:26:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-10-16 23:12:04)
> i.MX7D uses virtual cpu clock of "arm" clock to be child clock
> of "arm_a7_root_clk" and it is with CLK_IS_CRITICAL flag set, so
> no need to add CLK_IS_CRITICAL flag for keeping "arm_a7_root_clk"
> use count correct, latest clock tree is as below in clk_summary:
> =

> pll_arm_main                         1        1        0   792000000     =
     0
>       pll_arm_main_bypass            1        1        0   792000000     =
     0
>          pll_arm_main_clk            1        1        0   792000000     =
     0
>             arm_a7_src               1        1        0   792000000     =
     0
>                arm_a7_cg             1        1        0   792000000     =
     0
>                   arm_a7_div         1        1        0   792000000     =
     0
>                      arm_a7_root_clk       1        1        0   79200000=
0    0
>                         arm          1        1        0   792000000
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

