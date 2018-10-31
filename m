Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77962080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M4ht3Mz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77962080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeKADgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37467 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbeKADgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so7784145pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7lbeeSvEnZI4wYO4AdsAOv6p+rSk6vo3glAOsyex2g=;
        b=M4ht3Mz5mve84T3gpNuDl6d1buS5287grui3JQvm1qQQ4jS3FAjjA2yrdGq5q8uySQ
         dkpAkJl8wCOSa+IqEfGxldrsqAVp5bgTQkQqFATzfGUn3q2kE4kPTJ0sGUZkHCSNW+wU
         7P0UIgUq70mgkoxYR0ng1ntqZem/kdV9eXDTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7lbeeSvEnZI4wYO4AdsAOv6p+rSk6vo3glAOsyex2g=;
        b=tlOlJgpqan4Fyb2n0KZZXvMvbu1tvmZdM+yZ9X3mjavjPKRFu7f/a1Eg2C8lGshV7x
         E3t6yntLK/IKVtFuFQsHQo5A4Y0xhWnz27wpCCpTTWylKNZhW4eLUArgUr/zr47el6kO
         hQ1gliPGh52FYH2DjVCF6d1yWyoRVjM+dqRkYjTEphH3zk+smaDR6FtSFbW0nkFWgfDP
         EgYwlGjVJFa/enaUCq5LOnVcoJPfWvzg95we/ea4E5M7sSqb+pdMuWfJjvdHJHg8VkeL
         nFuPS/+OYYc0Kdc5CiXMNqQvS+IBY5u5yUSZWVoVBR8dLqTOyBef8vt1p4cTEppYYV3A
         7GIg==
X-Gm-Message-State: AGRZ1gLLO1Z5D3J88iKaWRAYx9htwpNaRqyDauPYIuzbDIU8KxajAkLi
        WdhkUlAhl1OwXbHYMDQUFeevnw==
X-Google-Smtp-Source: AJdET5d6SDNBgqzm6vbzEWsm8SaMihOKNtoV9jru8Y8s1qsmoH/HIIrxRazbm2ZuXDr2CTouctckMA==
X-Received: by 2002:a62:5e02:: with SMTP id s2-v6mr4713768pfb.146.1541011010932;
        Wed, 31 Oct 2018 11:36:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:36:50 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/7] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
Date:   Thu,  1 Nov 2018 00:06:28 +0530
Message-Id: <20181031183634.29640-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MUX bits for MMC clock register range are 25:24 where 24 is shift
and 2 is width So fix the width number from 3 to 2.

Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2193e1495086..e2bc612f1d3e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -411,7 +411,7 @@ static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
 					  0, 4,		/* M */
 					  8, 2,		/* N */
-					  24, 3,	/* mux */
+					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
 					  0);
@@ -419,7 +419,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 					  0, 4,		/* M */
 					  8, 2,		/* N */
-					  24, 3,	/* mux */
+					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
 					  0);
@@ -427,7 +427,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
 static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
 					  0, 4,		/* M */
 					  8, 2,		/* N */
-					  24, 3,	/* mux */
+					  24, 2,	/* mux */
 					  BIT(31),	/* gate */
 					  2,		/* post-div */
 					  0);
-- 
2.18.0.321.gffc6fa0e3

