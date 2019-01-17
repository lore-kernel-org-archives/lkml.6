Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC320205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QevgCGzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfAQAfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:35:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46241 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfAQAf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:35:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so3565372pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=VTHWtlVbQul7bfM9w9IYIYA38lGAXNVOLlUfKXeMV5M=;
        b=QevgCGzKkh4e/Ugp3ZMY4dLllbuXr29HZxgccxdZkw0n3IntXYND3n+DMtUijNA6qD
         WkWRvoo2fPgWWNIj40dTuRrlHU36mNQjQ6FjBI+5Nnj81zCJ5RqkupYJSIwsuUqx8w1j
         5i7V2wC2CIuVMGwHzVkMkXrVcMZfBvflEm4OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VTHWtlVbQul7bfM9w9IYIYA38lGAXNVOLlUfKXeMV5M=;
        b=AR25fAPtW2NmgOctgETymoZOEauoVNw//7leXAxRWpCVAKz4LUc0YcxxEh85acDpEu
         M0IgnDHcNSviCxIH3uap4NwMGYritSDIHuS7/RY2kGumpkEWfnl4usqYS4cnLxj6M4zG
         cieQtB0MLaaVhbWfiFowx7OHHr8H/gVKKTF5wcB51ua2iCQvf+X75caXEEemy8y12kdt
         ZQIKnRvFWbNAcnr1QjZu7ePIXcHz6nUin+ef0vS5vHEeCNNeKISKid5QTVfimYMSHjzq
         MO8PAabnbp5zsB9nNWW4nusyFUhCY+EQotlcODxEroABwjIkzgA6XV/tjza7dSYpM3CE
         qb2A==
X-Gm-Message-State: AJcUukfpq/1X5ybs9EgKwB/3Ds6bluNBUvGaQWMJ0445f1Kn/uG5HsXD
        GxKBXGkI209K4R7ZxPVTJEwrvw==
X-Google-Smtp-Source: ALg8bN67xGmPFowvxVPbfzIvfzfUpQR2qQbQlxTizNILrvC3ermxc7V8zXKdKPZPNQ7S280neLL4Gw==
X-Received: by 2002:a63:c848:: with SMTP id l8mr11311427pgi.78.1547685327243;
        Wed, 16 Jan 2019 16:35:27 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d3sm7730628pgl.64.2019.01.16.16.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 16:35:26 -0800 (PST)
Date:   Wed, 16 Jan 2019 16:35:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>,
        James Morris <jmorris@namei.org>
Subject: [PATCH] selftests/seccomp: Abort without user notification support
Message-ID: <20190117003525.GA37918@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the face of missing user notification support, the self test needs
to stop executing a test (ASSERT_*) instead of just reporting and
continuing (EXPECT_*). This adjusts the user notification tests to do
that where needed.

Reported-by: Shuah Khan <shuah@kernel.org>
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 067cb4607d6c..496a9a8c773a 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3044,7 +3044,7 @@ TEST(user_notification_basic)
 	/* Check that the basic notification machinery works */
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	/* Installing a second listener in the chain should EBUSY */
 	EXPECT_EQ(user_trap_syscall(__NR_getpid,
@@ -3103,7 +3103,7 @@ TEST(user_notification_kill_in_middle)
 
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	/*
 	 * Check that nothing bad happens when we kill the task in the middle
@@ -3152,7 +3152,7 @@ TEST(user_notification_signal)
 
 	listener = user_trap_syscall(__NR_gettid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -3215,7 +3215,7 @@ TEST(user_notification_closed_listener)
 
 	listener = user_trap_syscall(__NR_getpid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	EXPECT_GE(listener, 0);
+	ASSERT_GE(listener, 0);
 
 	/*
 	 * Check that we get an ENOSYS when the listener is closed.
@@ -3376,7 +3376,7 @@ TEST(seccomp_get_notif_sizes)
 {
 	struct seccomp_notif_sizes sizes;
 
-	EXPECT_EQ(seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes), 0);
+	ASSERT_EQ(seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes), 0);
 	EXPECT_EQ(sizes.seccomp_notif, sizeof(struct seccomp_notif));
 	EXPECT_EQ(sizes.seccomp_notif_resp, sizeof(struct seccomp_notif_resp));
 }
-- 
2.17.1


-- 
Kees Cook
