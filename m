Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886DFECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F8A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TIbDPUeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F8A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeINPF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:05:26 -0400
Received: from m12-11.163.com ([220.181.12.11]:35729 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbeINPF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=7UBpilPnsKaTQPnAbt
        va6+x1zvWlZWKjPW37uDKpvJI=; b=TIbDPUeQGrWWH4fatNMGyXT6RZQuCVf/zI
        rLaWIyBnpO/6ZCrD7AUyoNmkWp2YEe041vqYwuPMYRqFeIv3DN183v5BfJKg+lyf
        qqxSoiWuN7mu2fmS1arQ+pK/cu0KoWobArrNguyPvRiJankYHQK2sI42zWsBmxki
        wavUNr4To=
Received: from localhost.localdomain (unknown [117.136.0.171])
        by smtp7 (Coremail) with SMTP id C8CowAAHhSqmhJtbfcAgAQ--.41883S4;
        Fri, 14 Sep 2018 17:51:35 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH] add label interface for cache device in sysfs
Date:   Fri, 14 Sep 2018 17:51:20 +0800
Message-Id: <20180914095120.2699-1-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowAAHhSqmhJtbfcAgAQ--.41883S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7GrWDZrWxCw1fWryrWF43GFg_yoW8JrWfpF
        W3W34rWw1kX347Jrn3CF17GaySg3ySya4kWrW2yay8Za4jq3WDC3yFgayY9ryktr45Ca93
        Ar18tF45Wa1UWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8Xo7UUUUU=
X-Originating-IP: [117.136.0.171]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiJQ-B3FUMM6ZMHgAAsp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

label interface will be called by bcache tools in user space.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/sysfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 225b15aa..e64c718f 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -950,6 +950,13 @@ SHOW(__bch_cache)
 		return ret;
 	}
 
+	if (attr == &sysfs_label) {
+		memcpy(buf, ca->sb.label, SB_LABEL_SIZE);
+		buf[SB_LABEL_SIZE + 1] = '\0';
+		strcat(buf, "\n");
+		return strlen(buf);
+	}
+
 	return 0;
 }
 SHOW_LOCKED(bch_cache)
@@ -993,6 +1000,17 @@ STORE(__bch_cache)
 		atomic_set(&ca->io_errors, 0);
 	}
 
+	if (attr == &sysfs_label) {
+		if (size > SB_LABEL_SIZE)
+			return -EINVAL;
+		memcpy(ca->sb.label, buf, size);
+		if (size < SB_LABEL_SIZE)
+			ca->sb.label[size] = '\0';
+		if (size && ca->sb.label[size - 1] == '\n')
+			ca->sb.label[size - 1] = '\0';
+		bcache_write_super(ca->set);
+	}
+
 	return size;
 }
 STORE_LOCKED(bch_cache)
@@ -1009,6 +1027,7 @@ static struct attribute *bch_cache_files[] = {
 	&sysfs_io_errors,
 	&sysfs_clear_stats,
 	&sysfs_cache_replacement_policy,
+	&sysfs_label,
 	NULL
 };
 KTYPE(bch_cache);
-- 
2.17.1


