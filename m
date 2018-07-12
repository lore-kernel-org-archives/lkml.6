Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE54C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573F820883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573F820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbeGLIQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbeGLIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:16:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C85NVi059019
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:08:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k61xd377n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 04:08:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Thu, 12 Jul 2018 09:08:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 09:08:09 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6C8886E42336316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 08:08:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAEC652063;
        Thu, 12 Jul 2018 11:08:29 +0100 (BST)
Received: from JARVIS.in.ibm.com (unknown [9.124.35.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A476852054;
        Thu, 12 Jul 2018 11:08:28 +0100 (BST)
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] livepatch: Remove reliable stacktrace check in klp_try_switch_task()
Date:   Thu, 12 Jul 2018 13:35:06 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18071208-0008-0000-0000-000002523E73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071208-0009-0000-0000-000021B87606
Message-Id: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=973 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for immediate flag was removed by commit d0807da78e11
("livepatch: Remove immediate feature").  We bail out during
patch registration for architectures, those don't support
reliable stack trace. Remove the check in klp_try_switch_task(),
as its not required.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 kernel/livepatch/transition.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 7c6631e693bc..5bc349805e03 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -310,13 +310,6 @@ static bool klp_try_switch_task(struct task_struct *task)
 		return true;
 
 	/*
-	 * For arches which don't have reliable stack traces, we have to rely
-	 * on other methods (e.g., switching tasks at kernel exit).
-	 */
-	if (!klp_have_reliable_stack())
-		return false;
-
-	/*
 	 * Now try to check the stack for any to-be-patched or to-be-unpatched
 	 * functions.  If all goes well, switch the task to the target patch
 	 * state.
-- 
2.7.4

