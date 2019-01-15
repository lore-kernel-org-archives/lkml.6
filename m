Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91130C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624A020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570583;
	bh=rb9YC6bXLP0znJk96NSa7HZz8Lb06Bdjf2YlP0k8BOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tG8K/QvX6w+CrI5WRLQ2PHU7gfKs88JNQQvvGLgcH0SHncODmwHLPxwhFUtHIoQIp
	 8gCqn5P6bttE3kvrIl52X5YoS5b2QRpO+DrJyW0CyC+pzq+5vZ0/iTPEYbLIZs9oH7
	 X2DEu6zQqRL3cWT1aoi1QhLvA8uY/0p5A53VulDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfAOQnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbfAOQnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7050C20675;
        Tue, 15 Jan 2019 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570579;
        bh=rb9YC6bXLP0znJk96NSa7HZz8Lb06Bdjf2YlP0k8BOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TT+08dYIYIrr1hX3NRriYICFU88V/2A3YpWZxbmOl6OF+S15Ev+pmQmgDmpRPUAmy
         Gekkotl7tthdKOpm3HKMNf1qcYiH8O3ccUnfU30gczufwh19ikFJzwmMeA77HsAJmS
         j3wGBIxRHcxu1dOr1aSvjfHZ0Pin02fcpSKqKyys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pi-Hsun Shih <pihsun@chromium.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.19 47/50] arm64: compat: Dont pull syscall number from regs in arm_compat_syscall
Date:   Tue, 15 Jan 2019 17:36:23 +0100
Message-Id: <20190115154912.655131093@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 53290432145a8eb143fe29e06e9c1465d43dc723 upstream.

The syscall number may have been changed by a tracer, so we should pass
the actual number in from the caller instead of pulling it from the
saved r7 value directly.

Cc: <stable@vger.kernel.org>
Cc: Pi-Hsun Shih <pihsun@chromium.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/kernel/sys_compat.c |    9 ++++-----
 arch/arm64/kernel/syscall.c    |    9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

--- a/arch/arm64/kernel/sys_compat.c
+++ b/arch/arm64/kernel/sys_compat.c
@@ -66,12 +66,11 @@ do_compat_cache_op(unsigned long start,
 /*
  * Handle all unrecognised system calls.
  */
-long compat_arm_syscall(struct pt_regs *regs)
+long compat_arm_syscall(struct pt_regs *regs, int scno)
 {
 	siginfo_t info;
-	unsigned int no = regs->regs[7];
 
-	switch (no) {
+	switch (scno) {
 	/*
 	 * Flush a region from virtual address 'r0' to virtual address 'r1'
 	 * _exclusive_.  There is no alignment requirement on either address;
@@ -107,7 +106,7 @@ long compat_arm_syscall(struct pt_regs *
 		 * way the calling program can gracefully determine whether
 		 * a feature is supported.
 		 */
-		if (no < __ARM_NR_COMPAT_END)
+		if (scno < __ARM_NR_COMPAT_END)
 			return -ENOSYS;
 		break;
 	}
@@ -119,6 +118,6 @@ long compat_arm_syscall(struct pt_regs *
 	info.si_addr  = (void __user *)instruction_pointer(regs) -
 			 (compat_thumb_mode(regs) ? 2 : 4);
 
-	arm64_notify_die("Oops - bad compat syscall(2)", regs, &info, no);
+	arm64_notify_die("Oops - bad compat syscall(2)", regs, &info, scno);
 	return 0;
 }
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -13,16 +13,15 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 
-long compat_arm_syscall(struct pt_regs *regs);
-
+long compat_arm_syscall(struct pt_regs *regs, int scno);
 long sys_ni_syscall(void);
 
-asmlinkage long do_ni_syscall(struct pt_regs *regs)
+static long do_ni_syscall(struct pt_regs *regs, int scno)
 {
 #ifdef CONFIG_COMPAT
 	long ret;
 	if (is_compat_task()) {
-		ret = compat_arm_syscall(regs);
+		ret = compat_arm_syscall(regs, scno);
 		if (ret != -ENOSYS)
 			return ret;
 	}
@@ -47,7 +46,7 @@ static void invoke_syscall(struct pt_reg
 		syscall_fn = syscall_table[array_index_nospec(scno, sc_nr)];
 		ret = __invoke_syscall(regs, syscall_fn);
 	} else {
-		ret = do_ni_syscall(regs);
+		ret = do_ni_syscall(regs, scno);
 	}
 
 	regs->regs[0] = ret;


