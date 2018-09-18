Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DE92146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DE92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeIRTRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:17:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45279 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbeIRTRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:17:34 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06439B53B6503;
        Tue, 18 Sep 2018 21:44:51 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 21:44:45 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: initialize `pblk' with 0 first in `z_erofs_map_blocks_iter'
Date:   Tue, 18 Sep 2018 21:44:36 +0800
Message-ID: <1537278276-110982-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20180918130911.GA16187@kroah.com>
References: <20180918130911.GA16187@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit message helps to understand why `pblk' is assigned with 0 here.

[ Greg reported a warning raised by gcc. ]
In file included from drivers/staging/erofs/unzip_vle.h:16:0,
                 from drivers/staging/erofs/unzip_vle.c:13:
drivers/staging/erofs/unzip_vle.c: In function ‘z_erofs_map_blocks_iter’:
drivers/staging/erofs/internal.h:303:34: warning: ‘pblk’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
                                  ^
drivers/staging/erofs/unzip_vle.c:1574:20: note: ‘pblk’ was declared here
  erofs_blk_t mblk, pblk;
                    ^~~~

Actually, it is a false-positive warning when looking into that. [1]
Just initialize the variable to keep gcc from printing foolish warnings.

[1] https://lists.ozlabs.org/pipermail/linux-erofs/2018-September/000637.html

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Thanks-to: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index ad3b7bb..3ff8adf 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1571,7 +1571,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	unsigned int lcn;
 	u32 ofs_rem;
 
-	erofs_blk_t mblk, pblk;
+	erofs_blk_t mblk, pblk = 0;
 	struct page *mpage = *mpage_ret;
 	struct z_erofs_vle_decompressed_index *di;
 	unsigned int cluster_type, logical_cluster_ofs;
-- 
1.9.1

