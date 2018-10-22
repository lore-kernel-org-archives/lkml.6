Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B73FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620F92087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5IMZEq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620F92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeJVSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbeJVSif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:35 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DD32087D;
        Mon, 22 Oct 2018 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203640;
        bh=raDPIphocoz2yKOAb9guDGowwllkuXJFA9maSIajmdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5IMZEq7JU6Rk2f7R2E7HG4a8pj/9l325hZ0XxKYzuW3pQFFZpgiJWeoII7JZJKd6
         lHG+ciXiBizECPi7rndMSHIjmoZk/Zr9b4NBC1/FwHpG5gVa7c4bvb4N+Faisiy681
         J4MJB/1F4uOGLSsnGgSYR86nXkVanZeX4SnsILWo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 02/15] s390/hibernate: fix error handling when suspend cpu != resume cpu
Date:   Mon, 22 Oct 2018 06:20:13 -0400
Message-Id: <20181022102026.40869-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102026.40869-1-sashal@kernel.org>
References: <20181022102026.40869-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

[ Upstream commit 55a5542a546238354d1f209f794414168cf8c71d ]

The resume code checks if the resume cpu is the same as the suspend cpu.
If not, and if it is also not possible to switch to the suspend cpu, an
error message should be printed and the resume process should be stopped
by loading a disabled wait psw.

The current logic is broken in multiple ways, the message is never printed,
and the disabled wait psw never loaded because the kernel panics before that:
- sam31 and SIGP_SET_ARCHITECTURE to ESA mode is wrong, this will break
  on the first 64bit instruction in sclp_early_printk().
- The init stack should be used, but the stack pointer is not set up correctly
  (missing aghi %r15,-STACK_FRAME_OVERHEAD).
- __sclp_early_printk() checks the sclp_init_state. If it is not
  sclp_init_state_uninitialized, it simply returns w/o printing anything.
  In the resumed kernel however, sclp_init_state will never be uninitialized.

This patch fixes those issues by removing the sam31/ESA logic, adding a
correct init stack pointer, and also introducing sclp_early_printk_force()
to allow using sclp_early_printk() even when sclp_init_state is not
uninitialized.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/sclp.h        |  3 ++-
 arch/s390/kernel/early_printk.c     |  2 +-
 arch/s390/kernel/swsusp.S           |  8 +++-----
 drivers/s390/char/sclp_early_core.c | 11 ++++++++---
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index d3c1a8a2e3ad..d90a84770ce5 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -107,7 +107,8 @@ int sclp_early_get_core_info(struct sclp_core_info *info);
 void sclp_early_get_ipl_info(struct sclp_ipl_info *info);
 void sclp_early_detect(void);
 void sclp_early_printk(const char *s);
-void __sclp_early_printk(const char *s, unsigned int len);
+void sclp_early_printk_force(const char *s);
+void __sclp_early_printk(const char *s, unsigned int len, unsigned int force);
 
 int _sclp_get_core_info(struct sclp_core_info *info);
 int sclp_core_configure(u8 core);
diff --git a/arch/s390/kernel/early_printk.c b/arch/s390/kernel/early_printk.c
index 9431784d7796..40c1dfec944e 100644
--- a/arch/s390/kernel/early_printk.c
+++ b/arch/s390/kernel/early_printk.c
@@ -10,7 +10,7 @@
 
 static void sclp_early_write(struct console *con, const char *s, unsigned int len)
 {
-	__sclp_early_printk(s, len);
+	__sclp_early_printk(s, len, 0);
 }
 
 static struct console sclp_early_console = {
diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index a049a7b9d6e8..c1a080b11ae9 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -198,12 +198,10 @@ pgm_check_entry:
 
 	/* Suspend CPU not available -> panic */
 	larl	%r15,init_thread_union
-	ahi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
+	aghi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
+	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r2,.Lpanic_string
-	lghi	%r1,0
-	sam31
-	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	brasl	%r14,sclp_early_printk
+	brasl	%r14,sclp_early_printk_force
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
diff --git a/drivers/s390/char/sclp_early_core.c b/drivers/s390/char/sclp_early_core.c
index edeb2597b0b8..4daf797a6423 100644
--- a/drivers/s390/char/sclp_early_core.c
+++ b/drivers/s390/char/sclp_early_core.c
@@ -188,11 +188,11 @@ static int sclp_early_setup(int disable, int *have_linemode, int *have_vt220)
  * Output one or more lines of text on the SCLP console (VT220 and /
  * or line-mode).
  */
-void __sclp_early_printk(const char *str, unsigned int len)
+void __sclp_early_printk(const char *str, unsigned int len, unsigned int force)
 {
 	int have_linemode, have_vt220;
 
-	if (sclp_init_state != sclp_init_state_uninitialized)
+	if (!force && sclp_init_state != sclp_init_state_uninitialized)
 		return;
 	if (sclp_early_setup(0, &have_linemode, &have_vt220) != 0)
 		return;
@@ -205,5 +205,10 @@ void __sclp_early_printk(const char *str, unsigned int len)
 
 void sclp_early_printk(const char *str)
 {
-	__sclp_early_printk(str, strlen(str));
+	__sclp_early_printk(str, strlen(str), 0);
+}
+
+void sclp_early_printk_force(const char *str)
+{
+	__sclp_early_printk(str, strlen(str), 1);
 }
-- 
2.17.1

