Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62969C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DB42089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMRdmb3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DB42089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeJAFX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44306 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJAFXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so1273493ljc.11;
        Sun, 30 Sep 2018 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsgdinMofIP7nr3aY1U1WRqrvWUpybzDl0Q6gbyrGkU=;
        b=iMRdmb3VFDrlpRuF7tx/29vupYRZOzpDLyMOkWoP96y5UUizzHMXpmzH4Ne7Yril2c
         EDMbjRLaxnwxKoQGDVzJiHFmM4Nw25jVmoo5Y9VaGrAGs3HKzWUSlIQs2dG29k2ab8wW
         O7CIVg9bgdAv7K7rBrce2suQvJS1AxI2+l+Wf+p5YEp2Qc3Z+y2Kbe4FhU1OjD5sz9gu
         h1uqLmw4oOmVCJhmE4sI/B333Ij8HDttGHX1E7agReIjZv50UGq2R2VVzTM2l/krZ9wI
         TMQ1I5bAFIwcn1YnwTrnXLUTuEevQcjidkmUT1+Kkkdfnho7SY4LEYd6nzEx23DlhF0t
         Opjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsgdinMofIP7nr3aY1U1WRqrvWUpybzDl0Q6gbyrGkU=;
        b=tiPWF7RXgaWanbKoM0ysurQav9BiNmuiEhGLp+161TjN0SxfZcqmdoYe1elgThyRIW
         Nex4NfvamtUaBlAW05UsJrLk8iHOgoaca5XwBfw1KI04M9rjizj5hmzJnYQG1RRyDnBu
         iPeVmvvFZFILlM8KS8w+xTUv0DCBDuMMI9S7Rvj6hrzfUQaS6MuT+c113iyrl5J2B4u6
         607ZzXMsgXrOaC+EVuTySL87MGyZvgcXa68seYI2WwjxVhNRi35MeW5lfzis63uAciF3
         WOoM8Bcd81Pvw2RjujEz3IP2+JTlehULxNkBfAWqjzL0C4CsunB3JvfTQcqZrEFS3aFv
         cseA==
X-Gm-Message-State: ABuFfogZuLXusjzEe/jUzd30on/DaB1I3sb34vrQzeQ7Aow7hFGet+rT
        aMIh2vjRW9P/7UCxWwLbLK7ddwdX
X-Google-Smtp-Source: ACcGV60fr2ZHEPXZybTDxn5eSL9G0n6DZ/xZPoPTtaRGC3o1uUJylFUwm345gn5O2VDamJubRAt6Ug==
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr4518411lji.140.1538347744546;
        Sun, 30 Sep 2018 15:49:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/21] memory: tegra: Use of_device_get_match_data()
Date:   Mon,  1 Oct 2018 01:48:23 +0300
Message-Id: <20180930224833.28809-12-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to match device with the DT node since it was already
matched, use of_device_get_match_data() helper to get the match-data.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 5454ffe5b2e0..bb45cbd3d5de 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -619,23 +620,18 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 
 static int tegra_mc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct resource *res;
 	struct tegra_mc *mc;
 	void *isr;
 	int err;
 
-	match = of_match_node(tegra_mc_of_match, pdev->dev.of_node);
-	if (!match)
-		return -ENODEV;
-
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mc);
 	spin_lock_init(&mc->lock);
-	mc->soc = match->data;
+	mc->soc = of_device_get_match_data(&pdev->dev);
 	mc->dev = &pdev->dev;
 
 	/* length of MC tick in nanoseconds */
-- 
2.19.0

