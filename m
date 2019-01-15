Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FE520861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547533473;
	bh=JMPzgJxn71Oh3CSPLMfjWsZVP7P3WH3Nj9DBNFncCNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qY4YPNiEiE8bDiD8w5PA2/FhDsiGFyy9TPm+7KhfQx1FCnz9woW6FQYad80pVq862
	 13qaEsOwU4ZPRYhgtR0IehOUMbTGjShe6CAN07cBR7ao/sZnbmcJsjlb6ScbrIx1sc
	 GM0k99G6Np2CvC65EvOFptM/GJK+gqoWyvfXTJ2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfAOGYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbfAOGYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:24:32 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C9A20651;
        Tue, 15 Jan 2019 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547533471;
        bh=JMPzgJxn71Oh3CSPLMfjWsZVP7P3WH3Nj9DBNFncCNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0d+QhrAA1raIo2uM8j525TaubAY8kIQauQJKDLhiGMRqVv7wWbq6kWjXGfmxsoX9
         NjbiDm+VqVFOQBA/Se3Wa+5BmE7KTsDD9dVaH/aQqtk8TKSR5vxfNesLDdvR8F+PSC
         IxwCzpAMu2a6FILbySzAk35WBJrHPMaoiYx+jvqM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 1/4] arm64: kprobes: Move extable address check into arch_prepare_kprobe()
Date:   Tue, 15 Jan 2019 15:24:08 +0900
Message-Id: <154753344814.31541.1870614689774287684.stgit@devbox>
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

Move extable address check into arch_prepare_kprobe() from
arch_within_kprobe_blacklist().
The blacklist is exposed via debugfs as a list of symbols.
The extable entries are smaller, so must be filtered out
by arch_prepare_kprobe().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 Update in v2:
  - Update commit message.
  - Add Reviewed-by from James.
---
 arch/arm64/kernel/probes/kprobes.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 2a5b338b2542..b2d4b7428ebc 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 	if (in_exception_text(probe_addr))
 		return -EINVAL;
+
+	if (search_exception_tables(probe_addr))
+		return -EINVAL;
+
 	if (probe_addr >= (unsigned long) __start_rodata &&
 	    probe_addr <= (unsigned long) __end_rodata)
 		return -EINVAL;
@@ -477,8 +481,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__entry_text_start &&
 	    addr < (unsigned long)__entry_text_end) ||
 	    (addr >= (unsigned long)__idmap_text_start &&
-	    addr < (unsigned long)__idmap_text_end) ||
-	    !!search_exception_tables(addr))
+	    addr < (unsigned long)__idmap_text_end))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {

