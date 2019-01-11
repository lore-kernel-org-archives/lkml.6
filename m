Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7381C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1D1206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SqmSf2Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfAKA0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:26:49 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46902 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAKA0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:26:47 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E8EB710C0D59;
        Thu, 10 Jan 2019 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547166407; bh=eKBup9uhbGbyAPqlLa4zZa3Jtqj2PAt9eLGZkA1RvN4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SqmSf2NrQugccT38I5aHfN4WFd6vJlQdry2qm8IJGUX2JbU0uKPyw1epBo6W8oxK2
         utBjd2Pz0AtwCcCTULpwDz1bmiYsRJJvVNjtgphq/lkDy1crFKgXDb8aFavfTFBcq3
         9Mr5smW2c5dHkYkYJfu7Xb6WOCJFCdPCqBfa1M98RQUA79zl+UxfTURhlRZIH4y6Wq
         8mN5jOgB5BhMWbZgbz0uwSOG/AueWakpTA2WPe4RvFM6ZTMlAvbnqPCz+VNOEPHpap
         pQwVZedlhtdi1U0DfuqTUVaMBcwRDiTy67Vl9EosS43I/HKR1jKhuSd+yFiLU/5toX
         f7kMbiWCbTZbA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id BCA10344D;
        Thu, 10 Jan 2019 16:26:46 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 16:26:46 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:45 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:46 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 2/3] fs: inode_set_flags() replace opencoded set_mask_bits()
Date:   Thu, 10 Jan 2019 16:26:26 -0800
Message-ID: <1547166387-19785-3-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that 5f16f3225b0624 and 00a1a053ebe5, both with same commitlog
("ext4: atomically set inode->i_flags in ext4_set_inode_flags()")
introduced the set_mask_bits API, but somehow missed not using it in
ext4 in the end

Also, set_mask_bits is used in fs quite a bit and we can possibly come up
with a generic llsc based implementation (w/o the cmpxchg loop)

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 fs/inode.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0cd47fe0dbe5..799b0c4beda8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2096,14 +2096,8 @@ EXPORT_SYMBOL(inode_dio_wait);
 void inode_set_flags(struct inode *inode, unsigned int flags,
 		     unsigned int mask)
 {
-	unsigned int old_flags, new_flags;
-
 	WARN_ON_ONCE(flags & ~mask);
-	do {
-		old_flags = READ_ONCE(inode->i_flags);
-		new_flags = (old_flags & ~mask) | flags;
-	} while (unlikely(cmpxchg(&inode->i_flags, old_flags,
-				  new_flags) != old_flags));
+	set_mask_bits(&inode->i_flags, mask, flags);
 }
 EXPORT_SYMBOL(inode_set_flags);
 
-- 
2.7.4

