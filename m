Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78707217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986285;
	bh=cOkRumOfvL1eFJehoxj9QVbXEqGehq/bppBluJ7ALYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPrtYUY4pvMPnSe5Cs/UpeXl1zq5QxxgkIGXhiiqSiL4Me1kj3qx8VbTa8ULcTaU6
	 MPXDqNqhKYzT2AppS82xvs+NdASgfap5TlIOXDYdVf6JwNw67D8ut2/IFCAztKV5QS
	 kOwJsS99GNanbHQSqMr3+sjyUTORWCgloj8uyTKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfBLPon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:44:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B6721773;
        Tue, 12 Feb 2019 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986282;
        bh=cOkRumOfvL1eFJehoxj9QVbXEqGehq/bppBluJ7ALYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfMfzuh38/J16K+MtphMf6srnr1Z1IgO3uGeDgtAPJi+v3HMr3C6XIuLhiqTwMJsc
         AsNim30goU8qLCIYeMWuFeXE/dHghMQ2pJbEhIMoDgA17dwqEUJ0uvIsGvWlV7Xu/i
         e6qJmmfoou+P97aufw3gbnxNZWb8C+J5aruSfDio=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 3/4] arm64: kprobes: Move exception_text check in blacklist
Date:   Wed, 13 Feb 2019 00:44:19 +0900
Message-Id: <154998625948.21869.8505204111913908807.stgit@devbox>
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

Move exception/irqentry text address check in blacklist,
since those are symbol based rejection.

If we prohibit probing on the symbols in exception_text,
those should be blacklisted.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bd06b4b13fa9..194262fca5cd 100644
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
 
@@ -477,7 +474,8 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 	    (addr >= (unsigned long)__idmap_text_start &&
 	    addr < (unsigned long)__idmap_text_end) ||
 	    (addr >= (unsigned long)__hyp_text_start &&
-	    addr < (unsigned long)__hyp_text_end))
+	    addr < (unsigned long)__hyp_text_end) ||
+	    in_exception_text(addr))
 		return true;
 
 	if (!is_kernel_in_hyp_mode()) {

