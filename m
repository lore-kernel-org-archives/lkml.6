Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A42C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A6520700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108403;
	bh=16/NLCUjNCfa7WW7VdRKNezTsBGzlvMXMLXY8O+j5bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XNPN2YkUGloN0uJMvgac8e2kNng5dyglG3O9Ho195ZRFFULyRrPoxwmjJbTvZBWDz
	 3hLs8Q3OWNC+j6AHPlGBeYiqNvyRju9a4ccr/6mvpafEOl9R2GEC1I0Bc7rAdTUcR4
	 mm83eJsIeFbDwwqeF5IgMEUXk727htcvTIGkwfug=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A6520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLFPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbeLFOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E536421527;
        Thu,  6 Dec 2018 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107262;
        bh=16/NLCUjNCfa7WW7VdRKNezTsBGzlvMXMLXY8O+j5bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8qrPvuJZNfsBf5FUUbqWDvn07O/evdDj/iwgxywEThww6vPGL4J4tAw+qf6P9GUZ
         8euhdjJEUzDZX9fNa/fzSnwuU8dJe+L8Ad/7mc/1wPLn1H4SnUNZJOYZ7XwWHzP3f7
         t8zY4DmRJg1XxU+CZ6r1ghubeqc7i31bo0P8xa00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.19 07/41] arm64: ftrace: Fix to enable syscall events on arm64
Date:   Thu,  6 Dec 2018 15:38:47 +0100
Message-Id: <20181206142950.287729112@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 874bfc6e5422d2421f7e4d5ea318d30e91679dfe upstream.

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
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/ftrace.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -56,6 +56,19 @@ static inline bool arch_trace_is_compat_
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


