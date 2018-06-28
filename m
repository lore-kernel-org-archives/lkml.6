Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E03C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEB026DAC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEB026DAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeF1FXC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:23:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933057AbeF1FW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:22:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5S5JARP105369
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jvrp0j24x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:58 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 28 Jun 2018 06:22:56 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 06:22:51 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5S5MowJ31195314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 05:22:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 783E842049;
        Thu, 28 Jun 2018 06:22:41 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CF1A42042;
        Thu, 28 Jun 2018 06:22:38 +0100 (BST)
Received: from bangoria.in.ibm.com (unknown [9.124.31.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jun 2018 06:22:38 +0100 (BST)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     srikar@linux.vnet.ibm.com, oleg@redhat.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v5 08/10] Uprobes/sdt: Prevent multiple reference counter for same uprobe
Date:   Thu, 28 Jun 2018 10:52:07 +0530
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062805-0020-0000-0000-0000029FC7AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062805-0021-0000-0000-000020EC49CD
Message-Id: <20180628052209.13056-9-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We assume to have only one reference counter for one uprobe.
Don't allow user to register multiple uprobes having same
inode+offset but different reference counter.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 61f9b0024794..feefeeb6d2c6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -662,6 +662,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
+			pr_warn("Err: Reference counter mismatch.\n");
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -1076,6 +1082,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
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

