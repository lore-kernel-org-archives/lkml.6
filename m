Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8C0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DE621479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DE621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeGLLLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:22 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58342 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeGLLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 6905418188FA2;
        Thu, 12 Jul 2018 13:02:18 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/5] ubifs: Turn two ubifs_assert() into a WARN_ON()
Date:   Thu, 12 Jul 2018 13:01:56 +0200
Message-Id: <20180712110200.13054-2-richard@nod.at>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110200.13054-1-richard@nod.at>
References: <20180712110200.13054-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to pass struct ubifs_info to ubifs_assert()
but while unloading the UBIFS module we don't have the info
struct anymore.
Therefore replace the asserts by a regular WARN_ON().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index c5466c70d620..90ebfcc8a8ea 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2304,8 +2304,8 @@ late_initcall(ubifs_init);
 
 static void __exit ubifs_exit(void)
 {
-	ubifs_assert(list_empty(&ubifs_infos));
-	ubifs_assert(atomic_long_read(&ubifs_clean_zn_cnt) == 0);
+	WARN_ON(list_empty(&ubifs_infos));
+	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) == 0);
 
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
-- 
2.18.0

