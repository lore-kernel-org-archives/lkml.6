Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E6E222DE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550160988;
	bh=iFB0pAUa1zDYI4+rRiqN1cbEhHOeVwhwT2CFVgb2UWI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xwKPawn7C1hmth84LHQSx0hfva2dYiiZkCGCr6RfF4FDssGsRSOvGxrxKh+k+27yf
	 OzmoO0IPC4J0pD6MFUF1HOMG/zkxEzbjnAMo0SZ06kB6Zyz2ukpzBZoxojrrwM2kbb
	 sxgha77QWhPcJaqjH/u8Msb2zbWVvO2d81c2w5eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfBNQQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:16:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfBNQQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:16:26 -0500
Received: from localhost.localdomain (unknown [49.77.183.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2BA2077B;
        Thu, 14 Feb 2019 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550160985;
        bh=iFB0pAUa1zDYI4+rRiqN1cbEhHOeVwhwT2CFVgb2UWI=;
        h=From:To:Cc:Subject:Date:From;
        b=N2CrQH7UcPkqL0iMdRTB+b1Y4OyOCLF34Kw/gJgnqSXRqGYFzzA6oBQUFTCO8HM3J
         I158q2m+4i747kcrbcbZra9TbIASBhdw+RHw3bY12GpI2xJMEMPPY1OrEdIoU37cd6
         T1OsaryOmkXfXuYvwad0jYTwXa6GSnKVi/14oP6c=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't allow negative ->write_io_size_bits
Date:   Fri, 15 Feb 2019 00:16:15 +0800
Message-Id: <20190214161615.5854-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Dan reported:

"We put an upper bound on ->write_io_size_bits but we don't have a lower
bound."

So let's add lower bound check for ->write_io_size_bits in parse_options().

[We don't allow configuring ->write_io_size_bits to zero, since at least
we need to fill one dummy page for aligned IO.]

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index be8be445c6ed..230845221c74 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -586,7 +586,7 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_io_size_bits:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			if (arg > __ilog2_u32(BIO_MAX_PAGES)) {
+			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"Not support %d, larger than %d",
 					1 << arg, BIO_MAX_PAGES);
-- 
2.18.0

