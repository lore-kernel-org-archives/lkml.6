Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83D5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B148216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iFJQOELx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B148216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeHOJ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:56:47 -0400
Received: from m12-14.163.com ([220.181.12.14]:50242 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeHOJ4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:56:47 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2018 05:56:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=4WdXGaIAcKbqSvdCSp
        wsEod+t9aYchU273VXKEGxzDA=; b=iFJQOELxdtIjzSr7Z5eB0gG/zsj9mWLtP4
        xUGEJhxvzPv/wVnQ9vwCgA/wMagWdvcZoKygGQav8FI5XKdfU73+NHL86YqqWXlq
        cKNpHQtrvtnzZig/sr8FT+uWLhUMZJZ/uyFZhxhE6N4bGtIVMFVIWNaL4wT5HOcF
        8FX3KN1dg=
Received: from localhost.localdomain (unknown [117.136.38.140])
        by smtp10 (Coremail) with SMTP id DsCowAB3vR4szXNbWT8QNQ--.62402S4;
        Wed, 15 Aug 2018 14:50:21 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH 2/2] fix potential memory leak in function "register_bcache"
Date:   Wed, 15 Aug 2018 14:50:06 +0800
Message-Id: <20180815065006.19856-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowAB3vR4szXNbWT8QNQ--.62402S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar45Cw43Kw1DCw1kAF4UXFb_yoW8Gw1Upa
        97C3y3trW8XwsrurWUJa1kua4Sga93tFZ5u3y2yw1Fv34jgw10yFW5JFy8ZFWxZFyrCw42
        qF4DJay7Za95Cr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6yIbUUUUU=
X-Originating-IP: [117.136.38.140]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiow2j3FUMG+Ql+wAAsp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if register_cache get error, memory pointed by ca should be released.
and also, blkdev_put should be called I think.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f98352d4..14c31e03 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2159,6 +2159,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	struct cache_sb *sb = NULL;
 	struct block_device *bdev = NULL;
 	struct page *sb_page = NULL;
+	struct cache *ca = NULL;
 
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
@@ -2206,12 +2207,12 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		register_bdev(sb, sb_page, bdev, dc);
 		mutex_unlock(&bch_register_lock);
 	} else {
-		struct cache *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
+		ca = kzalloc(sizeof(struct cache), GFP_KERNEL);
 		if (!ca)
 			goto err_close;
 
 		if (register_cache(sb, sb_page, bdev, ca) != 0)
-			goto err;
+			goto err_register;
 	}
 out:
 	if (sb_page)
@@ -2221,6 +2222,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	module_put(THIS_MODULE);
 	return ret;
 
+err_register:
+	kfree(ca);
 err_close:
 	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 err:
-- 
2.17.1


