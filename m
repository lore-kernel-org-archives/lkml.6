Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724B0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315D421773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549987933;
	bh=M9BzOKcjSHrnF/hxoyZFdVlh1Oa72HK6z/2/YIL0ijY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pwaLgPhnEoaDekwQWSG1nTzgmdgZUJyvzJ7QzS0Gf0JBPm0w8xq0VdXmL1T9w2a8w
	 MoKRQnPu5K++lv/HKPidydwu0yue3ritFpImo+K6zXaFlqKelEEgbsL3td18nRnNkO
	 SyffnfEB7ulYPLj7HKhZUuI4DFQsOu+gwxRUuisE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfBLQML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbfBLQML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:12:11 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 508B8217D9;
        Tue, 12 Feb 2019 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549987930;
        bh=M9BzOKcjSHrnF/hxoyZFdVlh1Oa72HK6z/2/YIL0ijY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0QS+CdjObBH06OCVvng/Ai/JPUVrXlQB/VHsr3Lqjl/th2rrx3NN76fr+tibisFJH
         zRc7sx5ne7Bav1IBhkKco93CwcwyS47XT+mcRNJyCuPkGV47yiT/vs5tfABFgxVnfN
         a0S1d7EuXumL1B0/z5BgPJNFLRXVG1rssgvGeevk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 02/10] x86/kprobes: Move trampoline code into RODATA
Date:   Wed, 13 Feb 2019 01:11:47 +0900
Message-Id: <154998790744.31052.3016106262944915510.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move optprobe trampoline code into RODATA since it is
not executed, but copied and modified to be used on
a trampoline buffer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/opt.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 544bd41a514c..f14262952015 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -97,6 +97,7 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 }
 
 asm (
+			".pushsection .rodata\n"
 			"optprobe_template_func:\n"
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
@@ -136,16 +137,10 @@ asm (
 #endif
 			".global optprobe_template_end\n"
 			"optprobe_template_end:\n"
-			".type optprobe_template_func, @function\n"
-			".size optprobe_template_func, .-optprobe_template_func\n");
+			".popsection\n");
 
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
-NOKPROBE_SYMBOL(optprobe_template_func);
-NOKPROBE_SYMBOL(optprobe_template_entry);
-NOKPROBE_SYMBOL(optprobe_template_val);
-NOKPROBE_SYMBOL(optprobe_template_call);
-NOKPROBE_SYMBOL(optprobe_template_end);
 
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)

