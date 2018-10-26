Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93605C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6620651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IwQkeVkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC6620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJZXVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:21:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33744 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeJZXVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:21:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id a15-v6so681591pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqT7S7ccSlN0Z4oiBOZYnQBnDGQDeTm2f/tIRaoUEO4=;
        b=IwQkeVkXMNjUbqG8HwSVKIlFeG2UDJLGlpb32wDzc5jnDs0TKyi8UfQ8Otm3LgsIyn
         YhgeEihQGExInby1uQLx0bNRQbdAc18wdR1WUphI5NzDUErZJL62BKY36F1lQ9OobsBJ
         c539CFIjvY1RMhiGduAsTT6tjYoNdJJB4F29I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqT7S7ccSlN0Z4oiBOZYnQBnDGQDeTm2f/tIRaoUEO4=;
        b=TOTtqJZsUoD8ZJeTiAhSI81p8Wbw6NFq8Mzytz7rMxNBlptuMKNFxQPrn1+L2is6DV
         YJF+5V1KyVKJaSyGBF0KOgNkjsp2NY5r2J0Uncui+rs1LXJ+EYr9N7ufuiSQEoAQIiUg
         25gEcnbEzQRaRc5bfNDndSCvvYRdyZNIQ6NZeYAW7Bnno6hj1EOQcVm1I6FKvFACXlv1
         mB0HAJO6RRy4VChgOa9pOOoXtOuZwl+IrUqkYZe1mG5Liyou76AmoWsJlutadRemPLeY
         pESLNbxmx+TYR2a2XI71eB+aWC1BxmSAYrJLtv49/X6sOEnuNZXWkf+/y7qQ3tCBLT4W
         jX2w==
X-Gm-Message-State: AGRZ1gJc5CfsHNCt2FqQKmpdl4PvS1M9/3wUUuLnsZYhNDQNVxMCsINe
        UxCGYfa5VhUmA2fYsFJ+bluXdA==
X-Google-Smtp-Source: AJdET5dwXUrFOyiMpZ7HyN1IfRqpZo8uWMppQAsUlS9mUf0ioXHLoBiT2n/c/xkE2UhLRT+xsEUqxg==
X-Received: by 2002:a63:b218:: with SMTP id x24mr3606180pge.223.1540565063890;
        Fri, 26 Oct 2018 07:44:23 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:23 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 02/25] clk: sunxi-ng: Add check for minimal rate to NKM PLLs
Date:   Fri, 26 Oct 2018 20:13:21 +0530
Message-Id: <20181026144344.27778-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NKM PLLs doesn't work well when their output clock rate is set below
certain rate.

So, add support for minimal rate for relevant PLLs.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- collect Stephen Ack
- add tested credit
Changes for v2:
- none

 drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
 drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 841840e35e61..d17539dc88dd 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -125,6 +125,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
+	if (rate < nkm->min_rate) {
+		rate = nkm->min_rate;
+		if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
+			rate /= nkm->fixed_post_div;
+		return rate;
+	}
+
 	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
 
 	rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index cc6efb70a102..ff5bd00f429f 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -35,6 +35,7 @@ struct ccu_nkm {
 	struct ccu_mux_internal	mux;
 
 	unsigned int		fixed_post_div;
+	unsigned int		min_rate;
 
 	struct ccu_common	common;
 };
-- 
2.18.0.321.gffc6fa0e3

