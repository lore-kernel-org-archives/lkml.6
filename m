Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F901C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F372157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F372157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeHXQrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:47:16 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:53811 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHXQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:47:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 7DBB1184C7;
        Fri, 24 Aug 2018 15:12:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id k8ZXcun8HrAW; Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id CDEF5184D8;
        Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1C21A06D;
        Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61E871A06B;
        Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 554CF1E7F;
        Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 501B78016F; Fri, 24 Aug 2018 15:12:36 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] kmemleak: Always register debugfs file
Date:   Fri, 24 Aug 2018 15:12:20 +0200
Message-Id: <20180824131220.19176-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kmemleak built in to the kernel, but is disabled by default, the
debugfs file is never registered.  Because of this, it is not possible
to find out if the kernel is built with kmemleak support by checking for
the presence of this file.  To allow this, always register the file.

After this patch, if the file doesn't exist, kmemleak is not available
in the kernel.  If writing "scan" or any other value than "clear" to
this file results in EBUSY, then kmemleak is available but is disabled
by default and can be activated via the kernel command line.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 mm/kmemleak.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9a085d525bbc..17dd883198ae 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -2097,6 +2097,11 @@ static int __init kmemleak_late_init(void)
 
 	kmemleak_initialized = 1;
 
+	dentry = debugfs_create_file("kmemleak", 0644, NULL, NULL,
+				     &kmemleak_fops);
+	if (!dentry)
+		pr_warn("Failed to create the debugfs kmemleak file\n");
+
 	if (kmemleak_error) {
 		/*
 		 * Some error occurred and kmemleak was disabled. There is a
@@ -2108,10 +2113,6 @@ static int __init kmemleak_late_init(void)
 		return -ENOMEM;
 	}
 
-	dentry = debugfs_create_file("kmemleak", 0644, NULL, NULL,
-				     &kmemleak_fops);
-	if (!dentry)
-		pr_warn("Failed to create the debugfs kmemleak file\n");
 	mutex_lock(&scan_mutex);
 	start_scan_thread();
 	mutex_unlock(&scan_mutex);
-- 
2.11.0

