Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF1920C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF1920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIMSnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeIMSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:17 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2C33CCF3;
        Thu, 13 Sep 2018 13:33:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>
Subject: [PATCH 4.4 49/60] ovl: rename is_merge to is_lowest
Date:   Thu, 13 Sep 2018 15:30:56 +0200
Message-Id: <20180913131747.757405365@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 56656e960b555cb98bc414382566dcb59aae99a2 upstream.

The 'is_merge' is an historical naming from when only a single lower layer
could exist.  With the introduction of multiple lower layers the meaning of
this flag was changed to mean only the "lowest layer" (while all lower
layers were being merged).

So now 'is_merge' is inaccurate and hence renaming to 'is_lowest'

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -36,7 +36,7 @@ struct ovl_dir_cache {
 
 struct ovl_readdir_data {
 	struct dir_context ctx;
-	bool is_merge;
+	bool is_lowest;
 	struct rb_root root;
 	struct list_head *list;
 	struct list_head middle;
@@ -140,9 +140,9 @@ static int ovl_cache_entry_add_rb(struct
 	return 0;
 }
 
-static int ovl_fill_lower(struct ovl_readdir_data *rdd,
-			  const char *name, int namelen,
-			  loff_t offset, u64 ino, unsigned int d_type)
+static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
+			   const char *name, int namelen,
+			   loff_t offset, u64 ino, unsigned int d_type)
 {
 	struct ovl_cache_entry *p;
 
@@ -194,10 +194,10 @@ static int ovl_fill_merge(struct dir_con
 		container_of(ctx, struct ovl_readdir_data, ctx);
 
 	rdd->count++;
-	if (!rdd->is_merge)
+	if (!rdd->is_lowest)
 		return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_type);
 	else
-		return ovl_fill_lower(rdd, name, namelen, offset, ino, d_type);
+		return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
 }
 
 static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
@@ -290,7 +290,7 @@ static int ovl_dir_read_merged(struct de
 		.ctx.actor = ovl_fill_merge,
 		.list = list,
 		.root = RB_ROOT,
-		.is_merge = false,
+		.is_lowest = false,
 	};
 	int idx, next;
 
@@ -307,7 +307,7 @@ static int ovl_dir_read_merged(struct de
 			 * allows offsets to be reasonably constant
 			 */
 			list_add(&rdd.middle, rdd.list);
-			rdd.is_merge = true;
+			rdd.is_lowest = true;
 			err = ovl_dir_read(&realpath, &rdd);
 			list_del(&rdd.middle);
 		}


