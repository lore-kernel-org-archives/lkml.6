Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49/rP3YZu1B9rxUV0TW7KBM9fS1cPvKcAxqg7lUT0+3midZ5PEj8p35PHSQZ2eqB54D2IZs
ARC-Seal: i=1; a=rsa-sha256; t=1524405408; cv=none;
        d=google.com; s=arc-20160816;
        b=PBe9pbQFiKmmVld8bYHXHaN4u/6AmIYwmrB28KANWyVKUjqyEHJkCchdEa+apTmoFD
         jIX0LJ9Hb5MjJxaGZoAtvbEJWyN++MyGLIb4OSoNxkTumR7WCrJC2ETg0RvKTt6LRSiP
         LrYFhQP8SlWkGUoxh4D5jgakq4o14EMnCt4qK3BalenJk2dSeZcJkGA5NUrvz6AGy+8S
         AgzK+mY5sNw141pgtHOxaR1k41xwQAFmSAiTndYFkoN/21X5lmG7jA0xO4b3QEoGSUr5
         JUEsZGG2FJsQrK4A9eFHUulbA9Ps9ZxjiV0qpt7YlJOVW+/dAWKoil5dkkEeyKmcUEY1
         /akQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7us1cTr7yQf2nelGRZQZq/yGxs+cD4EJaf9GZZRJWIo=;
        b=kCuorI3B/7Mi24wNeno3H4/rMm9kMqk1ObMkqyFecGRaF/zrK+dxX+k4mi7zkpUUxV
         rHaolyd51Na8f97Irg4HrlMiNoKSOC5ZOAB4QyJte4jSL4USgWai0BntrAK51CyldCt3
         wrPdznXeOpswVH6KQwRYqXvTEOfk6+QROaVc/xhgxoGypesBLosxXEV2GZJWnryr6Fnx
         4IDNX9u7XKe3i4OMj6oGXkETOUaPoABLci9y3/qqsVB9v7ftjpgcZWpYNI8rdpES0gUd
         WO05Oack3qfmcSKaqIeyPPsCQxZmT1dzH2lRk6VxuqDEeiHGVnEavFTN23pQyTPjThCP
         KSFg==
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
Subject: [PATCH 4.16 056/196] CIFS: implement v3.11 preauth integrity
Date: Sun, 22 Apr 2018 15:51:16 +0200
Message-Id: <20180422135107.071276831@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454925737207992?=
X-GMAIL-MSGID: =?utf-8?q?1598454925737207992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Aptel <aaptel@suse.com>

commit 8bd68c6e47abff34e412a0c68cecb4a36bf0198b upstream.

SMB3.11 clients must implement pre-authentification integrity.

* new mechanism to certify requests/responses happening before Tree
  Connect.
