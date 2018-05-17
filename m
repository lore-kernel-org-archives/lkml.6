Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZrV7Kk0wlylmgzORIAKxJ97R7JhmXSokEvCXxl5OpRmqo49kusFcsrcr4glmhwAkB1O5Ga7
ARC-Seal: i=1; a=rsa-sha256; t=1526568589; cv=none;
        d=google.com; s=arc-20160816;
        b=TtoVsnG6nbNR9a380tCUF7Xc4tWyDqLhUmStj8vvX2NybdH/HSSfQmge+ufITOI0lE
         cCaAlotrg1es3qRWmh2DX4i7B3QVsoHXlsdR+NulIcQVcNP6wxaJGws0Kge/ousjCgOE
         gSoPDsLNkea7pL8BXju8k31BW50noIR2NZHcvZBHnk4gLxIPh0wyCqiJHCQlw/em8NIx
         PdyEruNuFkB8ZTZ9S0gOSLrJ1gc7GEZ0X4gQySkgJ7/blJFwIr7mW/1D1NgAMmE7XrJz
         ALPE4KgGeCB5KspZxHHxsFhG5DeAvmocwUDUGY8oWL/fiFuRDsLlUIqhTHG7+YaQgrfJ
         kM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=i0V7Ctu4LSaXknMKaxDcuEchI2AIsMNHQM+ePVg/Nks=;
        b=pjjVngwTbj36loqreJbmExswAUmEA3MDWeVPHMzY7v+7ba/waSZR1ummIJvSc5op2n
         wMHPftZWkIlCg0WRYJoPt3CG7a5Irgz/fX/gOUEW/wV8OLEIPai/5UumXVXS1abQZ0gS
         UhGFv90mfcyOoD3OH2f6JJFmF4X9keGzEQERnc664MGeek39owAH1ezLEpLlhYFv0RGr
         oyx3NlMnSI5ka5yf/mWv2Kg2DbWQseD06900i+W11VMch8qvg+vLcMNKGJ8DRq+hZnDn
         +BATeewMXlShEbSPw8YjocSz4/jOwZyAY/HMutt+SyH8gtKdHmhoEmoJ8GYyRkHXvuZ9
         xbbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
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
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 5/9] ima: based on policy require signed kexec kernel images
Date: Thu, 17 May 2018 10:48:46 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0012-0000-0000-000005D7A702
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0013-0000-0000-00001954D35A
Message-Id: <1526568530-9144-6-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723185178724685?=
X-GMAIL-MSGID: =?utf-8?q?1600723185178724685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The original kexec_load syscall can not verify file signatures.  This
patch differentiates between the kexec_load and kexec_file_load
syscalls.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
---
 security/integrity/ima/ima.h        | 1 +
 security/integrity/ima/ima_main.c   | 9 +++++++++
 security/integrity/ima/ima_policy.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..78c15264b17b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -232,6 +232,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
+#define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 83f84928ad76..7e1a127f18fe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -442,6 +442,15 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;	/* We rely on module signature checking */
 	}
+
+	if (!file && read_id == READING_KEXEC_IMAGE) {
+		if ((ima_appraise & IMA_APPRAISE_KEXEC) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bbc18eb07eb..c27f6993b07a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_FIRMWARE;
 	else if (func == POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
+	else if (func == KEXEC_KERNEL_CHECK)
+		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
 
-- 
2.7.5
