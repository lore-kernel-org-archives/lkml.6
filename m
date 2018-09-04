Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5803AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D1B20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ksm/4W1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D1B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeIDVCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:02:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41895 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:02:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id b12-v6so1880208plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJPqoDH0MsoE4lYy5gnvFNVcKk6DSC/Epq+gLG7sxy4=;
        b=Ksm/4W1VEhiO0BBEv/ivEX/juF4+UKgOVjCc6kuH1xDive78BS8pGo8+A3QP/l71Qy
         vIpxFEXzWrIBT4inoS+04LA2/akPQDUeEND8T5f5lfMOJLY9Bcoca+vyT21QI9PsXMHQ
         xwYFHAPAt2HYKWX1UlpJqL34Wf1Nf3rnnJSqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJPqoDH0MsoE4lYy5gnvFNVcKk6DSC/Epq+gLG7sxy4=;
        b=MsdpqWz9n8xEVsBo4rnpj9lkdm0Lx/qHp8rlaRIAiynFH6zOlS+I0KBmJh6aIS+ZTe
         0JypYEnPUT22vVtl6PqVA/o1RmKIr1s8b1c1de8J/eYCMwOE9Q9Y+TLxt6LvRDaphL7J
         Dj9Avas3FCKIR5V0lcXREMb1rpV+3skMPPIwQOXsmkQNMulzWneokNIpqktblBOQQx1V
         3S6hZyL63szKimXm/TWJ6rPSx9qglhmzFg6qgNkxHaiid7cWGT1Sm9k6YOo0besUHfhT
         nSK/RI3UIdEJ0KBEALAwtDHeQqt3HdDFsQ6PHhOuFRnps8luA2ItySqOSskqKIZPRQdi
         6KWg==
X-Gm-Message-State: APzg51DtVx/7WPFqcjUTIqcYsM11xMuswwSWhTFDVf2h2XhHdPpmHU+j
        Tp2cGqLkk5s6jAhNJE92jD1hUA==
X-Google-Smtp-Source: ANB0VdbqptrP5mrB91FCF+akBQOeZ3CHarEG2EN3zb5++dF9QYC/9VLdowcCm6FBU+F3CCqfDny7aA==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9-v6mr34234961plz.138.1536078983561;
        Tue, 04 Sep 2018 09:36:23 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.161])
        by smtp.gmail.com with ESMTPSA id t2-v6sm36037072pfj.7.2018.09.04.09.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:36:23 -0700 (PDT)
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
Subject: [PATCH v4 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
Date:   Tue,  4 Sep 2018 22:06:06 +0530
Message-Id: <20180904163609.10171-1-jagan@amarulasolutions.com>
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
Changes for v4, v3:
- none
Changes for v2:
- Enable for MACH_SUN8I

 drivers/clk/sunxi-ng/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 826674d090fd..e20182aa9748 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
 
 config SUN8I_DE2_CCU
 	bool "Support for the Allwinner SoCs DE2 CCU"
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	depends on DRM_SUN4I && (MACH_SUN8I || (ARM64 && ARCH_SUNXI))
 
 config SUN8I_R40_CCU
 	bool "Support for the Allwinner R40 CCU"
-- 
2.18.0.321.gffc6fa0e3

