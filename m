Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Od3ZXMW1SYVHeuoHR58vA2nXp20caBt5ff5PONu6AaD+GPxevrrNYANr95F0wBtR3m6dF
ARC-Seal: i=1; a=rsa-sha256; t=1518708858; cv=none;
        d=google.com; s=arc-20160816;
        b=f/umlIJBuiyML/auQUfdzJqB2PWsxIRfsEEcSoEUYzt9B+cJn+sZEcDSQZoZ3vF/OM
         9gDQGJCGJZiMzhmRteheXdlh3JNKwEKW9rXdctyYUaGnF+lj/VxSYKXEWG4qyOgPuyEu
         CGnHB1cdD66fjxcx+1kUin0eXAnaz9NIFAFVgCo3IQp/4r892R3cEjgenHyzQE8V8cLp
         wTHNh38aWdpiCqcvzJ+zEFZmd0c6JLsJGmHQauN9VLlzV+Wtmbhx9e+fXhuuXa5dj66L
         kdLa1uM63Hcr0+y0WAEPGu5t0TMeTCv22yNArOWGflEEHLVIJBpetNLS1g0yOCJ3dXNa
         soag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SzS+AvKHgthmTI/vUSZho+a4wiLV5x9kOznfJ3SeC5s=;
        b=B5OYmRPGqvgTM9mHpeycVYuptKzCvKap/54dYe388F3fHDuclPa8ggyYBh9vS+/9zc
         Dr7I5eHlP0KDEaPXeQkpq4I2VmD+xUcqx3LJWMdEyBr5ggaOsfX+WlOdNhNk2imQNN03
         erIMFoD8hCL2FoE79ugE1SIYhZXZLC6Bfdi/c+DqIRg4nsCQ4DQneI87ffrpDMg5IZ7D
         GGFxUJxRiLGD6Zf9aPzSX1YDni0pH0DwGiLEiKaX2SRJuCl5ZoX9ui3GZewusJr0T+Sc
         FqTdGH53zvcC+SZK7AYq18ceSsWs0xxx6heNTVcDQs/5Ln50TrlqwDvOESb2Vqpu31jg
         XTsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.14 106/195] NFS: Fix nfsstat breakage due to LOOKUPP
Date: Thu, 15 Feb 2018 16:16:37 +0100
Message-Id: <20180215151710.995218167@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481660024302424?=
X-GMAIL-MSGID: =?utf-8?q?1592481660024302424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 8634ef5e05311f32d7f2aee06f6b27a8834a3bd6 upstream.

The LOOKUPP operation was inserted into the nfs4_procedures array
rather than being appended, which put /proc/net/rpc/nfs out of
whack, and broke the nfsstat utility.
Fix by moving the LOOKUPP operation to the end of the array, and
by ensuring that it keeps the same length whether or not NFSV4.1
and NFSv4.2 are compiled in.

Fixes: 5b5faaf6df734 ("nfs4: add NFSv4 LOOKUPP handlers")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4xdr.c     |   64 ++++++++++++++++++++++++++++++---------------------
 include/linux/nfs4.h |   12 ++++++---
 2 files changed, 46 insertions(+), 30 deletions(-)

--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7668,6 +7668,22 @@ nfs4_stat_to_errno(int stat)
 	.p_name = #proc,	\
 }
 
