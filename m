Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA3DC43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6E621872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547259994;
	bh=8LZm9dNn3cys+j98zjuWUS3/y2IImFDWESUVHisUDgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ob3APC8G5t2pFMS3vSfUtNP4faVv2w3n6cL2n4RkhvBPIhi+BzoR47zNNMGf/UPPw
	 kux7vBKhRLJEDOVHSAjbvoUcxgq5jc34UNiZeeVTTTHNxJ1M4CN5OkiEEJESTlpi3Y
	 AbjVv5Sqf4QBJES004iHO/pGq03gO7bKWvFqq0/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfALC0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:26:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALC0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:26:32 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F1D20872;
        Sat, 12 Jan 2019 02:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547259991;
        bh=8LZm9dNn3cys+j98zjuWUS3/y2IImFDWESUVHisUDgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFdoqdXNAREgoJNv0aUZveP31L61yuKHwp1XtottSODlFI87e0Tvebr4UVh4JsUPV
         6r4ufcDswyMc8gRHN7CFyyGJain6hRTiT9B+7qR1ie+Tw6pIH8u9L8ZWMadQPhE5ZY
         oaesUYJm1ruUQdgOp1fU68fDe9sB4sqhimhue4i4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/9] x86/kprobes: Prohibit probing on optprobe template code
Date:   Sat, 12 Jan 2019 11:26:09 +0900
Message-Id: <154725996885.18060.7107278512876517981.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154725993986.18060.2759150647140353514.stgit@devbox>
References: <154725993986.18060.2759150647140353514.stgit@devbox>
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
Cc: stable@vger.kernel.org
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

