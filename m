Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0648220879
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0648220879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK2Mvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:51:47 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:35025 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeK2Mvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:51:47 -0500
Received: from [10.18.29.194] (10.18.29.194) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 29 Nov
 2018 09:48:20 +0800
Subject: Re: [PATCH v7 0/4] clk: meson: add a sub EMMC clock controller
 support
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <aa21f2d6-507d-a672-9e9b-0896df011307@amlogic.com>
Date:   Thu, 29 Nov 2018 09:48:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1542284312-55418-1-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.194]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

I made some modifications as you suggested， could you please take a look?

On 2018/11/15 20:18, Jianxin Pan wrote:
> This driver will add a MMC clock controller driver support.
> The original idea about adding a clock controller is during the
> discussion in the NAND driver mainline effort[1].
> 
> This driver is tested in the S400 board (AXG platform) with NAND driver.
> 
> Changes since v6 [7]:
>  - add one based support for sclk divier
>  - alloc sclk in probe for multiple instance
>  - fix coding styles
> 
> Changes since v5 [6]:
>  - remove divider ops with .init and use sclk_div instead
>  - drop CLK_DIVIDER_ROUND_CLOSEST in mux and div
>  - drop the useless type cast 
> 
> Changes since v4 [5]:
>  - use struct parm in phase delay driver
>  - remove 0 delay releted part in phase delay driver
>  - don't rebuild the parent name once again
>  - add divider ops with .init
> 
> Changes since v3 [4]:
>  - separate clk-phase-delay driver
>  - replace clk_get_rate() with clk_hw_get_rate()
>  - collect Rob's R-Y
>  - drop 'meson-' prefix from compatible string
> 
>  Changes since v2 [3]:
>  - squash dt-binding clock-id patch
>  - update license
>  - fix alignment
>  - construct a clk register helper() function
> 
> Changes since v1 [2]:
>  - implement phase clock
>  - update compatible name
>  - adjust file name
>  - divider probe() into small functions, and re-use them
> 
> [1] https://lkml.kernel.org/r/20180628090034.0637a062@xps13
> [2] https://lkml.kernel.org/r/20180703145716.31860-1-yixun.lan@amlogic.com
> [3] https://lkml.kernel.org/r/20180710163658.6175-1-yixun.lan@amlogic.com
> [4] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan@amlogic.com
> [5] https://lkml.kernel.org/r/20180809070724.11935-4-yixun.lan@amlogic.com
> [6] https://lkml.kernel.org/r/1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com
> [7] https://lkml.kernel.org/r/1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com
> Yixun Lan (3):
>   clk: meson: add emmc sub clock phase delay driver
>   clk: meson: add DT documentation for emmc clock controller
>   clk: meson: add sub MMC clock controller driver
>   clk: meson: add one based divider support for sclk divider
> 
>  .../devicetree/bindings/clock/amlogic,mmc-clkc.txt |  39 +++
>  drivers/clk/meson/Kconfig                          |  10 +
>  drivers/clk/meson/Makefile                         |   3 +-
>  drivers/clk/meson/clk-phase-delay.c                |  64 +++++
>  drivers/clk/meson/clkc-audio.h                     |   1 +
>  drivers/clk/meson/clkc.h                           |  13 +
>  drivers/clk/meson/mmc-clkc.c                       | 313 +++++++++++++++++++++
>  drivers/clk/meson/sclk-div.c                       |  28 +-
>  include/dt-bindings/clock/amlogic,mmc-clkc.h       |  17 ++
>  9 files changed, 477 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>  create mode 100644 drivers/clk/meson/clk-phase-delay.c
>  create mode 100644 drivers/clk/meson/mmc-clkc.c
>  create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h
> 

