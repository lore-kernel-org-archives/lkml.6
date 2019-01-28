Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B9DC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF802175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yf/kYh5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfA1SEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:04:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfA1SEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:04:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so19125983wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpNi8npcEuB1/go2Tg3AdjTVG+V6jYSlzX7BwF0GsfM=;
        b=Yf/kYh5BzodGUwm1cbrUVBA1KqVdS2kGmvsYG6gRA4Se+GVQx8zHtil+snbPXEvzNT
         AeovQMbgjPdfEoBVaZmz3//mXG0o4zf8FWrufwnP0F2slTgaS4qz3gnSzd/yLcOASQQU
         kQ1a1EvsZWa8w7ayuI23vIftKyAkSE/QSNAbNYOAE1cWaBB5RNGPYpLJThSuhy+o8eib
         GcDOhT+lu4X9A/jie8xBQGzseO3DPhA1+vgJ7vz5PVnhs4/M9HFVHeX1+SQ81vol2kjP
         YZ6sPvdNjfXHruCJLZFZ/KbTSGT4OxtV33ulJlfGz/hcnu6trg+bQ2aGPisvcO6Jw2fU
         yySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpNi8npcEuB1/go2Tg3AdjTVG+V6jYSlzX7BwF0GsfM=;
        b=PrCNm9CzIqFVfWibXT7YfQFWu/IVzIstjrxMXbVCdrAHwR/Xc153M0t2LnYpo9xdTF
         1cnmc9tKvJHQmmxl2FovxW462ALK+ar6cdwB+CotmgNjskHFkTtrWzvuxA4kDBMXg6Kd
         Rs1sjwVr6dMhAgfHjOHLTRiYquJZIKmfJBqLIokEZH4VSQMF1BNpEhodivaGqJ5nZTgG
         I11tm0vHiHCdioPMXjNRVm1OZ6cakpn9XQCDrxZRkYMJvtoFXDrteyFGAaGSA0E0R4fF
         T7iXCWxuvzH1ljgVfbYewXHGj+EnyX9ArbLevevzXb57IDlXdoJOagQyBrkH8wKzeA0i
         waXw==
X-Gm-Message-State: AJcUukfU6Ur0pfJ/UQ2E0TwTPM7xGfvZzlyNPEY8IuvCI1uwgIl4vj4y
        atR1L/1ach3jp4bDUe6z4BOw0A==
X-Google-Smtp-Source: ALg8bN6R2RU/vwdb2lallgs6zrXDfvCKfKjNkwGfxMbyJV+hUE8OgxlmoMHX9A00qaFeyXiCvCWqrQ==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr22509938wrh.148.1548698683205;
        Mon, 28 Jan 2019 10:04:43 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:42 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/14] clk: export some clk_hw function symbols for module drivers
Date:   Mon, 28 Jan 2019 19:04:17 +0100
Message-Id: <20190128180430.28689-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk-provider.h provides clk_hw_is_prepared(), clk_hw_is_enabled() and
clk_hw_is_prepared() but these symbols are not exported for the
modules which prevents a clock driver using them to be compiled as
a module. Export them to fix the problem.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5a0551aba09e..91ae0e6e76e7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -394,16 +394,19 @@ bool clk_hw_is_prepared(const struct clk_hw *hw)
 {
 	return clk_core_is_prepared(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_is_prepared);
 
 bool clk_hw_rate_is_protected(const struct clk_hw *hw)
 {
 	return clk_core_rate_is_protected(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_rate_is_protected);
 
 bool clk_hw_is_enabled(const struct clk_hw *hw)
 {
 	return clk_core_is_enabled(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_is_enabled);
 
 bool __clk_is_enabled(struct clk *clk)
 {
-- 
2.20.1

