Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D5DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB45A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB45A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936021AbeFRIYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935862AbeFRIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4AA79C74;
        Mon, 18 Jun 2018 08:24:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 189/279] powerpc/trace/syscalls: Update syscall name matching logic to account for ppc_ prefix
Date:   Mon, 18 Jun 2018 10:12:54 +0200
Message-Id: <20180618080616.748461868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

[ Upstream commit edf6a2dfe3889daf97e7c164891a87832169e3e4 ]

Some syscall entry functions on powerpc are prefixed with
ppc_/ppc32_/ppc64_ rather than the usual sys_/__se_sys prefix. fork(),
clone(), swapcontext() are some examples of syscalls with such entry
points. We need to match against these names when initializing ftrace
syscall tracing.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/ftrace.h |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -69,13 +69,30 @@ struct dyn_arch_ftrace {
 #endif
 
 #if defined(CONFIG_FTRACE_SYSCALLS) && !defined(__ASSEMBLY__)
-#ifdef PPC64_ELF_ABI_v1
+/*
+ * Some syscall entry functions on powerpc start with "ppc_" (fork and clone,
+ * for instance) or ppc32_/ppc64_. We should also match the sys_ variant with
+ * those.
+ */
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+#ifdef PPC64_ELF_ABI_v1
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
 	/* We need to skip past the initial dot, and the __se_sys alias */
 	return !strcmp(sym + 1, name) ||
-		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name));
+		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name)) ||
+		(!strncmp(sym, ".ppc_", 5) && !strcmp(sym + 5, name + 4)) ||
+		(!strncmp(sym, ".ppc32_", 7) && !strcmp(sym + 7, name + 4)) ||
+		(!strncmp(sym, ".ppc64_", 7) && !strcmp(sym + 7, name + 4));
+}
+#else
+static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
+{
+	return !strcmp(sym, name) ||
+		(!strncmp(sym, "__se_sys", 8) && !strcmp(sym + 5, name)) ||
+		(!strncmp(sym, "ppc_", 4) && !strcmp(sym + 4, name + 4)) ||
+		(!strncmp(sym, "ppc32_", 6) && !strcmp(sym + 6, name + 4)) ||
+		(!strncmp(sym, "ppc64_", 6) && !strcmp(sym + 6, name + 4));
 }
 #endif
 #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */


