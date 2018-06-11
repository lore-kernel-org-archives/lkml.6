Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pGu1DJtQHlt1TAAAmS7hNA
	; Mon, 11 Jun 2018 10:41:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 882A2607A4; Mon, 11 Jun 2018 10:41:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1166C600D0;
	Mon, 11 Jun 2018 10:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1166C600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeFKKk6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:40:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932472AbeFKKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:40:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5BAd1ZN005288
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:40:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jhmux00ee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:40:56 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 11 Jun 2018 11:40:54 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Jun 2018 11:40:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5BAeqBP27656236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jun 2018 10:40:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD55952043;
        Mon, 11 Jun 2018 10:30:23 +0100 (BST)
Received: from localhost.localdomain (unknown [9.40.193.84])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B3E775204E;
        Mon, 11 Jun 2018 10:30:22 +0100 (BST)
From: Sandipan Das <sandipan@linux.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, sukadev@linux.vnet.ibm.com
Subject: [PATCH] perf report powerpc: Fix crash if callchain is empty
Date: Mon, 11 Jun 2018 16:10:49 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18061110-0016-0000-0000-000001DA615F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061110-0017-0000-0000-0000322D8BD7
Message-Id: <20180611104049.11048-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806110128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some cases, the callchain provided by the kernel may be
empty. So, the callchain ip filtering code will cause a crash
if we do not check whether the struct ip_callchain pointer is
NULL before accessing any members.

This can be observed on a powerpc64le system running Fedora 27
as shown below.

  # perf record -b -e cycles:u ls

Before applying this patch:

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

After applying this patch:

  # perf report --branch-history

  Samples: 25  of event 'cycles:u', Event count (approx.): 2306870
    Overhead  Source:Line            Symbol                   Shared Object
  +   11.60%  _init+35736            [.] _init                ls
  +    9.84%  strcoll_l.c:137        [.] __strcoll_l          libc-2.26.so
  +    9.16%  memcpy.S:175           [.] __memcpy_power7      libc-2.26.so
  +    9.01%  gconv_charset.h:54     [.] _nl_find_locale      libc-2.26.so
  +    8.87%  dl-addr.c:52           [.] _dl_addr             libc-2.26.so
  +    8.83%  _init+236              [.] _init                ls
  ...

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 3598b8b75d27..ef5d59a5742e 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -243,7 +243,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 	u64 ip;
 	u64 skip_slot = -1;
 
-	if (chain->nr < 3)
+	if (!chain || chain->nr < 3)
 		return skip_slot;
 
 	ip = chain->ips[2];
-- 
2.14.3
