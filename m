Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842F8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D3D2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547533559;
	bh=c3cvMz1HCpmGl/imOyH/ipMAfTvysPlZuDxCV5MItjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sEv1BNUPHh0Lrz8uGR2uSNjSMQQJKgp+mkPlGvYrY9TrEfc3Eg7KLFAYWHqpbVsaM
	 39CpVWKdtJn431jvBpIlwkd8qpiLYE0AwOWU7/dKojU66tctPWRkdTWC4SOsYJtOkk
	 UxiXGQYf8GuMSgxBcw8Fuv+6tHgFP+u0LnVpuYTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfAOGZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOGZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:25:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A105220651;
        Tue, 15 Jan 2019 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547533556;
        bh=c3cvMz1HCpmGl/imOyH/ipMAfTvysPlZuDxCV5MItjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiGtl9juScFfW2sBrGxgUaVX/ak2eqEJp8+NKHvesiTC9yjB2ELFuuKgqG4lsoYTh
         cGr30LDQpxgCucetQyrsnaDUnv5BZ/AUv90BUwc9lmNJpne7BcQxTPUbisWM8GQfID
         rjaxLB8UaByVvSqLzsMv1A518K6PF1sT6KunuTfc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 4/4] arm64: kprobes: Use arch_populate_kprobe_blacklist()
Date:   Tue, 15 Jan 2019 15:25:33 +0900
Message-Id: <154753353370.31541.14485875717131836689.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154753341900.31541.8135985235882849464.stgit@devbox>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use arch_populate_kprobe_blacklist() instead of
arch_within_kprobe_blacklist() so that we can see the full
blacklisted symbols under the debugfs.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |   42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index b9e9758b6534..6c066c34c8a4 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
 	return DBG_HOOK_HANDLED;
 }
 
-bool arch_within_kprobe_blacklist(unsigned long addr)
+int __init arch_populate_kprobe_blacklist(void)
 {
-	if ((addr >= (unsigned long)__kprobes_text_start &&
-	    addr < (unsigned long)__kprobes_text_end) ||
-	    (addr >= (unsigned long)__entry_text_start &&
-	    addr < (unsigned long)__entry_text_end) ||
-	    (addr >= (unsigned long)__idmap_text_start &&
-	    addr < (unsigned long)__idmap_text_end) ||
-	    in_exception_text(addr))
-		return true;
-
-	if (!is_kernel_in_hyp_mode()) {
-		if ((addr >= (unsigned long)__hyp_text_start &&
-		    addr < (unsigned long)__hyp_text_end) ||
-		    (addr >= (unsigned long)__hyp_idmap_text_start &&
-		    addr < (unsigned long)__hyp_idmap_text_end))
-			return true;
-	}
-
-	return false;
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
+					(unsigned long)__kprobes_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
+					(unsigned long)__entry_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
+					(unsigned long)__idmap_text_end);
+	if (ret || is_kernel_in_hyp_mode())
+		return ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
+					(unsigned long)__hyp_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_idmap_text_start,
+					(unsigned long)__hyp_idmap_text_end);
+	return ret;
 }
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)

