Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E3CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3F22173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547088896;
	bh=GGKf920ODgI/vHFWCDyr0KzdW98/aCQsCNrGkZtU/Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IdbbCaUB2/rLdVqTB1Zvk6kDSVh5kbI72zZBFlJgYN3GLVyNKrBybEDee/4jgMstB
	 dQWxDhr45wVqJbCSErFeef5f7b+QMeQHHH8Kz2m/yGgvTEJvBcBS/uto+K+1b5jZ3C
	 RwmUj6PWUwGDm8W9LQELdKQSVnZqP0GFQmwt6+4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfAJCy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfAJCyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:54:54 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860D020665;
        Thu, 10 Jan 2019 02:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547088893;
        bh=GGKf920ODgI/vHFWCDyr0KzdW98/aCQsCNrGkZtU/Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhPIl7OeEZCRX5J08BbSS1JLBG0cc4tJznMy5EcEVrkw45V52bPeA89aORSoBbgk7
         aSP/2fsXtPZibninH50XBblNMYcwapmPdXQlP7bjbQezFSVRoO4b1ffEXhOy2K2XEL
         qebQZsnCWGP/glNGj1rZmxvL/j9SFM74GBsJm0w8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH 1/9] x86/kprobes: Prohibit probing on optprobe template code
Date:   Thu, 10 Jan 2019 11:54:30 +0900
Message-Id: <154708887054.6325.3201133039718891603.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154708884117.6325.4454464467156828009.stgit@devbox>
References: <154708884117.6325.4454464467156828009.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit probing on optprobe template code, since it is not
a code but a template instruction sequence. If we modify
this template, copied template must be broken.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 9326638cbee2 ("kprobes, x86: Use NOKPROBE_SYMBOL() instead of __kprobes annotation")
---
 arch/x86/kernel/kprobes/opt.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 6adf6e6c2933..544bd41a514c 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -141,6 +141,11 @@ asm (
 
 void optprobe_template_func(void);
 STACK_FRAME_NON_STANDARD(optprobe_template_func);
+NOKPROBE_SYMBOL(optprobe_template_func);
+NOKPROBE_SYMBOL(optprobe_template_entry);
+NOKPROBE_SYMBOL(optprobe_template_val);
+NOKPROBE_SYMBOL(optprobe_template_call);
+NOKPROBE_SYMBOL(optprobe_template_end);
 
 #define TMPL_MOVE_IDX \
 	((long)optprobe_template_val - (long)optprobe_template_entry)

