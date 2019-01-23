Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595D6C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296B3218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UwABq9HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfAWUfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:35:37 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38740 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:35:37 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 69EEB10C0EB9;
        Wed, 23 Jan 2019 12:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548275736; bh=5aqJIt6TmksnMnFVKjXMkW1BGCYVhXZ+GYxGZlH9Bhk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UwABq9HCGrxzd0x+PMqCWh3JwQ7ooGkdnfoILCzSLZeKmLLWOybXyjeu61ecChbV4
         yOVNQ2j3JajcEzlUejxh3MnFRNGqN6epSxutpCQ8bthEigufj6W+dhjv7o/twWGNL6
         KHMwVKZk8a4m464p/oP5gR+/yLSTDc9uRgmrnmmdWvD9dg4nONK/v5Q0XtBoxP3c3V
         rY0ME/sobPY7eNFJkSZsoV1e8FADT0RbBpk6K5VtwA3Ii6FwFhuUg/2cHfuqn7TS3U
         UgbNeHlRzmC5dM436fX0f8VCZtk4DB+8zzOjcI5k1u4D1Y0KcVYiHm4CX1LMLr9Ga2
         bw3jOmjcALOkQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 22C98A0070;
        Wed, 23 Jan 2019 20:35:34 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 12:33:23 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:24 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:22 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 2/3] fs: inode_set_flags() replace opencoded set_mask_bits()
Date:   Wed, 23 Jan 2019 12:33:03 -0800
Message-ID: <1548275584-18096-3-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
References: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
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
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
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

