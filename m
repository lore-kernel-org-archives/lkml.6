Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C50C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F812173A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvXIBMNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F812173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeHUSLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeHUSLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:11:12 -0400
Received: from localhost.localdomain (unknown [121.229.162.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042E32173A;
        Tue, 21 Aug 2018 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534863044;
        bh=SQ8IFpSG++qkNvX2wyKc+7QCgJK6/gvVL7b/Hvn5spg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bvXIBMNTq0J6XftmSf6kq2vcgFD3cA1fpKQ8b0Bq0kot7V8ZVXVGgd+j5SAVVjllh
         tSYcfMQtLuopoxfSCmpEbZFY/YsuNfsmh1waVxaRX8E/kDaSlWUgz0o5YLwJ2shDh0
         l+6dP8aXvsbctqplz0KwSfjkLAole2Iu3XTX01AU=
From:   Chao Yu <chao@kernel.org>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 9/9] staging: erofs: fix potential overflow in erofs_grab_bio()
Date:   Tue, 21 Aug 2018 22:49:37 +0800
Message-Id: <20180821144937.20555-10-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821144937.20555-1-chao@kernel.org>
References: <20180821144937.20555-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Dan reported in LKP's mailing list:

https://lists.01.org/pipermail/kbuild-all/2018-August/051419.html

New smatch warnings:
drivers/staging/erofs/internal.h:446 erofs_grab_bio() warn: should 'blkaddr << (12 - 9)' be a 64 bit type?
drivers/staging/erofs/data.c:78 __erofs_get_meta_page() error: 'bio' dereferencing possible ERR_PTR()
drivers/staging/erofs/internal.h:446 erofs_grab_bio() warn: should 'blkaddr << (12 - 9)' be a 64 bit type?

Old smatch warnings:
drivers/staging/erofs/unzip_vle.c:989 z_erofs_vle_unzip() error: double unlock 'mutex:&z_pagemap_global_lock'
drivers/staging/erofs/unzip_vle.c:1318 z_erofs_vle_normalaccess_readpage() warn: should 'page->index << 12' be a 64 bit type?
drivers/staging/erofs/unzip_vle.c:1351 __z_erofs_vle_normalaccess_readpages() warn: should '()->index << 12' be a 64 bit type?

It needs to cast varable's type to sector_t before left shifting.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 8951e01216e3..f20c6e9b7471 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -443,7 +443,7 @@ erofs_grab_bio(struct super_block *sb,
 
 	bio->bi_end_io = endio;
 	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_iter.bi_sector = blkaddr << LOG_SECTORS_PER_BLOCK;
+	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
 	return bio;
 }
 
-- 
2.18.0

