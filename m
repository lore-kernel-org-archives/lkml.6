Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZr7qL9V5nB6404iJ8i0V9p6+JTX9kx0HuIvaZcal02SsMTMeIZDxhmMNAIhkrKJmAjSB3le
ARC-Seal: i=1; a=rsa-sha256; t=1526568577; cv=none;
        d=google.com; s=arc-20160816;
        b=Rgpr8XShAml+cw3iS+hR1jhlDk/4k8nnrTporZQuelCvcrLOyeTTVs2C6wyuzIL4ys
         lougsoqymxrceZuzCiSpVGZ+D6yojZFK0j/Rp3i8PTtf1o27bLk/rFwzSQzySglBIjOu
         0B8wk50/Kt/lH9HvkwVFfyX5P4PUNyQWaTJFx7i3MLnQs5Nk8w7+8Oo0VGV8UGwtlo0y
         0kJ7GyongnGWmXnabz3QAF4z2fUGFAUNYA40JsHPwA0gBtP61LQ2AUJMMLqnon/TqsNB
         EGNOssf+6TOCbMvb1JNhrKgydZGCVkcp20aGuMe/6k96mQaC0hGEivgTcs3N/R/8Skyo
         AiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=X+csqfwNgRkT/gUWAR2+jRUi5CcIP5+MV+rIjj7yeU0=;
        b=dbuHixbHthtudiyHH8WWJJ/Xpez3nXnJsH+qGJ3juAPBRgxDFsTsyCGB+XzaWR6MlE
         qnz10z8AzTZKQjDCO9DEdBr0Nyhtpowxal1/+m1yIuVKLBs1mS7Wiu60OUdVthYJkNLN
         MYuY+u/exWk9h1pEAwI34d7m9JIeaBVihgJ9oam2Pf6NXn6Z3OI/OnspluMXQJBBlU8B
         Ld8XqbciAVHE0Zsq8B+IH70G3DKxWcbW7ZVaTRScK7ORCi9JUnLoyXk8zK9IojV3d1aW
         rIJF90wUKKbQ5XKfOVHpHI4DTRtxpIe7TC+9lnWS1ymF10lPwQhwkBesSn5+ADZOMDXr
         Wcpg==
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
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH v2 1/9] ima: based on policy verify firmware signatures (pre-allocated buffer)
Date: Thu, 17 May 2018 10:48:42 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0008-0000-0000-000004F78F68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0009-0000-0000-00001E8C0559
Message-Id: <1526568530-9144-2-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723173147077605?=
X-GMAIL-MSGID: =?utf-8?q?1600723173147077605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Don't differentiate between kernel_read_file_id READING_FIRMWARE and
READING_FIRMWARE_PREALLOC_BUFFER enumerations.

Fixes: a098ecd firmware: support loading into a pre-allocated buffer (since 4.8)
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
---
 security/integrity/ima/ima_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e771b736aa03..83f84928ad76 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -447,6 +447,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 
 static int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-- 
2.7.5
