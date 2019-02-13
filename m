Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF7C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A215222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbfBMCHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfBMCHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:07:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9F8222C1;
        Wed, 13 Feb 2019 02:07:46 +0000 (UTC)
Date:   Tue, 12 Feb 2019 21:07:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [GIT PULL] tracing: probeevent: Correctly update remaining space in
 dynamic area
Message-ID: <20190212210745.50878316@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This fixes kprobes/uprobes dynamic processing of strings, where
it processes the args but does not update the remaining length
of the buffer that the string arguments will be placed in. It
constantly passes in the total size of buffer used instead of
passing in the remaining size of the buffer used. This could cause
issues if the strings are larger than the max size of an event
which could cause the strings to be written beyond what was reserved
on the buffer.


Please pull the latest trace-v5.0-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.0-rc4

Tag SHA1: 2ed4d789cd16de14657339cec2bbeb5ce3cc192f
Head SHA1: f6675872db57305fa957021efc788f9983ed3b67


Andreas Ziegler (1):
      tracing: probeevent: Correctly update remaining space in dynamic area

----
 kernel/trace/trace_probe_tmpl.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---------------------------
commit f6675872db57305fa957021efc788f9983ed3b67
Author: Andreas Ziegler <andreas.ziegler@fau.de>
Date:   Wed Feb 6 20:00:13 2019 +0100

    tracing: probeevent: Correctly update remaining space in dynamic area
    
    Commit 9178412ddf5a ("tracing: probeevent: Return consumed
    bytes of dynamic area") improved the string fetching
    mechanism by returning the number of required bytes after
    copying the argument to the dynamic area. However, this
    return value is now only used to increment the pointer
    inside the dynamic area but misses updating the 'maxlen'
    variable which indicates the remaining space in the dynamic
    area.
    
    This means that fetch_store_string() always reads the *total*
    size of the dynamic area from the data_loc pointer instead of
    the *remaining* size (and passes it along to
    strncpy_from_{user,unsafe}) even if we're already about to
    copy data into the middle of the dynamic area.
    
    Link: http://lkml.kernel.org/r/20190206190013.16405-1-andreas.ziegler@fau.de
    
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: stable@vger.kernel.org
    Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
    Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 5c56afc17cf8..4737bb8c07a3 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -180,10 +180,12 @@ store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
 		ret = process_fetch_insn(arg->code, regs, dl, base);
-		if (unlikely(ret < 0 && arg->dynamic))
+		if (unlikely(ret < 0 && arg->dynamic)) {
 			*dl = make_data_loc(0, dyndata - base);
-		else
+		} else {
 			dyndata += ret;
+			maxlen -= ret;
+		}
 	}
 }
 
