Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954DFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A8020868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWOqRYw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A8020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeK2QoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbeK2QoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:44:05 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A426C206B6;
        Thu, 29 Nov 2018 05:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543469997;
        bh=bF4Zs7p5EpO8j1jDIGbTNa7ZYpVtFb2o+SRkbs8nJb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nWOqRYw2j1A9YZ/YdkCFIRmoDsBvnPlnqtIiqJmrVs4YuJNZCWJNqjbt6ru8by2i1
         UG6JetO6zTUNIeKkOiwDn9JBKqUgNHV0LxoZbkXZXQRN+M2DzbnvT7ykQqvcfQpbiV
         YjaD/zd97xZlPf1ubU0eiGrDTTjbKzJ8PzB9u2h4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] arm64: ftrace: Fix to enable syscall events on arm64
Date:   Thu, 29 Nov 2018 14:39:33 +0900
Message-Id: <154346997347.21404.9819884326251206341.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181128195921.GA32668@arm.com>
References: <20181128195921.GA32668@arm.com>
In-Reply-To: <20181128195921.GA32668@arm.com>
References: <20181128195921.GA32668@arm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4378a7d4be30 ("arm64: implement syscall wrappers")
introduced "__arm64_" prefix to all syscall wrapper symbols in
sys_call_table, syscall tracer can not find corresponding
metadata from syscall name. In the result, we have no syscall
ftrace events on arm64 kernel, and some bpf testcases are failed
on arm64.

To fix this issue, this introduces custom
arch_syscall_match_sym_name() which skips first 8 bytes when
comparing the syscall and symbol names.

Fixes: 4378a7d4be30 ("arm64: implement syscall wrappers")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/ftrace.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index caa955f10e19..fac54fb050d0 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -56,6 +56,19 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
 	return is_compat_task();
 }
+
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	/*
+	 * Since all syscall functions have __arm64_ prefix, we must skip it.
+	 * However, as we described above, we decided to ignore compat
+	 * syscalls, so we don't care about __arm64_compat_ prefix here.
+	 */
+	return !strcmp(sym + 8, name);
+}
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* __ASM_FTRACE_H */