+#if defined(CONFIG_NFS_V4_1)
+#define PROC41(proc, argtype, restype)				\
+	PROC(proc, argtype, restype)
+#else
+#define PROC41(proc, argtype, restype)				\
+	STUB(proc)
+#endif
+
+#if defined(CONFIG_NFS_V4_2)
+#define PROC42(proc, argtype, restype)				\
+	PROC(proc, argtype, restype)
+#else
+#define PROC42(proc, argtype, restype)				\
+	STUB(proc)
+#endif
+
 const struct rpc_procinfo nfs4_procedures[] = {
 	PROC(READ,		enc_read,		dec_read),
 	PROC(WRITE,		enc_write,		dec_write),
@@ -7688,7 +7704,6 @@ const struct rpc_procinfo nfs4_procedure
 	PROC(ACCESS,		enc_access,		dec_access),
 	PROC(GETATTR,		enc_getattr,		dec_getattr),
 	PROC(LOOKUP,		enc_lookup,		dec_lookup),
-	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 	PROC(LOOKUP_ROOT,	enc_lookup_root,	dec_lookup_root),
 	PROC(REMOVE,		enc_remove,		dec_remove),
 	PROC(RENAME,		enc_rename,		dec_rename),
@@ -7707,33 +7722,30 @@ const struct rpc_procinfo nfs4_procedure
 	PROC(RELEASE_LOCKOWNER,	enc_release_lockowner,	dec_release_lockowner),
 	PROC(SECINFO,		enc_secinfo,		dec_secinfo),
 	PROC(FSID_PRESENT,	enc_fsid_present,	dec_fsid_present),
-#if defined(CONFIG_NFS_V4_1)
-	PROC(EXCHANGE_ID,	enc_exchange_id,	dec_exchange_id),
-	PROC(CREATE_SESSION,	enc_create_session,	dec_create_session),
-	PROC(DESTROY_SESSION,	enc_destroy_session,	dec_destroy_session),
-	PROC(SEQUENCE,		enc_sequence,		dec_sequence),
-	PROC(GET_LEASE_TIME,	enc_get_lease_time,	dec_get_lease_time),
-	PROC(RECLAIM_COMPLETE,	enc_reclaim_complete,	dec_reclaim_complete),
-	PROC(GETDEVICEINFO,	enc_getdeviceinfo,	dec_getdeviceinfo),
-	PROC(LAYOUTGET,		enc_layoutget,		dec_layoutget),
-	PROC(LAYOUTCOMMIT,	enc_layoutcommit,	dec_layoutcommit),
-	PROC(LAYOUTRETURN,	enc_layoutreturn,	dec_layoutreturn),
-	PROC(SECINFO_NO_NAME,	enc_secinfo_no_name,	dec_secinfo_no_name),
-	PROC(TEST_STATEID,	enc_test_stateid,	dec_test_stateid),
-	PROC(FREE_STATEID,	enc_free_stateid,	dec_free_stateid),
+	PROC41(EXCHANGE_ID,	enc_exchange_id,	dec_exchange_id),
+	PROC41(CREATE_SESSION,	enc_create_session,	dec_create_session),
+	PROC41(DESTROY_SESSION,	enc_destroy_session,	dec_destroy_session),
+	PROC41(SEQUENCE,	enc_sequence,		dec_sequence),
+	PROC41(GET_LEASE_TIME,	enc_get_lease_time,	dec_get_lease_time),
+	PROC41(RECLAIM_COMPLETE,enc_reclaim_complete,	dec_reclaim_complete),
+	PROC41(GETDEVICEINFO,	enc_getdeviceinfo,	dec_getdeviceinfo),
+	PROC41(LAYOUTGET,	enc_layoutget,		dec_layoutget),
+	PROC41(LAYOUTCOMMIT,	enc_layoutcommit,	dec_layoutcommit),
+	PROC41(LAYOUTRETURN,	enc_layoutreturn,	dec_layoutreturn),
+	PROC41(SECINFO_NO_NAME,	enc_secinfo_no_name,	dec_secinfo_no_name),
+	PROC41(TEST_STATEID,	enc_test_stateid,	dec_test_stateid),
+	PROC41(FREE_STATEID,	enc_free_stateid,	dec_free_stateid),
 	STUB(GETDEVICELIST),
-	PROC(BIND_CONN_TO_SESSION,
+	PROC41(BIND_CONN_TO_SESSION,
 			enc_bind_conn_to_session, dec_bind_conn_to_session),
-	PROC(DESTROY_CLIENTID,	enc_destroy_clientid,	dec_destroy_clientid),
-#endif /* CONFIG_NFS_V4_1 */
-#ifdef CONFIG_NFS_V4_2
-	PROC(SEEK,		enc_seek,		dec_seek),
-	PROC(ALLOCATE,		enc_allocate,		dec_allocate),
-	PROC(DEALLOCATE,	enc_deallocate,		dec_deallocate),
-	PROC(LAYOUTSTATS,	enc_layoutstats,	dec_layoutstats),
-	PROC(CLONE,		enc_clone,		dec_clone),
-	PROC(COPY,		enc_copy,		dec_copy),
-#endif /* CONFIG_NFS_V4_2 */
+	PROC41(DESTROY_CLIENTID,enc_destroy_clientid,	dec_destroy_clientid),
+	PROC42(SEEK,		enc_seek,		dec_seek),
+	PROC42(ALLOCATE,	enc_allocate,		dec_allocate),
+	PROC42(DEALLOCATE,	enc_deallocate,		dec_deallocate),
+	PROC42(LAYOUTSTATS,	enc_layoutstats,	dec_layoutstats),
+	PROC42(CLONE,		enc_clone,		dec_clone),
+	PROC42(COPY,		enc_copy,		dec_copy),
+	PROC(LOOKUPP,		enc_lookupp,		dec_lookupp),
 };
 
 static unsigned int nfs_version4_counts[ARRAY_SIZE(nfs4_procedures)];
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -457,7 +457,12 @@ enum lock_type4 {
 
 #define NFS4_DEBUG 1
 
-/* Index of predefined Linux client operations */
+/*
+ * Index of predefined Linux client operations
+ *
+ * To ensure that /proc/net/rpc/nfs remains correctly ordered, please
+ * append only to this enum when adding new client operations.
+ */
 
 enum {
 	NFSPROC4_CLNT_NULL = 0,		/* Unused */
@@ -480,7 +485,6 @@ enum {
 	NFSPROC4_CLNT_ACCESS,
 	NFSPROC4_CLNT_GETATTR,
 	NFSPROC4_CLNT_LOOKUP,
-	NFSPROC4_CLNT_LOOKUPP,
 	NFSPROC4_CLNT_LOOKUP_ROOT,
 	NFSPROC4_CLNT_REMOVE,
 	NFSPROC4_CLNT_RENAME,
@@ -500,7 +504,6 @@ enum {
 	NFSPROC4_CLNT_SECINFO,
 	NFSPROC4_CLNT_FSID_PRESENT,
 
-	/* nfs41 */
 	NFSPROC4_CLNT_EXCHANGE_ID,
 	NFSPROC4_CLNT_CREATE_SESSION,
 	NFSPROC4_CLNT_DESTROY_SESSION,
@@ -518,13 +521,14 @@ enum {
 	NFSPROC4_CLNT_BIND_CONN_TO_SESSION,
 	NFSPROC4_CLNT_DESTROY_CLIENTID,
 
-	/* nfs42 */
 	NFSPROC4_CLNT_SEEK,
 	NFSPROC4_CLNT_ALLOCATE,
 	NFSPROC4_CLNT_DEALLOCATE,
 	NFSPROC4_CLNT_LAYOUTSTATS,
 	NFSPROC4_CLNT_CLONE,
 	NFSPROC4_CLNT_COPY,
+
+	NFSPROC4_CLNT_LOOKUPP,
 };
 
 /* nfs41 types */
