Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeDAImN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 04:42:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54781 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeDAImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 04:42:11 -0400
X-Google-Smtp-Source: AIpwx4+SFJHR2BdVEy35b57IELBbJpHQUrTaxoMoteWxHSm8QpVE+lA1jQuZNKKJrzDdxPn54aTWww==
Date: Sun, 1 Apr 2018 08:42:08 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, casey@schaufler-ca.com,
        jmorris@namei.org
Subject: [PATCH] security: remove security_settime
Message-ID: <20180401084205.GA14512@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_settime was a wrapper around security_settime64. There are no more
users of it. Therefore it can be removed. It was removed in:
commit 4eb1bca17933 ("time: Use do_settimeofday64() internally")

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/security.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 3f5fd988ee87..5111fe8159ce 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -222,12 +222,6 @@ int security_quotactl(int cmds, int type, int id, struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
-static inline int security_settime(const struct timespec *ts, const struct timezone *tz)
-{
-	struct timespec64 ts64 = timespec_to_timespec64(*ts);
-
-	return security_settime64(&ts64, tz);
-}
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
@@ -509,14 +503,6 @@ static inline int security_settime64(const struct timespec64 *ts,
 	return cap_settime(ts, tz);
 }
 
-static inline int security_settime(const struct timespec *ts,
-				   const struct timezone *tz)
-{
-	struct timespec64 ts64 = timespec_to_timespec64(*ts);
-
-	return cap_settime(&ts64, tz);
-}
-
 static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
-- 
2.14.1
