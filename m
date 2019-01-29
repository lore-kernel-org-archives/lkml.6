Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B22C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CAF20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfA2TTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:19:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfA2TTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:19:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TJJX2J2063447
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 11:19:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TJJXOj2063443;
        Tue, 29 Jan 2019 11:19:33 -0800
Date:   Tue, 29 Jan 2019 11:19:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Greg Kroah-Hartman <tipbot@zytor.com>
Message-ID: <tip-0365aeba50841e087b3d6a0eca1bddccc5e650c8@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, dvhart@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com
Reply-To: mingo@kernel.org, dvhart@infradead.org, hpa@zytor.com,
          gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190122152151.16139-40-gregkh@linuxfoundation.org>
References: <20190122152151.16139-40-gregkh@linuxfoundation.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] futex: No need to check return value of
 debugfs_create functions
Git-Commit-ID: 0365aeba50841e087b3d6a0eca1bddccc5e650c8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0365aeba50841e087b3d6a0eca1bddccc5e650c8
Gitweb:     https://git.kernel.org/tip/0365aeba50841e087b3d6a0eca1bddccc5e650c8
Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate: Tue, 22 Jan 2019 16:21:39 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 20:15:48 +0100

futex: No need to check return value of debugfs_create functions

When calling debugfs functions, there is no need to ever check the return
value.  The function can work or not, but the code logic should never do
something different based on this.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190122152151.16139-40-gregkh@linuxfoundation.org

---
 kernel/futex.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index fdd312da0992..69e619baf709 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -321,12 +321,8 @@ static int __init fail_futex_debugfs(void)
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 
-	if (!debugfs_create_bool("ignore-private", mode, dir,
-				 &fail_futex.ignore_private)) {
-		debugfs_remove_recursive(dir);
-		return -ENOMEM;
-	}
-
+	debugfs_create_bool("ignore-private", mode, dir,
+			    &fail_futex.ignore_private);
 	return 0;
 }
 
