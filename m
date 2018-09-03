Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A16C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7BD2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7BD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeICVhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeICVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9CF9D06;
        Mon,  3 Sep 2018 17:16:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 007/165] ext4: clear mmp sequence number when remounting read-only
Date:   Mon,  3 Sep 2018 18:54:53 +0200
Message-Id: <20180903165655.374039052@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 2dca60d98e241bea686004168f85208f215fc697 ]

Previously, when an MMP-protected file system is remounted read-only,
the kmmpd thread would exit the next time it woke up (a few seconds
later), without resetting the MMP sequence number back to
EXT4_MMP_SEQ_CLEAN.

Fix this by explicitly killing the MMP thread when the file system is
remounted read-only.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/mmp.c   |    7 ++-----
 fs/ext4/super.c |    2 ++
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -186,11 +186,8 @@ static int kmmpd(void *data)
 			goto exit_thread;
 		}
 
-		if (sb_rdonly(sb)) {
-			ext4_warning(sb, "kmmpd being stopped since filesystem "
-				     "has been remounted as readonly.");
-			goto exit_thread;
-		}
+		if (sb_rdonly(sb))
+			break;
 
 		diff = jiffies - last_update_time;
 		if (diff < mmp_update_interval * HZ)
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5163,6 +5163,8 @@ static int ext4_remount(struct super_blo
 
 			if (sbi->s_journal)
 				ext4_mark_recovery_complete(sb, es);
+			if (sbi->s_mmp_tsk)
+				kthread_stop(sbi->s_mmp_tsk);
 		} else {
 			/* Make sure we can mount this feature set readwrite */
 			if (ext4_has_feature_readonly(sb) ||


