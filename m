Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFF9C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2FF208B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhTB0nGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2FF208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbeHFUQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbeHFUQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:16:32 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478F8208B6;
        Mon,  6 Aug 2018 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533578778;
        bh=+ho6jDYqnievsHzsTmCspmvfJNHa/SW4ZD3Es/3J9ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=MhTB0nGh4QgQTJT6JqH0NBr+HQAZq+ODH+rlcTL8Z3ZaROHhj8mV6sTvTVCPO6mMm
         mfBJpDIsrMxIq+3mPTWU6ja7HVyjGdfB4QFpNnVCycS3vjIs63DHR7QrwCCF36XpQ7
         9GsrOnH7HigDFoIi5S/tD8fyakkLs/eFhVJa1z5Y=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locks: add tracepoint in flock codepath
Date:   Mon,  6 Aug 2018 14:06:16 -0400
Message-Id: <20180806180616.9889-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      | 1 +
 include/trace/events/filelock.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index e533623e2e99..6138a9bcd924 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -990,6 +990,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	if (new_fl)
 		locks_free_lock(new_fl);
 	locks_dispose_list(&dispose);
+	trace_flock_lock_inode(inode, request, error);
 	return error;
 }
 
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index d1faf3597b9d..68b17c116907 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -112,8 +112,11 @@ DEFINE_EVENT(filelock_lock, locks_remove_posix,
 		TP_PROTO(struct inode *inode, struct file_lock *fl, int ret),
 		TP_ARGS(inode, fl, ret));
 
-DECLARE_EVENT_CLASS(filelock_lease,
+DEFINE_EVENT(filelock_lock, flock_lock_inode,
+		TP_PROTO(struct inode *inode, struct file_lock *fl, int ret),
+		TP_ARGS(inode, fl, ret));
 
+DECLARE_EVENT_CLASS(filelock_lease,
 	TP_PROTO(struct inode *inode, struct file_lock *fl),
 
 	TP_ARGS(inode, fl),
-- 
2.17.1

