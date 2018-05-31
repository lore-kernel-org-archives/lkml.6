Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeEaO02 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:26:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755356AbeEaO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:26:25 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 1/4] ima: Call audit_log_string() rather than logging it untrusted
Date: Thu, 31 May 2018 10:24:57 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
References: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18053114-8235-0000-0000-00000D9F2AED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009102; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040334; UDB=6.00532532; IPR=6.00819463;
 MB=3.00021393; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-31 14:26:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053114-8236-0000-0000-00004143DFB2
Message-Id: <20180531142500.4193818-2-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters passed to this logging function are all provided by
a privileged user and therefore we can call audit_log_string()
rather than audit_log_untrustedstring().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
Acked-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bbc18eb07eb..1d00db19d167 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -634,7 +634,7 @@ static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
 		audit_log_format(ab, "%s<", key);
 	else
 		audit_log_format(ab, "%s=", key);
-	audit_log_untrustedstring(ab, value);
+	audit_log_string(ab, value);
 	audit_log_format(ab, " ");
 }
 static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
-- 
2.13.6
