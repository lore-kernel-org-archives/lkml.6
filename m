Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45218C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF9E21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAVMs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:48:59 -0500
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:59222 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbfAVMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:48:58 -0500
Received: from faui49copter1 (faui49copter1.informatik.uni-erlangen.de [131.188.42.149])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 70E65548040;
        Tue, 22 Jan 2019 13:48:53 +0100 (CET)
Received: by faui49copter1 (sSMTP sendmail emulation); Tue, 22 Jan 2019 13:48:53 +0100
From:   Andreas Ziegler <andreas.ziegler@fau.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH] tracing: probeevent: Correctly update remaining space in dynamic area
Date:   Tue, 22 Jan 2019 13:48:48 +0100
Message-Id: <20190122124848.17774-1-andreas.ziegler@fau.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 9178412ddf5a ("tracing: probeevent: Return consumed bytes of dynamic area")
Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 kernel/trace/trace_probe_tmpl.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 5c56afc17cf8..0cf953e47584 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -182,8 +182,10 @@ store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
 		ret = process_fetch_insn(arg->code, regs, dl, base);
 		if (unlikely(ret < 0 && arg->dynamic))
 			*dl = make_data_loc(0, dyndata - base);
-		else
+		else {
 			dyndata += ret;
+			maxlen -= ret;
+		}
 	}
 }
 
-- 
2.17.1

