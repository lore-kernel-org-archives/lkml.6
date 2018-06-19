Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC02BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BE92083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BE92083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756275AbeFSH2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:28:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755463AbeFSH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:27:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5J7Rmut3006731
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 00:27:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5J7RlTR3006728;
        Tue, 19 Jun 2018 00:27:47 -0700
Date:   Tue, 19 Jun 2018 00:27:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-0fe2795516b9e1c59b58b02bdf8658698117ec4e@git.kernel.org>
Cc:     mingo@kernel.org, rafael.j.wysocki@intel.com, arnd@arndb.de,
        deepa.kernel@gmail.com, hpa@zytor.com, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          anna-maria@linutronix.de, hpa@zytor.com, deepa.kernel@gmail.com,
          rafael.j.wysocki@intel.com, arnd@arndb.de, mingo@kernel.org
In-Reply-To: <20180618140811.2998503-1-arnd@arndb.de>
References: <20180618140811.2998503-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] posix-timers: Fix nanosleep_copyout() for
 CONFIG_COMPAT_32BIT_TIME
Git-Commit-ID: 0fe2795516b9e1c59b58b02bdf8658698117ec4e
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

Commit-ID:  0fe2795516b9e1c59b58b02bdf8658698117ec4e
Gitweb:     https://git.kernel.org/tip/0fe2795516b9e1c59b58b02bdf8658698117ec4e
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 18 Jun 2018 16:07:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 19 Jun 2018 09:23:19 +0200

posix-timers: Fix nanosleep_copyout() for CONFIG_COMPAT_32BIT_TIME

Commit b5793b0d92c9 added support for building the nanosleep compat system
call on 32-bit architectures, but missed one change in nanosleep_copyout(),
which would trigger a BUG() as soon as any architecture is switched over to
use it.

Use the proper config symbol to enable the code path.

Fixes: Commit b5793b0d92c9 ("posix-timers: Make compat syscalls depend on CONFIG_COMPAT_32BIT_TIME")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038@lists.linaro.org
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20180618140811.2998503-1-arnd@arndb.de

---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 055a4a728c00..3e93c54bd3a1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1659,7 +1659,7 @@ EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {
 	switch(restart->nanosleep.type) {
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 	case TT_COMPAT:
 		if (compat_put_timespec64(ts, restart->nanosleep.compat_rmtp))
 			return -EFAULT;
