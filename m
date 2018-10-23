Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F613C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C9220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iUSSYUyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C9220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeJXAVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:21:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbeJXAVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:21:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id v11-v6so898466pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIY6XhLByufxF+jVV+vlr11HuVwMmElwdSieruZf6qI=;
        b=iUSSYUyCpdiO1GRMAFNXQN43ygxLTUhK+Rj/ZX+WmDWv0eP7WQyrhwLGYToBYZNB8g
         T3aGctkx4lQ+R/48kk4MFhNrk7PIMUk+9S+ssHJkBAYi1GOE0xlxijj6B6/IuJPQpXbj
         OyvJ5T9Q8ly8Z6qHbbofv5SXl65+8aR7qG3VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIY6XhLByufxF+jVV+vlr11HuVwMmElwdSieruZf6qI=;
        b=lFLydc/2vWPduJ4Dvlq8dTq4rB08Jccv2eNaYg6XO9E19jZxC3jOUggvkSvSwdOICp
         YPPRxj4HwA1fyUbArnWTw5uIx2dVrWb1d0iUNNrWhe4caIZ6jr9jO84PenrWlk0GwN8K
         P8pEWrJveQQPpLmumBGCJcD7OFgxEPYA8CHZFC9NxpYWZSbluh9pu7ceARKhI4qj4XOU
         ULY9lEQzV9m/2zHARVdZKinNGnQTTDkWMVjwpYL5btZT5AjXs73tkKyWUvb1Tkhm+PgX
         CMhWxx6B23IUjyl3a+ro1W2F6oDACghmiRGfMwYIkMOx6uqYEMU7wyrp1QipGIAu2o/j
         /omQ==
X-Gm-Message-State: ABuFfojHyTIPFPHGQ69noMbpuEjAiG06KnOd1hoJm27FElYXc8P6RN12
        O7Wmpl90TY+Y8/dB0ukmgb34AW/eIQI=
X-Google-Smtp-Source: ACcGV60pdG3ei7JrWRwypPNjyyu3kxebPLbzjcuA1aJxR4zKrQbHgrf0xXXAt6QkteALIkvT+LeggA==
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr50108831pfd.106.1540310261056;
        Tue, 23 Oct 2018 08:57:41 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id l2-v6sm2207609pgp.20.2018.10.23.08.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:57:40 -0700 (PDT)
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
Subject: [PATCH v5 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
Date:   Tue, 23 Oct 2018 21:27:24 +0530
Message-Id: <20181023155727.9383-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- remove DRM dependency 
Changes for v4, v3:
- none
Changes for v2:
- Enable for MACH_SUN8I

 drivers/clk/sunxi-ng/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 826674d090fd..99cf8103474c 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
 
 config SUN8I_DE2_CCU
 	bool "Support for the Allwinner SoCs DE2 CCU"
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 
 config SUN8I_R40_CCU
 	bool "Support for the Allwinner R40 CCU"
-- 
2.18.0.321.gffc6fa0e3

