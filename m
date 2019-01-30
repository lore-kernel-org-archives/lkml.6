Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7AFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49B020833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfA3KVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:21:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfA3KVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:21:51 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 34DDF90F5C0E121313C2;
        Wed, 30 Jan 2019 18:21:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 18:21:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <colyli@suse.de>, <kent.overstreet@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-bcache@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] bcache: Fix potential NULL pointer dereference
Date:   Wed, 30 Jan 2019 18:21:12 +0800
Message-ID: <20190130102112.11228-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential NULL pointer dereference in case
kzalloc() fails and returns NULL.

Fixes: bc082a55d25c ("bcache: fix inaccurate io state for detached bcache devices")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/md/bcache/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 1507041..a50afa4 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1094,6 +1094,8 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio)
 	 * which would call closure_get(&dc->disk.cl)
 	 */
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
+	if (!ddip)
+		return;
 	ddip->d = d;
 	ddip->start_time = jiffies;
 	ddip->bi_end_io = bio->bi_end_io;
-- 
2.7.0


