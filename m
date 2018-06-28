Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FACCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185412741D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185412741D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965872AbeF1NRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:17:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965245AbeF1NRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:17:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fYWnE-00034Y-5l; Thu, 28 Jun 2018 13:17:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: make several functions and variables static (and some const)
Date:   Thu, 28 Jun 2018 14:16:59 +0100
Message-Id: <20180628131659.12133-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a variety of functions and variables that are local to the
source and do not need to be in global scope, so make them static. Also
make a couple of char arrays static const.

Cleans up sparse warnings:
symbol 'o2hb_heartbeat_mode_desc' was not declared. Should it be static?
symbol 'o2hb_heartbeat_mode' was not declared. Should it be static?
symbol 'o2hb_dependent_users' was not declared. Should it be static?
symbol 'o2hb_region_dec_user' was not declared. Should it be static?
symbol 'o2nm_fence_method_desc' was not declared. Should it be static?
symbol 'lockdep_keys' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/cluster/heartbeat.c   | 12 ++++++------
 fs/ocfs2/cluster/nodemanager.c |  6 +++---
 fs/ocfs2/dlmglue.c             |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index ea8c551bcd7e..9b2ed62dd638 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -127,13 +127,13 @@ enum o2hb_heartbeat_modes {
 	O2HB_HEARTBEAT_NUM_MODES,
 };
 
-char *o2hb_heartbeat_mode_desc[O2HB_HEARTBEAT_NUM_MODES] = {
-		"local",	/* O2HB_HEARTBEAT_LOCAL */
-		"global",	/* O2HB_HEARTBEAT_GLOBAL */
+static const char *o2hb_heartbeat_mode_desc[O2HB_HEARTBEAT_NUM_MODES] = {
+	"local",	/* O2HB_HEARTBEAT_LOCAL */
+	"global",	/* O2HB_HEARTBEAT_GLOBAL */
 };
 
 unsigned int o2hb_dead_threshold = O2HB_DEFAULT_DEAD_THRESHOLD;
-unsigned int o2hb_heartbeat_mode = O2HB_HEARTBEAT_LOCAL;
+static unsigned int o2hb_heartbeat_mode = O2HB_HEARTBEAT_LOCAL;
 
 /*
  * o2hb_dependent_users tracks the number of registered callbacks that depend
@@ -141,7 +141,7 @@ unsigned int o2hb_heartbeat_mode = O2HB_HEARTBEAT_LOCAL;
  * However only o2dlm depends on the heartbeat. It does not want the heartbeat
  * to stop while a dlm domain is still active.
  */
-unsigned int o2hb_dependent_users;
+static unsigned int o2hb_dependent_users;
 
 /*
  * In global heartbeat mode, all regions are pinned if there are one or more
@@ -2486,7 +2486,7 @@ static int o2hb_region_inc_user(const char *region_uuid)
 	return ret;
 }
 
-void o2hb_region_dec_user(const char *region_uuid)
+static void o2hb_region_dec_user(const char *region_uuid)
 {
 	spin_lock(&o2hb_live_lock);
 
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index da64c3a20eeb..0e4166cc23a0 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -35,9 +35,9 @@
  * cluster references throughout where nodes are looked up */
 struct o2nm_cluster *o2nm_single_cluster = NULL;
 
-char *o2nm_fence_method_desc[O2NM_FENCE_METHODS] = {
-		"reset",	/* O2NM_FENCE_RESET */
-		"panic",	/* O2NM_FENCE_PANIC */
+static const char *o2nm_fence_method_desc[O2NM_FENCE_METHODS] = {
+	"reset",	/* O2NM_FENCE_RESET */
+	"panic",	/* O2NM_FENCE_PANIC */
 };
 
 static inline void o2nm_lock_subsystem(void);
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 5502a5e8f0d9..97897211298a 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -96,7 +96,7 @@ struct ocfs2_unblock_ctl {
 };
 
 /* Lockdep class keys */
-struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
+static struct lock_class_key lockdep_keys[OCFS2_NUM_LOCK_TYPES];
 
 static int ocfs2_check_meta_downconvert(struct ocfs2_lock_res *lockres,
 					int new_level);
-- 
2.17.1

