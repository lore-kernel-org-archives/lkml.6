Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E61C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB8E20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FweXRpwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfBWNH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:07:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38848 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:07:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so4259688wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AKSyCQMNYBv5nWh/KBmSW8hTM6N2dO+8FV84ST3V3Mk=;
        b=FweXRpwO5ayiperaVHweKq29vXe1C65x4VoJdxMjwwWtiWIxgUPzCZSzW/8DqrMai2
         hSqP3E3K3ifNxd/Gge8QibnK+XGe5pOOfv6rSIwfhdIzMgxiKHeXGHgBQZD67QYnbf3T
         5AyEFpWFeSFb9IroZT//XYiQONOYhenc402TUug3Kwux0CPMkKHM7Ok/1DudjXLDOMoB
         JJGa2pFrr/icqFrcL/atpIBLOKxtWwg2LpQrIS5j9KWr+r2vmmO9iXOd2KbvoV3YbDsm
         ieFGVDuJm5mkrKNy57dTXf2e/gdauqaWwYdmLPBjZWjspQo9InxfgMSmMlisfgfN+EFX
         FesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AKSyCQMNYBv5nWh/KBmSW8hTM6N2dO+8FV84ST3V3Mk=;
        b=dk6Fhi9URNDq3gYQTEHaauxDbvi8L/ODWkCHe9FU8iqm3hHSEVznr+15eI9L/iPkJi
         ePH7qIl0v8ujMyFBcM2WaJFfwh3aKNxsilertRMg9W9jfpOSvIPsv0rvo/55ycxVdbOq
         U3IA/pU5EtcNHl3khnk017Ri6IrtiE+igcewOhZ8LetF5d/V4LQRShOisGooYtZfV7oH
         oLgxgbjlOnIJUYDavJogW3ly4rZAbKGeYUCycroXDJ6qnstD6yoTlxleEq4MHU5nbb/U
         EnAzJznaIiWegazpglhORxS+BxCRZz52T2hCvesuynvepZUbq5hPHqYe+lcRue1ZdbWP
         G0dQ==
X-Gm-Message-State: AHQUAuZz1PeNenzvg3S9FNJ6zMdaCrculZFzxZy/Z+DyLVv3Z3UMSZTm
        /WEBKPmng+E6zt/y7TdjAmiFJoiYQeI=
X-Google-Smtp-Source: AHgI3IY+jcPSsKN69Gcm2EYvn3Rne57hr42so/SgmhoskLAweyRxnWBIC0/vmLnIlDCyk9AEoD6CaQ==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr5548250wmd.103.1550927273393;
        Sat, 23 Feb 2019 05:07:53 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:07:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 01/18] clocksource/drivers/sun5i: Fail gracefully when clock rate is unavailable
Date:   Sat, 23 Feb 2019 14:06:49 +0100
Message-Id: <20190223130707.16704-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

If the clock tree is not fully populated when the timer-sun5i init code
is called, attempts to get the clock rate for the timer would fail and
return 0.

Make the init code for both clock events and clocksource check the
returned clock rate and fail gracefully if the result is 0, instead of
causing a divide by 0 exception later on.

Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun5i.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 3b56ea3f52af..552c5254390c 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -202,6 +202,11 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	}
 
 	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	cs->timer.base = base;
 	cs->timer.clk = clk;
@@ -275,6 +280,11 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 	}
 
 	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	ce->timer.base = base;
 	ce->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-- 
2.17.1

