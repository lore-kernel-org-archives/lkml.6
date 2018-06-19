Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9B5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199212083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199212083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937464AbeFSIBM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:01:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937392AbeFSIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:01:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5J80oAV3015007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 01:00:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5J80oIF3015004;
        Tue, 19 Jun 2018 01:00:50 -0700
Date:   Tue, 19 Jun 2018 01:00:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-f5a89295e2f566d8e9f1d4f3d524d8d3c966958c@git.kernel.org>
Cc:     arnd@arndb.de, sboyd@kernel.org, deepa.kernel@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        john.stultz@linaro.org, tglx@linutronix.de, mingo@kernel.org,
        viro@zeniv.linux.org.uk
Reply-To: viro@zeniv.linux.org.uk, mingo@kernel.org, tglx@linutronix.de,
          john.stultz@linaro.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, deepa.kernel@gmail.com, sboyd@kernel.org,
          arnd@arndb.de
In-Reply-To: <20180618140811.2998503-2-arnd@arndb.de>
References: <20180618140811.2998503-2-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Use ktime_get_real_seconds() in time
 syscall
Git-Commit-ID: f5a89295e2f566d8e9f1d4f3d524d8d3c966958c
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

Commit-ID:  f5a89295e2f566d8e9f1d4f3d524d8d3c966958c
Gitweb:     https://git.kernel.org/tip/f5a89295e2f566d8e9f1d4f3d524d8d3c966958c
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 18 Jun 2018 16:08:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 19 Jun 2018 09:56:26 +0200

time: Use ktime_get_real_seconds() in time syscall

Both get_seconds() and do_gettimeofday() are deprecated. Change the time()
implementation to use the replacement function instead.

Obviously the system call will still overflow in 2038, but this gets us
closer to removing the old helper functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: y2038@lists.linaro.org
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lkml.kernel.org/r/20180618140811.2998503-2-arnd@arndb.de

---
 kernel/time/time.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 6fa99213fc72..b1225db61eb2 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(sys_tz);
  */
 SYSCALL_DEFINE1(time, time_t __user *, tloc)
 {
-	time_t i = get_seconds();
+	time_t i = (time_t)ktime_get_real_seconds();
 
 	if (tloc) {
 		if (put_user(i,tloc))
@@ -106,11 +106,9 @@ SYSCALL_DEFINE1(stime, time_t __user *, tptr)
 /* compat_time_t is a 32 bit "long" and needs to get converted. */
 COMPAT_SYSCALL_DEFINE1(time, compat_time_t __user *, tloc)
 {
-	struct timeval tv;
 	compat_time_t i;
 
-	do_gettimeofday(&tv);
-	i = tv.tv_sec;
+	i = (compat_time_t)ktime_get_real_seconds();
 
 	if (tloc) {
 		if (put_user(i,tloc))
