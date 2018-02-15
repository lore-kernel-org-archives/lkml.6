Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720446-2-17286714987213388529
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720445; b=r/08gT15B7Zq8imaYbJypWjuxqb/UtMgmkG9roPsfq8oEWJ
    KAjIT0Mcjsp5QSy0M3BEk7YlX7y18yE4vXL1+I4uY3ItKL3Yfi+dCQGKoJVcKoiU
    c9Hhx0YuVefBPwLrZp3ywfFJwTga3eOiX632Ln+IXNiT8QmmrJU0Yyak5MEvYZzy
    S7sYNiiobXCUVoHI4JuJKRsq4ib75GivwK4WlBAq5xoEaRtyF72stHL73vRYkit2
    Leu0hUJnW3LbS6sqWcYPhWlbOoEsM7AspPujazW6RKPL8JjHEmLcDaVlH+1LsTsL
    XRmjhVHbLXtJ52zbXkxlcbU+Bs0/ShziO3C091g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720445; bh=HgMrIi0KM3i7BGkPhHlhrcurUf
    nVUtbwLfDtOK/qHxs=; b=tRv2oVzAc4I/nd+3N1f3ny9C07ujZMVg1lMYEGNNVt
    t0i4FLz3l3G+5GNZUTRVYJKYYUcKPT0oa2EyybLrgKKipmhJsAyQ2/DGdvcnDpr5
    7tPhAcNgHPCGNrRWPyTmT/nnKdKrs6W+retxKZkTJHl99iweZMzEwHCqbB/kbALx
    exbH6Z/09qOLN/0QLSC3G7d8pU2ajZda1Hqw7nxQDUeex+/CI3hzrQf/mhBgHKA4
    1qqrqV7eeMaUrnCyFL3NtOTykQPJcwRWnnH10gjYg3lokOAThiTaYUSQoqiirPJe
    sPZAhVaBKROMqSpYtPPgbnOeSBw1PfPin9t49Qwyqydg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161760AbeBOPWX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:22:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161525AbeBOPWV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
        Steve French <smfrench@gmail.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.4 042/108] CIFS: zero sensitive data when freeing
Date: Thu, 15 Feb 2018 16:16:39 +0100
Message-Id: <20180215151228.322447988@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -306,9 +306,8 @@ int calc_lanman_hash(const char *passwor
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
@@ -1695,7 +1695,7 @@ cifs_parse_mount_options(const char *mou
 			tmp_end++;
 			if (!(tmp_end < end && tmp_end[1] == delim)) {
 				/* No it is not. Set the password to NULL */
-				kfree(vol->password);
+				kzfree(vol->password);
 				vol->password = NULL;
 				break;
 			}
@@ -1733,7 +1733,7 @@ cifs_parse_mount_options(const char *mou
 					options = end;
 			}
 
-			kfree(vol->password);
+			kzfree(vol->password);
 			/* Now build new password string */
 			temp_len = strlen(value);
 			vol->password = kzalloc(temp_len+1, GFP_KERNEL);
@@ -4148,7 +4148,7 @@ cifs_construct_tcon(struct cifs_sb_info
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
 
