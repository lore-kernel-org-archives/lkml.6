Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A9FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78A121477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEMm1bC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78A121477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIXGrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:47:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40833 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:47:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so8333099plp.7;
        Sun, 23 Sep 2018 17:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGEUS43rmrDiePYKKFPE6JQ30QeCTnyz4CZGEBeeyW8=;
        b=dEMm1bC1EDeogca6Q9IuTBmu3wdpu2dM7p8bHgze2Hc3bJ/mv176X6swM+K6TYbyHt
         4sxHN38Yn0XaFRPrIQVcGty95Dpx7xRE0pjhk8loJoih+T5dQFKaaSLcTsnSs6U12dMc
         otG0u3Gm0+3GbzJx8hHVWDL78BqPY0xUMsC5EKLhOO+ossJmrzTQ2cpuv2aO5reWaRlB
         SZV5Sw43TjJTc6zVpiX03AW3Jagc/H/n0NXC8kEutlb3DFhqvkWXGbwgyIU9gom4BsF0
         SVQcwTx6b0br4Hjv01wVCLd5R2T+eF6MkmZFws1qepbiwok4FQzGR75iYULm6ooj2NRa
         2BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGEUS43rmrDiePYKKFPE6JQ30QeCTnyz4CZGEBeeyW8=;
        b=BBYkoq7odSNHym2gpmJ+hZK5WqlE9odq26BH2037swkZBuMlVk0o0QPN9PMYBmpgkT
         XOm7krRvgOPYw2ETGPrik/efOWewbb2l7kdUg58ODl/TQZv3D9Eol5gpwRRGFmPdaxf7
         xRabp2CdTBtmlBZsSAnvQF1qSoCtM/cf6hRuUFBeR8cZOyjFECKXUoFagyRDlYc/fwDR
         /qTEVzorH1C72yhotle8hlb9jJLT45s3WeLOYDAetSuffeia3nNm5VjbhhfGhjE8Aus8
         IT9EPF7qBD6MDb2iLgcbw++W8/QkogjPP5eOnSDiF+sXKBLXsJnQ+px2ujCGwMpt/fuz
         0JiQ==
X-Gm-Message-State: ABuFfohIqTjCY3UHIKN1RlYIaN0cQprq3Kmjg6MaIggtt+z9C2CFU8jD
        6vZ7FivtR1hFEToOGnlfRZg=
X-Google-Smtp-Source: ACcGV60eAMashiv6PbvM7zY1Nadtu5u31QnrMn4kLUcf6GlleVKGQuDdh3Tftr59zO540ZEMR/82ag==
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr8318366pld.312.1537750052671;
        Sun, 23 Sep 2018 17:47:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Date:   Mon, 24 Sep 2018 03:41:49 +0300
Message-Id: <20180924004153.8232-17-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART is a part of the Memory Controller driver that is always built-in,
hence there is no benefit from the use of managed resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 9f7d3afb686f..d019ae8ecfc9 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -171,7 +171,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
+	client = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 	client->dev = dev;
@@ -197,7 +197,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 fail:
-	devm_kfree(gart->dev, client);
+	kfree(client);
 	spin_unlock(&gart->client_lock);
 	return err;
 }
@@ -212,7 +212,7 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
-			devm_kfree(gart->dev, c);
+			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
@@ -459,7 +459,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -468,7 +468,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -506,6 +506,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.19.0

