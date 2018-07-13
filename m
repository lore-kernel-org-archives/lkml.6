Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E167ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123472087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123472087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbeGMSWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:22:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387717AbeGMSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:22:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DI4FEH071605
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:06:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k6yvf2r34-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 14:06:38 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 13 Jul 2018 19:06:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 19:06:32 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6DI6VEq41418796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 18:06:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F55B42045;
        Fri, 13 Jul 2018 21:06:52 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBDF342041;
        Fri, 13 Jul 2018 21:06:50 +0100 (BST)
Received: from dhcp-9-31-103-18.watson.ibm.com (unknown [9.31.103.18])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 21:06:50 +0100 (BST)
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v6 8/8] ima: based on policy warn about loading firmware (pre-allocated buffer)
Date:   Fri, 13 Jul 2018 14:06:03 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071318-0016-0000-0000-000001E691DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071318-0017-0000-0000-0000323B2F85
Message-Id: <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems are memory constrained but they need to load very large
firmwares.  The firmware subsystem allows drivers to request this
firmware be loaded from the filesystem, but this requires that the
entire firmware be loaded into kernel memory first before it's provided
to the driver.  This can lead to a situation where we map the firmware
twice, once to load the firmware into kernel memory and once to copy the
firmware into the final resting place.

To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
into a pre-allocated buffer") introduced request_firmware_into_buf() API
that allows drivers to request firmware be loaded directly into a
pre-allocated buffer.

Do devices using pre-allocated memory run the risk of the firmware being
accessible to the device prior to the completion of IMA's signature
verification any more than when using two buffers? (Refer to mailing list
discussion[1]).

Only on systems with an IOMMU can the access be prevented.  As long as
the signature verification completes prior to the DMA map is performed,
the device can not access the buffer.  This implies that the same buffer
can not be re-used.  Can we ensure the buffer has not been DMA mapped
before using the pre-allocated buffer?

[1] https://lkml.org/lkml/2018/7/10/56

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---
Changelog v6:
- Change warning to comment.

Changelog v5:
- Instead of preventing loading firmware from a pre-allocate buffer,
emit a warning.

 security/integrity/ima/ima_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ef349a761609..b82500cd6fbd 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -429,6 +429,14 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	/*
+	 * READING_FIRMWARE_PREALLOC_BUFFER
+	 *
+	 * Do devices using pre-allocated memory run the risk of the
+	 * firmware being accessible to the device prior to the completion
+	 * of IMA's signature verification any more than when using two
+	 * buffers?
+	 */
 	return 0;
 }
 
-- 
2.7.5

