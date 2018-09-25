Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2758AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4339208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FpBcEE8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4339208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIYMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:16:07 -0400
Received: from m12-15.163.com ([220.181.12.15]:55090 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIYMQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=rkRH6fPSqexuLzk7EH
        omO2XoN1TdTkv91CxsYdxoc1g=; b=FpBcEE8Fh7/bhYt6KuMgHUhShrzbj7Vhmo
        TNhoFiQz2TAAX4ktuxefKhL578trnAzC/nWNrasbds9c1jTZRxBDqVenEJSoL0pR
        sGkuZcgArPnALpHvzFBrB+OYNWj7uURMG7f0N5hapD0q7JT+yF8O4sSt1N//I+5h
        12qRckYb0=
Received: from localhost.localdomain (unknown [117.136.0.174])
        by smtp11 (Coremail) with SMTP id D8CowADHYdA20albK3grIQ--.53064S5;
        Tue, 25 Sep 2018 14:10:06 +0800 (CST)
From:   Dongbo Cao <cdbdyx@163.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dongbo Cao <cdbdyx@163.com>
Subject: [PATCH 2/2] panic fix for making cache device
Date:   Tue, 25 Sep 2018 14:09:45 +0800
Message-Id: <20180925060945.6731-2-cdbdyx@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925060945.6731-1-cdbdyx@163.com>
References: <20180925060945.6731-1-cdbdyx@163.com>
X-CM-TRANSID: D8CowADHYdA20albK3grIQ--.53064S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18Gw1xGw4fWr43GFy5CFg_yoW8Xr1kpF
        Z3C34fAF48Xr17AF1DXr4v9a4rA392vFZrG3srAw43u3WYgFyY9FWDtFyjgr1UXry8Ja1a
        yFy5Kr18WF1jkaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI6wAUUUUU=
X-Originating-IP: [117.136.0.174]
X-CM-SenderInfo: xfgev5r06rljoofrz/1tbiRx7M3Fc7EoAjpwAAsz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the nbuckets of cache device is smaller than 1024, making cache device will trigger BUG_ON in kernel, add a condition to avoid this.

Signed-off-by: Dongbo Cao <cdbdyx@163.com>
---
 drivers/md/bcache/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0c0f6d8f..47d122ed 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2036,7 +2036,12 @@ static int cache_alloc(struct cache *ca)
 	 */
 	btree_buckets = ca->sb.njournal_buckets ?: 8;
 	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
-	
+	if (!free) {
+		ret = -EPERM;
+		err = "ca->sb.nbuckets is too small";
+		goto err_free;
+	}
+
 	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets,
 						GFP_KERNEL)) {
 		err = "ca->free[RESERVE_BTREE] alloc failed";
@@ -2102,6 +2107,7 @@ static int cache_alloc(struct cache *ca)
 err_prio_alloc:
 	free_fifo(&ca->free[RESERVE_BTREE]);
 err_btree_alloc:
+err_free:
 	module_put(THIS_MODULE);
 	if (err)
 		pr_notice("error %s: %s", ca->cache_dev_name, err);
@@ -2131,6 +2137,8 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
 		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
 		if (ret == -ENOMEM)
 			err = "cache_alloc(): -ENOMEM";
+		else if (ret == -EPERM)
+			err = "cache_alloc(): cache device is too small";
 		else
 			err = "cache_alloc(): unknown error";
 		goto err;
-- 
2.17.1


