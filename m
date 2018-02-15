Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yK9Z3Wcl1th9BfOiqn3eBowbFltO3t0yjURydfeE36sNT4pShz1MwYyZI9NsV8xLR9RUt
ARC-Seal: i=1; a=rsa-sha256; t=1518709142; cv=none;
        d=google.com; s=arc-20160816;
        b=q9VPg2RLE5K1FFKdhNtCYuCUiUFoj5UgJlwv8bO8ZnFi4KdEqWroezTwynb1SRcj9Q
         IBZc/I3LtuZuSQetES/realGv7S3XRvK7T5KnRiARkq4GfGrqG74CT/1ecpc7Kr6DlOm
         jSDMmr6qGiqxmCDHaGKF2tyM9N7psOwz/AJXFn75X4thlDsYirp2RIrjgvu5Mr+Q9SxY
         fj3utB66uH7PWfF5J5olQr68yb3Wfw98WMhenbAf8oTMfa8PRUKCXOYicXg1s2faRErD
         M1AiTOE90dpPiqygQ08Bl6jU3fOY5Ji6jkkZMyQlmXnrEZdNsAkrwo0fwIqyisjCvT5N
         xVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wu5IKbNKkSRsHtlXYVAEHvQzQKOMukw+3uLWvHgMT2o=;
        b=e6alF/hsEehvpsH9FF9OXqbJeMZRPLOqO5kNcyq1cuzZX8hDLf8g4ldzWJGvEPY+G1
         nDU8STYWdbNAcBotnHsbGMZeBruIsB0kJ2TcFxkPE8mcHvCQaukmNy6BcxAkZU9jWLTy
         hw15q8je8cG8XN+/GSGa+Xjp+YZT6e6YWwbhuHozptbeT9suzXnwlCFki+uuNVVRVBBo
         Yq9McFRzwU57RUxYwQu0DwU1v+71k6OWbMMUNvl6Rrvywj7Bl2/EGhuN5qlCgjPWl6gM
         sCYZDzBUQxeiQKA9CaoDnJttewR6IsIK12GWhXAKaS4I+t4lUDd5twiT0nm1m5LaT3A6
         a92w==
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
Subject: [PATCH 4.15 004/202] CIFS: zero sensitive data when freeing
Date: Thu, 15 Feb 2018 16:15:04 +0100
Message-Id: <20180215151713.009348339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480706706045067?=
X-GMAIL-MSGID: =?utf-8?q?1592481958115052344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -325,9 +325,8 @@ int calc_lanman_hash(const char *passwor
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
@@ -1707,7 +1707,7 @@ cifs_parse_mount_options(const char *mou
 			tmp_end++;
 			if (!(tmp_end < end && tmp_end[1] == delim)) {
 				/* No it is not. Set the password to NULL */
-				kfree(vol->password);
+				kzfree(vol->password);
 				vol->password = NULL;
 				break;
 			}
@@ -1745,7 +1745,7 @@ cifs_parse_mount_options(const char *mou
 					options = end;
 			}
 
-			kfree(vol->password);
+			kzfree(vol->password);
 			/* Now build new password string */
 			temp_len = strlen(value);
 			vol->password = kzalloc(temp_len+1, GFP_KERNEL);
@@ -4235,7 +4235,7 @@ cifs_construct_tcon(struct cifs_sb_info
 		reset_cifs_unix_caps(0, tcon, NULL, vol_info);
 out:
 	kfree(vol_info->username);
-	kfree(vol_info->password);
+	kzfree(vol_info->password);
 	kfree(vol_info);
 
 	return tcon;
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -98,14 +98,11 @@ sesInfoFree(struct cifs_ses *buf_to_free
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
 
