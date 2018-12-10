Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4023320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="c6YjHI+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4023320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeLJQRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:17:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53632 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeLJQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so11504228wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=;
        b=c6YjHI+8zaC8n0EX4g1e8Vzwq0r6HCALxJ7GNsXRoSdq5wGlk8aqV/UMUWWy0ZigNu
         pJWOQbpwtk91QX+azruY7KvFzZr1EcdNqByLWx+kfBWeKJno2lvvLH6neki4WH2teAfc
         hw1FzyfEbpO0kXMjwmBiKA7sBioRz5hHYVvn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEGBFedCv0eGIwFBpPqp7aDi2x6OUg3hp3DvnJn01c8=;
        b=owuapD2Arefgm69AsfRw4uyMk+S5sR0+jImMML6LhRuAGoEGe7CAGqiN4vXtREwpTx
         jUBZUxd9DPjXv6NvvSMbNVKd1zDWgEDlSv9zU6+54TmevWvQzXxhxZNkZ70oN/8LEHq+
         lYtEbwBpYzl4hiuZ+siCbPvFP1OmCNVsSKBPSazca/+sahVuBRPsSAAKPinOf2e5I13A
         uP4n22z4f503qOXzqbwR1rwr0TZRAYrUFFEf1tgpwdB/Qm3aap/PpP79S8l9ckiVIASk
         Hk1062eQelFaiOdny+sr+brYjvJX5c6DlTKH5s331shcJ1mDgb2691rt7jRyLE0gB+H1
         TBHw==
X-Gm-Message-State: AA+aEWZriWOdzzFVwDCzlAF1JH/QAZN5ixp0OMAQNkQ6lHTf9mJ9iP1i
        9bi1mIGEc1Tvm3rUwmZRtmOUJQ==
X-Google-Smtp-Source: AFSGD/UpCEzvMXG9xNu95c5VJhwbFLp1a5BdqBxOrmp/Ab/qDMfMcWI2sk3xnLZqpOL57VXj6x8Qyw==
X-Received: by 2002:a1c:16ce:: with SMTP id 197mr10900332wmw.126.1544458665729;
        Mon, 10 Dec 2018 08:17:45 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:45 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 01/17] clk: sunxi-ng: Add check for minimal rate to NKM PLLs
Date:   Mon, 10 Dec 2018 21:47:13 +0530
Message-Id: <20181210161729.29720-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
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
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 5 +++++
 drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 841840e35e61..096ff4f4839a 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -125,6 +125,11 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
+	if (rate < nkm->min_rate) {
+		rate = nkm->min_rate;
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

