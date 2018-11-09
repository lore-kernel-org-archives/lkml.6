Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5258C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF8020818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lNpshCdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF8020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKJDke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:40:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeKJDke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=grECD9UpKgIHHbWvB7G+VEfcsyi+a4MhqDkLccDBln4=; b=lNpshCdQ9XQkY+dMSiwDIGSMa
        lidnIECsaPnVCBacE8E7u2n4bgIA2/JssaDKPQydSGtNzE9RJVsbaKM7mNu+bzrmbQM3MYEJV/eyR
        zHW5g3Yj17beQgANMpFuB4YMGqHkKyxT/CMf5gtwAsm4KcmW99hH75uRUdc/txZBf5rfs7LMAaeCJ
        7bYEgWH7DEDt8+yg1WZURjVbI5fRk4VLBGqg5vHJg9BqJUamR9INIqCWY2LG4kkBXgHdUK5N0bYGO
        4KzQvgc8pBgkL+X50KiwTqEEo1iZOO3LDaX1nNdra5nvbkBbaadGxh5pjpw0YzaR+gtWMb0iobFAp
        NXjZyGhBw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLB3O-0003VF-6N; Fri, 09 Nov 2018 17:58:46 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] staging: erofs: select LZ4_DECOMPRESS to fix build error
Message-ID: <e2365d5f-aabb-a631-1338-1e32f8c9bea6@infradead.org>
Date:   Fri, 9 Nov 2018 09:58:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

EROFS Data Compression support uses LZ4 decompression, so it
should select LZ4_DECOMPRESS to prevent this build error:

drivers/staging/erofs/unzip_vle_lz4.o: In function `z_erofs_unzip_lz4':
drivers/staging/erofs/unzip_vle_lz4.c:18: undefined reference to `LZ4_decompress_safe_partial'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Gao Xiang <gaoxiang25@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
---
 drivers/staging/erofs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181109.orig/drivers/staging/erofs/Kconfig
+++ linux-next-20181109/drivers/staging/erofs/Kconfig
@@ -90,6 +90,7 @@ config EROFS_FS_IO_MAX_RETRIES
 config EROFS_FS_ZIP
 	bool "EROFS Data Compresssion Support"
 	depends on EROFS_FS
+	select LZ4_DECOMPRESS
 	help
 	  Currently we support VLE Compression only.
 	  Play at your own risk.

