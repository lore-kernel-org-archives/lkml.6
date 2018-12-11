Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3258AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E007820855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491534;
	bh=pJIVFydXReMtbU0T7fKO5kqX4ncJ+Iq/R4Q2AgQm62A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u/JrSlxfAL31xPG/g2qXZovLEffoeRu3gVshMPdPNT4eTlk3lxAwV+HgMvbgt/d79
	 Uq4yL+aZ1BHEG1NYyWJ8r5fT3P4G1vUF9ThqeQY5M7bzC1cZXYvStEu3fqPT7Ln2DT
	 YSETvGeHhNJ+pVYJAZ2zf/u4z9Wk60KDrOn/LaMA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E007820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeLKBZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbeLKBZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:25:32 -0500
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F74E2081F;
        Tue, 11 Dec 2018 01:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544491531;
        bh=pJIVFydXReMtbU0T7fKO5kqX4ncJ+Iq/R4Q2AgQm62A=;
        h=From:To:Cc:Subject:Date:From;
        b=SSPj/YOQXAAA/w/JSMJDPm60ByRIGpiiSY4pkMFuMAG8RxJ29LGjRL09yN18VbwW6
         Bmd6isq7p4fC0vrvhGVYfwrBkBMr74I2qgVaW1Fglboth4ufBnnk8C79rh9ZNKViSJ
         9E2Ebn4+cXXt3BU/KO+FVKNwPqtzGhonNzPYUNAA=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/syscalls: Use the compat versions of rt_sigsuspend() and rt_sigprocmask()
Date:   Mon, 10 Dec 2018 17:25:29 -0800
Message-Id: <5debcb065386c1762566d9429d7576b9f91f5eaf.1544491480.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on some code that detects at build time if there's a
COMPAT_SYSCALL_DEFINE() that is not referenced in the x86 syscall
tables.  It catches three offenders: rt_sigsuspend(),
rt_sigprocmask(), and sendfile64().

For rt_sigsuspend() and rt_sigprocmask(), the only potential
difference between the native and compat versions is that the compat
version converts the sigset_t, but, on little endian architectures,
the conversion is a no-op.  This is why they both currently work on
x86.

To make the code more consistent, and to make my upcoming patches
work, this patch rewires x86 to use the compat vesions.

sendfile64() is more complicated, and I'll address it separately.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 3cf7b533b3d1..8f6b771606e6 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -186,11 +186,11 @@
 172	i386	prctl			sys_prctl			__ia32_sys_prctl
 173	i386	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
 174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
-175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_sys_rt_sigprocmask
+175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
 176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
 177	i386	rt_sigtimedwait		sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait
 178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
-179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_sys_rt_sigsuspend
+179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
 180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
 181	i386	pwrite64		sys_pwrite64			__ia32_compat_sys_x86_pwrite
 182	i386	chown			sys_chown16			__ia32_sys_chown16
-- 
2.17.2

