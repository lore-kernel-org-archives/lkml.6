Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id usILGdJJGVteUgAAmS7hNA
	; Thu, 07 Jun 2018 15:06:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 43482608B8; Thu,  7 Jun 2018 15:06:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AAD956063F;
	Thu,  7 Jun 2018 15:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AAD956063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936054AbeFGPFo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:05:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41570 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933405AbeFGPEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:04:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbb-0005hK-Jz; Thu, 07 Jun 2018 15:09:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00034a-4e; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com,
        "Yisheng Xie" <xieyisheng1@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.410679082@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 249/410] staging: android: ashmem: Fix possible
 deadlock in ashmem_ioctl
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>

commit 740a5759bf222332fbb5eda42f89aa25ba38f9b2 upstream.

ashmem_mutex may create a chain of dependencies like:

CPU0                                    CPU1
 mmap syscall                           ioctl syscall
 -> mmap_sem (acquired)                 -> ashmem_ioctl
 -> ashmem_mmap                            -> ashmem_mutex (acquired)
    -> ashmem_mutex (try to acquire)       -> copy_from_user
                                              -> mmap_sem (try to acquire)

There is a lock odering problem between mmap_sem and ashmem_mutex causing
a lockdep splat[1] during a syzcaller test. This patch fixes the problem
by move copy_from_user out of ashmem_mutex.

[1] https://www.spinics.net/lists/kernel/msg2733200.html

Fixes: ce8a3a9e76d0 (staging: android: ashmem: Fix a race condition in pin ioctls)
Reported-by: syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/android/ashmem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -703,16 +703,14 @@ static int ashmem_pin_unpin(struct ashme
 	size_t pgstart, pgend;
 	int ret = -EINVAL;
 
+	if (unlikely(copy_from_user(&pin, p, sizeof(pin))))
+		return -EFAULT;
+
 	mutex_lock(&ashmem_mutex);
 
 	if (unlikely(!asma->file))
 		goto out_unlock;
 
-	if (unlikely(copy_from_user(&pin, p, sizeof(pin)))) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
 	/* per custom, you can pass zero for len to mean "everything onward" */
 	if (!pin.len)
 		pin.len = PAGE_ALIGN(asma->size) - pin.offset;
