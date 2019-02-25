Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D165C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F5F2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfBYMoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:44:17 -0500
Received: from 61-228-43-219.dynamic-ip.hinet.net ([61.228.43.219]:38866 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbfBYMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:44:17 -0500
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id A5055C10A9;
        Mon, 25 Feb 2019 17:45:23 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     harry.pan@intel.com, gs0622@gmail.com, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org
Subject: [PATCH v7 2/2] PM / sleep: measure the time of filesystems syncing
Date:   Mon, 25 Feb 2019 17:44:23 +0800
Message-Id: <20190225094422.5492-2-harry.pan@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190225094422.5492-1-harry.pan@intel.com>
References: <20190224061753.17638-2-harry.pan@intel.com>
 <20190225094422.5492-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives the reader an intuitive metric of the time cost by
the kernel issuing filesystems sync during system sleep; although
developer can guess by the timestamp of next log or enable the ftrace
power event for manual calculation, this manner is easier to read and
benefits the automation script.

v1 to v5: context discussion
v6: split patches logically in code refactor and sync profile
v7: improve 32/64 bit machine compatibility

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 kernel/power/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a8a8e6ec57e6..eea3d65eb960 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -54,9 +54,15 @@ EXPORT_SYMBOL_GPL(unlock_system_sleep);
 
 void ksys_sync_helper(void)
 {
-	pr_info("Syncing filesystems ... ");
+	ktime_t start;
+	long elapsed_msecs;
+
+	start = ktime_get();
 	ksys_sync();
-	pr_cont("done.\n");
+	elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
+	pr_info("Filesystems sync: %ld.%03ld seconds\n",
+		elapsed_msecs / MSEC_PER_SEC,
+		elapsed_msecs % MSEC_PER_SEC);
 }
 EXPORT_SYMBOL_GPL(ksys_sync_helper);
 
-- 
2.18.1

