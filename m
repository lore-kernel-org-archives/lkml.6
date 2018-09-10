Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E50C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33DB20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXSLJXlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33DB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIJLQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:16:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41207 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:16:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so9230560plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3MmFh5VYNhBbWAgBarErsEIFlbjZvJPeEdHR7yalks8=;
        b=jXSLJXlot2IR2g7En6xCzJouoS5MAIcvPjxxGHeNhNdxkewv0TeRiuJkK58S6mGHdv
         CnEfwzqUoPNVTh6snNhv1eUfc7WMDg5fcA1NH+x0binvxbJJ1r+RUGWH1+aoWblULpmM
         HO6sAjz+7dz1Cd1PKEaFKE0PU+ztrm4eWWF/nOQxa49FVsPEIqXGvr70HVep1A5NcOBx
         MZrAftjohhWoxPtwHpYzOnLY61y6huNIPdULZf/3WfDJs1s6A2+wzXxBsC2GwrmPU3KM
         lepmp6NQcphykNAK4Bo/dDmOTkiray0cV8rf879Q73zdoTFSipVcmsZpWTGXXLf786NB
         lXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3MmFh5VYNhBbWAgBarErsEIFlbjZvJPeEdHR7yalks8=;
        b=QtKNBnGYsxexorRtlHt+zwh8I9bXZJohg3PglWeKrC+Rp2VUmkQABMgxNIwJ7ObsUs
         SvghZ45nYcSwGtk5pScQId5GtW6rWomQnwBRQVMiB7u1oO4vJnOanMJZWbW9nCb5k/eB
         kxdpbxXe8yMxZ0HjZWTHdLvREIxGQfGu1E6NSoOb7B9vV+tGRNDzWaJzzQF8nIk4Pjt5
         qNXpn/iwhmMVDHfal41rjD4qeAw8eSePiBwq1x92k4/OZkIovhV7qP4wnASywJbKaVIW
         eqBnzaUCaaAY2MyoVJRiajqCRcENAxuyaVKfVTzHirwUs5rXrbYuipMbZm8DktxpCEsh
         kBrw==
X-Gm-Message-State: APzg51CMrD51jbtXj+7By9/RtPwiaQpDd6Gi8R+hMsUy2t2v0NdKdnBg
        ewwtRX6ynnm7MPeKp/hhqcBFmtU9
X-Google-Smtp-Source: ANB0VdYwY1BEVzHUSZwG2PauzFQWzUu+hfuHu+/oMhmB2V8nB8hDeIBDfWFERedxly7NycDgbhFr5w==
X-Received: by 2002:a17:902:b089:: with SMTP id p9-v6mr20108057plr.254.1536560650554;
        Sun, 09 Sep 2018 23:24:10 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.186])
        by smtp.gmail.com with ESMTPSA id e190-v6sm29884955pfc.81.2018.09.09.23.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 23:24:10 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH 3/3] libnvdimm, region_devs: reset related seeds when fail to create namespace
Date:   Mon, 10 Sep 2018 02:21:48 -0400
Message-Id: <1536560508-24564-4-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
References: <1536560508-24564-1-git-send-email-oceanhehy@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

During runtime, namespace creation may fail if blocked by
commit 15d36fecd0bdc7510b70 ("mm: disallow mappings that conflict for
devm_memremap_pages()"). To ensure pfn_seed/dax_seed and namespace_seed
are ready for next namespace creation, here to do detach and reset.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/nvdimm/region_devs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index fa37afc..4c46fb6 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -703,7 +703,27 @@ void nd_mapping_free_labels(struct nd_mapping *nd_mapping)
 		kfree(label_ent);
 	}
 }
+/*
+ * To ensure pfn_seed/dax_seed and namespace_seed are ready for
+ * next namespace creation, here to do detach and reset.
+ */
+void nd_region_detach_and_reset(struct device *dev,
+		struct nd_region *nd_region)
+{
+	/* Only nd_pmem has been verified, fix me for other dev type. */
+	if (!is_nd_pmem(&nd_region->dev))
+		return;
 
+	if (is_nd_pfn(dev) || is_nd_dax(dev)) {
+		struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
+		struct nd_namespace_common *ndns = to_ndns(nd_region->ns_seed);
+
+		if (nd_pfn->ndns == ndns && ndns->claim == dev) {
+			nd_detach_and_reset(dev, &nd_pfn->ndns);
+			nd_region_reset_ns_seed(nd_region);
+			}
+	}
+}
 /*
  * Upon successful probe/remove, take/release a reference on the
  * associated interleave set (if present), and plant new btt + namespace
@@ -774,6 +794,20 @@ static void nd_region_notify_driver_action(struct nvdimm_bus *nvdimm_bus,
 			nd_region_create_ns_seed(nd_region);
 		nvdimm_bus_unlock(dev);
 	}
+	if (is_nd_pfn(dev) && !probe) {
+		nd_region = to_nd_region(dev->parent);
+		nvdimm_bus_lock(dev);
+		if (nd_region->pfn_seed == dev)
+			nd_region_detach_and_reset(dev, nd_region);
+		nvdimm_bus_unlock(dev);
+	}
+	if (is_nd_dax(dev) && !probe) {
+		nd_region = to_nd_region(dev->parent);
+		nvdimm_bus_lock(dev);
+		if (nd_region->dax_seed == dev)
+			nd_region_detach_and_reset(dev, nd_region);
+		nvdimm_bus_unlock(dev);
+	}
 }
 
 void nd_region_probe_success(struct nvdimm_bus *nvdimm_bus, struct device *dev)
-- 
1.8.3.1

