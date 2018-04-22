Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4929oiybnSTM9cquiRegq2pzioIYUcMUtf978MmDhfZ9D6HhZZUagFK5gZtnP2J/X614cfN
ARC-Seal: i=1; a=rsa-sha256; t=1524405925; cv=none;
        d=google.com; s=arc-20160816;
        b=Mk/IwHP4BqMmcyiwID+3jsfvqXsPFdLDfR1iJXVO/rHq/jcRv7/JSyAKrGFPUwBeL9
         7yZfJXfpZfkpfitqsvs4GaMh2jgUcSJzuUk72fwzb2VFxCZD5nJ9drhMtfyhcgiicagY
         nu/LMsGbw/933sy1MCONffL7knKOteKXidWuj9aFbucZ+ElmD3McojW4krRUPgAfCUR3
         bN5A1P+VMT6BN3JS94Pn/LnarUsTJrzwdaxpnzPqSFyX2+ljM2qp0zutwdW1B4uk9PWv
         r7LUdbMvggrCjlyy6Y9GMcLwxt7mEBGxCoXlaLjCmB/O5c94kJFCGvxL+DKsHIBEaO3t
         vbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BuGxgKR0KxYx6mCx67gKTFcXcD6cQiq+Ob/92Sngrdg=;
        b=f8qZ8gU7KMPmOqD1vQPpIyA0aP/IfWWMh2Tiv12/CycZeBMi3tvZED7eX9KfuwxxS5
         AGULCRMqRL7xsyiIxoEeLNIsurT/a0ObURXuPa0x3uWUU3Q6832Ccd8fTYCx6GZ7yhiV
         Z0FSRMrcO4AWEo3CJRec0v323mRkJ69MeTYRq1Atu75qUgwwnESlB2ZBHUgdV4BjPeA7
         QMEdKjkV5iky79wbEs3PJy13S+jEjxkChGqhUY8Ud1mzJL5XyvfFV9Q0o2ndZjAvelGr
         fWLe7pjZeGJUujLbHpFz/uKKfLcAI9LK1URA1Ugw7JeQUK0UujFXAi5TeWOklL2Kul3r
         nKMQ==
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
Subject: [PATCH 4.14 049/164] CIFS: add sha512 secmech
Date: Sun, 22 Apr 2018 15:51:56 +0200
Message-Id: <20180422135137.410100381@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454922231390535?=
X-GMAIL-MSGID: =?utf-8?q?1598455467528470392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -190,6 +190,7 @@ config CIFS_NFSD_EXPORT
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
@@ -1476,6 +1476,7 @@ MODULE_SOFTDEP("pre: nls");
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
@@ -203,4 +203,7 @@ extern int smb3_validate_negotiate(const
 
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
