Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5367C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545CE21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545CE21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeHXFfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:35:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbeHXFfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:35:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7BE87E08A37FB;
        Fri, 24 Aug 2018 10:03:04 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 24 Aug
 2018 10:02:57 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: fix potential overflow in z_erofs_vle_normalaccess_readpage{,s}
Date:   Fri, 24 Aug 2018 10:02:40 +0800
Message-ID: <1535076160-99466-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dan reported in the LKP mailing list:
https://lists.01.org/pipermail/kbuild-all/2018-August/051558.html

New smatch warnings:
drivers/staging/erofs/unzip_vle.c:1359 z_erofs_vle_normalaccess_readpages() warn: should '()->index << 12' be a 64 bit type?

Old smatch warnings:
drivers/staging/erofs/unzip_vle.c:1322 z_erofs_vle_normalaccess_readpage() warn: should 'page->index << 12' be a 64 bit type?

It needs to cast variable's type to erofs_off_t before left shifting.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

This patch is based on
`staging: erofs: fix potential overflow in erofs_grab_bio()'
of Chao Yu's previous patchset in order to
avoid patch conflict when applying.

Thanks,
Gao Xiang

 drivers/staging/erofs/unzip_vle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 6c4c928..22f9a02 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1314,7 +1314,7 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
 	LIST_HEAD(pagepool);
 
 #if (EROFS_FS_ZIP_CACHE_LVL >= 2)
-	f.cachedzone_la = page->index << PAGE_SHIFT;
+	f.cachedzone_la = (erofs_off_t)page->index << PAGE_SHIFT;
 #endif
 	err = z_erofs_do_read_page(&f, page, &pagepool);
 	(void)z_erofs_vle_work_iter_end(&f.builder);
@@ -1347,7 +1347,7 @@ static inline int __z_erofs_vle_normalaccess_readpages(
 	LIST_HEAD(pagepool);
 
 #if (EROFS_FS_ZIP_CACHE_LVL >= 2)
-	f.cachedzone_la = lru_to_page(pages)->index << PAGE_SHIFT;
+	f.cachedzone_la = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
 #endif
 	for (; nr_pages; --nr_pages) {
 		struct page *page = lru_to_page(pages);
-- 
1.9.1