* supersedes VALIDATE_NEGOTIATE
* fixes signing for SMB3.11

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h  |    5 ++--
 fs/cifs/smb2misc.c  |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/smb2pdu.c   |   25 ++++++++++++++++++++
 fs/cifs/smb2pdu.h   |    1 
 fs/cifs/smb2proto.h |    2 +
 fs/cifs/transport.c |   17 +++++++++++++
 6 files changed, 112 insertions(+), 2 deletions(-)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -675,7 +675,8 @@ struct TCP_Server_Info {
 	unsigned int	max_read;
 	unsigned int	max_write;
 #ifdef CONFIG_CIFS_SMB311
-	__u8	preauth_sha_hash[64]; /* save initital negprot hash */
+	 /* save initital negprot hash */
+	__u8	preauth_sha_hash[SMB2_PREAUTH_HASH_SIZE];
 #endif /* 3.1.1 */
 	struct delayed_work reconnect; /* reconnect workqueue job */
 	struct mutex reconnect_mutex; /* prevent simultaneous reconnects */
@@ -864,7 +865,7 @@ struct cifs_ses {
 	__u8 smb3encryptionkey[SMB3_SIGN_KEY_SIZE];
 	__u8 smb3decryptionkey[SMB3_SIGN_KEY_SIZE];
 #ifdef CONFIG_CIFS_SMB311
-	__u8 preauth_sha_hash[64];
+	__u8 preauth_sha_hash[SMB2_PREAUTH_HASH_SIZE];
 #endif /* 3.1.1 */
 };
 
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -706,3 +706,67 @@ smb2_handle_cancelled_mid(char *buffer,
 
 	return 0;
 }
+
+#ifdef CONFIG_CIFS_SMB311
+/**
+ * smb311_update_preauth_hash - update @ses hash with the packet data in @iov
+ *
+ * Assumes @iov does not contain the rfc1002 length and iov[0] has the
+ * SMB2 header.
+ */
+int
+smb311_update_preauth_hash(struct cifs_ses *ses, struct kvec *iov, int nvec)
+{
+	int i, rc;
+	struct sdesc *d;
+	struct smb2_sync_hdr *hdr;
+
+	if (ses->server->tcpStatus == CifsGood) {
+		/* skip non smb311 connections */
+		if (ses->server->dialect != SMB311_PROT_ID)
+			return 0;
+
+		/* skip last sess setup response */
+		hdr = (struct smb2_sync_hdr *)iov[0].iov_base;
+		if (hdr->Flags & SMB2_FLAGS_SIGNED)
+			return 0;
+	}
+
+	rc = smb311_crypto_shash_allocate(ses->server);
+	if (rc)
+		return rc;
+
+	d = ses->server->secmech.sdescsha512;
+	rc = crypto_shash_init(&d->shash);
+	if (rc) {
+		cifs_dbg(VFS, "%s: could not init sha512 shash\n", __func__);
+		return rc;
+	}
+
+	rc = crypto_shash_update(&d->shash, ses->preauth_sha_hash,
+				 SMB2_PREAUTH_HASH_SIZE);
+	if (rc) {
+		cifs_dbg(VFS, "%s: could not update sha512 shash\n", __func__);
+		return rc;
+	}
+
+	for (i = 0; i < nvec; i++) {
+		rc = crypto_shash_update(&d->shash,
+					 iov[i].iov_base, iov[i].iov_len);
+		if (rc) {
+			cifs_dbg(VFS, "%s: could not update sha512 shash\n",
+				 __func__);
+			return rc;
+		}
+	}
+
+	rc = crypto_shash_final(&d->shash, ses->preauth_sha_hash);
+	if (rc) {
+		cifs_dbg(VFS, "%s: could not finalize sha512 shash\n",
+			 __func__);
+		return rc;
+	}
+
+	return 0;
+}
+#endif
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -453,6 +453,10 @@ SMB2_negotiate(const unsigned int xid, s
 		return rc;
 
 	req->sync_hdr.SessionId = 0;
+#ifdef CONFIG_CIFS_SMB311
+	memset(server->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
+	memset(ses->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
+#endif
 
 	if (strcmp(ses->server->vals->version_string,
 		   SMB3ANY_VERSION_STRING) == 0) {
@@ -564,6 +568,15 @@ SMB2_negotiate(const unsigned int xid, s
 
 	/* BB: add check that dialect was valid given dialect(s) we asked for */
 
+#ifdef CONFIG_CIFS_SMB311
+	/*
+	 * Keep a copy of the hash after negprot. This hash will be
+	 * the starting hash value for all sessions made from this
+	 * server.
+	 */
+	memcpy(server->preauth_sha_hash, ses->preauth_sha_hash,
+	       SMB2_PREAUTH_HASH_SIZE);
+#endif
 	/* SMB2 only has an extended negflavor */
 	server->negflavor = CIFS_NEGFLAVOR_EXTENDED;
 	/* set it to the maximum buffer size value we can send with 1 credit */
@@ -621,6 +634,10 @@ int smb3_validate_negotiate(const unsign
 		return 0;
 #endif
 
+	/* In SMB3.11 preauth integrity supersedes validate negotiate */
+	if (tcon->ses->server->dialect == SMB311_PROT_ID)
+		return 0;
+
 	/*
 	 * validation ioctl must be signed, so no point sending this if we
 	 * can not sign it (ie are not known user).  Even if signing is not
@@ -1148,6 +1165,14 @@ SMB2_sess_setup(const unsigned int xid,
 	sess_data->buf0_type = CIFS_NO_BUFFER;
 	sess_data->nls_cp = (struct nls_table *) nls_cp;
 
+#ifdef CONFIG_CIFS_SMB311
+	/*
+	 * Initialize the session hash with the server one.
+	 */
+	memcpy(ses->preauth_sha_hash, ses->server->preauth_sha_hash,
+	       SMB2_PREAUTH_HASH_SIZE);
+#endif
+
 	while (sess_data->func)
 		sess_data->func(sess_data);
 
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -264,6 +264,7 @@ struct smb2_negotiate_req {
 #define SMB311_SALT_SIZE			32
 /* Hash Algorithm Types */
 #define SMB2_PREAUTH_INTEGRITY_SHA512	cpu_to_le16(0x0001)
+#define SMB2_PREAUTH_HASH_SIZE 64
 
 struct smb2_preauth_neg_context {
 	__le16	ContextType; /* 1 */
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -204,5 +204,7 @@ extern enum securityEnum smb2_select_sec
 					enum securityEnum);
 #ifdef CONFIG_CIFS_SMB311
 extern int smb311_crypto_shash_allocate(struct TCP_Server_Info *server);
+extern int smb311_update_preauth_hash(struct cifs_ses *ses,
+				      struct kvec *iov, int nvec);
 #endif
 #endif			/* _SMB2PROTO_H */
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -37,6 +37,7 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
+#include "smb2proto.h"
 #include "smbdirect.h"
 
 /* Max number of iovectors we can use off the stack when sending requests. */
@@ -751,6 +752,12 @@ cifs_send_recv(const unsigned int xid, s
 	if (rc < 0)
 		goto out;
 
+#ifdef CONFIG_CIFS_SMB311
+	if (ses->status == CifsNew)
+		smb311_update_preauth_hash(ses, rqst->rq_iov+1,
+					   rqst->rq_nvec-1);
+#endif
+
 	if (timeout == CIFS_ASYNC_OP)
 		goto out;
 
@@ -789,6 +796,16 @@ cifs_send_recv(const unsigned int xid, s
 	else
 		*resp_buf_type = CIFS_SMALL_BUFFER;
 
+#ifdef CONFIG_CIFS_SMB311
+	if (ses->status == CifsNew) {
+		struct kvec iov = {
+			.iov_base = buf + 4,
+			.iov_len = get_rfc1002_length(buf)
+		};
+		smb311_update_preauth_hash(ses, &iov, 1);
+	}
+#endif
+
 	credits = ses->server->ops->get_credits(midQ);
 
 	rc = ses->server->ops->check_receive(midQ, ses->server,
