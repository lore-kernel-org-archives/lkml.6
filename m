Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966ED20875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/i337MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966ED20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeFUBaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:30:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43023 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754101AbeFUBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:30:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id c41-v6so717586plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JUNWyT1fHJMPNX/hy198vkCapR8JExiNDwqcfSvq+28=;
        b=k/i337MGQfh1S4b7+9PEpHjIFVFB/+rtsr5097CzkvsItC4DgaIy4+ejD9mfL7tYLp
         v+F9fMRhUjLHyApITjmkNBupc6k+rZJSabouF6Jc4KPhtMWVLT9iR/jy8EX49VOoAiwQ
         lwKHSAOG8uirpBANvA6EXJjoHuVEfXnnXeTMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JUNWyT1fHJMPNX/hy198vkCapR8JExiNDwqcfSvq+28=;
        b=m5RcgefSrweF3OuFFMULLGJ7gHfqKT9FYkLU/8jJiFZQUAf474c5RQZSEYKJklblMJ
         uzn5hSobMIiJqeBsUOFJziYtHYwCcyide6VgEAkxalk4VY46bl/RekVnnaC6nchPra1k
         zNN6jghx1eKyev7UsV1HNpNnmfjJM+SnvLJOjNCYJknCl7FZb3m5s7nUXtvhUCwEw9/e
         hn5j42/fJokNz4WwrMeJHNjRUpDye0IdF4b+I/5gZlqfVZHMu2GXfVb1lbln8AUDqLN4
         0f486ypo2nUs0lC/0qA+LqTdAnKWYTliDYUYzFIU4CWRVMCTukHyS9AYKf8OYNFTMrwy
         UbQw==
X-Gm-Message-State: APt69E0b4oZ6XgiwGVOLRg/DkG1S4MMOVYlIsPfrupu6Dw9qpXqW8C3s
        fULftgw/bOO+ViOp72flmqtb4g==
X-Google-Smtp-Source: ADUXVKIZP6T5stDWfzfamsNbarz6E66sR64DqJR4x8sXNlLwgpTnVEIJx2IJvNXGnRoVwDcm9j4SLQ==
X-Received: by 2002:a17:902:5501:: with SMTP id f1-v6mr26097329pli.108.1529544601916;
        Wed, 20 Jun 2018 18:30:01 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id f11-v6sm4073918pgq.18.2018.06.20.18.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:30:00 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: [PATCH] cfg80211: use IDA to allocate wiphy indeces
Date:   Wed, 20 Jun 2018 18:29:45 -0700
Message-Id: <20180621012945.185705-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's annoying to see the phy index increase arbitrarily, just because a
device got removed and re-probed (e.g., during a device reset, or due to
probe testing). We can use the in-kernel index allocator for this,
instead of just an increasing counter.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 net/wireless/core.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index c0fd8a85e7f7..80c108c3ca38 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/idr.h>
 #include <linux/if.h>
 #include <linux/module.h>
 #include <linux/err.h>
@@ -380,11 +381,11 @@ static void cfg80211_propagate_cac_done_wk(struct work_struct *work)
 
 /* exported functions */
 
+static DEFINE_IDA(wiphy_ida);
+
 struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 			   const char *requested_name)
 {
-	static atomic_t wiphy_counter = ATOMIC_INIT(0);
-
 	struct cfg80211_registered_device *rdev;
 	int alloc_size;
 
@@ -413,18 +414,12 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 
 	rdev->ops = ops;
 
-	rdev->wiphy_idx = atomic_inc_return(&wiphy_counter);
-
+	rdev->wiphy_idx = ida_simple_get(&wiphy_ida, 0, 0, GFP_KERNEL);
 	if (unlikely(rdev->wiphy_idx < 0)) {
-		/* ugh, wrapped! */
-		atomic_dec(&wiphy_counter);
 		kfree(rdev);
 		return NULL;
 	}
 
-	/* atomic_inc_return makes it start at 1, make it start at 0 */
-	rdev->wiphy_idx--;
-
 	/* give it a proper name */
 	if (requested_name && requested_name[0]) {
 		int rv;
@@ -452,10 +447,8 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		 * value, and use a different name if this one exists?
 		 */
 		rv = dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
-		if (rv < 0) {
-			kfree(rdev);
-			return NULL;
-		}
+		if (rv < 0)
+			goto err;
 	}
 
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
@@ -497,10 +490,8 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 				   &rdev->wiphy.dev, RFKILL_TYPE_WLAN,
 				   &rdev->rfkill_ops, rdev);
 
-	if (!rdev->rfkill) {
-		kfree(rdev);
-		return NULL;
-	}
+	if (!rdev->rfkill)
+		goto err;
 
 	INIT_WORK(&rdev->rfkill_sync, cfg80211_rfkill_sync_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
@@ -525,6 +516,11 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	rdev->wiphy.max_sched_scan_plan_interval = U32_MAX;
 
 	return &rdev->wiphy;
+
+err:
+	ida_simple_remove(&wiphy_ida, rdev->wiphy_idx);
+	kfree(rdev);
+	return NULL;
 }
 EXPORT_SYMBOL(wiphy_new_nm);
 
@@ -972,6 +968,7 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	}
 	list_for_each_entry_safe(scan, tmp, &rdev->bss_list, list)
 		cfg80211_put_bss(&rdev->wiphy, &scan->pub);
+	ida_simple_remove(&wiphy_ida, rdev->wiphy_idx);
 	kfree(rdev);
 }
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

