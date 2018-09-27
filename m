Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0F21537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hU8AS20U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE0F21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeI0MEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:04:15 -0400
Received: from m50-132.163.com ([123.125.50.132]:36332 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeI0MEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:04:15 -0400
X-Greylist: delayed 914 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 08:04:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=5jptIBbRoobIYB9Xwc
        oNGKN3nXvvhvJz+7d4p3gMULE=; b=hU8AS20Umv+3J2s9ZKc5o+yPGg9LoYs7x2
        sAH6iNiZuTV1gA1Dcog8ODfqapEE0L7Cwi34VsJmdKjOgAQwX3xER1+RkY19UtDQ
        bM4Q5RU+R5Mvv9TmPaRi56MwZNUe7j7Chlx1vNhYC4NKUKXiYvhN3QYk0JwTvpcl
        ON25yI4YE=
Received: from localhost.localdomain (unknown [117.136.0.186])
        by smtp2 (Coremail) with SMTP id DNGowACniYRBa6xb7TQmAA--.140S4;
        Thu, 27 Sep 2018 13:31:58 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH] use STORE_LOCKED instead of STORE macro
Date:   Thu, 27 Sep 2018 13:31:42 +0800
Message-Id: <20180927053142.4529-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DNGowACniYRBa6xb7TQmAA--.140S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1DZFW3Wr4DXFyxAr4xZwb_yoW8GF48pF
        ZxWFy7t34vqw40y398CF12gFyrA3yUXasFgw4rA3W09a4kWF17CayUta4FvrW8ArZruayx
        Ar4UKrs8WF4qkaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJxhJUUUUU=
X-Originating-IP: [117.136.0.186]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiJR-O3FUMNGb7mQAAsB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merge sysfs_writeback_running attr and sysfs_writeback_percent attr together with other attrs of cached_dev.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/sysfs.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 26f035a0..14fc9104 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -245,7 +245,7 @@ SHOW(__bch_cached_dev)
 }
 SHOW_LOCKED(bch_cached_dev)
 
-STORE(__cached_dev)
+STORE(__bch_cached_dev)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
@@ -373,17 +373,6 @@ STORE(__cached_dev)
 	if (attr == &sysfs_stop)
 		bcache_device_stop(&dc->disk);
 
-	return size;
-}
-
-STORE(bch_cached_dev)
-{
-	struct cached_dev *dc = container_of(kobj, struct cached_dev,
-					     disk.kobj);
-
-	mutex_lock(&bch_register_lock);
-	size = __cached_dev_store(kobj, attr, buf, size);
-
 	if (attr == &sysfs_writeback_running)
 		bch_writeback_queue(dc);
 
@@ -392,9 +381,9 @@ STORE(bch_cached_dev)
 			schedule_delayed_work(&dc->writeback_rate_update,
 				      dc->writeback_rate_update_seconds * HZ);
 
-	mutex_unlock(&bch_register_lock);
 	return size;
 }
+STORE_LOCKED(bch_cached_dev)
 
 static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_attach,
-- 
2.17.1


