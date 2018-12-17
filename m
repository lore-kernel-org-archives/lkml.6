Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A459C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4A217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545028900;
	bh=0xtxfZtFdIUmaXPj2hBVcHLm0ZupOdVKMg42UdHhv0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EttvFYUASEGEHOAiyYk9bMbExE1wq8vVdS7dJuUWI93T/KdKaV9wXGqJ9eYMVZVvL
	 lOR0ehzWoWsLOtbooHzotf3glUAX//X+Foo2TQRoSq69C10p2HU3tSEKVPSMtMcvpk
	 KM31b74GAgWnpIF/EaaC+Spw/V3pNzqEVoCWRIGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeLQGlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeLQGli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:41:38 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4591820675;
        Mon, 17 Dec 2018 06:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545028898;
        bh=0xtxfZtFdIUmaXPj2hBVcHLm0ZupOdVKMg42UdHhv0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7XHocSnVx+0Xra04NV3H5XEkQO0w0dGwg7DW9YnHqDAH4+2kQHIXXJA7bu6l906K
         b1UDTnU8XZA1ooJNxsoSwFFGgdJ7cHSOTEQyh1fr1UdIN+MeZoUJroxWFFwpVwzGRq
         8eRdPK6OVNR90BgNON2fBzS5NoU59EpJxQo2NEr4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: kprobes: Remove unneeded RODATA check
Date:   Mon, 17 Dec 2018 15:41:15 +0900
Message-Id: <154502887509.30629.17754148993239954461.stgit@devbox>
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
index b2d4b7428ebc..1dae500d0a81 100644
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

