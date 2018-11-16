Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D54B2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D54B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389803AbeKQBMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:12:36 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:5643 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbeKQBMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:12:35 -0500
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie6.idc.renesas.com with ESMTP; 16 Nov 2018 23:59:50 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id B6F9C10021F;
        Fri, 16 Nov 2018 23:59:50 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.56,240,1539615600"; 
   d="scan'208";a="297674423"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 16 Nov 2018 23:59:45 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@pku.edu.cn>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 0/6] clk: Add functions to get optional clocks
Date:   Fri, 16 Nov 2018 14:59:31 +0000
Message-Id: <20181116145937.27660-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few drivers get an optional clock, e.g. a bus clock required to 
access peripheral's registers that is always enabled on some devices. This
series adds of_clk_get_by_name_optional(), clk_get_optional() and
devm_clk_get_optional() functions for this purpose.

The functions behave the same as of_clk_get_by_name(), clk_get() and
devm_clk_get() except that they will return NULL instead of -ENOENT. This
allows for simpler error handling in the callers.

*Note*
This changes the return values for of_clk_get_by_name() in some cases, see
[PATCH 1/6] clk: Add of_clk_get_by_name_optional() function.

v6:
 - Rework the __of_clk_get_by_name() logic so as to avoid duplicate tests.
 - Add doxygen style comment for devm_clk_get_optional() args
 - Add clk_get_optional() to archs that don't use the commom clk framework.

Phil Edworthy (6):
  clk: Add of_clk_get_by_name_optional() function
  clk: Add functions to get optional clocks
  m68k: coldfire: Add clk_get_optional() function
  MIPS: AR7: Add clk_get_optional() function
  MIPS: Loongson 2F: Add clk_get_optional() function
  arch/unicore32/kernel/clock.c: Add clk_get_optional() function

 arch/m68k/coldfire/clk.c               | 11 ++++
 arch/mips/ar7/clock.c                  | 11 ++++
 arch/mips/loongson64/lemote-2f/clock.c | 11 ++++
 arch/unicore32/kernel/clock.c          | 11 ++++
 drivers/clk/clk-devres.c               | 18 ++++-
 drivers/clk/clkdev.c                   | 91 ++++++++++++++++++++++----
 include/linux/clk.h                    | 38 +++++++++++
 7 files changed, 175 insertions(+), 16 deletions(-)

-- 
2.17.1

