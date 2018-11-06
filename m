Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB13C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CE820685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CE820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbeKFXhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388477AbeKFXhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:37:24 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE4320685;
        Tue,  6 Nov 2018 14:11:58 +0000 (UTC)
Date:   Tue, 6 Nov 2018 09:11:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing/kprobes: Fix strpbrk() argument order
Message-ID: <20181106091156.1a373d76@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Masami found a slight bug in his code where he transposed the arguments of a
call to strpbrk.

The reason this wasn't detected in our tests is that the only way this would
transpire is when a kprobe event with a symbol offset is attached to a
function that belongs to a module that isn't loaded yet. When the kprobe
trace event is added, the offset would be truncated after it was parsed,
and when the module is loaded, it would use the symbol without the offset
(as the nul character added by the parsing would not be replaced with the
original character).


Please pull the latest trace-v4.20-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.20-rc1

Tag SHA1: 112b3ade59dcaec85ec3402c4dd270e051b660dd
Head SHA1: ee474b81fe5aa5dc0faae920bf66240fbf55f891


Masami Hiramatsu (1):
      tracing/kprobes: Fix strpbrk() argument order

----
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit ee474b81fe5aa5dc0faae920bf66240fbf55f891
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Thu Nov 1 23:29:28 2018 +0900

    tracing/kprobes: Fix strpbrk() argument order
    
    Fix strpbrk()'s argument order, it must pass acceptable string
    in 2nd argument. Note that this can cause a kernel panic where
    it recovers backup character to code->data.
    
    Link: http://lkml.kernel.org/r/154108256792.2604.1816052586385217811.stgit@devbox
    
    Fixes: a6682814f371 ("tracing/kprobes: Allow kprobe-events to record module symbol")
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

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
