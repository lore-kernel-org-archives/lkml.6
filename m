Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED6C04AB9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AA421473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AA421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeHTH5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:57:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbeHTH5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:57:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7K4d2WB130583
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 00:43:17 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kyj7vf8b6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 00:43:17 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 20 Aug 2018 05:43:15 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Aug 2018 05:43:09 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7K4h8Xn38994104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Aug 2018 04:43:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8053642042;
        Mon, 20 Aug 2018 07:43:11 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62AF942049;
        Mon, 20 Aug 2018 07:43:08 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.35.132])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Aug 2018 07:43:08 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v9 2/4] Uprobes/sdt: Prevent multiple reference counter for same uprobe
Date:   Mon, 20 Aug 2018 10:12:48 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082004-0028-0000-0000-000002ED0355
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082004-0029-0000-0000-000023A63A42
Message-Id: <20180820044250.11659-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808200049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We assume to have only one reference counter for one uprobe.
Don't allow user to register multiple uprobes having same
inode+offset but different reference counter.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 35065febcb6c..ecee371a59c7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
 	return u;
 }
 
+static void
+ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
+{
+	pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
+		"ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
+		uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
+		(unsigned long long) cur_uprobe->ref_ctr_offset,
+		(unsigned long long) uprobe->ref_ctr_offset);
+}
+
 static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 				   loff_t ref_ctr_offset)
 {
@@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
+			ref_ctr_mismatch_warn(cur_uprobe, uprobe);
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
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

