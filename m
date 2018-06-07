Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qKVBCMpDGVtfDAAAmS7hNA
	; Thu, 07 Jun 2018 14:41:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 361A46089E; Thu,  7 Jun 2018 14:41:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A4D52607DC;
	Thu,  7 Jun 2018 14:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4D52607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934203AbeFGOlW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:41:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40580 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932931AbeFGOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:19 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zi-60; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002x7-FE; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Aurelien Aptel" <aaptel@suse.com>,
        "Pavel Shilovsky" <pshilov@microsoft.com>,
        "Steve French" <smfrench@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.881015899@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 171/410] CIFS: zero sensitive data when freeing
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Aptel <aaptel@suse.com>

commit 97f4b7276b829a8927ac903a119bef2f963ccc58 upstream.

also replaces memset()+kfree() by kzfree().

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifsencrypt.c |  3 +--
 fs/cifs/connect.c     |  6 +++---
 fs/cifs/misc.c        | 14 ++++----------
 3 files changed, 8 insertions(+), 15 deletions(-)

--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -303,9 +303,8 @@ int calc_lanman_hash(const char *passwor
 {
 	int i;
 	int rc;
-	char password_with_pad[CIFS_ENCPWD_SIZE];
+	char password_with_pad[CIFS_ENCPWD_SIZE] = {0};
 
-	memset(password_with_pad, 0, CIFS_ENCPWD_SIZE);
 	if (password)
 		strncpy(password_with_pad, password, CIFS_ENCPWD_SIZE);
 
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1614,7 +1614,7 @@ cifs_parse_mount_options(const char *mou
 			tmp_end++;
 			if (!(tmp_end < end && tmp_end[1] == delim)) {
 				/* No it is not. Set the password to NULL */
-				kfree(vol->password);
+				kzfree(vol->password);
 				vol->password = NULL;
 				break;
 			}
@@ -1652,7 +1652,7 @@ cifs_parse_mount_options(const char *mou
 					options = end;
 			}
 
-			kfree(vol->password);
+			kzfree(vol->password);
 			/* Now build new password string */
 			temp_len = strlen(value);
 			vol->password = kzalloc(temp_len+1, GFP_KERNEL);
@@ -4039,7 +4039,7 @@ cifs_construct_tcon(struct cifs_sb_info
 		reset_cifs_unix_caps(0, tcon, NULL, vol_info);
 out:
 	kfree(vol_info->username);
-	kfree(vol_info->password);
+	kzfree(vol_info->password);
 	kfree(vol_info);
 
 	return tcon;
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -99,14 +99,11 @@ sesInfoFree(struct cifs_ses *buf_to_free
 	kfree(buf_to_free->serverOS);
 	kfree(buf_to_free->serverDomain);
 	kfree(buf_to_free->serverNOS);
-	if (buf_to_free->password) {
-		memset(buf_to_free->password, 0, strlen(buf_to_free->password));
-		kfree(buf_to_free->password);
-	}
+	kzfree(buf_to_free->password);
 	kfree(buf_to_free->user_name);
 	kfree(buf_to_free->domainName);
-	kfree(buf_to_free->auth_key.response);
-	kfree(buf_to_free);
+	kzfree(buf_to_free->auth_key.response);
+	kzfree(buf_to_free);
 }
 
 struct cifs_tcon *
@@ -137,10 +134,7 @@ tconInfoFree(struct cifs_tcon *buf_to_fr
 	}
 	atomic_dec(&tconInfoAllocCount);
 	kfree(buf_to_free->nativeFileSystem);
-	if (buf_to_free->password) {
-		memset(buf_to_free->password, 0, strlen(buf_to_free->password));
-		kfree(buf_to_free->password);
-	}
+	kzfree(buf_to_free->password);
 	kfree(buf_to_free);
 }
 
