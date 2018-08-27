Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3418C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A650F208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A650F208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeH0Xdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:33:49 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeH0Xdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:49 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M1nxq-1ffbh80KlO-00toEj; Mon, 27 Aug 2018 21:45:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/14] y2038: sched: Change sched_rr_get_interval to use __kernel_timespec
Date:   Mon, 27 Aug 2018 21:45:29 +0200
Message-Id: <20180827194531.3796559-13-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:A/PvtBsBqqPBHphqonIzFoco4UcdjHocqMllKaqT0ZBSX1pyyuv
 CI9k4lkIApv0KhEoBjNLqN1I9Q6Y9E/9wuJ2zNhpIDhNW4AkM+A1NnEEXU8x7Kj0ddMuHio
 xj5PFbUKX/1Cokxjq88roCCZe4ZJmhmekFCYsj1oqPvESVUTpwtSrMTU2YyPFDt9HUln1zO
 a0UyZy78YOCAc6msBEXmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xKLUZx0V7qM=:ZJT2IOPxulQ8zzcIdMU1bF
 iMjUInVfAjhSZc7+pFYiB05dQmC7RiKjw3/TxrrSHWg8LvBBF+qiG22FhCStK7w9WYBewxh3O
 Ezu2nhmHEXdUPYF+4PVhhZZ70xqHlSkbp1iMMXopl7fNfIusg1Jr6enjY3XEfsLVNBw+Cd/DO
 TrDHWRn0rA0GGZ8oU5ayVF4Sck45RkmQ2mTk7ToqjuoZV2RphbaIohASG8Jz2zg6iexBXzq11
 /e5bKisCU2+WeQAAecrPKOZzkBLwf0y846CyRSZ25QBkZG8pPXLXebhS2zccyz3tr+OOzDQzp
 InlHGQ8Zut9pPafpiUJSig4NXT3eEd5nMZNj9f4MplqdCG4AaSf8GIBQNoINDacztEPL5Dks6
 NTZ+cjZBcAarQGQHFCbDpqt8eRGR5o9+BLp1ilgsxYcO/qOwCOuWM0B23IsPr03RAJcZsXuou
 m0ijpj4/RfGAXXq9+wM1UjLlEY4u72GGVoMpV/VKhteUs2KYZDiOHEtQnNl2UmjWDWRhmWnEL
 y1PRqVDk2DLdFAX9RqmaItTrVTF9LeTmsKuh+SGweY9r/WOiNRUVEYtovY6K80Uf1v4yRGxzG
 UA/Q8zowGzEliVY8f7eLvFfLPwz0JkYCwIp2p4xqjHwgFk22Ofp0+rRDanzRK2aD/68o9imXT
 uVmjww+R6D1nuDTwvtCIhFpDKAEZAMSS0y1ZE8QTC/O9hFpaftYoyYqd1V5XtdD9/hcA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch for converting sys_sched_rr_get_interval to
work with 64-bit time_t on 32-bit architectures. The 'interval' argument
is changed to struct __kernel_timespec, which will be redefined using
64-bit time_t in the future. The compat version of the system call in
turn is enabled for compilation with CONFIG_COMPAT_32BIT_TIME so
the individual 32-bit architectures can share the handling of the
traditional argument with 64-bit architectures providing it for their
compat mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 2 +-
 kernel/sched/core.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 95e795fb0593..5642016a312d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -614,7 +614,7 @@ asmlinkage long sys_sched_yield(void);
 asmlinkage long sys_sched_get_priority_max(int policy);
 asmlinkage long sys_sched_get_priority_min(int policy);
 asmlinkage long sys_sched_rr_get_interval(pid_t pid,
-					struct timespec __user *interval);
+				struct __kernel_timespec __user *interval);
 
 /* kernel/signal.c */
 asmlinkage long sys_restart_syscall(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8287b75ed961..39af2bec2b39 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5243,7 +5243,7 @@ static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
  * an error code.
  */
 SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
-		struct timespec __user *, interval)
+		struct __kernel_timespec __user *, interval)
 {
 	struct timespec64 t;
 	int retval = sched_rr_get_interval(pid, &t);
@@ -5254,7 +5254,7 @@ SYSCALL_DEFINE2(sched_rr_get_interval, pid_t, pid,
 	return retval;
 }
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_32BIT_TIME
 COMPAT_SYSCALL_DEFINE2(sched_rr_get_interval,
 		       compat_pid_t, pid,
 		       struct old_timespec32 __user *, interval)
-- 
2.18.0

