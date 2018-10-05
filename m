Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F262C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5E208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RS1gRwgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE5E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeJFEUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:20:09 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:36068 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJFEUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:20:09 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7806710C0A70;
        Fri,  5 Oct 2018 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538774377; bh=tDzuuME0GaDD8mj1n0Jn2SE0+gTmpd+ZjEhD4sQaywU=;
        h=From:To:CC:Subject:Date:From;
        b=RS1gRwgW0CWddBXRjaGD5kh5t6WNMeInxmVTyOq68KwqJL6qiaCYHNllJbYCHG1gO
         +sgc5xVxi2EZNOYUBrLRARS3cgSy1BDPDQct0D69jRLoA8gN4GVdkYAzpqpnkigTqL
         EMjEYCuuVnyb7C9KITtfouvnPopM8qgbqBxvgDFMr70DaiB44b0b4Q6HKpGMgb9o+G
         ZUVfSV0okU3R0kPJKfxzwUHWIHs4ABV2GbU9JgJc+Gr4Ly/K7DiGisM0kb6sTvSaLo
         Iaqvm4sSM0y6uq7WY1aiv3hcYoezwqt+RY1tjAplRAY6TuQdCipxVcmeX6c4cpnhjK
         Lm/2hMYDrnbyA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 26C1735BE;
        Fri,  5 Oct 2018 14:19:36 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 5 Oct 2018 14:19:36 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 6 Oct 2018 02:49:32 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.73) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 6 Oct 2018 02:49:32 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <alexey.brodkin@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] ARC: clone syscall to setp r25 as thread pointer
Date:   Fri, 5 Oct 2018 14:19:21 -0700
Message-ID: <1538774361-9306-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.73]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per ARC TLS ABI, r25 is designated TP (thread pointer register).
However so far kernel didn't do any special treatment, like setting up
usermode r25, even for CLONE_SETTLS. We instead relied on libc runtime
to do this, in say clone libc wrapper [1]. This was deliberate to keep
kernel ABI agnostic (userspace could potentially change TP, specially
for different ARC ISA say ARCompact vs. ARCv2 with different spare
registers etc)

However userspace setting up r25, after clone syscall opens a race, if
child is not scheduled and gets a signal instead. It starts off in
userspace not in clone but in a signal handler and anything TP sepcific
there such as pthread_self() fails which showed up with uClibc
testsuite nptl/tst-kill6 [2]

Fix this by having kernel populate r25 to TP value. So this locks in
ABI, but it was not going to change anyways, and fwiw is same for both
ARCompact (arc700 core) and ARCvs (HS3x cores)

[1] https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/tree/libc/sysdeps/linux/arc/clone.S
[2] https://github.com/wbx-github/uclibc-ng-test/blob/master/test/nptl/tst-kill6.c

Fixes: ARC STAR 9001378481
Cc: stable@vger.kernel.org
Reported-by: Nikita Sobolev <sobolev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/process.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 4674541eba3f..c29fa8ceb2d6 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -241,6 +241,26 @@ int copy_thread(unsigned long clone_flags,
 		task_thread_info(current)->thr_ptr;
 	}
 
+
+	/*
+	 * setup usermode thread pointer #1:
+	 * when child is picked by scheduler, __switch_to() uses @c_callee to
+	 * populate usermode callee regs: this is fine even despite being in a
+	 * kernel function since special return path for child @ret_from_fork()
+	 * ensures those regs are not clobbered all the way to RTIE to usermode
+	 */
+	c_callee->r25 = task_thread_info(p)->thr_ptr;
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/*
+	 * setup usermode thread pointer #2:
+	 *   however for this special use of r25 in kernel, __switch_to() sets
+	 *   r25 for kernel needs and only in the final return path is usermode
+	 *   r25 setup, from pt_regs->user_r25. So set that up as well
+	 */
+	c_regs->user_r25 = c_callee->r25;
+#endif
+
 	return 0;
 }
 
-- 
2.7.4

