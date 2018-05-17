Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZoUm+wz1jYvw7dzi59OD6eCq7kQ2ynLJiFfQ/AMAqhfazpTBxXuiISAMAxaroTq1VWqy4Uf
ARC-Seal: i=1; a=rsa-sha256; t=1526568580; cv=none;
        d=google.com; s=arc-20160816;
        b=J5K6JY3XT5f1vPiX3lL4N+o0ZIc7CYAcvkvpzMXNWZu1klBQJxeBxydt4r6v6cWwnL
         YIW9U3XXn03NVMnLfRqyC833+KALrete/YkSmHmv1/JBfTH6HLJyUu7IJQlgUP3dmPSf
         4YK5mZh7vks8yvFaYA2VkDKs0+kEW+LUgOfiFxg4VAZHApvIflaFLSxS2CxUyF55Xr/W
         l3h/CtOhwBtpkxD12+tfVIMDH/qlA5ZutzqqowV7EXLIY/VI5us3S6pnNuvjb0ULbP71
         /fIWEJWeI339qoKqpyqFV5Hg3J7ERyn3na6DJAo5ut5U21tXNKrvzzRxr8rMoShqYwwd
         bdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Og13Nn5o9TslGHvcWaX+GxinxqZ6oGjDWoVYRy1aZLU=;
        b=vR5z+e02HUxDsFu89AQnyCN91yZqO5SX4ZrA6Zw8YScl2sIS7ApuC3ikgWvJn39EhK
         mqE3Gie4riaMCFyKrDWAu2y4FH2WA4AVl1GFxTnpeGBX3BBhsSTovsEz0b2kL8E2YGc5
         V9nJhx+RDUbhPDMlGxmKim8IVbbKKmnARkQO5Jm9mmPDsdgeWC9RzvdnvNxy55TDqqv8
         oTZRl210HC4dgbXXEB7J5KVx+XRV1EMpiKkaIbKo1Iwv4NHD1BfVznPhK4GBIuoxMyMI
         s7DnrfTao8Pv4pEwsfttrjKksgL++raBPrTzOxqfJaDkXEEAUxBgse2aqn+8R+z+H5eS
         AUyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 2/9] ima: fix updating the ima_appraise flag
Date: Thu, 17 May 2018 10:48:43 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0040-0000-0000-0000043AE2EF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0041-0000-0000-0000264000E1
Message-Id: <1526568530-9144-3-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723175488224777?=
X-GMAIL-MSGID: =?utf-8?q?1600723175488224777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As IMA policy rules are added, a mask of the type of rule (eg. kexec
kernel image, firmware, IMA policy) is updated.  Based on this mask,
integrity decisions can be made quickly.

Unlike custom IMA policy rules, which replace the original builtin
policy rules and update the mask, the builtin "secure_boot" policy
rules were loaded, but did not update the mask.

This patch refactors the code to load custom policies, defining a new
function named ima_appraise_flag().  The new function is called either
when loading the builtin "secure_boot" or custom policies.

Fixes: 503ceaef8e2e ("ima: define a set of appraisal rules requiring file signatures")
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 03cbba423e59..8bbc18eb07eb 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -440,6 +440,17 @@ void ima_update_policy_flag(void)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
 
+static int ima_appraise_flag(enum ima_hooks func)
+{
+	if (func == MODULE_CHECK)
+		return IMA_APPRAISE_MODULES;
+	else if (func == FIRMWARE_CHECK)
+		return IMA_APPRAISE_FIRMWARE;
+	else if (func == POLICY_CHECK)
+		return IMA_APPRAISE_POLICY;
+	return 0;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -478,9 +489,11 @@ void __init ima_init_policy(void)
 	 * Insert the appraise rules requiring file signatures, prior to
 	 * any other appraise rules.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
-		list_add_tail(&secure_boot_rules[i].list,
-			      &ima_default_rules);
+	for (i = 0; i < secure_boot_entries; i++) {
+		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
+		temp_ima_appraise |=
+		    ima_appraise_flag(secure_boot_rules[i].func);
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
@@ -934,12 +947,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	}
 	if (!result && (entry->action == UNKNOWN))
 		result = -EINVAL;
-	else if (entry->func == MODULE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_MODULES;
-	else if (entry->func == FIRMWARE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
-	else if (entry->func == POLICY_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_POLICY;
+	else if (entry->action == APPRAISE)
+		temp_ima_appraise |= ima_appraise_flag(entry->func);
+
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.7.5
