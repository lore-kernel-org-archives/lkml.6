Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07DDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477122157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fQuOeS6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477122157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeI0OpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:45:15 -0400
Received: from m12-18.163.com ([220.181.12.18]:56301 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbeI0OpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=NSQpNuvKRZqjq0tiXp
        AXHUU+vZwnShbuhno79Tm8Cvo=; b=fQuOeS6bAwwcrtV8GYw5oMDLj7KGicFYS/
        sFoNlvohT/d1r3iTmu3h2pJtrYylH26OBk3UtHHkasgUy+KUI5jrHGQW4FiVgWmT
        7eEyXpIIuN9uui7rC1V/WMSemvyMfkFezUd1ybKYOOctTlFZ092r8KQcMEkVcbWH
        BVZsXtvYU=
Received: from localhost.localdomain (unknown [117.136.0.186])
        by smtp14 (Coremail) with SMTP id EsCowAA3ixiRlKxbTqRoUw--.50523S4;
        Thu, 27 Sep 2018 16:28:02 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH] bug fix in function check_should_bypass
Date:   Thu, 27 Sep 2018 16:27:49 +0800
Message-Id: <20180927082749.2243-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowAA3ixiRlKxbTqRoUw--.50523S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1UJryDZFyrXr4Utry3XFb_yoWDJFc_u3
        WfWFZFqrZ5Gr10qry7Zr45X3yF9F18Zr1fWF13tFWF9F9xCw17Wr10gry5AFs3JF4fJF4U
        C3sFgw1rCrn8KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8mhF7UUUUU==
X-Originating-IP: [117.136.0.186]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiJQ7O3FUMNGlxNgAAs6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio->bi_iter.bi_sector is the sector index of current request, no need to be aligned.
instead, bio->bi_iter.bi_size should be aligned to block_bytes-1, not block_size-1.
and bio_sectors is the number of sectors of current request, also no need to be aligned, just remove it.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/request.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 13d3355a..fb3502da 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -398,8 +398,7 @@ static bool check_should_bypass(struct cached_dev *dc, struct bio *bio)
 	    !(bio->bi_opf & REQ_PRIO))
 		goto skip;
 
-	if (bio->bi_iter.bi_sector & (c->sb.block_size - 1) ||
-	    bio_sectors(bio) & (c->sb.block_size - 1)) {
+	if (bio->bi_iter.bi_size & (block_bytes(c) - 1)) {
 		pr_debug("skipping unaligned io");
 		goto skip;
 	}
-- 
2.17.1


