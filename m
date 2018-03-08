Return-Path: <kernel-hardening-return-12279-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELttiMGwP/x3XoWooMd7B6LArs92sp86HQTep5rq1mxOojhz/rJ7VivYo5JR6u/QPWDQseQM
ARC-Seal: i=1; a=rsa-sha256; t=1520550595; cv=none;
        d=google.com; s=arc-20160816;
        b=mETvXU+ubvVVgJrB3JxWokHeE9FpdCwFyWpX4ddSeIq5v7VJqoaqTtH8ZLAVyq5f48
         j73cGllj1NaMyput6bmy3U+hS2MjmSPqY6GHcz/AxgqDbwKHBtIIKL3aHThSn3b4eQDn
         552mrsiUDlyGmez9kSImt8TnkE4BPmwBR34DJf5IJ3BOmwk46Nf/yta3lMRaLPDeAv9l
         0MAhohIwWrH8Q3tiK86bCrENqfF2G61oIcaK9lOYDCQ15Gm16WjyB/EaZAUflWobzw+q
         UChoge/xtkABbliY+pQYA7SzESvq8fcadlODZRfGxP9Qbok+aca9ytnzpb8i80GncrMp
         oe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=OmEZEDaS6hpyR5iA9/rKKJIhauokv+9y1XDmRE6gT94=;
        b=Osr+880Qln0cXWFQpsYijEtWxOx4srtaWGekSPFccWvKrymVvlAoVK3Wqz3b2bR6P0
         EQ5VDHD5/OYOjuVEfo4NHqKKHXBKOP2E9d+Zei7uPRT3JcORqzJVbiuN8byfLtGfveSP
         YRNLT2oQNaYO1dyJ6JViXj2Axv7bbm/J11qXU9zF3iiAUhtJu15fyVueDZW3NsvdpOYQ
         I/nbhq2V2Nm5qsEyykbMRKeMK7LyVtrDu+Q9GJtuZVSDFTL9l/scTxzBLn7p9zRd2XKS
         JjhQ/Iwn6DsaPkU2G0AwFH+d0eUz6NCDuXF2ub5DHlbmQc5sF8sZVX5nKgAqL8/EME00
         3m6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=yzPkTp1p;
       spf=pass (google.com: domain of kernel-hardening-return-12279-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12279-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=yzPkTp1p;
       spf=pass (google.com: domain of kernel-hardening-return-12279-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12279-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH v3] ima: drop vla in ima_audit_measurement()
Date: Thu,  8 Mar 2018 16:08:36 -0700
Message-Id: <20180308230836.24329-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594412861096605696?=
X-GMAIL-MSGID: =?utf-8?q?1594412861096605696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In keeping with the directive to get rid of VLAs [1], let's drop the VLA
from ima_audit_measurement(). We need to adjust the return type of
ima_audit_measurement, because now this function can fail if an allocation
fails.

[1]: https://lkml.org/lkml/2018/3/7/621

v2: just use audit_log_format instead of doing a second allocation
v3: ignore failures in ima_audit_measurement()

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 security/integrity/ima/ima_api.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 08fe405338e1..2aab9170ef68 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -308,14 +308,17 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename)
 {
 	struct audit_buffer *ab;
-	char hash[(iint->ima_hash->length * 2) + 1];
+	char *hash;
 	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
-	char algo_hash[sizeof(hash) + strlen(algo_name) + 2];
 	int i;
 
 	if (iint->flags & IMA_AUDITED)
 		return;
 
+	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
+	if (!hash)
+		return;
+
 	for (i = 0; i < iint->ima_hash->length; i++)
 		hex_byte_pack(hash + (i * 2), iint->ima_hash->digest[i]);
 	hash[i * 2] = '\0';
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
+	return;
 }
 
 /*
-- 
2.14.1
