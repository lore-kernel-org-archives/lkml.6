Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E65C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbFcP9XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDF02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJXRPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeJXRPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:15:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73192081B;
        Wed, 24 Oct 2018 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540370878;
        bh=QVhTGzw5V0Wa+4cI2tp1Taqfs+xvEq+hJgmPBgiJkho=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tbFcP9XSggjZWhp1hnq7/25ntDOKn+6L1oHHpiK2kMKfvx0dJGWOs7XNOnOeyXrKv
         keoLBKfbAry3UHCeXM0hJWxKEIclwmQCMwrIQHM6QuuT45uvMuiWI1TNSO0hBBBATw
         AmjQ3WmH2uIVOOXTTktEYo3aNF/6IQhAeI5vaxH0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <ffb2e431-95a2-b5fc-34ee-432e101379a4@amlogic.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-4-git-send-email-jianxin.pan@amlogic.com>
 <153988282130.5275.17528969137837015544@swboyd.mtv.corp.google.com>
 <ffb2e431-95a2-b5fc-34ee-432e101379a4@amlogic.com>
Message-ID: <154037087711.53599.12246779227164118041@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 3/3] clk: meson: add sub MMC clock controller driver
Date:   Wed, 24 Oct 2018 01:47:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jianxin Pan (2018-10-23 23:29:24)
> On 2018/10/19 1:13, Stephen Boyd wrote:
> > Quoting Jianxin Pan (2018-10-17 22:07:25)
> [...]
> >> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc=
.c
> >> new file mode 100644
> >> index 0000000..5555e3f
> >> --- /dev/null
> >> +++ b/drivers/clk/meson/mmc-clkc.c
> >> @@ -0,0 +1,296 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Amlogic Meson MMC Sub Clock Controller Driver
> >> + *
> >> + * Copyright (c) 2017 Baylibre SAS.
> >> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> >> + *
> >> + * Copyright (c) 2018 Amlogic, inc.
> >> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> >> + */
> >> +
> >> +#include <linux/clk.h>
> > =

> > clk-provider.h instead of clk.h?>
> Maybe we need to keep clk.h
> devm_clk_get() is called in mmc_clkc_register_mux() to get parent in from=
 DTS.
> I'm sorry to miss this in previous reply.

OK. But also include clk-provider.h if provider APIs are being used
here.

