Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDDSE1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:04:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750915AbeDDSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:04:26 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 1/3] perf tools: Fix perf builds with clang support
Date: Wed,  4 Apr 2018 23:34:17 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18040418-0040-0000-0000-00000449C0E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040418-0041-0000-0000-000020EDD1CF
Message-Id: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For libclang, some distro packages provide static libraries (.a)
while some provide shared libraries (.so). Currently, perf code
can only be linked with static libraries. This makes perf build
possible for both cases.

Fixes: d58ac0bf8d1e ("perf build: Add clang and llvm compile and linking support")
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
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
