Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FD0C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA61215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xlc/uNhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA61215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeHRTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46923 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeHRTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so6099426edt.13;
        Sat, 18 Aug 2018 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WTxC9P0e187wMiz2N5iLPT4giNu311br0rXL91LJsD8=;
        b=Xlc/uNhWV6kCs0E5ny/Y/QSKdifMD87EHP9dOBuLeTzog2qGLRdSadxw6aVs5NXI9W
         xwFMv4jp4k8pmJqoElpu+9C+Z9CZB8sqYhXIa4EUF50/5ukn/z842nPVGu/Z0Ir4X1BQ
         yiyJLpuHgrs6PXRXeDzeUwlAbJlTfR8cRjXEg+HwK8exNeoT3Y0eU4RTavY7tt1rHlmV
         22vU0WQBfKM6onmbArnJtdO8Q+hlHGYBx+JwAgKv7AueCeU58nCsiQ0Yp5MrGlF+shoE
         0AOI9BgStOU364RyEGY0oKlu9++5wMA2bv6Y159uQBAIicKzhxuAxq1vZlpp4EbqaU6D
         BwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WTxC9P0e187wMiz2N5iLPT4giNu311br0rXL91LJsD8=;
        b=HX7vKfI2Owc0RgruhhHFZCneuj+uH1nOXDS6PZU085IR3ETcOPmyA91dFZEdtfP5Sz
         O0fnhw01mstpRyTY5SCwuAf4EYZmWYWR3lqBaE1IahrUpGntIQITPWKKjJXYddZ8CmPM
         obyWkSC+i5b4xzSV+cdr3PoXGNYVI0lbFmOEQ5h7SjcIr+FQuIlBaT8HSdSKzoHNXCz9
         CphJiVKk6SeZDLN8eD9M3qQ7yWXl/Iwgt7vnMz9C2xFWXrL8rWSeH4ghYQyDQzgHhav6
         NPePt3un3YYQ6IjDQZ1O8eP9VJhjIqr0FGIG7GHPgD/1H4Fv9dWU/1m5n/rq/3km2IUE
         yTig==
X-Gm-Message-State: AOUpUlHm8AylxROTvhF4lT6v8z0EKiBSp9clkh8Tt4GSS5k0tnMc0bG2
        gzY2Yz/d4rnAzJTZWlwiF3U+SBdD
X-Google-Smtp-Source: AA+uWPx9I3ElRIYpjIb30RAssQGE75vE4rVnQvfB4t3/+MaBH8Ck5xupv4pkeV0Y2Uhrtg7O8hTfag==
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr46823762edc.64.1534607758003;
        Sat, 18 Aug 2018 08:55:58 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/19] iommu/tegra: gart: Don't detach devices from inactive domains
Date:   Sat, 18 Aug 2018 18:54:28 +0300
Message-Id: <20180818155430.5586-18-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be unlimited number of allocated domains, but only one domain
can be active at a time. Hence devices must be detached only from the
active domain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 284cddf90888..306e9644a676 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -167,7 +167,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	struct gart_client *client, *c;
 	int err = 0;
 
@@ -192,6 +192,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 		goto fail;
 	}
 	gart->active_domain = domain;
+	gart_domain->gart = gart;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
@@ -214,8 +215,10 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			kfree(c);
-			if (list_empty(&gart->client))
+			if (list_empty(&gart->client)) {
 				gart->active_domain = NULL;
+				gart_domain->gart = NULL;
+			}
 			dev_dbg(gart->dev, "GART: Detached %s\n",
 				dev_name(dev));
 			return;
@@ -253,7 +256,6 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 	if (!gart_domain)
 		return NULL;
 
-	gart_domain->gart = gart;
 	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
 	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-- 
2.18.0

