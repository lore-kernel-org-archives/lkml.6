Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF13FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4BD217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498290;
	bh=uWuGdq6xjXE4ujHufYEgmlNjLqEiT+MQvQtA3sbLSSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d47BkEBIsYj/gjAmjTPB7sEYg7+FmVGwH45QvXX7fjhnbPeXWpq06bD7PdWTigPgg
	 yEjLXg0rEUidmQa9GgmCBlLjhvVYQzTVLyOxow20FjpD1/aOVOCXkA7g41RoVN9deC
	 OqabiRGErer0YjIwrBfon7Z2uXBRcfF3innvFPdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfBRN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388252AbfBRN6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02532217D9;
        Mon, 18 Feb 2019 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498285;
        bh=uWuGdq6xjXE4ujHufYEgmlNjLqEiT+MQvQtA3sbLSSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xD0aZrBYxsxW+u+8bru03PEdUztwR12vUQhJYZd7UPjSrDMg1/q77g3LhLESnHJY8
         gJ/YddT76afkVB7aoSaGqg24C2ViP0TcFacdMUs86SZ4CJbmMxGBGaRP8qp076sWkR
         XCLei9IRM3u/gKdi6ZEvTDnd4CJQjxc5Uwk4weAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 04/58] ARM: 8789/1: signal: copy registers using __copy_to_user()
Date:   Mon, 18 Feb 2019 14:43:25 +0100
Message-Id: <20190218133508.908817706@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit 5ca451cf6ed04443774bbb7ee45332dafa42e99f upstream.

When saving the ARM integer registers, use __copy_to_user() to
copy them into user signal frame, rather than __put_user_error().
This has the benefit of disabling/enabling PAN once for the whole copy
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/signal.c | 49 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 6bee5c9b1133..fbb325ff8acc 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -256,30 +256,35 @@ static int
 setup_sigframe(struct sigframe __user *sf, struct pt_regs *regs, sigset_t *set)
 {
 	struct aux_sigframe __user *aux;
+	struct sigcontext context;
 	int err = 0;
 
-	__put_user_error(regs->ARM_r0, &sf->uc.uc_mcontext.arm_r0, err);
-	__put_user_error(regs->ARM_r1, &sf->uc.uc_mcontext.arm_r1, err);
-	__put_user_error(regs->ARM_r2, &sf->uc.uc_mcontext.arm_r2, err);
-	__put_user_error(regs->ARM_r3, &sf->uc.uc_mcontext.arm_r3, err);
-	__put_user_error(regs->ARM_r4, &sf->uc.uc_mcontext.arm_r4, err);
-	__put_user_error(regs->ARM_r5, &sf->uc.uc_mcontext.arm_r5, err);
-	__put_user_error(regs->ARM_r6, &sf->uc.uc_mcontext.arm_r6, err);
-	__put_user_error(regs->ARM_r7, &sf->uc.uc_mcontext.arm_r7, err);
-	__put_user_error(regs->ARM_r8, &sf->uc.uc_mcontext.arm_r8, err);
-	__put_user_error(regs->ARM_r9, &sf->uc.uc_mcontext.arm_r9, err);
-	__put_user_error(regs->ARM_r10, &sf->uc.uc_mcontext.arm_r10, err);
-	__put_user_error(regs->ARM_fp, &sf->uc.uc_mcontext.arm_fp, err);
-	__put_user_error(regs->ARM_ip, &sf->uc.uc_mcontext.arm_ip, err);
-	__put_user_error(regs->ARM_sp, &sf->uc.uc_mcontext.arm_sp, err);
-	__put_user_error(regs->ARM_lr, &sf->uc.uc_mcontext.arm_lr, err);
-	__put_user_error(regs->ARM_pc, &sf->uc.uc_mcontext.arm_pc, err);
-	__put_user_error(regs->ARM_cpsr, &sf->uc.uc_mcontext.arm_cpsr, err);
-
-	__put_user_error(current->thread.trap_no, &sf->uc.uc_mcontext.trap_no, err);
-	__put_user_error(current->thread.error_code, &sf->uc.uc_mcontext.error_code, err);
-	__put_user_error(current->thread.address, &sf->uc.uc_mcontext.fault_address, err);
-	__put_user_error(set->sig[0], &sf->uc.uc_mcontext.oldmask, err);
+	context = (struct sigcontext) {
+		.arm_r0        = regs->ARM_r0,
+		.arm_r1        = regs->ARM_r1,
+		.arm_r2        = regs->ARM_r2,
+		.arm_r3        = regs->ARM_r3,
+		.arm_r4        = regs->ARM_r4,
+		.arm_r5        = regs->ARM_r5,
+		.arm_r6        = regs->ARM_r6,
+		.arm_r7        = regs->ARM_r7,
+		.arm_r8        = regs->ARM_r8,
+		.arm_r9        = regs->ARM_r9,
+		.arm_r10       = regs->ARM_r10,
+		.arm_fp        = regs->ARM_fp,
+		.arm_ip        = regs->ARM_ip,
+		.arm_sp        = regs->ARM_sp,
+		.arm_lr        = regs->ARM_lr,
+		.arm_pc        = regs->ARM_pc,
+		.arm_cpsr      = regs->ARM_cpsr,
+
+		.trap_no       = current->thread.trap_no,
+		.error_code    = current->thread.error_code,
+		.fault_address = current->thread.address,
+		.oldmask       = set->sig[0],
+	};
+
+	err |= __copy_to_user(&sf->uc.uc_mcontext, &context, sizeof(context));
 
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
 
-- 
2.19.1



