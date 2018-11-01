Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32891C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF9205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjP8wKhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEF9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeKAXdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbeKAXdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:33:04 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2DDA205F4;
        Thu,  1 Nov 2018 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541082592;
        bh=KFIU1K1QVcHoR+w3k/YGDu2HbvtH4Xj2PcRFhc7bo/8=;
        h=From:To:Cc:Subject:Date:From;
        b=MjP8wKhA5AgTlSI0bvGhA/GfU5ATnddOLgGYCunO99mQe7DeY9fh1ktgKps8Ol8jO
         i0+FXfgwQcYnBY5oNL6S17lomhwQ0p+wojiS+2AgshjwPlHTBU2XJjiET1LjU1k/U4
         wt8dT42eCSoXWzCQSLslzUbgSRhtWorKyomMQugg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [BUGFIX PATCH] tracing/kprobes: Fix strpbrk() argument order
Date:   Thu,  1 Nov 2018 23:29:28 +0900
Message-Id: <154108256792.2604.1816052586385217811.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix strpbrk()'s argument order, it must pass acceptable string
in 2nd argument. Note that this can cause a kernel panic where
it recovers backup character to code->data.

Fixes: a6682814f371 ("tracing/kprobes: Allow kprobe-events to record module symbol")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 3ef15a6683c0..bd30e9398d2a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -535,7 +535,7 @@ int traceprobe_update_arg(struct probe_arg *arg)
 			if (code[1].op != FETCH_OP_IMM)
 				return -EINVAL;
 
-			tmp = strpbrk("+-", code->data);
+			tmp = strpbrk(code->data, "+-");
 			if (tmp)
 				c = *tmp;
 			ret = traceprobe_split_symbol_offset(code->data,

