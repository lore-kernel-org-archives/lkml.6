Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 206F8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9385208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9385208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756305AbeFOOnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:43:12 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35722 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756225AbeFOOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:43:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id BF6F318188FC4;
        Fri, 15 Jun 2018 16:43:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        stable@vger.kernel.org, Ritesh Raj Sarraf <rrs@researchut.com>
Subject: [PATCH 1/3] um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
Date:   Fri, 15 Jun 2018 16:42:54 +0200
Message-Id: <20180615144256.13343-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32bit UML used to define PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
own its own because many years ago not all libcs had these request codes
in their UAPI.
These days PTRACE_SYSEMU/_SINGLESTEP is well known and part of glibc
and our own define becomes problematic.

With change c48831d0eebf ("linux/x86: sync sys/ptrace.h with Linux 4.14
[BZ #22433]") glibc turned PTRACE_SYSEMU/_SINGLESTEP into a enum and
UML failed to build.

Let's drop our define and rely on the fact that every libc has
PTRACE_SYSEMU/_SINGLESTEP.

Cc: <stable@vger.kernel.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>
Reported-and-tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/shared/sysdep/ptrace_32.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index b94a108de1dc..ae00d22bce02 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -10,20 +10,10 @@
 
 static inline void update_debugregs(int seq) {}
 
-/* syscall emulation path in ptrace */
-
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
-#ifndef PTRACE_SYSEMU_SINGLESTEP
-#define PTRACE_SYSEMU_SINGLESTEP 32
-#endif
-
 #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
 #define UPT_SYSCALL_ARG3(r) UPT_DX(r)
-- 
2.13.6

