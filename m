Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 16E65C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB94A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB94A208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965879AbeFONYm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:24:42 -0400
Received: from mail.windriver.com ([147.11.1.11]:34936 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965713AbeFONYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:24:35 -0400
Received: from ala-blade48.wrs.com (ala-blade48.wrs.com [147.11.105.68])
        by mail.windriver.com (8.15.2/8.15.1) with SMTP id w5FDOOBX021295;
        Fri, 15 Jun 2018 06:24:25 -0700 (PDT)
Received: by ala-blade48.wrs.com (sSMTP sendmail emulation); Fri, 15 Jun 2018 06:24:24 -0700
From:   He Zhe <zhe.he@windriver.com>
To:     ralf@linux-mips.org, jhogan@kernel.org, ebiederm@xmission.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Fix build error by disabling attribute-alias warning
Date:   Fri, 15 Jun 2018 06:24:21 -0700
Message-Id: <20180615132421.2693-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following error caused by building arch/mips with
GCC 8.1.0.

In file included from arch/mips/kernel/signal32.c:15:
include/linux/syscalls.h:233:18: error: 'sys_32_sigaction' alias between functions of incompatible types 'long int(long int,  const struct compat_sigaction *, struct compat_sigaction *)' and 'long int(long int,  long int,  long int)' [-Werror=attribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/mips/kernel/signal32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
index c4db910a8794..95cb406e220d 100644
--- a/arch/mips/kernel/signal32.c
+++ b/arch/mips/kernel/signal32.c
@@ -35,6 +35,9 @@ asmlinkage int sys32_sigsuspend(compat_sigset_t __user *uset)
 	return compat_sys_rt_sigsuspend(uset, sizeof(compat_sigset_t));
 }
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wpragmas"
+#pragma GCC diagnostic ignored "-Wattribute-alias"
 SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *, act,
 	struct compat_sigaction __user *, oact)
 {
@@ -76,3 +79,4 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
 
 	return ret;
 }
+#pragma GCC diagnostic pop
-- 
2.11.0

