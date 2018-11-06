Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B63C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871C42085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871C42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbeKFTI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:08:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:59958 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFTI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:08:28 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gJxtz-00037m-KI; Tue, 06 Nov 2018 12:44:03 +0300
Subject: [PATCH 5/6] fuse: Protect fuse_inode::nlookup with fuse_inode::lock
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 12:44:03 +0300
Message-ID: <154149744356.18189.13444618369955494886.stgit@localhost.localdomain>
In-Reply-To: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This continues previous patch and introduces the same
protection for nlookup field. It goes as separate patch
since it's separate logic change (sadly, but it looks
impossible to split previous patch more then in this way).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dir.c     |    4 ++--
 fs/fuse/inode.c   |    4 ++--
 fs/fuse/readdir.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 35f3b3d1e044..ac8519285327 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -222,9 +222,9 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 				fuse_queue_forget(fc, forget, outarg.nodeid, 1);
 				goto invalid;
 			}
-			spin_lock(&fc->lock);
+			spin_lock(&fi->lock);
 			fi->nlookup++;
-			spin_unlock(&fc->lock);
+			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
 		if (ret == -ENOMEM)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5f488b019cd9..b8092d49a4b2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -327,9 +327,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	}
 
 	fi = get_fuse_inode(inode);
-	spin_lock(&fc->lock);
+	spin_lock(&fi->lock);
 	fi->nlookup++;
-	spin_unlock(&fc->lock);
+	spin_unlock(&fi->lock);
 	fuse_change_attributes(inode, attr, attr_valid, attr_version);
 
 	return inode;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index ab18b78f4755..574d03f8a573 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -213,9 +213,9 @@ static int fuse_direntplus_link(struct file *file,
 		}
 
 		fi = get_fuse_inode(inode);
-		spin_lock(&fc->lock);
+		spin_lock(&fi->lock);
 		fi->nlookup++;
-		spin_unlock(&fc->lock);
+		spin_unlock(&fi->lock);
 
 		forget_all_cached_acls(inode);
 		fuse_change_attributes(inode, &o->attr,

