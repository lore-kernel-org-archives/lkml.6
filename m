Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935074AbeE2PXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935437AbeE2PX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:29 -0400
Message-Id: <20180529152326.009479578@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [for-next][PATCH 01/19] trace: Use -mcount-record for dynamic ftrace
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0001-trace-Use-mcount-record-for-dynamic-ftrace.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

gcc 5 supports a new -mcount-record option to generate ftrace
tables directly. This avoids the need to run record_mcount
manually.

Use this option when available.

So far doesn't use -mcount-nop, which also exists now.

This is needed to make ftrace work with LTO because the
normal record-mcount script doesn't run over the link
time output.

It should also improve build times slightly in the general
case.
Link: http://lkml.kernel.org/r/20171127213423.27218-12-andi@firstfloor.org

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/Makefile.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8bdb1dc4072c..dcbca18011bb 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -207,6 +207,11 @@ cmd_modversions_c =								\
 endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
+# gcc 5 supports generating the mcount tables directly
+ifneq ($(call cc-option,-mrecord-mcount,y),y)
+KBUILD_CFLAGS += -mrecord-mcount
+else
+# else do it all manually
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
@@ -259,6 +264,7 @@ ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
 endif
+endif
 
 
 ifdef CONFIG_MODVERSIONS
-- 
2.17.0
