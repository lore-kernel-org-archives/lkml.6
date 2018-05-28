Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423322AbeE1LGr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423308AbeE1LGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 063/272] perf tools: Fix perf builds with clang support
Date: Mon, 28 May 2018 12:01:36 +0200
Message-Id: <20180528100246.141300449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan@linux.vnet.ibm.com>

[ Upstream commit c2fb54a183cfe77c6fdc9d71e2d5299c1c302a6e ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/Makefile.perf |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -364,7 +364,8 @@ LIBS = -Wl,--whole-archive $(PERFLIBS) $
 
 ifeq ($(USE_CLANG), 1)
   CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-  LIBCLANG = $(foreach l,$(CLANGLIBS_LIST),$(wildcard $(shell $(LLVM_CONFIG) --libdir)/libclang$(l).a))
+  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
+  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
   LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
 endif
 
