Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22754HeJff7jd/213aslaDducky9TCCgMp+Manxa9XYkAguBTsR/B+eSwxW5TbBh9ktXmZdV
ARC-Seal: i=1; a=rsa-sha256; t=1518708370; cv=none;
        d=google.com; s=arc-20160816;
        b=xG3ySaH4+NDyiumW30/eYMu8xLBsx+FfCx2YXV4+UCHnrbijxNVxGRYQyUxkvqsB3N
         HAHFwF4m/lmXM9IR+DlxAUsLo0sCMOPYBK5+/9L5N/QDAC4HkaQZsWAVdFCdtPylD25J
         RbTcNNZkom7qlikcUpgRlkGYAtWuPVtmoDFI2poGvG0nF1eloZDUU6BiFWgFX7FmrKlp
         S4IEeuTq68rQOOp0G/su7APABgSr2/ZtkLQSXSDkjegU2si6paJ5ha9M6Iev/LepuBuJ
         i1pMX2zTQJeJOH7DTqHBR3edvdsrpJ/ON1+Qs+1y537eKASRTTOriP11LRVrkevvmg4d
         GpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ea5rY2FamHaaCIXbuTsfD2zbxYt4gs4AtLUvZghrLIg=;
        b=egm0XeZhKC6VGI2D4d7fO5ridLGxhCh21NndHRYltVg9yKu+H9wJAx2th83jgRMf8R
         rhOI9CFOqrT7aeiL8YopOgGxm++LfSoT/Exuwi8GfzD+I55BJi5Nr9dyYIiaCafplcZH
         VPQgNMgNKLsb6u5XSygsJCwhsa2/R6qHiAsRyyVAfG9i7RpuObOaBY0ZqwIyaQfF8sMI
         jB2Z3cAHdmON2AMMOFC/avFtu7D+QpXx8OlAakYRMs36xYTSRGA3O4vJDpjZqXWMzHng
         kZyNZH+/D3vXQZInLmn4jiLa1B+cE0vbqoqtjyGvQDkW6jxiufop4sVNk73Y7qDLy/x5
         b0Pg==
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
Subject: [PATCH 4.9 04/88] CIFS: zero sensitive data when freeing
Date: Thu, 15 Feb 2018 16:16:31 +0100
Message-Id: <20180215151223.108761945@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480706706045067?=
X-GMAIL-MSGID: =?utf-8?q?1592481148222399861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -318,9 +318,8 @@ int calc_lanman_hash(const char *passwor
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
@@ -1667,7 +1667,7 @@ cifs_parse_mount_options(const char *mou
 			tmp_end++;
 			if (!(tmp_end < end && tmp_end[1] == delim)) {
 				/* No it is not. Set the password to NULL */
-				kfree(vol->password);
+				kzfree(vol->password);
 				vol->password = NULL;
 				break;
 			}
@@ -1705,7 +1705,7 @@ cifs_parse_mount_options(const char *mou
 					options = end;
 			}
 
-			kfree(vol->password);
+			kzfree(vol->password);
 			/* Now build new password string */
 			temp_len = strlen(value);
 			vol->password = kzalloc(temp_len+1, GFP_KERNEL);
@@ -4159,7 +4159,7 @@ cifs_construct_tcon(struct cifs_sb_info
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
 
