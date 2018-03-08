Return-Path: <kernel-hardening-return-12257-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtwp9zxkj/HnGo2MHbuRZxsCvH787W6F0wCyzej3PLw6SfOSKBL3xWuZ5s/UPC6Isy7DEJv
ARC-Seal: i=1; a=rsa-sha256; t=1520540759; cv=none;
        d=google.com; s=arc-20160816;
        b=olFVnBgWBhYENUXtMauCubc/EWpBT9xvvXrkWP5G+IP0gahq0Yto40EFBy1nBwK+bu
         DM4l9ylrWK6kEkZWGMQPZ8KmGaYQiKzriBrYybLxfgCR+hlJzPrB+51kiQO0pwHYbe3t
         aSYmDiXTkDvzIxpt/6XYUbCSjfMNlK5+08fthSVamNZU1A+lJJKvdKkoKCDu8wzbiNt2
         ObomHhZyRV/GWitSsuiu/ufea47VG3E45N5PZilFNp1j+yBGwsv+/tpI+N+2YZzbbZ0c
         MnXuy6hkUjiGBkPD5xOLGAhhpkerhEfETinPVPeBPGuBjluUYnHl069eC874+TLBCoV9
         ujmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=utvQamLhNRz0WjN2Bpo3kqLK74ALg/V17hjtS2daHX8=;
        b=lhF/q+SW9JrhphHHex+cgw5ymw+qo4/rGg3qJVvyl4hYmrIzlagfVOQRchB+UxCsfY
         MoD3UsRhDgBAKTG+nygJSD5jMjEC7rlQUwTrsrQWDO1mTXudr4bZpGN8x6P6vdsKGeF5
         XzNWMkpeqqBE7Scaf3XNix3Y7k+31pifhY7jGB5pn3IkkyCq2o8HNsCCm3fI7F6DisV1
         VlRSguTpnP2bsn2mOXeX8iiBFHK/cnnIvH0pgUOUChD7xvOuizDyygJzrhe1x6hLpMsY
         29ouRNJ8M8qs37iDdBeCtAOcJ/KaUZ5A6tZ2D0Baw2MHmFaVIu9y+/uGYbxBaG/Dfucv
         DGBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Lijz3pye;
       spf=pass (google.com: domain of kernel-hardening-return-12257-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12257-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=Lijz3pye;
       spf=pass (google.com: domain of kernel-hardening-return-12257-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12257-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Tycho Andersen <tycho@tycho.ws>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v2] ima: drop vla in ima_audit_measurement()
Date: Thu,  8 Mar 2018 13:23:47 -0700
Message-Id: <20180308202347.31331-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594402547592935810?=
X-GMAIL-MSGID: =?utf-8?q?1594402547592935810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In keeping with the directive to get rid of VLAs [1], let's drop the VLA
from ima_audit_measurement(). We need to adjust the return type of
ima_audit_measurement, because now this function can fail if an allocation
fails.

[1]: https://lkml.org/lkml/2018/3/7/621

v2: just use audit_log_format instead of doing a second allocation

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 security/integrity/ima/ima.h      |  4 ++--
 security/integrity/ima/ima_api.c  | 22 +++++++++++++---------
 security/integrity/ima/ima_main.c |  7 +++++--
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d52b487ad259..8e2470f72f7f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -201,8 +201,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, int pcr);
-void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename);
+int ima_audit_measurement(struct integrity_iint_cache *iint,
+			  const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry);
 int ima_store_template(struct ima_template_entry *entry, int violation,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 08fe405338e1..3a4442405cc8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -304,17 +304,20 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		ima_free_template_entry(entry);
 }
 
-void ima_audit_measurement(struct integrity_iint_cache *iint,
-			   const unsigned char *filename)
+int ima_audit_measurement(struct integrity_iint_cache *iint,
+			  const unsigned char *filename)
 {
 	struct audit_buffer *ab;
-	char hash[(iint->ima_hash->length * 2) + 1];
+	char *hash;
 	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
-	char algo_hash[sizeof(hash) + strlen(algo_name) + 2];
 	int i;
 
 	if (iint->flags & IMA_AUDITED)
-		return;
+		return 0;
+
+	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
+	if (!hash)
+		return -ENOMEM;
 
 	for (i = 0; i < iint->ima_hash->length; i++)
 		hex_byte_pack(hash + (i * 2), iint->ima_hash->digest[i]);
@@ -323,18 +326,19 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	ab = audit_log_start(current->audit_context, GFP_KERNEL,
 			     AUDIT_INTEGRITY_RULE);
 	if (!ab)
-		return;
+		goto out;
 
 	audit_log_format(ab, "file=");
 	audit_log_untrustedstring(ab, filename);
-	audit_log_format(ab, " hash=");
-	snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
-	audit_log_untrustedstring(ab, algo_hash);
+	audit_log_format(ab, " hash=\"%s:%s\"", algo_name, hash);
 
 	audit_log_task_info(ab, current);
 	audit_log_end(ab);
 
 	iint->flags |= IMA_AUDITED;
+out:
+	kfree(hash);
+	return 0;
 }
 
 /*
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2cfb0c714967..356faae6f09c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 					      xattr_value, xattr_len, opened);
 		inode_unlock(inode);
 	}
-	if (action & IMA_AUDIT)
-		ima_audit_measurement(iint, pathname);
+	if (action & IMA_AUDIT) {
+		rc = ima_audit_measurement(iint, pathname);
+		if (rc < 0)
+			goto out_locked;
+	}
 
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
 		rc = 0;
-- 
2.14.1
