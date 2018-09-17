Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F22ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DA32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="m/uMubdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DA32147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeIRBkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45098 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeIRBkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id g44-v6so16514691qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WJ51dxv+psxts3n9n4dYDWv3yfTVCNwV6wMKD8V5fQ=;
        b=m/uMubdN9BtDBk+z0RtbpNiFb8tugeVSAT0nwMqdO63e4MIIJ7TKcnNtB8Q1eoYnum
         OZXrzwSK2jWcF8dn9vCdoeOpt7ynalictJ6zbNkO1bdXYZ2FB5OfRJ9f7uvgl650M+n1
         sh7MKt9P8HlANnA0t+c2mZKHIgeb8mWb1ODd8XSzjnyUlAUF1VRJ015ZQQVD5tiVM7C4
         3ENC5u0bmOFnjefc6zFYYY/Cfa+sQIECFdAugYTe2mA3NJJerPmBpqY5GKltB78taAen
         xigLuCwEdit/43rEr5dGB77vFquPYAioguHpfD4Cytozd3krYdjQ0knIluuqlGLyOawt
         dkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WJ51dxv+psxts3n9n4dYDWv3yfTVCNwV6wMKD8V5fQ=;
        b=X/XWjGk0rQM2XtGFyvjhm9EYwj/saIpbCbrejMsrVabPE3jV071oGxwvicpM4KvlHE
         fLMj2QqYfnT4tHxotTmeuv1poJxVFQQ8UdGRAO8DUjBiD6k51dZlStZOYHig/7kEnFed
         kkbs060AOCTEEX7zaT/oOk+rxqHKKAOEHxKKYfig2vi7FOc8iSX5OmuRkswPqJj2S+NY
         ZVRSECj00GW/63GhP4FEdvAmWDYr1XXDSdYBSZmI5HoJ9xMy14ZQwGApO84P2X7ThcmF
         O4qLC8UU2v1Ehqwp5FfunrhFOS7SMtho/ViwQ+GUC4YqzZ0Sd/RDfLG1OGmlUNZTExX+
         QEeA==
X-Gm-Message-State: APzg51BqcXjTIT8XUMrchiIwv7jzVHnGChgvmNTafteHSm64KnAYOiwy
        6f0xMOP4FSIR8kNWFfNVbSbFCFkr7e2jF/f7
X-Google-Smtp-Source: ANB0VdbmlvWeh8euUC6/Pu3kIK1DrqPm6L8A6ISpBksR7B/QpxyUdxvNn4cUE1mdsIaIap+Sfpt0mQ==
X-Received: by 2002:ac8:156:: with SMTP id f22-v6mr18593162qtg.186.1537215078256;
        Mon, 17 Sep 2018 13:11:18 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:17 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 07/17] orangefs: let setattr write to cached inode
Date:   Mon, 17 Sep 2018 20:10:44 +0000
Message-Id: <20180917201054.3530-8-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fairly big change, but ultimately it's not a lot of code.

Implement write_inode and then avoid the call to orangefs_inode_setattr
within orangefs_setattr.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 11 +++--------
 fs/orangefs/super.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index ec3996a61f92..b16b11294573 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -207,8 +207,8 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
  */
 int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 {
-	int ret = -EINVAL;
 	struct inode *inode = dentry->d_inode;
+	int ret;
 
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		"%s: called on %pd\n",
@@ -228,16 +228,11 @@ int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 	setattr_copy(inode, iattr);
 	mark_inode_dirty(inode);
 
-	ret = orangefs_inode_setattr(inode, iattr);
-	gossip_debug(GOSSIP_INODE_DEBUG,
-		"%s: orangefs_inode_setattr returned %d\n",
-		__func__,
-		ret);
-
-	if (!ret && (iattr->ia_valid & ATTR_MODE))
+	if (iattr->ia_valid & ATTR_MODE)
 		/* change mod on a file that has ACLs */
 		ret = posix_acl_chmod(inode, inode->i_mode);
 
+	ret = 0;
 out:
 	gossip_debug(GOSSIP_INODE_DEBUG, "%s: ret:%d:\n", __func__, ret);
 	return ret;
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 61bec955b285..788869c8233b 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -151,6 +151,21 @@ static void orangefs_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, orangefs_i_callback);
 }
 
+int orangefs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	struct iattr iattr;
+	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
+	iattr.ia_valid = ATTR_MODE | ATTR_UID | ATTR_GID | ATTR_ATIME |
+	    ATTR_ATIME_SET | ATTR_MTIME | ATTR_MTIME_SET | ATTR_CTIME;
+	iattr.ia_mode = inode->i_mode;
+	iattr.ia_uid = inode->i_uid;
+	iattr.ia_gid = inode->i_gid;
+	iattr.ia_atime = inode->i_atime;
+	iattr.ia_mtime = inode->i_mtime;
+	iattr.ia_ctime = inode->i_ctime;
+	return orangefs_inode_setattr(inode, &iattr);
+}
+
 /*
  * NOTE: information filled in here is typically reflected in the
  * output of the system command 'df'
@@ -309,6 +324,7 @@ void fsid_key_table_finalize(void)
 static const struct super_operations orangefs_s_ops = {
 	.alloc_inode = orangefs_alloc_inode,
 	.destroy_inode = orangefs_destroy_inode,
+	.write_inode = orangefs_write_inode,
 	.drop_inode = generic_delete_inode,
 	.statfs = orangefs_statfs,
 	.remount_fs = orangefs_remount_fs,
-- 
2.19.0

