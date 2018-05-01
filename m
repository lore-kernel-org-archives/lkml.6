Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755958AbeEANuJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:50:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755507AbeEANsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:48:43 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 2/6] ima: prevent sysfs fallback firmware loading
Date: Tue,  1 May 2018 09:48:19 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050113-0020-0000-0000-00000417CA32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050113-0021-0000-0000-000042ACE1DF
Message-Id: <1525182503-13849-3-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With an IMA policy requiring signed firmware, this patch prevents
the sysfs fallback method of loading firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/ima_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 754ece08e1c6..8759280dccf6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -453,7 +453,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;
 	}
+
+	if (read_id == READING_FIRMWARE_FALLBACK) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware sysfs fallback loading.\n");
+			return -EACCES;
+		}
+		return 0;
+	}
 	return 0;
+
 }
 
 static int read_idmap[READING_MAX_ID] = {
-- 
2.7.5
