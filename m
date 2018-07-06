Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB6C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC272409E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC272409E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeGFFZy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:25:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45689 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbeGFFZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:25:51 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fbJFd-0001Jc-Vu; Fri, 06 Jul 2018 05:25:50 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] apparmor: Check buffer bounds when mapping permissions mask
Date:   Fri,  6 Jul 2018 05:25:00 +0000
Message-Id: <1530854701-7348-2-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
References: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't read past the end of the buffer containing permissions
characters or write past the end of the destination string.

Detected by CoverityScan CID#1415361, 1415376 ("Out-of-bounds access")

Fixes: e53cfe6c7caa ("apparmor: rework perm mapping to a slightly broader set")
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
---
 security/apparmor/file.c          |  3 ++-
 security/apparmor/include/perms.h |  3 ++-
 security/apparmor/lib.c           | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 224b2fef93ca..4285943f7260 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -47,7 +47,8 @@ static void audit_file_mask(struct audit_buffer *ab, u32 mask)
 {
 	char str[10];
 
-	aa_perm_mask_to_str(str, aa_file_perm_chrs, map_mask_to_chr_mask(mask));
+	aa_perm_mask_to_str(str, sizeof(str), aa_file_perm_chrs,
+			    map_mask_to_chr_mask(mask));
 	audit_log_string(ab, str);
 }
 
diff --git a/security/apparmor/include/perms.h b/security/apparmor/include/perms.h
index 38aa6247d00f..b94ec114d1a4 100644
--- a/security/apparmor/include/perms.h
+++ b/security/apparmor/include/perms.h
@@ -137,7 +137,8 @@ extern struct aa_perms allperms;
 	xcheck(fn_for_each((L1), (P), (FN1)), fn_for_each((L2), (P), (FN2)))
 
 
-void aa_perm_mask_to_str(char *str, const char *chrs, u32 mask);
+void aa_perm_mask_to_str(char *str, size_t str_size, const char *chrs,
+			 u32 mask);
 void aa_audit_perm_names(struct audit_buffer *ab, const char * const *names,
 			 u32 mask);
 void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index a7b3f681b80e..7ab368c3789b 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -198,15 +198,24 @@ const char *aa_file_perm_names[] = {
 /**
  * aa_perm_mask_to_str - convert a perm mask to its short string
  * @str: character buffer to store string in (at least 10 characters)
+ * @str_size: size of the @str buffer
+ * @chrs: NUL-terminated character buffer of permission characters
  * @mask: permission mask to convert
  */
-void aa_perm_mask_to_str(char *str, const char *chrs, u32 mask)
+void aa_perm_mask_to_str(char *str, size_t str_size, const char *chrs, u32 mask)
 {
 	unsigned int i, perm = 1;
+	size_t num_chrs = strlen(chrs);
+
+	for (i = 0; i < num_chrs; perm <<= 1, i++) {
+		if (mask & perm) {
+			/* Ensure that one byte is left for NUL-termination */
+			if (WARN_ON_ONCE(str_size <= 1))
+				continue;
 
-	for (i = 0; i < 32; perm <<= 1, i++) {
-		if (mask & perm)
 			*str++ = chrs[i];
+			str_size--;
+		}
 	}
 	*str = '\0';
 }
@@ -236,7 +245,7 @@ void aa_audit_perm_mask(struct audit_buffer *ab, u32 mask, const char *chrs,
 
 	audit_log_format(ab, "\"");
 	if ((mask & chrsmask) && chrs) {
-		aa_perm_mask_to_str(str, chrs, mask & chrsmask);
+		aa_perm_mask_to_str(str, sizeof(str), chrs, mask & chrsmask);
 		mask &= ~chrsmask;
 		audit_log_format(ab, "%s", str);
 		if (mask & namesmask)
-- 
2.7.4

