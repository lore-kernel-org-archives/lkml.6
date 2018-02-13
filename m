Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226A1rlnxhiO6eYbPHhhnxtYB0voPlB8bCnX5jNdbzWWdEA6Pk8VzYOJfTr4CRVu85Bqgd5/
ARC-Seal: i=1; a=rsa-sha256; t=1518553062; cv=none;
        d=google.com; s=arc-20160816;
        b=EY2wOUb8IpOakh3AjoiAZ18H9m/RX/TU2Qbg6YBms15O6lKQSbHD0UK573vXVS9Xkq
         eUhFwZG5vcOU+bfKhPPeHBlAtCmkwYxTPeSg+9iC9KPruRPuQJuSxowKJ9HCxXza25/s
         cU6pwA1mSy32Blgqx2kZ0zAjWbd0818lDd6Q8rDCdqd/UfGtLPwsnuGmVjbZGve80IEF
         3FoE2U0LH7ML6UoiMY/0gLmXFhQQs1K3nBlZNJZMgmbfyvlOud0cAirQMJOUbhCTskLR
         62mvRFFAR5KN+8JckqgW+qvzoTn60YUuSOtFKK3Om83TTSbMF/WvKVrJbo9x+4qdmrE0
         15Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=Vf9L3EHQjUGK/tkfmPiwWWzvy2N+Fat8KesVPb1kXm4=;
        b=Dh4ac8hpMxh0OlWesAXcRjl3ze7q7MYJKv6xiLsT/NIUQK8dXC/nX0gWRAjRTKWpLj
         EJC/kn1cmCy20HXuiOztn19Oa8mbuj5UQ/8UAmHGrkOmHIxALrU6g9X8+X2So7CSvOGS
         KctSnptUyTCZdhfhvMyPAKReUZP0iCJNlaK21oq3ysgoL6HwzdVZcs4aq+KloeStSO1N
         zFlJJ5M0tV0biYtxXgqpoar5Bic2UjT2+wgT5O5OSExGW2fLuV/VA56kiuH17WTBcx+p
         HZajMkvmIzgyqFz1xZQypYbOqAwGAJC/2hi7/h24EWonjwB/vqvl7RrzNofseXQR3zxC
         5oRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, Andreas Dilger <andreas.dilger@intel.com>, James Simmons <jsimmons@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2018 07:17:30 +1100
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Subject: [PATCH 08/19 - v2] staging: lustre: simplify waiting in ldlm_completion_ast()
In-Reply-To: <151847055674.22826.12912356108048917428.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble> <151847055674.22826.12912356108048917428.stgit@noble>
Message-ID: <87fu64r6ed.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231861062476291?=
X-GMAIL-MSGID: =?utf-8?q?1592318295522266951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


If a signal-callback (lwi_on_signal) is set without lwi_allow_intr, as
is the case in ldlm_completion_ast(), the behavior depends on the
timeout set.

If a timeout is set, then signals are ignored.  If the timeout is
reached, the timeout handler is called.  If the timeout handler
return 0, which ldlm_expired_completion_wait() always does, the
l_wait_event() switches to exactly the behavior if no timeout was set.

If no timeout is set, then "fatal" signals are not ignored.  If one
arrives the callback is run, but as the callback is empty in this
case, that is not relevant.

This can be simplified to:
 if a timeout is wanted
     wait_event_idle_timeout()
     if that timed out, call the timeout handler
 l_wait_event_abortable()

i.e. the code always waits indefinitely.  Sometimes it performs a
non-abortable wait first.  Sometimes it doesn't.  But it only
aborts before the condition is true if it is signaled.
This doesn't quite agree with the comments and debug messages.

Now that we call the timeout handler (ldlm_expired_completion_wait())
wait directly, we can pass the two args directly rather then
using a special-purpose struct.

Reviewed-by: Patrick Farrell <paf@cray.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Patrick discovered a bug in v1, which this v2 fixes.

Greg - do you need me to resend the whole series, or are you ok with
taking this replacement in the rest of the original series?

Thanks,
NeilBrown


 drivers/staging/lustre/lustre/ldlm/ldlm_request.c | 53 +++++++++----------=
----
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/st=
aging/lustre/lustre/ldlm/ldlm_request.c
index a244fa717134..c3c9186b74ce 100644
=2D-- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
@@ -72,15 +72,6 @@ MODULE_PARM_DESC(ldlm_enqueue_min, "lock enqueue timeout=
 minimum");
 /* in client side, whether the cached locks will be canceled before replay=
 */
 unsigned int ldlm_cancel_unused_locks_before_replay =3D 1;
=20
=2Dstatic void interrupted_completion_wait(void *data)
=2D{
=2D}
=2D
=2Dstruct lock_wait_data {
=2D	struct ldlm_lock *lwd_lock;
=2D	__u32	     lwd_conn_cnt;
=2D};
=2D
 struct ldlm_async_args {
 	struct lustre_handle lock_handle;
 };
@@ -112,10 +103,8 @@ static int ldlm_request_bufsize(int count, int type)
 	return sizeof(struct ldlm_request) + avail;
 }
=20
=2Dstatic int ldlm_expired_completion_wait(void *data)
+static void ldlm_expired_completion_wait(struct ldlm_lock *lock, __u32 con=
n_cnt)
 {
=2D	struct lock_wait_data *lwd =3D data;
=2D	struct ldlm_lock *lock =3D lwd->lwd_lock;
 	struct obd_import *imp;
 	struct obd_device *obd;
=20
@@ -135,19 +124,17 @@ static int ldlm_expired_completion_wait(void *data)
 			if (last_dump =3D=3D 0)
 				libcfs_debug_dumplog();
 		}
