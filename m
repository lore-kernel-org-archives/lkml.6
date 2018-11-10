Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844E9206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844E9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeKJPdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:33:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728728AbeKJPdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:51 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5CAA6A990E0D0;
        Sat, 10 Nov 2018 12:03:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 12:03:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] sysv: return 'err' instead of 0 in __sysv_write_inode
Date:   Sat, 10 Nov 2018 04:13:24 +0000
Message-ID: <1541823204-45068-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/sysv/inode.c: In function '__sysv_write_inode':
fs/sysv/inode.c:239:6: warning:
 variable 'err' set but not used [-Wunused-but-set-variable]

__sysv_write_inode should return 'err' instead of 0

Fixes: 05459ca81ac3 ("repair sysv_write_inode(), switch sysv to simple_fsync()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/sysv/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 499a20a..273736f 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -275,7 +275,7 @@ static int __sysv_write_inode(struct inode *inode, int wait)
                 }
         }
 	brelse(bh);
-	return 0;
+	return err;
 }
 
 int sysv_write_inode(struct inode *inode, struct writeback_control *wbc)



