Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZoAmlTfjmiCxTyu8+vfkUKjkPKzCwfjkENaZVcmQhJSwtUerT0xvs5uh1isc7AsUS03q3DY
ARC-Seal: i=1; a=rsa-sha256; t=1526568602; cv=none;
        d=google.com; s=arc-20160816;
        b=Epz74VIpVhoLqH9CevOMJm0qF0/+WvRyOazBuudJhiv/tM5ax5GzsSk+/O5F2B6b8J
         0Uci90Sh98ClUfbmF4IdDNPKQarBRJbyklwZFejC8yLFkRcresuzX63n+Kbi/Gz+2Dqy
         7QUol1Y64IeBqMaSKvidce5t4WnH/zH95qsdwaCj/DUABcVN7IvM0FGxer2EkZ3qA5Zs
         BmzOobxIca7gQ7DCnWJ04V5jhsc2EuRT4Mv4ey0Di++HfWP35E+okCIHuN2odrifzK+t
         JQPd1KK7io0K/YsiASYKv4uEGWVKSVcMnrbvMUl13Y6jIZYAECINBxFz+l4N7mJNO/Lz
         cByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mLUxgtHp3GVlK/7SoqUs7p2KCRZPui/uXdiesPhz+/0=;
        b=aupP/SlbGoZz+vA28t6AT0s2Ihol6Eop7Qy91gr6tUZW2Jeo5WyCd4ROcfFCCHROuv
         vwbNyC+wZH1NoLsQEtvXClfsUC87FzUcCV6jMttgizE90aaanQmwBuqBSvYUDsnx8UUU
         1zC7qWlUCS5ca07oXS9LSFMqTljnL/37E0IfkblHuOrFsXTIGb9d7cMq0Qc2jGRM2zTn
         hgRKke3lnc3lCq374fxLePYpHL/sR2EoPcIE3RQbdDXAPS+MuJLG5o+T4MAbaCW4KfpR
         q0d6b+MX3iDNtcZE5kaXdRaA1L2XkS2KTYhl4eH+XkFqIFdikypT5IZ/JJoEdU9rHwp7
         As0g==
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
Subject: [PATCH v2 9/9] ima: based on policy prevent loading firmware (pre-allocated buffer)
Date: Thu, 17 May 2018 10:48:50 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0012-0000-0000-000005D7A706
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0013-0000-0000-00001954D35F
Message-Id: <1526568530-9144-10-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723199422453169?=
X-GMAIL-MSGID: =?utf-8?q?1600723199422453169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Question: can the device access the pre-allocated buffer at any time?

By allowing devices to request firmware be loaded directly into a
pre-allocated buffer, will this allow the device access to the firmware
before the kernel has verified the firmware signature?

Is it dependent on the type of buffer allocated (eg. DMA)?  For example,
qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent().

With an IMA policy requiring signed firmware, this patch would prevent
loading firmware into a pre-allocated buffer.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
---
 security/integrity/ima/ima_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 29d1a929af5c..6224468845e6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -452,6 +452,15 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		return 0;
 	}
 
+	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
+			return -EACCES;
+		}
+		return 0;
+	}
+
 	if (read_id == READING_FIRMWARE_FALLBACK_SYSFS) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.7.5
