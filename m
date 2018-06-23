Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B8C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC98924A76
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC98924A76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934635AbeFWBVm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934462AbeFWBVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:21:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A316E24A7B;
        Sat, 23 Jun 2018 01:21:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fWXEf-0008SJ-Lw; Fri, 22 Jun 2018 21:21:05 -0400
Message-Id: <20180623012105.578170331@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Jun 2018 21:20:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
Subject: [PATCH 5/5] tracing: Fix SKIP_STACK_VALIDATION=1 build due to bad merge with
 -mrecord-mcount
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0005-tracing-Fix-SKIP_STACK_VALIDATION-1-build-due-to-bad.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Thelen <gthelen@google.com>

Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
SKIP_STACK_VALIDATION=1 fail.
Example output:
  /bin/sh: init/.tmp_main.o: Permission denied

commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
added a mismatched endif.  This causes cmd_objtool to get mistakenly
set.

Relocate endif to balance the newly added -record-mcount check.

Link: http://lkml.kernel.org/r/20180608214746.136554-1-gthelen@google.com

Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
Acked-by: Andi Kleen <ak@linux.intel.com>
Tested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 34d9e9ce97c2..e7889f486ca1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -239,6 +239,7 @@ cmd_record_mcount =						\
 	     "$(CC_FLAGS_FTRACE)" ]; then			\
 		$(sub_cmd_record_mcount)			\
 	fi;
+endif # -record-mcount
 endif # CONFIG_FTRACE_MCOUNT_RECORD
 
 ifdef CONFIG_STACK_VALIDATION
@@ -263,7 +264,6 @@ ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
 endif
-endif
 
 
 ifdef CONFIG_MODVERSIONS
-- 
2.17.1


