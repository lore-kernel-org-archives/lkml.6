Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C371C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2CD2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545034940;
	bh=q1ieTWvagMn6dWu5JFlMmZaHuRe06eqQjH4kDM/vd7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPEoYRW8xyIJQOQ1nXzXpod/9woRH/EGD31gLyT9WWbIEnhR0gVJGS24Oal2wtEZq
	 4odT/xcavi/41IB5+dzgp38AXmmt8ij8U7K3X6WJ0DltYYDYGJse0mn97zAKBXOKwD
	 yeaiInwl7AzouKepfhjGWvw3brhmE3U/z3Wpv8T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbeLQIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeLQIWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:22:18 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5C720672;
        Mon, 17 Dec 2018 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545034937;
        bh=q1ieTWvagMn6dWu5JFlMmZaHuRe06eqQjH4kDM/vd7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQh7lDD0j7sK2p5hu1eD3CpX7WV0MW+KolliySnMr06h/fPB+AgWaq2GYaztHZX9v
         FFBmG5s/mx8BWh5p3d6b4DJJXQVcBrLFPd1y7Aufi7Fta391Nmpw5bxX6ZmR39RUEp
         VOTW/JZgEKDc4kD+B8r30bBSfneUsRd77zAOgU6Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Andrea Righi <righi.andrea@gmail.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] x86/kprobes: Remove unneeded arch_within_kprobe_blacklist from x86
Date:   Mon, 17 Dec 2018 17:21:53 +0900
Message-Id: <154503491354.26176.13903264647254766066.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154503482486.26176.6224515860220847638.stgit@devbox>
References: <154503482486.26176.6224515860220847638.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove x86 specific arch_within_kprobe_blacklist().

Since we have already added all blacklisted symbols to
kprobe blacklist by arch_populate_kprobe_blacklist(),
we don't need arch_within_kprobe_blacklist() on x86
anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 2a291fcb6443..4ba75afba527 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1026,14 +1026,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 }
 NOKPROBE_SYMBOL(kprobe_fault_handler);
 
-bool arch_within_kprobe_blacklist(unsigned long addr)
-{
-	return  (addr >= (unsigned long)__kprobes_text_start &&
-		 addr < (unsigned long)__kprobes_text_end) ||
-		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
-}
-
 int __init arch_populate_kprobe_blacklist(void)
 {
 	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,

