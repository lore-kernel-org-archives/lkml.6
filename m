Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313E2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E188E20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E188E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936005AbeFRIYE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935974AbeFRIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 693DAC5C;
        Mon, 18 Jun 2018 08:23:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 188/279] powerpc/trace/syscalls: Update syscall name matching logic
Date:   Mon, 18 Jun 2018 10:12:53 +0200
Message-Id: <20180618080616.710967415@linuxfoundation.org>
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

[ Upstream commit 0b7758aaf6543b9a10c8671db559e9d374a3fd95 ]

On powerpc64 ABIv1, we are enabling syscall tracing for only ~20
syscalls. This is due to commit e145242ea0df6 ("syscalls/core,
syscalls/x86: Clean up syscall stub naming convention") which has
changed the syscall entry wrapper prefix from "SyS" to "__se_sys".

Update the logic for ABIv1 to not just skip the initial dot, but also
the "__se_sys" prefix.

Fixes: commit e145242ea0df6 ("syscalls/core, syscalls/x86: Clean up syscall stub naming convention")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/ftrace.h |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -73,13 +73,9 @@ struct dyn_arch_ftrace {
 #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
 static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
 {
-	/*
-	 * Compare the symbol name with the system call name. Skip the .sys or .SyS
-	 * prefix from the symbol name and the sys prefix from the system call name and
-	 * just match the rest. This is only needed on ppc64 since symbol names on
-	 * 32bit do not start with a period so the generic function will work.
-	 */
-	return !strcmp(sym + 4, name + 3);
+	/* We need to skip past the initial dot, and the __se_sys alias */
+	return !strcmp(sym + 1, name) ||
+		(!strncmp(sym, ".__se_sys", 9) && !strcmp(sym + 6, name));
 }
 #endif
 #endif /* CONFIG_FTRACE_SYSCALLS && !__ASSEMBLY__ */


