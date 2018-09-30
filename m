Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26015C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD83B206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzvkjqID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD83B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbeJAFZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:25:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39984 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbeJAFXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id r83-v6so10363494ljr.7;
        Sun, 30 Sep 2018 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ouqXLjUunN0zjItu13Z4M/nn8hcgnEka9D6ynQqkQts=;
        b=BzvkjqIDwkO1bIXy5MJdybVitwStOwwmG5JJaHL8AxqxPBcrLQcrvPrkkpkD4TTvo8
         nduCEKqrMhoFT1/Kd0zEIZLZ1K4z4mzkb/Fn2zuWnCZJ5UsLAiJMrt595wLttEcspg/d
         qt/kFuiHn4+WJY5RFjRKvN6XcMtGeGjzCo9algKGYH5qppcu/AqQDboQUgzUHpLHZHaK
         ETWuK1ByvyQ8xxym07Bv+rbheCinYGcy27YLnr4U2hr3VmGIznJe20mIrY0hDOVbtLYc
         /H8J166IoOqbkcrvDwKUDULll7pW6uRfAl+QM1RjmsLzzEdMpZKxzRTq9QtfSY2nC5k2
         wRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ouqXLjUunN0zjItu13Z4M/nn8hcgnEka9D6ynQqkQts=;
        b=pObqgwVn1C3rY3+U018X/NifOzaq2XKLocdP+lRlLHkTvJoEPEqEIQ2hRrEyO6c95d
         ipL/LJj64JcJuEDnkSsSoSFAT473i1FuLa1IpTxgaSnKjRM6OPU5cb5qbseIy78hk5Od
         tXJryjoeJohhbGkg6Y1CnXaQTxPu2v7gw4j3SSY0m/LMnWzBJd5M0SihVTjFnbKN4H4h
         20P8BWAijKxCY+MotMNzR7kGUQfshXNgmfOIOe4YpvYsO+sulK6uYVvhh6Yp1wpKnAU+
         194lcWUDjxvE5RJGZt/7J67ETqNf2GZyxhYxIGtDaAXfN46u4lgRpNoxSb9Z2mzrexZE
         I0og==
X-Gm-Message-State: ABuFfohedrSXVTVHv73lTk/RUHZIfaUsZ/U5XGf6m7N5VC45n6XorvrW
        EaO0FwKhlj0z7g7pt888IY8=
X-Google-Smtp-Source: ACcGV63J23APKiTemKWMVeGPaNTQ0HHVZ4ugf36MJA7Czphe3nkp5HNejUQhyiY1oW4t3cW6n0xNzw==
X-Received: by 2002:a2e:9a4d:: with SMTP id k13-v6mr4554715ljj.17.1538347743593;
        Sun, 30 Sep 2018 15:49:03 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:03 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/21] memory: tegra: Read client ID on GART page fault
Date:   Mon,  1 Oct 2018 01:48:22 +0300
Message-Id: <20180930224833.28809-11-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree binding changes, now Memory Controller has access to
GART registers. Hence it is now possible to read client ID on GART page
fault to get information about what memory client causes the fault.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 1b4ceefd82f9..5454ffe5b2e0 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -38,6 +38,7 @@
 
 #define MC_ERR_ADR 0x0c
 
+#define MC_GART_ERROR_REQ		0x30
 #define MC_DECERR_EMEM_OTHERS_STATUS	0x58
 #define MC_SECURITY_VIOLATION_STATUS	0x74
 
@@ -575,8 +576,15 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			reg = MC_GART_ERROR_REQ;
+			value = mc_readl(mc, reg);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
-- 
2.19.0