=2D		return 0;
+		return;
 	}
=20
 	obd =3D lock->l_conn_export->exp_obd;
 	imp =3D obd->u.cli.cl_import;
=2D	ptlrpc_fail_import(imp, lwd->lwd_conn_cnt);
+	ptlrpc_fail_import(imp, conn_cnt);
 	LDLM_ERROR(lock,
 		   "lock timed out (enqueued at %lld, %llds ago), entering recovery for =
%s@%s",
 		   (s64)lock->l_last_activity,
 		   (s64)(ktime_get_real_seconds() - lock->l_last_activity),
 		   obd2cli_tgt(obd), imp->imp_connection->c_remote_uuid.uuid);
=2D
=2D	return 0;
 }
=20
 /**
@@ -251,11 +238,10 @@ EXPORT_SYMBOL(ldlm_completion_ast_async);
 int ldlm_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data)
 {
 	/* XXX ALLOCATE - 160 bytes */
=2D	struct lock_wait_data lwd;
 	struct obd_device *obd;
 	struct obd_import *imp =3D NULL;
=2D	struct l_wait_info lwi;
 	__u32 timeout;
+	__u32 conn_cnt =3D 0;
 	int rc =3D 0;
=20
 	if (flags =3D=3D LDLM_FL_WAIT_NOREPROC) {
@@ -281,32 +267,33 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64=
 flags, void *data)
=20
 	timeout =3D ldlm_cp_timeout(lock);
=20
=2D	lwd.lwd_lock =3D lock;
 	lock->l_last_activity =3D ktime_get_real_seconds();
=20
=2D	if (ldlm_is_no_timeout(lock)) {
=2D		LDLM_DEBUG(lock, "waiting indefinitely because of NO_TIMEOUT");
=2D		lwi =3D LWI_INTR(interrupted_completion_wait, &lwd);
=2D	} else {
=2D		lwi =3D LWI_TIMEOUT_INTR(timeout * HZ,
=2D				       ldlm_expired_completion_wait,
=2D				       interrupted_completion_wait, &lwd);
=2D	}
=2D
 	if (imp) {
 		spin_lock(&imp->imp_lock);
=2D		lwd.lwd_conn_cnt =3D imp->imp_conn_cnt;
+		conn_cnt =3D imp->imp_conn_cnt;
 		spin_unlock(&imp->imp_lock);
 	}
=2D
 	if (OBD_FAIL_CHECK_RESET(OBD_FAIL_LDLM_INTR_CP_AST,
 				 OBD_FAIL_LDLM_CP_BL_RACE | OBD_FAIL_ONCE)) {
 		ldlm_set_fail_loc(lock);
 		rc =3D -EINTR;
 	} else {
=2D		/* Go to sleep until the lock is granted or cancelled. */
=2D		rc =3D l_wait_event(lock->l_waitq,
=2D				  is_granted_or_cancelled(lock), &lwi);
+		/* Go to sleep until the lock is granted or canceled. */
+		if (!ldlm_is_no_timeout(lock)) {
+			/* Wait uninterruptible for a while first */
+			rc =3D wait_event_idle_timeout(lock->l_waitq,
+						     is_granted_or_cancelled(lock),
+						     timeout * HZ);
+			if (rc =3D=3D 0)
+				ldlm_expired_completion_wait(lock, conn_cnt);
+		}
+		/* Now wait abortable */
+		if (rc =3D=3D 0)
+			rc =3D l_wait_event_abortable(lock->l_waitq,
+						    is_granted_or_cancelled(lock));
+		else
+			rc =3D 0;
 	}
=20
 	if (rc) {
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqDR9oACgkQOeye3VZi
gbnKQA//cRv4RuLhEJiwGCz7iDayo5vNaueU3MdsgskgayTnmWYoXa1BugIlzp8H
zxjvTIZKCkyVSrBao9At4zPXflDTuYc3SYusBTJEssdrPLMI8hRaD0z655KFPxQz
wcfzDXxnL1p9NOQJ92TAmJU95lmkpAcPC7N/pVmUWYHJ9+akn106JsyEVct8mNb9
tCw/JiWnEbheFs8nIAboCv6aTfl5lqFTNFdBVWLBl9sSLPfi5X0RAqLB2Vn4Zkjw
ciH+WSDpqXl6NtlhZY2NkYG9/ZV5mE5fT+jq9bSeIBZYjVZJCaWZHGzYLVCoVC6n
xgxt/A6UqhPQ9W2i1TKzcoHgWnAFCg2dmLxD2yvglxjld80KeA0kYcgXRDX+fZjq
Ez+Urj2OVULTmwmfrr2zdxvyrWvBWH9hRgLv3tGynO9Lm1rCMGMXHe0RvWugnzs+
XEXNyc7IoLawVkaMArdSiSl+Pu+P9RoulZDar+gqQKq/hqgkm4vUJIUWrbr5l7Aq
aofheTQl/khGNejz9XUGUyeZjA4GNfgYp7yuwBxJSaRhPkE0B92PT8ZjGzAnbxzZ
ciO3eUrD4DlzZI23Ws/O3+Q+jpJMXa8uwmAM7znYh/R+8xwhG5LlOTKZA6pFtLKH
SNY6G5wslx45mhpjewSH2xh8DVgzO9Cp+p2rX3pO+IpRqvv3udY=
=nv1c
-----END PGP SIGNATURE-----
--=-=-=--
