Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC499C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAE2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277197;
	bh=jWTkczFzRkHZNoxvsKNCisK3ologc78G12c+118q85I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgoQVNuI/DWupw3vsHfgfzIlNwTB3JlkRJo1EMKNH3y+jGXUngYcORdgq8h69YzR3
	 qzqOM4NjGdHDvk3V7lbj4+352QJmXWRJ/QxnzvGYAXPIvWAwtmhvNImCTmEa9mmBDa
	 JMg0dELG6BVH1f7goY9r6xFx0X/rhaRBJyvNFZLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfBDKqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731438AbfBDKq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:46:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24FD217F9;
        Mon,  4 Feb 2019 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277187;
        bh=jWTkczFzRkHZNoxvsKNCisK3ologc78G12c+118q85I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRqTf6PIlGYUaiZ6dPWgVshLIvFjyv0sD/wyQDRpn4GYV0NmClR7mAjbD6Bqfn1s0
         L8B2jtx9btslB5bJVlCHgHHuzAPN4shZFAsCEctdlVAMDZzPtMOCx4GftU1He+iCPo
         F7EEi41jS+SONNfQqsW78g9mqg536/yZavID0Kmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-raid@vger.kernel.org,
        Shaohua Li <shli@kernel.org>,
        Alexei Naberezhnov <anaberezhnov@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4.14 43/46] md/raid5: fix out of memory during raid cache recovery
Date:   Mon,  4 Feb 2019 11:37:14 +0100
Message-Id: <20190204103616.284210828@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Naberezhnov <anaberezhnov@fb.com>

commit 483cbbeddd5fe2c80fd4141ff0748fa06c4ff146 upstream.

This fixes the case when md array assembly fails because of raid cache recovery
unable to allocate a stripe, despite attempts to replay stripes and increase
cache size. This happens because stripes released by r5c_recovery_replay_stripes
and raid5_set_cache_size don't become available for allocation immediately.
Released stripes first are placed on conf->released_stripes list and require
md thread to merge them on conf->inactive_list before they can be allocated.

Patch allows final allocation attempt during cache recovery to wait for
new stripes to become availabe for allocation.

Cc: linux-raid@vger.kernel.org
Cc: Shaohua Li <shli@kernel.org>
Cc: linux-stable <stable@vger.kernel.org> # 4.10+
Fixes: b4c625c67362 ("md/r5cache: r5cache recovery: part 1")
Signed-off-by: Alexei Naberezhnov <anaberezhnov@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid5-cache.c |   33 ++++++++++++++++++++++-----------
 drivers/md/raid5.c       |    8 ++++++--
 2 files changed, 28 insertions(+), 13 deletions(-)

--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1942,12 +1942,14 @@ out:
 }
 
 static struct stripe_head *
-r5c_recovery_alloc_stripe(struct r5conf *conf,
-			  sector_t stripe_sect)
+r5c_recovery_alloc_stripe(
+		struct r5conf *conf,
+		sector_t stripe_sect,
+		int noblock)
 {
 	struct stripe_head *sh;
 
-	sh = raid5_get_active_stripe(conf, stripe_sect, 0, 1, 0);
+	sh = raid5_get_active_stripe(conf, stripe_sect, 0, noblock, 0);
 	if (!sh)
 		return NULL;  /* no more stripe available */
 
@@ -2157,7 +2159,7 @@ r5c_recovery_analyze_meta_block(struct r
 						stripe_sect);
 
 		if (!sh) {
-			sh = r5c_recovery_alloc_stripe(conf, stripe_sect);
+			sh = r5c_recovery_alloc_stripe(conf, stripe_sect, 1);
 			/*
 			 * cannot get stripe from raid5_get_active_stripe
 			 * try replay some stripes
@@ -2166,20 +2168,29 @@ r5c_recovery_analyze_meta_block(struct r
 				r5c_recovery_replay_stripes(
 					cached_stripe_list, ctx);
 				sh = r5c_recovery_alloc_stripe(
-					conf, stripe_sect);
+					conf, stripe_sect, 1);
 			}
 			if (!sh) {
+				int new_size = conf->min_nr_stripes * 2;
 				pr_debug("md/raid:%s: Increasing stripe cache size to %d to recovery data on journal.\n",
 					mdname(mddev),
-					conf->min_nr_stripes * 2);
-				raid5_set_cache_size(mddev,
-						     conf->min_nr_stripes * 2);
-				sh = r5c_recovery_alloc_stripe(conf,
-							       stripe_sect);
+					new_size);
+				ret = raid5_set_cache_size(mddev, new_size);
+				if (conf->min_nr_stripes <= new_size / 2) {
+					pr_err("md/raid:%s: Cannot increase cache size, ret=%d, new_size=%d, min_nr_stripes=%d, max_nr_stripes=%d\n",
+						mdname(mddev),
+						ret,
+						new_size,
+						conf->min_nr_stripes,
+						conf->max_nr_stripes);
+					return -ENOMEM;
+				}
+				sh = r5c_recovery_alloc_stripe(
+					conf, stripe_sect, 0);
 			}
 			if (!sh) {
 				pr_err("md/raid:%s: Cannot get enough stripes due to memory pressure. Recovery failed.\n",
-				       mdname(mddev));
+					mdname(mddev));
 				return -ENOMEM;
 			}
 			list_add_tail(&sh->lru, cached_stripe_list);
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6336,6 +6336,7 @@ raid5_show_stripe_cache_size(struct mdde
 int
 raid5_set_cache_size(struct mddev *mddev, int size)
 {
+	int result = 0;
 	struct r5conf *conf = mddev->private;
 
 	if (size <= 16 || size > 32768)
@@ -6352,11 +6353,14 @@ raid5_set_cache_size(struct mddev *mddev
 
 	mutex_lock(&conf->cache_size_mutex);
 	while (size > conf->max_nr_stripes)
-		if (!grow_one_stripe(conf, GFP_KERNEL))
+		if (!grow_one_stripe(conf, GFP_KERNEL)) {
+			conf->min_nr_stripes = conf->max_nr_stripes;
+			result = -ENOMEM;
 			break;
+		}
 	mutex_unlock(&conf->cache_size_mutex);
 
-	return 0;
+	return result;
 }
 EXPORT_SYMBOL(raid5_set_cache_size);
 


