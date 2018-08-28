Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54872089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54872089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH1M7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:59:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeH1M7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:59:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S949Bb070708
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:08:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m51sb4ud8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 05:08:57 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 28 Aug 2018 10:08:55 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 10:08:52 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7S98ps233489134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 09:08:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85F1811C04C;
        Tue, 28 Aug 2018 12:08:48 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52DF311C050;
        Tue, 28 Aug 2018 12:08:47 +0100 (BST)
Received: from localhost.localdomain (unknown [9.195.22.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Aug 2018 12:08:47 +0100 (BST)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        kamalesh@linux.vnet.ibm.com
Subject: [PATCH] perf probe powerpc: Ignore SyS symbols irrespective of endianness
Date:   Tue, 28 Aug 2018 14:38:48 +0530
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18082809-0020-0000-0000-000002BCB359
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082809-0021-0000-0000-0000210A23D3
Message-Id: <20180828090848.1914-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes sure that the SyS symbols are ignored for any powerpc
system, not just the big endian ones.

Fixes: fb6d59423115 ("perf probe ppc: Use the right prefix when ignoring SyS symbols on ppc")
Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 20e7d74d86cd..10a44e946f77 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -22,15 +22,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 
 #endif
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
 	char *sym = syma->name;
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Skip over any initial dot */
 	if (*sym == '.')
 		sym++;
+#endif
 
 	/* Avoid "SyS" kernel syscall aliases */
 	if (strlen(sym) >= 3 && !strncmp(sym, "SyS", 3))
@@ -41,6 +42,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
-- 
2.14.4

