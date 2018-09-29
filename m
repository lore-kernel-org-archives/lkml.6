Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D4EC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AFC2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AFC2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeI3ETr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:19:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52134 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbeI3ESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6H-0000H0-JI; Sat, 29 Sep 2018 22:48:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006qc-Pz; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.466617795@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 022/131] seccomp: Add filter flag to opt-out of SSB
 mitigation
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 00a02d0c502a06d15e07b857f8ff921e3e402675 upstream.

If a seccomp user is not interested in Speculative Store Bypass mitigation
by default, it can set the new SECCOMP_FILTER_FLAG_SPEC_ALLOW flag when
adding filters.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16:
 - We don't support SECCOMP_FILTER_FLAG_TSYNC or SECCOMP_FILTER_FLAG_LOG
 - Drop selftest changes]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/seccomp.h      |  2 ++
 include/uapi/linux/seccomp.h |  3 +++
 kernel/seccomp.c             | 14 ++++++++------
 3 files changed, 13 insertions(+), 6 deletions(-)

--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -3,6 +3,8 @@
 
 #include <uapi/linux/seccomp.h>
 
+#define SECCOMP_FILTER_FLAG_MASK	SECCOMP_FILTER_FLAG_SPEC_ALLOW
+
 #ifdef CONFIG_SECCOMP
 
 #include <linux/thread_info.h>
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -14,6 +14,9 @@
 #define SECCOMP_SET_MODE_STRICT	0
 #define SECCOMP_SET_MODE_FILTER	1
 
+/* Valid flags for SECCOMP_SET_MODE_FILTER */
+#define SECCOMP_FILTER_FLAG_SPEC_ALLOW	(1UL << 2)
+
 /*
  * All BPF programs must return a 32-bit value.
  * The bottom 16-bits are for optional return data.
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -220,11 +220,13 @@ static inline void spec_mitigate(struct
 		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
 }
 
-static inline void seccomp_assign_mode(unsigned long seccomp_mode)
+static inline void seccomp_assign_mode(unsigned long seccomp_mode,
+				       unsigned long flags)
 {
 	current->seccomp.mode = seccomp_mode;
-	/* Assume seccomp processes want speculation flaw mitigation. */
-	spec_mitigate(current, PR_SPEC_STORE_BYPASS);
+	/* Assume default seccomp processes want spec flaw mitigation. */
+	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
+		spec_mitigate(current, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(current, TIF_SECCOMP);
 }
 
@@ -524,7 +526,7 @@ static long seccomp_set_mode_strict(void
 #ifdef TIF_NOTSC
 	disable_TSC();
 #endif
-	seccomp_assign_mode(seccomp_mode);
+	seccomp_assign_mode(seccomp_mode, 0);
 	ret = 0;
 
 out:
@@ -553,7 +555,7 @@ static long seccomp_set_mode_filter(unsi
 	long ret = -EINVAL;
 
 	/* Validate flags. */
-	if (flags != 0)
+	if (flags & ~SECCOMP_FILTER_FLAG_MASK)
 		goto out;
 
 	if (!seccomp_may_assign_mode(seccomp_mode))
@@ -563,7 +565,7 @@ static long seccomp_set_mode_filter(unsi
 	if (ret)
 		goto out;
 
-	seccomp_assign_mode(seccomp_mode);
+	seccomp_assign_mode(seccomp_mode, flags);
 out:
 	return ret;
 }

