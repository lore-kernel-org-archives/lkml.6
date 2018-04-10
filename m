Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeDJFaZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:30:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38037 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeDJFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:30:24 -0400
Date: Mon, 9 Apr 2018 22:30:16 -0700
From: tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-c2fb54a183cfe77c6fdc9d71e2d5299c1c302a6e@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        jolsa@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, sandipan@linux.vnet.ibm.com
Reply-To: sandipan@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        mingo@kernel.org, tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
References: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix perf builds with clang support
Git-Commit-ID: c2fb54a183cfe77c6fdc9d71e2d5299c1c302a6e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c2fb54a183cfe77c6fdc9d71e2d5299c1c302a6e
Gitweb:     https://git.kernel.org/tip/c2fb54a183cfe77c6fdc9d71e2d5299c1c302a6e
Author:     Sandipan Das <sandipan@linux.vnet.ibm.com>
AuthorDate: Wed, 4 Apr 2018 23:34:17 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 9 Apr 2018 11:13:07 -0300

perf tools: Fix perf builds with clang support

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
 
