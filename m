Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87BA20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfBWItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:49:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbfBWIs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:48:56 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FE07782DAA82B6252A4;
        Sat, 23 Feb 2019 16:48:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 16:48:44 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] fs: Avoid signed overflow UBSAN warning
Date:   Sat, 23 Feb 2019 17:02:10 +0800
Message-ID: <20190223090210.116847-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into this:
	UBSAN: Undefined behaviour in fs/read_write.c:251:11
	signed integer overflow:
	9223372036854775805 + 9223372036854775805 cannot be represented in
	type 'long long int'

Use unsigned types to do math, it doesn't throw a UBSAN warning
when it does overflow.This patch doesn't change generated code.

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 8f08d4a2aa9a..0509e81afc8e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -248,7 +248,7 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 				retval = file->f_pos;
 				goto out;
 			}
-			offset += file->f_pos;
+			offset = (u64)file->f_pos + (u64)offset;
 			break;
 		case SEEK_DATA:
 			/*
-- 
2.20.1

