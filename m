Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FCBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86FA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86FA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeFTD4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754421AbeFTD4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:56:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5K3t98M059455
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:56:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqeeghvkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:56:50 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 20 Jun 2018 04:56:47 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 04:56:43 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5K3ugQt22347946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 03:56:42 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B03BDAE045;
        Wed, 20 Jun 2018 04:45:24 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F22D4AE058;
        Wed, 20 Jun 2018 04:45:21 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 04:45:21 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v4 2/9] Uprobe: Change set_swbp definition
Date:   Wed, 20 Jun 2018 09:26:22 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620035629.7844-1-ravi.bangoria@linux.ibm.com>
References: <20180620035629.7844-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062003-4275-0000-0000-0000028FB09D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062003-4276-0000-0000-00003796F6C0
Message-Id: <20180620035629.7844-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=751 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of arch_uprobe, pass uprobe object to set_swbp(). We need
this in later set of patches.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/arm/probes/uprobes/core.c | 4 ++--
 arch/mips/kernel/uprobes.c     | 4 ++--
 include/linux/uprobes.h        | 2 +-
 kernel/events/uprobes.c        | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index d1329f1..c678a5c 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -29,11 +29,11 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
 }
 
-int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	     unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr,
-		   __opcode_to_mem_arm(auprobe->bpinsn));
+		   __opcode_to_mem_arm(uprobe->arch.bpinsn));
 }
 
 bool arch_uprobe_ignore(struct arch_uprobe *auprobe, struct pt_regs *regs)
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index f7a0645..2aaa378 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -211,7 +211,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
 
 /**
  * set_swbp - store breakpoint at a given address.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to insert the opcode.
  *
@@ -221,7 +221,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
  * This version overrides the weak version in kernel/events/uprobes.c.
  * It is required to handle MIPS16 and microMIPS.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
+int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm,
 	unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e9..60f4eb5e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,7 +115,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
-extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern int set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 471eac8..e38c882 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -342,14 +342,14 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
 
 /**
  * set_swbp - store breakpoint at a given address.
- * @auprobe: arch specific probepoint information.
+ * @uprobe: uprobe object.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to insert the opcode.
  *
  * For mm @mm, store the breakpoint instruction at @vaddr.
  * Return 0 (success) or a negative errno.
  */
-int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
+int __weak set_swbp(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
 {
 	return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
 }
@@ -666,7 +666,7 @@ static bool filter_chain(struct uprobe *uprobe,
 	if (first_uprobe)
 		set_bit(MMF_HAS_UPROBES, &mm->flags);
 
-	ret = set_swbp(&uprobe->arch, mm, vaddr);
+	ret = set_swbp(uprobe, mm, vaddr);
 	if (!ret)
 		clear_bit(MMF_RECALC_UPROBES, &mm->flags);
 	else if (first_uprobe)
-- 
1.8.3.1

