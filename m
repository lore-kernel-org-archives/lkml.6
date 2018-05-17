Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZpgCs0HhH89FJO7bMo2Ma0gyvzEN0gGGvSF/Q4qxaCbTUvwPhwEBwrxRWyAJ3DM9tl2yEP9
ARC-Seal: i=1; a=rsa-sha256; t=1526568591; cv=none;
        d=google.com; s=arc-20160816;
        b=eYJeBMqnPQIKxsIfDeFAxos+PcMAmpxtkTHNSRlJjxDKwKamjR1J+Pv4+UZM+Kzbhz
         LaEgGORjvX50w4EA1CpO9OWQX8e24pc6xJVOCJ2B5Q0OBvB8re+jIN2fpr3mEzewFuOz
         ezOSNGtmHOOImh84KNquq9oMyTQiGXESMR2y1hJte4C+CtDhq6zw5Syp/HHJEbRqnxl0
         F+UqBiGFsqQWekWTj6YCc02RWHLXFekjpsAYXetryUx+EJC3EvGhq8l8iWM88GWcwS9x
         OsnkVBi6n0vUDw4evpZffhMpBBZFBNLhmMl5vUhmFybjntkW4gN/sEHu/kCV99rq0Q2K
         ClYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=aq6mzsOlRGILVIxAVw+U3wD2O/wbIFkzikuJBt68bgM=;
        b=XXOANSIokP++zvmni77M8nZxQjvHkdid2LJNDINRSVXefmONK8QDFEC3yAF0srX0Ro
         pBXYp2sVKXzLMzVAv4gbEdM16FEJK1H/X+RrhnEYsD8hR8xiOV6P+Mjod6D62Wj4cC19
         87d2ldGLT+i47swx4vyulsIq0iNRR7qZzsU2tKEOTiMLzjAZIscRessW7ecipO+laH4W
         M+GznUR9jpdtCXP+ttwibTBJUVYq01yiX/EoascI8mwKkFy82yMF/f8od+PQvqY/cyel
         5BLeT/1GrM93BcjFdgwJ1WNiiQaY36jQECX8m2JW8R2laI0liaBGY+AodmPVL95JdBsb
         5srg==
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 6/9] firmware: add call to LSM hook before firmware sysfs fallback
Date: Thu, 17 May 2018 10:48:47 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0012-0000-0000-000005D7A704
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0013-0000-0000-00001954D35C
Message-Id: <1526568530-9144-7-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723187289207856?=
X-GMAIL-MSGID: =?utf-8?q?1600723187289207856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an LSM hook prior to allowing firmware sysfs fallback loading.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>

Changelog:
- call security_kernel_read_blob()
- rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
READING_FIRMWARE_FALLBACK_SYSFS.
---
 drivers/base/firmware_loader/fallback.c | 7 +++++++
 include/linux/fs.h                      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 358354148dec..6ec97e19c017 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
+	int ret;
+
 	if (fw_fallback_config.ignore_sysfs_fallback) {
 		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
 		return false;
@@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
+	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
+	ret = security_kernel_read_blob(READING_FIRMWARE_FALLBACK_SYSFS);
+	if (ret < 0)
+		return ret;
+
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..6e31d9207435 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2810,6 +2810,7 @@ extern int do_pipe_flags(int *, int);
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
+	id(FIRMWARE_FALLBACK_SYSFS, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.7.5
