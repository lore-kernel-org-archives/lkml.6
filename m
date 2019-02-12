Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA5DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4D32186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549986256;
	bh=sozzUq5udjjfXAJamYZwgE+8GtztlIavIM+cKXa/iww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4DYDAGvKDY6J3/ZkdoRnJI9+5lSumsMgFYjFZzcvPcJgWZ4XO/4lgKgXPFLg7mJJ
	 4uyrG+o0aTAIIs/UCwf6/GVntZsWOKwNF/vVaEnddyq1MQwv9YKWRqUbHK9UYHcduB
	 +Es+8bdC2JljbapKUJ6xrzzF85qSBb4AJRhu5DvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfBLPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBLPoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:44:15 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F181721773;
        Tue, 12 Feb 2019 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549986254;
        bh=sozzUq5udjjfXAJamYZwgE+8GtztlIavIM+cKXa/iww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pq2FDpp7szFKKhOQOARBg/KLBThPob7NRfIWGjhiTSrZY8G5t95BsRivD9gYI+Tgn
         c+VGDTH51gvD8Z06pnanuUcrq80oRbnn5OTNr2lPE2vHiZeVf4BfcQFbopH16Sd8PL
         jyyCK53ztWZFzMtPg2fkC2kn18C6EuwHyo1sdT/w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 2/4] arm64: kprobes: Remove unneeded RODATA check
Date:   Wed, 13 Feb 2019 00:43:51 +0900
Message-Id: <154998623104.21869.15264079902544102514.stgit@devbox>
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

Remove unneeded RODATA check from arch_prepare_kprobe().

Since check_kprobe_address_safe() already ensured that
the probe address is in kernel text, we don't need to
check whether the address in RODATA or not. That must
be always false.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 9989ec9baa11..bd06b4b13fa9 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -91,8 +91,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
-	extern char __start_rodata[];
-	extern char __end_rodata[];
 
 	if (probe_addr & 0x3)
 		return -EINVAL;
@@ -106,10 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (search_exception_tables(probe_addr))
 		return -EINVAL;
 
-	if (probe_addr >= (unsigned long) __start_rodata &&
-	    probe_addr <= (unsigned long) __end_rodata)
-		return -EINVAL;
-
 	/* decode instruction */
 	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
 	case INSN_REJECTED:	/* insn not supported */

