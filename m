Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D56C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BFB21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2j6WMyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BFB21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbeK1D2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:28:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbeK1D2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:28:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485402086B;
        Tue, 27 Nov 2018 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543336208;
        bh=5pIDoNeCp+J91aQi1o2Eg311Dc06d02HsfLnNhAisuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Q2j6WMyP03KHw7MhR8QUIvsbPTz7PokVRFRtSrJmgVwylUygBph3eDt6S8VqQYxf6
         S9N9B8WXcMHIsgBtTAIkRbY+6bVNM9S+FUUdkBrE8Vu+M7I0iHLqXT/1EQ+p3tGpsi
         /s/RLkXj5HC9kIM/K2zSuWJmUXkJTwCNHgkrAWJg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Date:   Wed, 28 Nov 2018 01:29:45 +0900
Message-Id: <154333618522.27355.8094935453351562295.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
In-Reply-To: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
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
Cc: stable@vger.kernel.org
---
 arch/arm64/include/asm/ftrace.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index caa955f10e19..a710f79db442 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -56,6 +56,15 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
 	return is_compat_task();
 }
+
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	/* Since all syscall functions have __arm64_ prefix, we must skip it */
+	return !strcmp(sym + 8, name);
+}
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* __ASM_FTRACE_H */

