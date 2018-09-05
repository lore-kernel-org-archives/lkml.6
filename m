Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476312077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476312077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIEMKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:10:33 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:48969 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeIEMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:10:33 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65b8f88aa31d-e685b; Wed, 05 Sep 2018 15:41:30 +0800 (CST)
X-RM-TRANSID: 2ee65b8f88aa31d-e685b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35b8f88a8ed6-94b61;
        Wed, 05 Sep 2018 15:41:30 +0800 (CST)
X-RM-TRANSID: 2ee35b8f88a8ed6-94b61
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH] mips: txx9: fix resource leak after register fail
Date:   Wed,  5 Sep 2018 15:41:27 +0800
Message-Id: <1536133287-21110-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the memory allocated and ioremap address need free after
device_register return error.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/mips/txx9/generic/setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index f6d9182..7f4fd2b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -961,11 +961,13 @@ void __init txx9_sramc_init(struct resource *r)
 	err = sysfs_create_bin_file(&dev->dev.kobj, &dev->bindata_attr);
 	if (err) {
 		device_unregister(&dev->dev);
-		iounmap(dev->base);
-		kfree(dev);
+		goto exit_free;
 	}
 	return;
 exit_put:
 	put_device(&dev->dev);
+exit_free:
+	iounmap(dev->base);
+	kfree(dev);
 	return;
 }
-- 
1.9.1



