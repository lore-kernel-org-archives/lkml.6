Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED35ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A47208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A47208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeGPJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:14:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbeGPJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:14:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G8hZOV019294
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:47:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8jaam1sr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:47:42 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 16 Jul 2018 09:47:40 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 09:47:34 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G8lXHP39583810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 08:47:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0E4F4C040;
        Mon, 16 Jul 2018 11:47:52 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C571C4C04A;
        Mon, 16 Jul 2018 11:47:49 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 11:47:49 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter for same uprobe
Date:   Mon, 16 Jul 2018 14:17:05 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071608-0012-0000-0000-0000028A9B76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071608-0013-0000-0000-000020BC52BA
Message-Id: <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We assume to have only one reference counter for one uprobe. Don't
allow user to register multiple uprobes having same inode+offset
but different reference counter.

Though, existing tools which already support SDT events creates
normal uprobe and updates reference counter on their own. Allow 0 as
a special value for reference counter offset. I.e. two uprobes, one
having ref_ctr_offset=0 and the other having non-zero ref_ctr_offset
can coexists. This gives user a flexibility to either depend on
kernel uprobe infrastructure to maintain reference counter or just
use normal uprobe and maintain reference counter on his own.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 84da8512a974..563cc3e625b3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -63,6 +63,8 @@ static struct percpu_rw_semaphore dup_mmap_sem;
 
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
+/* Reference counter offset is reloaded with non-zero value. */
+#define REF_CTR_OFF_RELOADED	1
 
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
@@ -476,9 +478,23 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		return ret;
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
-	if (ret <= 0)
+	if (ret < 0)
 		goto put_old;
 
+	/*
+	 * If instruction is already patched but reference counter offset
+	 * has been reloaded to non-zero value, increment the reference
+	 * counter and return.
+	 */
+	if (ret == 0) {
+		if (is_register &&
+		    test_bit(REF_CTR_OFF_RELOADED, &uprobe->flags)) {
+			WARN_ON(!uprobe->ref_ctr_offset);
+			ret = update_ref_ctr(uprobe, mm, true);
+		}
+		goto put_old;
+	}
+
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register);
@@ -679,6 +695,30 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		/*
+		 * If inode+offset matches, ref_ctr_offset must match as
+		 * well. Though, 0 is a special value for ref_ctr_offset.
+		 */
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset &&
+		    cur_uprobe->ref_ctr_offset != 0 &&
+		    uprobe->ref_ctr_offset != 0) {
+			pr_warn("Err: Reference counter mismatch.\n");
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
+
+		/*
+		 * If existing uprobe->ref_ctr_offset is 0 and user is
+		 * registering same uprobe with non-zero ref_ctr_offset,
+		 * set new ref_ctr_offset to existing uprobe.
+		 */
+
+		if (!cur_uprobe->ref_ctr_offset && uprobe->ref_ctr_offset) {
+			cur_uprobe->ref_ctr_offset = uprobe->ref_ctr_offset;
+			set_bit(REF_CTR_OFF_RELOADED, &cur_uprobe->flags);
+		}
+
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -971,6 +1011,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	bool is_register = !!new;
 	struct map_info *info;
 	int err = 0;
+	bool installed = false;
 
 	percpu_down_write(&dup_mmap_sem);
 	info = build_map_info(uprobe->inode->i_mapping,
@@ -1000,8 +1041,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
 			if (consumer_filter(new,
-					UPROBE_FILTER_REGISTER, mm))
+					UPROBE_FILTER_REGISTER, mm)) {
 				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
+				installed = true;
+			}
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
 			if (!filter_chain(uprobe,
 					UPROBE_FILTER_UNREGISTER, mm))
@@ -1016,6 +1059,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	}
  out:
 	percpu_up_write(&dup_mmap_sem);
+	if (installed)
+		clear_bit(REF_CTR_OFF_RELOADED, &uprobe->flags);
 	return err;
 }
 
@@ -1093,6 +1138,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
 	/*
 	 * We can race with uprobe_unregister()->delete_uprobe().
 	 * Check uprobe_is_active() and retry if it is false.
-- 
2.14.4

