Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4951EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1898C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545028873;
	bh=nNf0gTmJMa74Q9EkpaUfMP3gIptXZ/cJXADX5WaPAhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M8/GMKYrgRHBYS1uCyEEgJp7ucs3IQQbH/aZnerc1bKThjnQOicFTnscCp66oIt4+
	 D/yqCRJ/oNNYUZ670tZcIIjgtN60Jr56ZA+Uqebg6SDJBG/EBJ+CttlBELuG+RmLTR
	 km+vEkEyhnBmBd5HoSfJd6+nJkEwW05AzerfBrhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeLQGlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbeLQGlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:41:10 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7BDB21836;
        Mon, 17 Dec 2018 06:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545028869;
        bh=nNf0gTmJMa74Q9EkpaUfMP3gIptXZ/cJXADX5WaPAhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkoOTHrYJ8WM8dkS6/GQwr0GmQt7K938ULQ5uBIc5OdwxXukIxVIkyqV1b8SjIEvA
         vCUlYttBCfDQf3sikAMb8v33u+kO5QNyeTITCo7aRYpnyuoPclxlHucjMsNb3EzBsb
         Wg8wjkcAbMp47rdl5X6oJ4EFU8670r7D0ZWxms5w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: kprobes: Move extable address check into arch_prepare_kprobe()
Date:   Mon, 17 Dec 2018 15:40:46 +0900
Message-Id: <154502884653.30629.3172839440883293817.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154502881646.30629.9938335052821665530.stgit@devbox>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
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
Please do not blacklisting instructions on exception_table,
since it is a kind of architectural unsupported instruction.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

