Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A938C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CC221773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986314;
	bh=uyCwuVK7m1EdKUW1jMDgbNHxoIArsqofJ5gDugVV8so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sz0TZcn/opYe2fUsJXMECPCqrr/Do7AzbZFbf55cxe7cC1DqNMcfh1j9woaHDD8jh
	 4YgiCBo4GiAUupX+jJq/6H+z6Mz7POs2MnvxP6I5RSJHzbP1jC+cglJAVJxgF+8p6Q
	 xCHuxGiQ4Z64rlT31UpoRce4HNwXG8nTb/g9g9i4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfBLPpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:45:12 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39F121773;
        Tue, 12 Feb 2019 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986311;
        bh=uyCwuVK7m1EdKUW1jMDgbNHxoIArsqofJ5gDugVV8so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zef25u1hDtnYTLdkMiNpVudl6DEgCBtDSb4Dc9n7UyMXLYUng/E7V9lbZx8aud2gY
         Z5yKina+DtMLWT/B3TuRIbF3FG/ndbReqhtIhl4JTqybDngkMEZ6A3DpXAbhbipCRa
         J1UGfkVzOfqfZM6H+wGNuDF7f/TLuqkeIB0uRhFw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 4/4] arm64: kprobes: Use arch_populate_kprobe_blacklist()
Date:   Wed, 13 Feb 2019 00:44:48 +0900
Message-Id: <154998628802.21869.4041705065539411318.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998617300.21869.11457765723750331236.stgit@devbox>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
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
  Changes in v3
   - Do not populate blacklist in __kprobe_text in
     arch_populate_kprobe_blacklist(), since it is already
     populated in populate_kprobe_blacklist().
   - Add exception entry text blacklist since those are rejected
     by in_exception_text().
---
 arch/arm64/kernel/probes/kprobes.c |   45 +++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 194262fca5cd..37d913f33a89 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -465,26 +465,33 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
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
-	    (addr >= (unsigned long)__hyp_text_start &&
-	    addr < (unsigned long)__hyp_text_end) ||
-	    in_exception_text(addr))
-		return true;
-
-	if (!is_kernel_in_hyp_mode()) {
-		if ((addr >= (unsigned long)__hyp_idmap_text_start &&
-		    addr < (unsigned long)__hyp_idmap_text_end))
-			return true;
-	}
-
-	return false;
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
+					(unsigned long)__entry_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					(unsigned long)__irqentry_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__exception_text_start,
+					(unsigned long)__exception_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
+					(unsigned long)__idmap_text_end);
+	if (ret)
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
+					(unsigned long)__hyp_text_end);
+	if (ret || is_kernel_in_hyp_mode())
+		return ret;
+	ret = kprobe_add_area_blacklist((unsigned long)__hyp_idmap_text_start,
+					(unsigned long)__hyp_idmap_text_end);
+	return ret;
 }
 
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)

