Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ZUrlcsE4QfQ0Y7PEBMidicHxsg1q3T/5yw2Hjn+at4WOzZGkv1DKz8taFSoS3/eQkYvsT
ARC-Seal: i=1; a=rsa-sha256; t=1524405405; cv=none;
        d=google.com; s=arc-20160816;
        b=NUd8SdkW6dao6BQxmvNsgVAzdkkKSC7X6KQ6YXLXaLADqmrJ/HZXrRbAqgUTKj3Vr9
         ZxJ4sqc+5syGDCyCEQcvLVlIol7eN3RdAst8swRZeIWLEhXCBfL1T080WzdExCyRP1Qh
         f9MGPFjOAM9+GCBNkAO4T5H+lvzrgL9gWjwG4aTDHUI899L1zMuKg88bNxSlxpmDt820
         NQOKAOYRkfEwOvuC1PDLUYI2MgQiqCb/y/cc1yvkaVlGQii6/8v+MnULzK8I9nJTs/u+
         AeyNPB611p03XYWQ+MulfW4Vogtcfdlrawc7Wlcaetn05loLTL9nrSXJc00gU6GGh7AC
         Tn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lSf4CFvfbplhLbykSV4t6N+3jH1uPkuGkrF7JjAr8cU=;
        b=D6OWFJRG0/PRj9foLmAf7v0wfulsxmAP90YlBK09HIKlyPF59J6hYU5931OcFiPoSp
         UQ+oENzeUBVLDwqB6tt7daP5LlSnS3l27tokghOC9AoqG+VT4/Vw+6rrKua5zaFmSVA7
         AGOdrnsDJmi7RnStzFDPMqc0EpdOTVJNtQgmuzlBmEICmXASd4e7XNehgnOKdzq8Or63
         vOpGhjgNBgAY9p5xNKTJxpNjEl2GPkYFKKdEbXBYXro3bHLDGZkUxVInOgnmJREvV+Km
         MPCqJMOqcTTxQGwRQTl5nKFfdzlIY0bXvRgEvq9cApSwviVdGBBXEpg7dSMCgEn4AMb5
         ZtEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aurelien Aptel <aaptel@suse.com>,
	Steve French <smfrench@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.16 055/196] CIFS: add sha512 secmech
Date: Sun, 22 Apr 2018 15:51:15 +0200
Message-Id: <20180422135106.986882742@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454922231390535?=
X-GMAIL-MSGID: =?utf-8?q?1598454922231390535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Aptel <aaptel@suse.com>

commit 5fcd7f3f966f37f3f9a215af4cc1597fe338d0d5 upstream.

* prepare for SMB3.11 pre-auth integrity
* enable sha512 when SMB311 is enabled in Kconfig
* add sha512 as a soft dependency

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/Kconfig         |    1 +
 fs/cifs/cifsencrypt.c   |    7 +++++++
 fs/cifs/cifsfs.c        |    1 +
 fs/cifs/cifsglob.h      |    2 ++
 fs/cifs/smb2proto.h     |    3 +++
 fs/cifs/smb2transport.c |   30 ++++++++++++++++++++++++++++++
 6 files changed, 44 insertions(+)

--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -189,6 +189,7 @@ config CIFS_NFSD_EXPORT
 config CIFS_SMB311
 	bool "SMB3.1.1 network file system support (Experimental)"
 	depends on CIFS
+	select CRYPTO_SHA512
 
 	help
 	  This enables experimental support for the newest, SMB3.1.1, dialect.
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -829,6 +829,11 @@ cifs_crypto_secmech_release(struct TCP_S
 		server->secmech.md5 = NULL;
 	}
 
+	if (server->secmech.md5) {
+		crypto_free_shash(server->secmech.sha512);
+		server->secmech.sha512 = NULL;
+	}
+
 	if (server->secmech.hmacmd5) {
 		crypto_free_shash(server->secmech.hmacmd5);
 		server->secmech.hmacmd5 = NULL;
@@ -852,4 +857,6 @@ cifs_crypto_secmech_release(struct TCP_S
 	server->secmech.sdeschmacmd5 = NULL;
 	kfree(server->secmech.sdescmd5);
 	server->secmech.sdescmd5 = NULL;
+	kfree(server->secmech.sdescsha512);
+	server->secmech.sdescsha512 = NULL;
 }
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1486,6 +1486,7 @@ MODULE_SOFTDEP("pre: nls");
 MODULE_SOFTDEP("pre: aes");
 MODULE_SOFTDEP("pre: cmac");
 MODULE_SOFTDEP("pre: sha256");
+MODULE_SOFTDEP("pre: sha512");
 MODULE_SOFTDEP("pre: aead2");
 MODULE_SOFTDEP("pre: ccm");
 module_init(init_cifs)
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -130,10 +130,12 @@ struct cifs_secmech {
 	struct crypto_shash *md5; /* md5 hash function */
 	struct crypto_shash *hmacsha256; /* hmac-sha256 hash function */
 	struct crypto_shash *cmacaes; /* block-cipher based MAC function */
+	struct crypto_shash *sha512; /* sha512 hash function */
 	struct sdesc *sdeschmacmd5;  /* ctxt to generate ntlmv2 hash, CR1 */
 	struct sdesc *sdescmd5; /* ctxt to generate cifs/smb signature */
 	struct sdesc *sdeschmacsha256;  /* ctxt to generate smb2 signature */
 	struct sdesc *sdesccmacaes;  /* ctxt to generate smb3 signature */
+	struct sdesc *sdescsha512; /* ctxt to generate smb3.11 signing key */
 	struct crypto_aead *ccmaesencrypt; /* smb3 encryption aead */
 	struct crypto_aead *ccmaesdecrypt; /* smb3 decryption aead */
 };
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -202,4 +202,7 @@ extern int smb3_validate_negotiate(const
 
 extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
+#ifdef CONFIG_CIFS_SMB311
+extern int smb311_crypto_shash_allocate(struct TCP_Server_Info *server);
+#endif
 #endif			/* _SMB2PROTO_H */
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -70,6 +70,36 @@ err:
 	return rc;
 }
 
+#ifdef CONFIG_CIFS_SMB311
+int
+smb311_crypto_shash_allocate(struct TCP_Server_Info *server)
+{
+	struct cifs_secmech *p = &server->secmech;
+	int rc = 0;
+
+	rc = cifs_alloc_hash("hmac(sha256)",
+			     &p->hmacsha256,
+			     &p->sdeschmacsha256);
+	if (rc)
+		return rc;
+
+	rc = cifs_alloc_hash("cmac(aes)", &p->cmacaes, &p->sdesccmacaes);
+	if (rc)
+		goto err;
+
+	rc = cifs_alloc_hash("sha512", &p->sha512, &p->sdescsha512);
+	if (rc)
+		goto err;
+
+	return 0;
+
+err:
+	cifs_free_hash(&p->cmacaes, &p->sdesccmacaes);
+	cifs_free_hash(&p->hmacsha256, &p->sdeschmacsha256);
+	return rc;
+}
+#endif
+
 static struct cifs_ses *
 smb2_find_smb_ses_unlocked(struct TCP_Server_Info *server, __u64 ses_id)
 {
