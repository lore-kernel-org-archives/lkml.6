Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D79C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F69208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F69208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbeG0QZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:25:30 -0400
Received: from bran.ispras.ru ([83.149.199.196]:13112 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730771AbeG0QZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:25:29 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 06E4A203B2;
        Fri, 27 Jul 2018 18:03:09 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Alessandro Rubini <rubini@gnudd.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] fmc: Fix memory leak and NULL pointer dereference
Date:   Fri, 27 Jul 2018 18:02:45 +0300
Message-Id: <20180727150245.22610-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no deallocation of fmc memory, allocated at ff_dev_create()
by kmemdup(), and no check on kmemdup() success.

The patch adds deallocation into ff_dev_release() and adds check on
allocation success.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/fmc/fmc-fakedev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/fmc/fmc-fakedev.c b/drivers/fmc/fmc-fakedev.c
index 941d0930969a..ede589f4e8e5 100644
--- a/drivers/fmc/fmc-fakedev.c
+++ b/drivers/fmc/fmc-fakedev.c
@@ -244,7 +244,10 @@ static struct fmc_operations ff_fmc_operations = {
 /* This device is kmalloced: release it */
 static void ff_dev_release(struct device *dev)
 {
+	int i;
 	struct ff_dev *ff = container_of(dev, struct ff_dev, dev);
+	for (i = 0; i < ff_nr_dev; i++)
+		kfree(ff->fmc[i]);
 	kfree(ff);
 }
 
@@ -273,15 +276,17 @@ static struct ff_dev *ff_dev_create(void)
 	ff->dev.release = ff_dev_release;
 
 	ret = device_register(&ff->dev);
-	if (ret < 0) {
-		put_device(&ff->dev);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto err;
 
 	/* Create fmc structures that refer to this new "hw" device */
 	for (i = 0; i < ff_nr_dev; i++) {
 		fmc = kmemdup(&ff_template_fmc, sizeof(ff_template_fmc),
 			      GFP_KERNEL);
+		if (!fmc) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		fmc->hwdev = &ff->dev;
 		fmc->carrier_data = ff;
 		fmc->nr_slots = ff_nr_dev;
@@ -294,6 +299,10 @@ static struct ff_dev *ff_dev_create(void)
 		ff_template_fmc.device_id++;
 	}
 	return ff;
+
+err:
+	put_device(&ff->dev);
+	return ERR_PTR(ret);
 }
 
 /* init and exit */
-- 
2.18.0

