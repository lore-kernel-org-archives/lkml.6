Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeDITgC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754213AbeDITfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:35:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867AE217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/13] perf tools: Fix perf builds with clang support
Date: Mon,  9 Apr 2018 16:34:35 -0300
Message-Id: <20180409193437.14199-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

For libclang, some distro packages provide static libraries (.a) while
some provide shared libraries (.so). Currently, perf code can only be
linked with static libraries. This makes perf build possible for both
cases.

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: d58ac0bf8d1e ("perf build: Add clang and llvm compile and linking support")
Link: http://lkml.kernel.org/r/20180404180419.19056-1-sandipan@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f7517e1b73f8..83e453de36f8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -364,7 +364,8 @@ LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive
 
 ifeq ($(USE_CLANG), 1)
   CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-  LIBCLANG = $(foreach l,$(CLANGLIBS_LIST),$(wildcard $(shell $(LLVM_CONFIG) --libdir)/libclang$(l).a))
+  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
+  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
   LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
 endif
 
-- 
2.14.3
