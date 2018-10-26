Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FE9ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CDA20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nGIIzA9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CDA20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJZXVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:21:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeJZXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:21:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so644060pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCfUU8SpHfEmAPHXqEtW+VtRBKPuExRqicCDj8q29y4=;
        b=nGIIzA9sUH3xhRTgytGk06e1T3qPtjrDwlKet6b3HqKEojx405qjqESehx1x4TqgHP
         G9gA3JalkS1tteEFAerR3AtMoRInyOlLRy1cPYF/iQINgLIYVRBOd/fYsUdt9yEqUFAY
         YgrxT1V8RmNHl8eu4ioOgMJz7EiMkyWdkFXJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCfUU8SpHfEmAPHXqEtW+VtRBKPuExRqicCDj8q29y4=;
        b=VJt5WLOrhPKYEe8Aaznu8pDop5MCMhWn1J9AR7ohED7/5OuFv9uzJQryO1qaxjq/G7
         4xYtnz0PhSscW/v7tlzL6rFUi7i32lw6JuI/9Y4za8/PgaULK4OAaMtYxu86EueDtDrb
         zyw9qw8Y7rknJ/aMsg2URo/Vsp8tM2wJyuI1B9SKZ/5DFF6x5NE2S+dD/6L3Q0QvCgxt
         fpwe48YiL4bRM9cFlRLYD57HaBovwYNl41jHR5/cp1Zjo5MA8foDuiQX1lLk97dmU6KJ
         8vE5DY+EDF1FNawAUwoBl/BimKZYVgY+bUZN2EzzQv18nmjPTr7dnR5xLrbraInMRorR
         TDOA==
X-Gm-Message-State: AGRZ1gIATyk8WxQaPD4jTU3Y+4UAo0zA2xbxt7h8uD2hSzSmu4aA+ch4
        o+9q7ZlCfiU9s14dLHXVc7kv9g==
X-Google-Smtp-Source: AJdET5dCkTKMuBJG5eIyIgbSBBwJuaDl+Rpv9ClSqBLosTZXn8tzu1DRJ9schG34dsVFgG3vek45Iw==
X-Received: by 2002:a63:ce56:: with SMTP id r22-v6mr3698001pgi.217.1540565069444;
        Fri, 26 Oct 2018 07:44:29 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:28 -0700 (PDT)
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
Subject: [PATCH v3 03/25] clk: sunxi-ng: Add check for maximum rate to NKM PLLs
Date:   Fri, 26 Oct 2018 20:13:22 +0530
Message-Id: <20181026144344.27778-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NKM PLLs, frequency can be set above PLL working range.

Add a constraint for maximum supported rate. This way, drivers can
specify which is maximum allowed rate for PLL.

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
index d17539dc88dd..574fd2cd2a79 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -132,6 +132,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 		return rate;
 	}
 
+	if (nkm->max_rate && rate > nkm->max_rate) {
+		rate = nkm->max_rate;
+		if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
+			rate /= nkm->fixed_post_div;
+		return rate;
+	}
+
 	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
 
 	rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
index ff5bd00f429f..c82590481188 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.h
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -36,6 +36,7 @@ struct ccu_nkm {
 
 	unsigned int		fixed_post_div;
 	unsigned int		min_rate;
+	unsigned int		max_rate;
 
 	struct ccu_common	common;
 };
-- 
2.18.0.321.gffc6fa0e3

