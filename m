Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA6AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622EF21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKU2WXpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622EF21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeIXGqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38371 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeIXGqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so3287538pgr.5;
        Sun, 23 Sep 2018 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJU/OMIS95Lf3Tx6/awWt2CDF0phION8a6f3KzZn+vM=;
        b=gKU2WXpxx8gqqyh9kjjIL4k/qRd2WzOpM+IKV5piWz2GX5/tyarPgCbA6n++7TpHSu
         4SLmpcq1nOXWToTd/tD5RuSlDVIJsU9i/mn3YykJxX0XqkZR92pftQiNN7lDUhq4Kj67
         UjxKLE1h+xzwxLumupaRjbWHURw6lwSrfhflLA/wLJggyA8qXq6366zQLkiav7/Hufq+
         EioahlQNjhr/3zorOmPEHXjNaH24O14kJzABOul0pD60gKw1dmix8waGP+R9kL2q7pGT
         9WXwfSpuNYiGqvbLDfLXfkAHCjGuNK4/yGrdMRPvdEAj2sJJebBge/LKDvYvHOzlqJnT
         Joqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJU/OMIS95Lf3Tx6/awWt2CDF0phION8a6f3KzZn+vM=;
        b=jNjvLptCg0Tzu8zIYgTJE1hF4/pf9AsNLkhMniwnpXIHQ5QNgANaQBlvc0TbewFFtL
         dX5aZ2dOdMrxNd8wcdINtIpIkMecSjojoUhGZtjq2RXbvNnCQ0CGAOlO00KqOuNnXcm2
         Js9aA1zzoYdRTizj9deQB5o8tO2DrkRARYnyPdhivvGKuimu2BxgxDg8Oh3/bIU5T2Fu
         0JC3McNqVOeqO1vEyEznjm4uO3GphvkVa3cvfcqWxNvyjn0NszDP3BL9rPGcvJvEtw+T
         tehRIJspJU9saHzZfWrBxirF645yBpvdB49RcIvbe0AAtl1/ulobO+9OYgVF0U+7d+wV
         I49Q==
X-Gm-Message-State: APzg51B22gXciIh/MXn89EtCaZI8VtKOZliY1GaBSuLAkdCa45YMVpTC
        M1VLQV2EeQkYvtdT8PMfsG4=
X-Google-Smtp-Source: ANB0VdZgCXGORQFbxvpnupv3C+fgv6mQsLbDdYx5GH9zmi1/bifO5LaL7vL0WdyOaiyNTVMpJcJqvQ==
X-Received: by 2002:a62:7510:: with SMTP id q16-v6mr8046015pfc.225.1537750022895;
        Sun, 23 Sep 2018 17:47:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Date:   Mon, 24 Sep 2018 03:41:44 +0300
Message-Id: <20180924004153.8232-12-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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
 drivers/memory/tegra/mc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 5454ffe5b2e0..cdc33f93cf7c 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -11,8 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
@@ -619,23 +618,18 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 
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

