Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCDC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB136214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXUglza/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB136214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeLDLFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbeLDLFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77DB32082D;
        Tue,  4 Dec 2018 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921549;
        bh=2agyAhRmHKsiJpkIzmNMpk7j834hygIHbsIlJmYkooQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXUglza/iNimkadHauQNV1KtuV6AoMsP+j2WE7ib0mubVRiVNnvJgR5hCfC/Id7Bb
         i04feTzzWDUVwMkCO6kqO0m4Q8WgCvILjQ5iCfIvrhDxwvi0DJev3Uyk8fcG+I0Ee0
         a5vqwq9kZ684Q97RT4WrFRovr6iu+6/xN+NVjTn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.14 115/146] xtensa: fix coprocessor part of ptrace_{get,set}xregs
Date:   Tue,  4 Dec 2018 11:50:01 +0100
Message-Id: <20181204103731.453084448@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 38a35a78c5e270cbe53c4fef6b0d3c2da90dd849 upstream.

Layout of coprocessor registers in the elf_xtregs_t and
xtregs_coprocessor_t may be different due to alignment. Thus it is not
always possible to copy data between the xtregs_coprocessor_t structure
and the elf_xtregs_t and get correct values for all registers.
Use a table of offsets and sizes of individual coprocessor register
groups to do coprocessor context copying in the ptrace_getxregs and
ptrace_setxregs.
This fixes incorrect coprocessor register values reading from the user
process by the native gdb on an xtensa core with multiple coprocessors
and registers with high alignment requirements.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/kernel/ptrace.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -127,12 +127,37 @@ static int ptrace_setregs(struct task_st
 }
 
 
+#if XTENSA_HAVE_COPROCESSORS
+#define CP_OFFSETS(cp) \
+	{ \
+		.elf_xtregs_offset = offsetof(elf_xtregs_t, cp), \
+		.ti_offset = offsetof(struct thread_info, xtregs_cp.cp), \
+		.sz = sizeof(xtregs_ ## cp ## _t), \
+	}
+
+static const struct {
+	size_t elf_xtregs_offset;
+	size_t ti_offset;
+	size_t sz;
+} cp_offsets[] = {
+	CP_OFFSETS(cp0),
+	CP_OFFSETS(cp1),
+	CP_OFFSETS(cp2),
+	CP_OFFSETS(cp3),
+	CP_OFFSETS(cp4),
+	CP_OFFSETS(cp5),
+	CP_OFFSETS(cp6),
+	CP_OFFSETS(cp7),
+};
+#endif
+
 static int ptrace_getxregs(struct task_struct *child, void __user *uregs)
 {
 	struct pt_regs *regs = task_pt_regs(child);
 	struct thread_info *ti = task_thread_info(child);
 	elf_xtregs_t __user *xtregs = uregs;
 	int ret = 0;
+	int i __maybe_unused;
 
 	if (!access_ok(VERIFY_WRITE, uregs, sizeof(elf_xtregs_t)))
 		return -EIO;
@@ -140,8 +165,13 @@ static int ptrace_getxregs(struct task_s
 #if XTENSA_HAVE_COPROCESSORS
 	/* Flush all coprocessor registers to memory. */
 	coprocessor_flush_all(ti);
-	ret |= __copy_to_user(&xtregs->cp0, &ti->xtregs_cp,
-			      sizeof(xtregs_coprocessor_t));
+
+	for (i = 0; i < ARRAY_SIZE(cp_offsets); ++i)
+		ret |= __copy_to_user((char __user *)xtregs +
+				      cp_offsets[i].elf_xtregs_offset,
+				      (const char *)ti +
+				      cp_offsets[i].ti_offset,
+				      cp_offsets[i].sz);
 #endif
 	ret |= __copy_to_user(&xtregs->opt, &regs->xtregs_opt,
 			      sizeof(xtregs->opt));
@@ -157,6 +187,7 @@ static int ptrace_setxregs(struct task_s
 	struct pt_regs *regs = task_pt_regs(child);
 	elf_xtregs_t *xtregs = uregs;
 	int ret = 0;
+	int i __maybe_unused;
 
 	if (!access_ok(VERIFY_READ, uregs, sizeof(elf_xtregs_t)))
 		return -EFAULT;
@@ -166,8 +197,11 @@ static int ptrace_setxregs(struct task_s
 	coprocessor_flush_all(ti);
 	coprocessor_release_all(ti);
 
-	ret |= __copy_from_user(&ti->xtregs_cp, &xtregs->cp0,
-				sizeof(xtregs_coprocessor_t));
+	for (i = 0; i < ARRAY_SIZE(cp_offsets); ++i)
+		ret |= __copy_from_user((char *)ti + cp_offsets[i].ti_offset,
+					(const char __user *)xtregs +
+					cp_offsets[i].elf_xtregs_offset,
+					cp_offsets[i].sz);
 #endif
 	ret |= __copy_from_user(&regs->xtregs_opt, &xtregs->opt,
 				sizeof(xtregs->opt));


