Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDDSEc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:04:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751213AbeDDSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:04:29 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 3/3] perf tests clang: Fix function name for clang IR test
Date: Wed,  4 Apr 2018 23:34:19 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
References: <20180404180419.19056-1-sandipan@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18040418-0044-0000-0000-000005437D37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040418-0045-0000-0000-00002883953F
Message-Id: <20180404180419.19056-3-sandipan@linux.vnet.ibm.com>
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

As stated in tests/llvm-src-base.c, the name of the bpf function
should be "bpf_func__SyS_epoll_pwait" but this clang test fails
as it tries to lookup "bpf_func__SyS_epoll_wait".

Before applying patch:

55: builtin clang support                                 :
55.1: builtin clang compile C source to IR                : FAILED!
55.2: builtin clang compile C source to ELF object        : Skip

After applying patch:

55: builtin clang support                                 :
55.1: builtin clang compile C source to IR                : Ok
55.2: builtin clang compile C source to ELF object        : Ok

Fixes: e67d52d411c3 ("perf clang: Update test case to use real BPF script")
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/util/c++/clang-test.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index a4014d786676..7b042a5ebc68 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -41,7 +41,7 @@ int test__clang_to_IR(void)
 	if (!M)
 		return -1;
 	for (llvm::Function& F : *M)
-		if (F.getName() == "bpf_func__SyS_epoll_wait")
+		if (F.getName() == "bpf_func__SyS_epoll_pwait")
 			return 0;
 	return -1;
 }
-- 
2.14.3
