Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9529220874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeLRAO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:14:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbeLRAO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:14:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBI03b0I106452
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:14:55 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2peh9n3g7d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:14:55 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 18 Dec 2018 00:14:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 00:14:51 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBI0EoZ241484382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 00:14:50 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 439D3AE045;
        Tue, 18 Dec 2018 00:14:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F96AAE053;
        Tue, 18 Dec 2018 00:14:49 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 00:14:49 +0000 (GMT)
Subject: [PATCH] ima: cleanup the match_token policy code
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Dec 2018 19:14:49 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121800-0012-0000-0000-000002DA7FA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121800-0013-0000-0000-000021101587
Message-Id: <1545092089.4206.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start the policy_tokens and the associated enumeration from zero,
simplifying the pt macro.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index d17a23b5c91d..e89af72b98ed 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -665,9 +665,9 @@ void ima_update_policy(void)
 	ima_update_policy_flag();
 }
 
+/* Keep the enumeration in sync with the policy_tokens! */
 enum {
-	Opt_err = -1,
-	Opt_measure = 1, Opt_dont_measure,
+	Opt_measure, Opt_dont_measure,
 	Opt_appraise, Opt_dont_appraise,
 	Opt_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
@@ -677,10 +677,10 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr
+	Opt_pcr, Opt_err
 };
 
-static match_table_t policy_tokens = {
+static const match_table_t policy_tokens = {
 	{Opt_measure, "measure"},
 	{Opt_dont_measure, "dont_measure"},
 	{Opt_appraise, "appraise"},
@@ -1188,7 +1188,7 @@ void ima_policy_stop(struct seq_file *m, void *v)
 {
 }
 
-#define pt(token)	policy_tokens[token + Opt_err].pattern
+#define pt(token)	policy_tokens[token].pattern
 #define mt(token)	mask_tokens[token]
 
 /*
-- 
2.7.5

