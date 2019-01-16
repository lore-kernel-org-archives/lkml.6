Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B4320859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbfAPI2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:28:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388690AbfAPI2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:28:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE4E3510ADCF46D0EF12;
        Wed, 16 Jan 2019 16:28:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 16:27:55 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <gregkh@linuxfoundation.org>, <arve@android.com>,
        <tkjos@android.com>, <maco@android.com>, <joel@joelfernandes.org>,
        <christian@brauner.io>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next v2] binderfs: fix error return code in binderfs_fill_super()
Date:   Wed, 16 Jan 2019 08:34:02 +0000
Message-ID: <1547627642-96450-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code -ENOMEM from the new_inode() and
d_make_root() error handling cases instead of 0, as done elsewhere in
this function.

Fixes: 3ad20fe393b3 ("binder: implement binderfs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: move 'ret = -ENOMEM' out of if
---
 drivers/android/binderfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 9518e2e..e4ff4c3 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -518,6 +518,7 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_fs_info = info;
 
+	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
 		goto err_without_dentry;



