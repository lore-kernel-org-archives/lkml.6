Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BD7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5984220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5984220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeGTKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:34:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727266AbeGTKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:34:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6K9iMjZ078959
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:47:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kbd3v8ry2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:47:13 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Fri, 20 Jul 2018 10:47:10 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Jul 2018 10:47:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6K9l7Mj39649298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Jul 2018 09:47:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E285A4C050;
        Fri, 20 Jul 2018 12:47:24 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 561B04C040;
        Fri, 20 Jul 2018 12:47:22 +0100 (BST)
Received: from JARVIS.in.ibm.com (unknown [9.77.85.180])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Jul 2018 12:47:22 +0100 (BST)
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Jiri Kosina <jikos@kernel.org>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] livepatch: Validate module/old func name length
Date:   Fri, 20 Jul 2018 15:16:42 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18072009-0012-0000-0000-0000028C86FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072009-0013-0000-0000-000020BE5451
Message-Id: <1532080002-10724-1-git-send-email-kamalesh@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807200114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

livepatch module author can pass module name/old function name with more
than the defined character limit. With obj->name length greater than
MODULE_NAME_LEN, the livepatch module gets loaded but waits forever on
the module specified by obj->name to be loaded. It also populates a /sys
directory with an untruncated object name.

In the case of funcs->old_name length greater then KSYM_NAME_LEN, it
would not match against any of the symbol table entries. Instead loop
through the symbol table comparing them against a nonexisting function,
which can be avoided.

The same issues apply, to misspelled/incorrect names. At least gatekeep
the modules with over the limit string length, by checking for their
length during livepatch module registration.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/livepatch/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3a4656fb7047..5b77a7314e01 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -678,6 +678,9 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 	if (!func->old_name || !func->new_func)
 		return -EINVAL;
 
+	if (strlen(func->old_name) >= KSYM_NAME_LEN)
+		return -EINVAL;
+
 	INIT_LIST_HEAD(&func->stack_node);
 	func->patched = false;
 	func->transition = false;
@@ -751,6 +754,9 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 	if (!obj->funcs)
 		return -EINVAL;
 
+	if (klp_is_module(obj) && strlen(obj->name) >= MODULE_NAME_LEN)
+		return -EINVAL;
+
 	obj->patched = false;
 	obj->mod = NULL;
 
-- 
2.7.4

