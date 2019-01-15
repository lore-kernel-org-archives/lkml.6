Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B246EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD1420651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547533531;
	bh=QM7XOsAU0i1KQFQo/n6k/OXJ89dL3NSEi3PjGHYFhXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e6phEE9fzrV8HdBRkHmhiPrla6Qcf21Lbbz5vUJE9K4t8fldSdHQLR5UqPpSCepyf
	 x8Nn8yK/6Nezs/aGyZsJBQ8fPdyQkAsv/iCG2CfV28+EfafL7bFTw9+RRDioE/7o/q
	 qutsBU40b8t7dsiawylci2VxHM6lBXR+CTQpfM84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfAOGZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfAOGZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:25:29 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC9C20651;
        Tue, 15 Jan 2019 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547533528;
        bh=QM7XOsAU0i1KQFQo/n6k/OXJ89dL3NSEi3PjGHYFhXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQnVjSJyhe5H/zxDjv/AU43qpcQRkrL87bktvAyvgQkOb/SIzsvOYaMnzFo6FPV/k
         JTRxeIgtVZEuVtbS/hBXTm/BZmzV2OShz/aebclSdn9Xey6nCKo3ZUZ4kOopD36/c8
         NgTD+FjYX8Css5AWdEYAUwYxAlqkQj0gfei6UecY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 3/4] arm64: kprobes: Move exception_text check in blacklist
Date:   Tue, 15 Jan 2019 15:25:05 +0900
Message-Id: <154753350520.31541.11995657762766497151.stgit@devbox>
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

Move exception/irqentry text address check in blacklist,
since those are symbol based rejection.

If we prohibit probing on the symbols in exception_text,
those should be blacklisted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 1dae500d0a81..b9e9758b6534 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -98,9 +98,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	/* copy instruction */
 	p->opcode = le32_to_cpu(*p->addr);
 
-	if (in_exception_text(probe_addr))
-		return -EINVAL;
-
 	if (search_exception_tables(probe_addr))
 		return -EINVAL;
 
@@ -475,7 +472,8 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__entry_text_start &&
 	    addr < (unsigned long)__entry_text_end) ||
 	    (addr >= (unsigned long)__idmap_text_start &&
-	    addr < (unsigned long)__idmap_text_end))
+	    addr < (unsigned long)__idmap_text_end) ||
+	    in_exception_text(addr))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {

