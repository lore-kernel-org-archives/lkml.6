Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6539724300
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6539724300
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFVNt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:49:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47729 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFVNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:49:56 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LoMri-1g88xP04dO-00gYqh; Fri, 22 Jun 2018 15:49:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>, Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] bcache: stop using the deprecated get_seconds()
Date:   Fri, 22 Jun 2018 15:48:41 +0200
Message-Id: <20180622134907.227131-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:qKhOH0K243mcpx0pn2Jcax64+iv10SCaE3QgJd5LJNsLXKeCmIL
 /73aDAtQkYVp2BQbR97V2OzFqYyFCTEeNR6F2a6A/iFzqUsr/1nwaa8KJEJkSH2uLYKQxJ/
 U63zJSHMwvM2BQvsOQ4ztxcnR5tRegyto01Rm94MTN2oiwC9OqdU5I5UN53mSbFi3LV7uh9
 FDj7QCF0PdK4B6LharT0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zls5a9OfCvE=:t9mjex/KHyCI3M6GnU67RU
 QfWi/kGGaPjD7upbfRNqc1V5T/WXoJ/FpH+306+UEwrH5oCJ2IBE/PSYcLBzwcyyESp2gZknW
 XxXjvRdrZHmixGKAIVsPHcG7kbNbVr74z9UcnyqJE5HDO8qzcxY4dqRgAILR76hsITz0ewLgE
 /+fgJNGy4/S7NbG3cYP0q4VzEr1yukPKeb7YXhcLeL/d/gXPoCT9am8kd8MoY/+1AoXGVk0Ol
 VoH+gE1rEgIrsSMAQcIyJAIZzEB+P/dWVV75cyyuB8WGUTRS3FJyvxL3Ht1NLeOnpEfAbaYEo
 BhrIrPF0ypyQ6peOm0dkkiugRKS+laCuhlASfiqQdeSmlcOdqu/kZ95xinrHLKNX28l5YvdEy
 iIQMmholUV64dKFZeJRoC7GfPwl6wAkMmpb5sjqcRA9WCFc8NChcYAW6kt1ERjMZBS7BzzTxt
 JXQ8/bUOHujwQYEbauku5LCi49XYlQLjnd6WOtbI/kX21huO1j335JQtRpnv3AhDjYfIJIqem
 tXOvboJmKFrkGsOa6l6ZUxelCodwNv5JSHBj3fHd+jfwEbl+SID3a8fBF+EGYMLHPuARqhZ0I
 qauBEyIGaiQwGHojPM0Y2bhee9ipQ9ZigQPSi2GBh0Ue7T2sM4rEqF2uTTrfPlu1/83DRXise
 yu9GeXwiGsYAvyCIkZiz95UeT6rBPCd5ikTyGwsRx9fvP8aM0TvtIKgSw6CAnb2Gxe6Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds function is deprecated now since it returns a 32-bit
value that will eventually overflow, and we are replacing it throughout
the kernel with ktime_get_seconds() or ktime_get_real_seconds() that
return a time64_t.

bcache uses get_seconds() to read the current system time and store it in
the superblock as well as in uuid_entry structures that are user visible.

Unfortunately, the two structures in are still limited to 32 bits, so this
won't fix any real problems but will still overflow in year 2106. Let's
at least document that properly, in case we get an updated format in the
future it can be fixed. We still have a long time before the overflow
and checking the tools at https://github.com/koverstreet/bcache-tools
reveals no access to any of them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/bcache/super.c   | 12 ++++++------
 include/uapi/linux/bcache.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index fa4058e43202..74746d8ee05e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -181,7 +181,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		goto err;
 	}
 
-	sb->last_mount = get_seconds();
+	sb->last_mount = (u32)ktime_get_real_seconds();
 	err = NULL;
 
 	get_page(bh->b_page);
@@ -701,7 +701,7 @@ static void bcache_device_detach(struct bcache_device *d)
 
 		SET_UUID_FLASH_ONLY(u, 0);
 		memcpy(u->uuid, invalid_uuid, 16);
-		u->invalidated = cpu_to_le32(get_seconds());
+		u->invalidated = cpu_to_le32((u32)ktime_get_real_seconds());
 		bch_uuid_write(d->c);
 	}
 
@@ -1027,7 +1027,7 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 			  uint8_t *set_uuid)
 {
-	uint32_t rtime = cpu_to_le32(get_seconds());
+	uint32_t rtime = cpu_to_le32((u32)ktime_get_real_seconds());
 	struct uuid_entry *u;
 	struct cached_dev *exist_dc, *t;
 
@@ -1070,7 +1070,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 	    (BDEV_STATE(&dc->sb) == BDEV_STATE_STALE ||
 	     BDEV_STATE(&dc->sb) == BDEV_STATE_NONE)) {
 		memcpy(u->uuid, invalid_uuid, 16);
-		u->invalidated = cpu_to_le32(get_seconds());
+		u->invalidated = cpu_to_le32((u32)ktime_get_real_seconds());
 		u = NULL;
 	}
 
@@ -1390,7 +1390,7 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size)
 
 	get_random_bytes(u->uuid, 16);
 	memset(u->label, 0, 32);
-	u->first_reg = u->last_reg = cpu_to_le32(get_seconds());
+	u->first_reg = u->last_reg = cpu_to_le32((u32)ktime_get_real_seconds());
 
 	SET_UUID_FLASH_ONLY(u, 1);
 	u->sectors = size >> 9;
@@ -1894,7 +1894,7 @@ static void run_cache_set(struct cache_set *c)
 		goto err;
 
 	closure_sync(&cl);
-	c->sb.last_mount = get_seconds();
+	c->sb.last_mount = (u32)ktime_get_real_seconds();
 	bcache_write_super(c);
 
 	list_for_each_entry_safe(dc, t, &uncached_devices, list)
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 821f71a2e48f..8d19e02d752a 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -195,7 +195,7 @@ struct cache_sb {
 	};
 	};
 
-	__u32			last_mount;	/* time_t */
+	__u32			last_mount;	/* time overflow in y2106 */
 
 	__u16			first_bucket;
 	union {
@@ -318,7 +318,7 @@ struct uuid_entry {
 		struct {
 			__u8	uuid[16];
 			__u8	label[32];
-			__u32	first_reg;
+			__u32	first_reg; /* time overflow in y2106 */
 			__u32	last_reg;
 			__u32	invalidated;
 
-- 
2.9.0

