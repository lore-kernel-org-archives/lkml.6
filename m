Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ufQT4tA3BJw6TD/xzwI1Imbtw9W4dAVU+M+fG8mno7bYuCsqMUJwSePrx53etUKk6KuYf
ARC-Seal: i=1; a=rsa-sha256; t=1518707949; cv=none;
        d=google.com; s=arc-20160816;
        b=nOqd6/jyMYTd0umQs96Pe/L02yNAVPECrDGoSPqjxjrMHow6Xti868KYt0WRt2LPjk
         15XE9BAbtWYPIWxGFCA1iI00KB6bX31oH0PdO3TmiPG1fbp61WfUjlHx6JXf/rmow/cB
         CuDrpqSBEfHC3D5P35rgPjP+D9FRAR4RY8MwdngsFLaA+OIJudsiy0M0h6g+Wx7dG4HM
         JzfdfuIiGMzT/44eC82vJbgeJW0SMJAjFHdVTs5aiwwMo1cOtTGPX/cl3cFAxziAkL4C
         E2VH8xFpOdtoqecXG2CTUjn5DIXGRB9qgXIWCCPWGtESi7U0llBSckbJTL6KdtTC6/lm
         bGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WEsB8OlQa1QdvQp0EMowQrlj8tMIG2RA10HGgzxafc8=;
        b=aWZdnLjzQ2GREsqfBMKR54D+FbV2mIUHlpBezlTLZ0xlRU219ku4hEdp0uwLENM6zj
         oqM1rJLrsK5Cqsjs6qOXLDD9N0evzs0pxrpqx8emBvhSZ3fthrFwF3ScRoCMaTfl+ly9
         KubgZP130/hgypB0CQ4b+GcceK6JTf9aB/Bfkp9/fefR1Ykffz5wyG/xTXpJ1NRxIrfW
         eFOk4BNvDXvfXkww1AoRpGuTTs5x95m7ZE38mjxTf1AZSmrXIvt1Slwd7mP5/aokbUsR
         GNyh508RGrY2riUFMawD72WyXxoOd2mlkRswHNZHxWGEtNHPSBg53vwW/Yqeg5BYB7zP
         u6Pg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aurelien Aptel <aaptel@suse.com>,
	Steve French <smfrench@gmail.com>,
	Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 3.18 13/45] CIFS: zero sensitive data when freeing
Date: Thu, 15 Feb 2018 16:17:04 +0100
Message-Id: <20180215144118.632102898@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480706706045067?=
X-GMAIL-MSGID: =?utf-8?q?1592480706706045067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Aptel <aaptel@suse.com>

commit 97f4b7276b829a8927ac903a119bef2f963ccc58 upstream.

also replaces memset()+kfree() by kzfree().

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsencrypt.c |    3 +--
 fs/cifs/connect.c     |    6 +++---
 fs/cifs/misc.c        |   14 ++++----------
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
@@ -1650,7 +1650,7 @@ cifs_parse_mount_options(const char *mou
 			tmp_end++;
 			if (!(tmp_end < end && tmp_end[1] == delim)) {
 				/* No it is not. Set the password to NULL */
-				kfree(vol->password);
+				kzfree(vol->password);
 				vol->password = NULL;
 				break;
 			}
@@ -1688,7 +1688,7 @@ cifs_parse_mount_options(const char *mou
 					options = end;
 			}
 
-			kfree(vol->password);
+			kzfree(vol->password);
 			/* Now build new password string */
 			temp_len = strlen(value);
 			vol->password = kzalloc(temp_len+1, GFP_KERNEL);
@@ -4046,7 +4046,7 @@ cifs_construct_tcon(struct cifs_sb_info
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
@@ -136,10 +133,7 @@ tconInfoFree(struct cifs_tcon *buf_to_fr
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
 
