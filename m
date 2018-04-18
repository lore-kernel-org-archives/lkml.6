Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeDRK7P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:59:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753211AbeDRK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:59:13 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        maynard@us.ibm.com
Subject: [PATCH v2 2/3] perf tools powerpc: Fix crash if callchain is empty
Date: Wed, 18 Apr 2018 16:28:59 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
References: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041810-0012-0000-0000-000005CC2ECD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041810-0013-0000-0000-000019487F66
Message-Id: <20180418105900.5899-3-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some cases, the callchain provided by the kernel may be
empty. So, the callchain ip filtering code will cause a crash
if we do not check whether the struct ip_callchain pointer is
NULL before accessing any members.

This can be observed on a powerpc64le system running Fedora 27
as shown below.

 # perf record -b -e cycles:u ls
 # perf report --branch-history
 perf: Segmentation fault
 -------- backtrace --------
 perf[0x1027615c]
 linux-vdso64.so.1(__kernel_sigtramp_rt64+0x0)[0x7fff856304d8]
 perf(arch_skip_callchain_idx+0x44)[0x10257c58]
 perf[0x1017f2e4]
 perf(thread__resolve_callchain+0x124)[0x1017ff5c]
 perf(sample__resolve_callchain+0xf0)[0x10172788]
 ...

Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index d3a13f79d3ee..910db8762120 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -262,7 +262,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	int rc;
 	u64 skip_slot = -1;
 
-	if (chain->nr < 3)
+	if (!chain || chain->nr < 3)
 		return skip_slot;
 
 	rc = check_return_addr(thread, chain->ips[1]);
-- 
2.14.3
