Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZqNjJ4DQ/7o9k3QPOKdXWGFiYZoi+i38a20bK6f84PymF0z52ubgSuvBZ+sKbXpz/V/zbom
ARC-Seal: i=1; a=rsa-sha256; t=1526568596; cv=none;
        d=google.com; s=arc-20160816;
        b=obd6xOAQc6iPhFNBDOU1JPMkBQ/SGF/51LKQaZSnklE0eY/URjy/t9vqTQlJ0Uj65G
         Ie790gVKyWr+lMAvUeOosEOqQWjvEvFpvCS6uAmfgTv7fOITLFgI4s5oqwMPxkKhs+aU
         3q8QC9mJziipdDF8LL9SI3qSo6M3EQz51ZtndRkZJhXsYqxsbBRIrgXx0szKv6aH8ppi
         SHU8KlxN7BwHlvYiJUD7i89wvrxlgLYwoyxUXiaLeGwOeuS863BRqbFGP22GCcXLfqeb
         +uxEIMOfzS3fLe+pImagb+plfgND2J1Ca9XsrkO3YL34KUpSAetqRt51MvNriehXzZM4
         p2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=z0PyC1/hsDk2InNu5DJB5/E7agahfTqeW3Xs/CDQrpA=;
        b=y76/6RVDgdo+uNChZ0JtTQbYbkzE8RWrvGqHnXHL55/Q+ZpZzJXaaSm57U0Z8X2Y7n
         BWpUlDxUhpN367024D3U4v3z/bOcEG2IrdWwKDVgHCBsjFSGzlZPx7tx2CRnLj0UWrHs
         2VbNNVBggEKYeGj62TsXL1GPBchJ6WcLWt9ysEoWCykZ6zQY0AxkpnPCGWiTH/zXFWks
         HF7piQEM04qDhZdRyJ4AXEza+6XiKUeSfb0rIqTfvOJy2fC786zElQ9gSspj+Y6kYdyN
         zl+rKNqKqBP1i3oM1X4j/gWXhAjgju1IQkMZ5qt7asR8vNZeGL+8pjmUGXWiqZ1h+IRq
         awfQ==
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
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH v2 7/9] ima: based on policy require signed firmware (sysfs fallback)
Date: Thu, 17 May 2018 10:48:48 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0008-0000-0000-000004F78F77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0009-0000-0000-00001E8C0567
Message-Id: <1526568530-9144-8-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723192101745987?=
X-GMAIL-MSGID: =?utf-8?q?1600723192101745987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
index 7e1a127f18fe..29d1a929af5c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -451,7 +451,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 		}
 		return 0;
 	}
+
+	if (read_id == READING_FIRMWARE_FALLBACK_SYSFS) {
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
