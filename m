Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D220869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbfAaOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:08:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49270 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbfAaOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:08:31 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gpD0u-0004V8-LQ; Thu, 31 Jan 2019 14:08:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: part: fix incorrect format specifier for an unsigned long long
Date:   Thu, 31 Jan 2019 14:08:20 +0000
Message-Id: <20190131140820.7422-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An unsigned long long is being formatted with %lld instead of the unsigned
version %llu. Fix this.

Clean up cppcheck warning:
%lld in format string (no. 1) requires 'long long' but the argument type
is 'unsigned long long'.

Fixes: a62c24d75529 ("mtd: part: Add sysfs variable for offset of partition")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 60104e1079c5..cca681b1a514 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -568,7 +568,7 @@ static ssize_t mtd_partition_offset_show(struct device *dev,
 {
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	struct mtd_part *part = mtd_to_part(mtd);
-	return snprintf(buf, PAGE_SIZE, "%lld\n", part->offset);
+	return snprintf(buf, PAGE_SIZE, "%llu\n", part->offset);
 }
 
 static DEVICE_ATTR(offset, S_IRUGO, mtd_partition_offset_show, NULL);
-- 
2.20.1

