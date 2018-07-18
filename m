Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1884ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA8C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y4eSKlL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA8C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeGRLdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:33:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45491 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbeGRLdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:33:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id f1-v6so1826347pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEZL8JMoR/lSHPQu49Ugq8JEqMzS9zLe5uwFgUmVDYs=;
        b=Y4eSKlL8vx/22hnlmjX2sS4VbuC/gUgeonF+PdU/ck0r+T7SbprPh11NmXmCZnvHdY
         ocQuA1OdH5fk/VD+rnKAMzj1OYeqE1kKMeIjXFJvjxA5i3bmhX7SxyQeH8RFGjnSN4OV
         V8f9U66WosHUPou6EdIgtMvxmWuiEYy0TWkWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEZL8JMoR/lSHPQu49Ugq8JEqMzS9zLe5uwFgUmVDYs=;
        b=jWPK7X2wBzIez5BKHf8FWtOsmHrMaqY34cwWIoqock9zx6jINvNVRGHoPTQghBH7lR
         TrLBfQRlbdPOBk1JFo1b+DRTPGhOUEBF49q8vP2AJEpuFJTRimLOpsh8xGyDL2qWIUd9
         DO9/E+eDSGtuFdU+4AWxM419oI2SakbP99+MrORJ1T7c++o2lPOCUhXipv0D21m7tmZ4
         eVCGK0LapApJGL1o7xGIYai2S7D6RlhxCDbBrWvWgkDBTPCgvFL1c0CHWKNPGEwQQclE
         ZNO5G6Gu7YJA+fOKDZReVDPnHRR7w0xGcrZ3EifrCPGaKusUgmOsOc5r7Y3g6hQMmp19
         BcDw==
X-Gm-Message-State: AOUpUlHVvooqZWs9BbcwQgByz62Tjyi4tE+w5M0fW9g+7dnwblQMu1hV
        dponvf3EI2sKCtMpRgPKFpqywg==
X-Google-Smtp-Source: AAOMgpfAsJ+b0oHqDOXy13H1AXviFmlrGQX8FAntfbchtlG9TtDMnJVTs/Rfzioi+hYt5qli34qhwA==
X-Received: by 2002:a62:d1b:: with SMTP id v27-v6mr4751151pfi.87.1531911350197;
        Wed, 18 Jul 2018 03:55:50 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:49 -0700 (PDT)
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
Subject: [PATCH v3 06/18] dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO[0-1] macros
Date:   Wed, 18 Jul 2018 16:24:46 +0530
Message-Id: <20180718105458.22304-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has two clock parents PLL_VIDEO0 and PLL_VIDEO1.

Include these macros on dt-bindings so-that the same can be
used while defining CCU clock phadles.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
- collect Rob r-w-b tag
Changes for v2:
- new patch

 include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index d66432c6e675..d1d7d5b7d06a 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -43,7 +43,9 @@
 #ifndef _DT_BINDINGS_CLK_SUN50I_A64_H_
 #define _DT_BINDINGS_CLK_SUN50I_A64_H_
 
+#define CLK_PLL_VIDEO0		7
 #define CLK_PLL_PERIPH0		11
+#define CLK_PLL_VIDEO1		15
 
 #define CLK_BUS_MIPI_DSI	28
 #define CLK_BUS_CE		29
-- 
2.17.1

