Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeCENnW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:43:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932837AbeCENnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:43:21 -0500
Subject: [PATCH] audit: add containerid support for IMA-audit
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 05 Mar 2018 08:43:13 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030513-0020-0000-0000-000003FED1CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030513-0021-0000-0000-000042930B3B
Message-Id: <1520257393.10396.291.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

This patch has been compiled, but not runtime tested.

---

If the containerid is defined, include it in the IMA-audit record.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 33b4458cdbef..41d29a06f28f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -335,6 +335,9 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	audit_log_untrustedstring(ab, algo_hash);
 
 	audit_log_task_info(ab, current);
+	if (audit_containerid_set(current))
+		audit_log_format(ab, " contid=%llu",
+				 audit_get_containerid(current));
 	audit_log_end(ab);
 
 	iint->flags |= IMA_AUDITED;
-- 
2.7.5
