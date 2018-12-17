Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E349C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696DD217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545034910;
	bh=fSaR4G2tYus4Zmr4TVJ/qDi3S9CVTICyVbR7ukSMuS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5e9kUQSMFO6Bxyvohe5kuv7ojjoVwtEjVjAmqM83fkmXLK/cicjw9uL1sIvLaRBG
	 ZhDsqgcfrIZLvA0i8fZmJ1VYY/pjAExMskvnYpd6v8yQ6szzcDHEBwE+jl6Z0FWGTh
	 iYJprJqTPSwPetukZp7egEYFCPca05uUjjrAjN9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbeLQIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeLQIVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:21:48 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FD6E20672;
        Mon, 17 Dec 2018 08:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545034908;
        bh=fSaR4G2tYus4Zmr4TVJ/qDi3S9CVTICyVbR7ukSMuS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AC53/yBsRIcTMm3w7y0qNJy8SnhkBmRo9SuAoXDPKi25We8OZYivcNspMac7buD6s
         hMEkT6/FQewB4iQoxweCW7C2Eb25n+vmCFDlpOY7hDnrrNC0mBaWKIyuU6aifqzOQ3
         OgftGP1DsHShn9OQ967dNqIAxeS0W0ZPrbcIP9cA=
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
Subject: [PATCH v2 2/3] x86/kprobes: Show x86-64 specific blacklisted symbols correctly
Date:   Mon, 17 Dec 2018 17:21:24 +0900
Message-Id: <154503488425.26176.17136784384033608516.stgit@devbox>
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

Show x86-64 specific blacklisted symbols in debugfs.
Since x86-64 prohibits probing on symbols which are in
entry text, those should be shown.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 308bf103cc73..2a291fcb6443 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1034,6 +1034,12 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
 		 addr < (unsigned long)__entry_text_end);
 }
 
+int __init arch_populate_kprobe_blacklist(void)
+{
+	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
+					 (unsigned long)__entry_text_end);
+}
+
 int __init arch_init_kprobes(void)
 {
 	return 0;

