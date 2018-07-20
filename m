Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BBAECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4320833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC4320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeGTBTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:19:09 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:29522 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeGTBTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:19:09 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id ABDB7A8CE9079A5F0A19;
        Fri, 20 Jul 2018 08:33:30 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6K0XS7N068966;
        Fri, 20 Jul 2018 08:33:28 +0800 (GMT-8)
        (envelope-from liu.hailong6@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072008333573-1017319 ;
          Fri, 20 Jul 2018 08:33:35 +0800 
From:   Hailong Liu <liu.hailong6@zte.com.cn>
To:     gregkh@linuxfoundation.org
Cc:     xiubli@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] uio: fix wrong return value from uio_mmap()
Date:   Fri, 20 Jul 2018 08:31:56 +0800
Message-Id: <1532046716-49792-1-git-send-email-liu.hailong6@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-20 08:33:36,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-20 08:33:13,
        Serialize complete at 2018-07-20 08:33:13
X-MAIL: mse01.zte.com.cn w6K0XS7N068966
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uio_mmap has multiple fail paths to set return value to nonzero then
goto out. However, it always returns *0* from the *out* at end, and
this will mislead callers who check the return value of this function.

Fixes: 57c5f4df0a5a0ee ("uio: fix crash after the device is unregistered")
CC: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5d421d7..0ddfda2 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -814,7 +814,7 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 
 out:
 	mutex_unlock(&idev->info_lock);
-	return 0;
+	return ret;
 }
 
 static const struct file_operations uio_fops = {
-- 
1.8.3.1

