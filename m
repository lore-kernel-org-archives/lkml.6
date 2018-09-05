Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9358120857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9358120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIEPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:52:21 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:40048 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:52:21 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b8fbc7329a-ee552; Wed, 05 Sep 2018 19:22:27 +0800 (CST)
X-RM-TRANSID: 2ee45b8fbc7329a-ee552
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25b8fbc72daa-a4a19;
        Wed, 05 Sep 2018 19:22:27 +0800 (CST)
X-RM-TRANSID: 2ee25b8fbc72daa-a4a19
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH V2] mips: txx9: fix resource leak after register fail
Date:   Wed,  5 Sep 2018 19:22:19 +0800
Message-Id: <1536146539-26131-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the memory allocated and ioremap address need free after
device_register return error.

v2: remove redundant "return"

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/mips/txx9/generic/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index f6d9182..e116a55 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -961,11 +961,12 @@ void __init txx9_sramc_init(struct resource *r)
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
-	return;
+exit_free:
+	iounmap(dev->base);
+	kfree(dev);
 }
-- 
1.9.1



