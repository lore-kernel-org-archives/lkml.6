Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265632087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RGsytdb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265632087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbeKPUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:42:53 -0500
Received: from m15-111.126.com ([220.181.15.111]:59196 "EHLO m15-111.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKPUmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=A/HYy38X64Ymi0JxJU
        nGzfz9CegyjpxxQc6zme4vEgM=; b=RGsytdb3yL/THk4P12QkD2EnENu0R+A0cm
        y6F9KMr09ACM9llXnX558sqcRcxk+8uosnW1uWhghWc29bf+7y3RVgwql4amkVtn
        ORQicILH9oYA75U3sEWgEvp8P1arvgJ2zQ+1xE/Vj8D+gKJMYzXqbAJmErDQ4gqR
        ozkH7y/yQ=
Received: from pek-zhang3-d1.corp.ad.wrs.com (unknown [60.247.85.82])
        by smtp1 (Coremail) with SMTP id C8mowAC3z7NUnO5b5DmoAA--.27164S2;
        Fri, 16 Nov 2018 18:30:51 +0800 (CST)
From:   Zhaolong Zhang <zhangzl2013@126.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, xiubli@redhat.com,
        ying.xue@windriver.com, hamish.martin@alliedtelesis.co.nz
Subject: [PATCH] uio: dismiss waiters on device unregistration
Date:   Fri, 16 Nov 2018 18:21:51 +0800
Message-Id: <1542363711-23231-1-git-send-email-zhangzl2013@126.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: C8mowAC3z7NUnO5b5DmoAA--.27164S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUZF4DCFWUtrW7GrW5Awb_yoW8Gry5p3
        yfKFWYyr18Wr4xWr13Ja1xXa45W34v9FWqqry7Ja43AanIqF1aqr17tFy29FyrtF95Ar4k
        tayrtw4fuFWUuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-o7tUUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: x2kd0wt2osiiat6rjloofrz/1tbitAMBz1pD7YspRgAAsp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device is unregistered, it should wake up the blocking waiters.
Otherwise, they will sleep forever.

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
---
 drivers/uio/uio.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 8564466..08fa55d 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -569,20 +569,20 @@ static ssize_t uio_read(struct file *filep, char __user *buf,
 	ssize_t retval = 0;
 	s32 event_count;
 
-	mutex_lock(&idev->info_lock);
-	if (!idev->info || !idev->info->irq)
-		retval = -EIO;
-	mutex_unlock(&idev->info_lock);
-
-	if (retval)
-		return retval;
-
 	if (count != sizeof(s32))
 		return -EINVAL;
 
 	add_wait_queue(&idev->wait, &wait);
 
 	do {
+		mutex_lock(&idev->info_lock);
+		if (!idev->info || !idev->info->irq) {
+			retval = -EIO;
+			mutex_unlock(&idev->info_lock);
+			break;
+		}
+		mutex_unlock(&idev->info_lock);
+
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		event_count = atomic_read(&idev->event);
@@ -1014,6 +1014,9 @@ void uio_unregister_device(struct uio_info *info)
 	idev->info = NULL;
 	mutex_unlock(&idev->info_lock);
 
+	wake_up_interruptible(&idev->wait);
+	kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);
+
 	device_unregister(&idev->dev);
 
 	return;
-- 
1.9.1

