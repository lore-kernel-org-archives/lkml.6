Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C61220823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfBFTA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:00:27 -0500
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:46668 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfBFTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:00:27 -0500
Received: from faui49copter1 (faui49copter1.informatik.uni-erlangen.de [131.188.42.149])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 93F36548859;
        Wed,  6 Feb 2019 20:00:21 +0100 (CET)
Received: by faui49copter1 (sSMTP sendmail emulation); Wed, 06 Feb 2019 20:00:21 +0100
From:   Andreas Ziegler <andreas.ziegler@fau.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH v2 RESEND] tracing: probeevent: Correctly update remaining space in dynamic area
Date:   Wed,  6 Feb 2019 20:00:13 +0100
Message-Id: <20190206190013.16405-1-andreas.ziegler@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122152634.18957-1-andreas.ziegler@fau.de>
References: <20190122152634.18957-1-andreas.ziegler@fau.de>
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
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
v2: follow coding guidelines for braces

 kernel/trace/trace_probe_tmpl.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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

--
2.17.1

