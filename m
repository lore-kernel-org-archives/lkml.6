Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1549C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FAE206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6R3Idbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FAE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeJAFYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43899 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbeJAFXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id r8-v6so10355200ljc.10;
        Sun, 30 Sep 2018 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbH0hajpnTl0zJfBVdsDy+MT/NpTwMHZcOU8d9ol1jw=;
        b=K6R3IdbqUa3uuSC9JGYJqT0QcDaOushqrC1s/ZwePWgo7lNtgs7csaPte3AnyyvJ7K
         EjZcsVyT9N+oZJgEulcqsuSAaskhNdjWNqKI0kfJIabeQoNDfTKMDZnGmo8KpoOaXAeN
         kZw03m+EQ9GLY6YsVZPYs11QSMPnvdNMTowStJIGs7qMrMuSC+hbGiwCLDtwq9xy7KX3
         EIUVejF+B+8YmVKzuofTUfk/8bH++6bKOTeyhUA5RZgYWpBvXHEY0MwIDTbF1a0jg+Af
         n65K15QoIwLjrl46YaxJbdspbGd1Q5E5bfP557RG0vLgeyjib2lwnTFsL5SrGmTZsg8g
         MZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbH0hajpnTl0zJfBVdsDy+MT/NpTwMHZcOU8d9ol1jw=;
        b=iWH/+UfFJnk/X37SRUeuh2kJfutYhviUpKOneCQsxtxJTT9ZSeWsjwrh1DadJbjs/s
         husSRK2LPPVVEtQNMhzTiVwb5YbNBFVBsiCudIK4bpT2HuxCvTF2vo8XNAYhldFmApNA
         AnfGxzryCCFC02SI160iURxYI1xpHIS2ngYARY5Le1AsZRg/0HcQjIyCm8hSLiZuforq
         0uduNOCoo95dgOXMvNx8TCX0i2MiSRhiNEHiOqktEGTzUZ98YtQAcRhzTAgvHNmzDDSv
         5IBaxbwGP1kDI8+IbzKZh632NdiamFdt/C1z09Bq6PJlpBJ5lenXw0R5vUTSPXruCfgH
         k8hw==
X-Gm-Message-State: ABuFfog0z/rC9qs8REfcV5WbsRzxXbYjCAL2pivq6e77qJ40rzmqfSTm
        ljUckKO4nASC/EbIKOVrzsTlfR1M
X-Google-Smtp-Source: ACcGV625+Rq/rTqDq4VRpb7zVsHpBAoMy3zA3xqVw/10nBIN5B1KtjGix9psFZ07rl/NX4IsDznY4Q==
X-Received: by 2002:a2e:8606:: with SMTP id a6-v6mr3973366lji.43.1538347745519;
        Sun, 30 Sep 2018 15:49:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/21] memory: tegra: Use relaxed versions of readl/writel
Date:   Mon,  1 Oct 2018 01:48:24 +0300
Message-Id: <20180930224833.28809-13-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for inserting of memory barriers to access registers of
Memory Controller. Hence use the relaxed versions of the accessors.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 9856f085e487..887a3b07334f 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -26,13 +26,13 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
-	return readl(mc->regs + offset);
+	return readl_relaxed(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
-	writel(value, mc->regs + offset);
+	writel_relaxed(value, mc->regs + offset);
 }
 
 extern const struct tegra_mc_reset_ops terga_mc_reset_ops_common;
-- 
2.19.0

