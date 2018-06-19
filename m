Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB2D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB2D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937488AbeFSICK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:02:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937349AbeFSICH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:02:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5J81rAl3015138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 01:01:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5J81rQQ3015135;
        Tue, 19 Jun 2018 01:01:53 -0700
Date:   Tue, 19 Jun 2018 01:01:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-58a10456d7175fa674b951f1fd7ead3d9a550db4@git.kernel.org>
Cc:     hpa@zytor.com, deepa.kernel@gmail.com, arnd@arndb.de,
        mingo@kernel.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, ebiederm@xmission.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, arnd@arndb.de,
          deepa.kernel@gmail.com, hpa@zytor.com
In-Reply-To: <20180618143246.3865099-1-arnd@arndb.de>
References: <20180618143246.3865099-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Use new ktime_get_*_ts64() helpers
Git-Commit-ID: 58a10456d7175fa674b951f1fd7ead3d9a550db4
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

Commit-ID:  58a10456d7175fa674b951f1fd7ead3d9a550db4
Gitweb:     https://git.kernel.org/tip/58a10456d7175fa674b951f1fd7ead3d9a550db4
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 18 Jun 2018 16:32:24 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 19 Jun 2018 09:56:27 +0200

posix-timers: Use new ktime_get_*_ts64() helpers

Some of the oddly named time accessor functions now have a more consistent
naming, which should be used from now on so the aliases can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038@lists.linaro.org
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lkml.kernel.org/r/20180618143246.3865099-1-arnd@arndb.de

---
 kernel/time/posix-stubs.c  |  2 +-
 kernel/time/posix-timers.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 26aa9569e24a..2c6847d5d69b 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -81,7 +81,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		ktime_get_ts64(tp);
 		break;
 	case CLOCK_BOOTTIME:
-		get_monotonic_boottime64(tp);
+		ktime_get_boottime_ts64(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e08ce3f27447..fcf90a10c43a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -228,21 +228,21 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
  */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
-	getrawmonotonic64(tp);
+	ktime_get_raw_ts64(tp);
 	return 0;
 }
 
 
 static int posix_get_realtime_coarse(clockid_t which_clock, struct timespec64 *tp)
 {
-	*tp = current_kernel_time64();
+	ktime_get_coarse_real_ts64(tp);
 	return 0;
 }
 
 static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
-	*tp = get_monotonic_coarse64();
+	ktime_get_coarse_ts64(tp);
 	return 0;
 }
 
@@ -254,13 +254,13 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 
 static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
 {
-	get_monotonic_boottime64(tp);
+	ktime_get_boottime_ts64(tp);
 	return 0;
 }
 
 static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
 {
-	timekeeping_clocktai64(tp);
+	ktime_get_clocktai_ts64(tp);
 	return 0;
 }
 
