Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85CD2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759960;
	bh=cdIIifEO+9raOtT9CNvK3FIRD1gmv49v+ejjD0dpW0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIlctJhrOLGMxEU07m2iI6z1owTxXWWSUOGuZQUU82uqW6yeq59fva8oA5aXZiSfv
	 KGlzbAiN2+Jtn3Jy4pfPfUNAuPJBXkfzu3ZQ8jl16jUd1Jzz8kfLeeKcJ7qV6UXxVI
	 DOah5KDsLKQzQUjh2WHsvcKkIYVvXHXx2BUen+4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfBUOjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbfBUOjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9794620838;
        Thu, 21 Feb 2019 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759954;
        bh=cdIIifEO+9raOtT9CNvK3FIRD1gmv49v+ejjD0dpW0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pj/m6xZkg1W1+dAjzxAUMiZVpZ4WkSGWbYSpFFvXvQxK5V43CMQ0R/6+jMNJA6kD9
         aCLd4KYD0fOJ6f6hITy5GP9X99il/4XeuomLevJM+OAn3EkT0OYM9CySS/HDIf2v4Q
         0ueiO2MXSSnK917UvmXDzSyuA5GMJ6FxN4TMOrqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Sterba <dsterba@suse.cz>,
        Adam Borowski <kilobyte@angband.pl>,
        Qu Wenruo <quwenruo@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 17/20] btrfs: Remove false alert when fiemap range is smaller than on-disk extent
Date:   Thu, 21 Feb 2019 15:35:55 +0100
Message-Id: <20190221125244.027806070@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125242.153179182@linuxfoundation.org>
References: <20190221125242.153179182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <quwenruo@cn.fujitsu.com>

commit 848c23b78fafdcd3270b06a30737f8dbd70c347f upstream.

Commit 4751832da990 ("btrfs: fiemap: Cache and merge fiemap extent before
submit it to user") introduced a warning to catch unemitted cached
fiemap extent.

However such warning doesn't take the following case into consideration:

0			4K			8K
|<---- fiemap range --->|
|<----------- On-disk extent ------------------>|

In this case, the whole 0~8K is cached, and since it's larger than
fiemap range, it break the fiemap extent emit loop.
This leaves the fiemap extent cached but not emitted, and caught by the
final fiemap extent sanity check, causing kernel warning.

This patch removes the kernel warning and renames the sanity check to
emit_last_fiemap_cache() since it's possible and valid to have cached
fiemap extent.

Reported-by: David Sterba <dsterba@suse.cz>
Reported-by: Adam Borowski <kilobyte@angband.pl>
Fixes: 4751832da990 ("btrfs: fiemap: Cache and merge fiemap extent ...")
Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent_io.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4463,29 +4463,25 @@ try_submit_last:
 }
 
 /*
- * Sanity check for fiemap cache
+ * Emit last fiemap cache
  *
- * All fiemap cache should be submitted by emit_fiemap_extent()
- * Iteration should be terminated either by last fiemap extent or
- * fieinfo->fi_extents_max.
- * So no cached fiemap should exist.
+ * The last fiemap cache may still be cached in the following case:
+ * 0		      4k		    8k
+ * |<- Fiemap range ->|
+ * |<------------  First extent ----------->|
+ *
+ * In this case, the first extent range will be cached but not emitted.
+ * So we must emit it before ending extent_fiemap().
  */
-static int check_fiemap_cache(struct btrfs_fs_info *fs_info,
-			       struct fiemap_extent_info *fieinfo,
-			       struct fiemap_cache *cache)
+static int emit_last_fiemap_cache(struct btrfs_fs_info *fs_info,
+				  struct fiemap_extent_info *fieinfo,
+				  struct fiemap_cache *cache)
 {
 	int ret;
 
 	if (!cache->cached)
 		return 0;
 
-	/* Small and recoverbale problem, only to info developer */
-#ifdef CONFIG_BTRFS_DEBUG
-	WARN_ON(1);
-#endif
-	btrfs_warn(fs_info,
-		   "unhandled fiemap cache detected: offset=%llu phys=%llu len=%llu flags=0x%x",
-		   cache->offset, cache->phys, cache->len, cache->flags);
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
 				      cache->len, cache->flags);
 	cache->cached = false;
@@ -4701,7 +4697,7 @@ int extent_fiemap(struct inode *inode, s
 	}
 out_free:
 	if (!ret)
-		ret = check_fiemap_cache(root->fs_info, fieinfo, &cache);
+		ret = emit_last_fiemap_cache(root->fs_info, fieinfo, &cache);
 	free_extent_map(em);
 out:
 	btrfs_free_path(path);


