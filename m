Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E3DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09FA21848
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfBULW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:22:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52172 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBULW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:22:26 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gwmQq-0004hZ-MZ; Thu, 21 Feb 2019 11:22:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][xfs-next] xfs: fix uninitialized error variable
Date:   Thu, 21 Feb 2019 11:22:24 +0000
Message-Id: <20190221112224.3748-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A previous commit removed the initialization of variable 'error' to zero,
and can cause a bogus error return.  This occurs when error contains a
non-zero garbage value and the call to xchk_should_terminate detects a
pending fatal signal and checks for a zero error before setting it
to -EAGAIN. Fix the issue by initializing error to zero.

Fixes: b9454fe056bd ("xfs: clean up the inode cluster checking in the inobt scrub")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/xfs/scrub/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/ialloc.c b/fs/xfs/scrub/ialloc.c
index 2c9dad2b61b1..700114f79a7d 100644
--- a/fs/xfs/scrub/ialloc.c
+++ b/fs/xfs/scrub/ialloc.c
@@ -161,7 +161,7 @@ xchk_iallocbt_check_cluster_ifree(
 	bool				irec_free;
 	bool				ino_inuse;
 	bool				freemask_ok;
-	int				error;
+	int				error = 0;
 
 	if (xchk_should_terminate(bs->sc, &error))
 		return error;
-- 
2.20.1

