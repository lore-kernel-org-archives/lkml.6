Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6459C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904AE20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oxnv06Py"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904AE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIDVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:02:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40567 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeIDVCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:02:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so1960121pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgGxqpHfONe63cngU4r8XAmCw46ptaTvnJJqhhtjpPI=;
        b=oxnv06PySTU7a7uPWxGd94aID/VRa9Jye0J4NPsCfO6LlFg+cQ0MVxZmIlxPu96h+F
         +PW6cQsjtPk5fWqRIN1nyZbbZVGqadE7KYMAjelbWMcGRDpn0gwonc2VQUaRMTfGY+j0
         uuOFGUHDCP/anc8HvmOpmyrL6T6Dvof9sQTs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgGxqpHfONe63cngU4r8XAmCw46ptaTvnJJqhhtjpPI=;
        b=V/D/17FfsyKsgZqlKrg3iLFEieVgwnomyXJ6K2INJz5EdZxZwbKltV94WrbasrYvX+
         dlnhA32tFzGsskY87YEXF/ngPKmvvP/7ojEoC2D0R3uYxomHz0Kp7ipbAXSmZCWh7EiM
         ATM5cBwlqXhZDio1CD+0+4kckJEK4axw3HVVSQUAWPtKsrIVkK64eRbR2dQg4YFf+iuS
         MikffUqQ19FfSij5PV+hXUXmwhzBm3gIIBBPzDm80h+aIwKYAaB1BRf3+hZPAmZioEeo
         lUD91rQ4NNw+6bd1egHInoVfNTZJVrUp6WyYvror/W9LTqxpCL0ys4aYbXA1DAGpG+hE
         SOAQ==
X-Gm-Message-State: APzg51ARNTkz9cZgxg5DkfF0BZHPoB/e+Lu4dyAbDcT8gh1zTLauWuQh
        0rRSPxNEMgiLaCAaB9HfuwZ+BA==
X-Google-Smtp-Source: ANB0VdallYHbk8tSESlcQkdFYIPyxD3iu26MMNQrh6vePTeiNKuOnS0iAQjj1bLqXHjiAZu/Pua2og==
X-Received: by 2002:a62:de04:: with SMTP id h4-v6mr31821616pfg.258.1536078988982;
        Tue, 04 Sep 2018 09:36:28 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.161])
        by smtp.gmail.com with ESMTPSA id t2-v6sm36037072pfj.7.2018.09.04.09.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:36:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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
Subject: [PATCH v4 2/4] arm64: defconfig: Enable CONFIG_DRM_SUN4I
Date:   Tue,  4 Sep 2018 22:06:07 +0530
Message-Id: <20180904163609.10171-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180904163609.10171-1-jagan@amarulasolutions.com>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DRM Support for Allwinner Display Engine, built as a module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4, v3, v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..4919e4577548 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -433,6 +433,7 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
+CONFIG_DRM_SUN4I=m
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
-- 
2.18.0.321.gffc6fa0e3

