Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226wAyAEzqfN0UNkAvN/BeEfMCZUZSZP3yToIrJU5MKxJjuZ50EhYMl4MCmmITZndcnVZTxI
ARC-Seal: i=1; a=rsa-sha256; t=1518470631; cv=none;
        d=google.com; s=arc-20160816;
        b=twuW5Sq7/pPVgDg/Xfq7d/ldhZp3dd3S0s/1RadQ41Heje0Fd12PNkvFK0NwpuZqE9
         2boP3MK2fQ50Ti8hjDtNgcrRVhM2vYxPWOG4Dvj5/y/ulgLyJBuJEgwLeujtR13BW+mR
         CmBZakB8pqnBn8AliWPHVxRtZN1ZxKJiC7SFn0sp0AIY3yTsRPPzKaHc0nadLF53yRdE
         3RcBUGO7DCOVhSvAkPTpWQIg/qx6fQL8ib/coO026XxKuUji/zdHRLsSBYpIED2EGnHJ
         qAatyaTcItAppGe2DCN7piJlZXY3/vdlDYRtoUtKvT4FpCCyXAMCyoo8mwzMzyQg7pFx
         iRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=oNzeFoZIzRPRGknvv6mIHLgmO8ktghzJ8hYFgvB10rg=;
        b=d3nB/ttjrR6E21gAnjbU6p/P4whel9NztkRVWPih+fClp0FRJ5vIQWhkdcRuegz0vb
         /Extf2bPsHj09qAfU5SP0SSG2LS74mZujE7+mQmqGJYCyPh1TH6R6Frr0V01JzdeohV+
         hvZzV0cTC6KU4wvE9f6S9XGOwc+2OVw0kjn1T9crpAdmlX7DB0U5j658LzWn3DvjKdAG
         45SImco2D9s9Vv3dVHV3Z0ynbaG3HhWmblqpIx/Yz1F0OAjKcXecwa/OeUWl3KTCYhpQ
         30xuwVFs3mc05h5nDA8D2kI9ei1a6VuNfWAqsGuiqmETwiBYwH3LKu1a7rSKwHDS2JEN
         +wQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:22:36 +1100
Subject: [PATCH 08/19] staging: lustre: simplify waiting in
 ldlm_completion_ast()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847055674.22826.12912356108048917428.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231861062476291?=
X-GMAIL-MSGID: =?utf-8?q?1592231861062476291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c |   55 +++++++--------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
index a244fa717134..f1233d844bbd 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_request.c
@@ -72,15 +72,6 @@ MODULE_PARM_DESC(ldlm_enqueue_min, "lock enqueue timeout minimum");
 /* in client side, whether the cached locks will be canceled before replay */
 unsigned int ldlm_cancel_unused_locks_before_replay = 1;
 
-static void interrupted_completion_wait(void *data)
-{
-}
-
-struct lock_wait_data {
-	struct ldlm_lock *lwd_lock;
-	__u32	     lwd_conn_cnt;
-};
-
 struct ldlm_async_args {
 	struct lustre_handle lock_handle;
 };
@@ -112,10 +103,8 @@ static int ldlm_request_bufsize(int count, int type)
 	return sizeof(struct ldlm_request) + avail;
 }
 
-static int ldlm_expired_completion_wait(void *data)
+static void ldlm_expired_completion_wait(struct ldlm_lock *lock, struct obd_import *imp2)
 {
-	struct lock_wait_data *lwd = data;
-	struct ldlm_lock *lock = lwd->lwd_lock;
 	struct obd_import *imp;
 	struct obd_device *obd;
 
@@ -135,19 +124,17 @@ static int ldlm_expired_completion_wait(void *data)
 			if (last_dump == 0)
 				libcfs_debug_dumplog();
 		}
-		return 0;
+		return;
 	}
 
 	obd = lock->l_conn_export->exp_obd;
 	imp = obd->u.cli.cl_import;
-	ptlrpc_fail_import(imp, lwd->lwd_conn_cnt);
+	ptlrpc_fail_import(imp, imp2 ? imp2->imp_conn_cnt : 0);
 	LDLM_ERROR(lock,
 		   "lock timed out (enqueued at %lld, %llds ago), entering recovery for %s@%s",
 		   (s64)lock->l_last_activity,
 		   (s64)(ktime_get_real_seconds() - lock->l_last_activity),
 		   obd2cli_tgt(obd), imp->imp_connection->c_remote_uuid.uuid);
-
-	return 0;
 }
 
 /**
@@ -251,10 +238,8 @@ EXPORT_SYMBOL(ldlm_completion_ast_async);
 int ldlm_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data)
 {
 	/* XXX ALLOCATE - 160 bytes */
-	struct lock_wait_data lwd;
 	struct obd_device *obd;
 	struct obd_import *imp = NULL;
-	struct l_wait_info lwi;
 	__u32 timeout;
 	int rc = 0;
 
@@ -281,32 +266,28 @@ int ldlm_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data)
 
 	timeout = ldlm_cp_timeout(lock);
 
-	lwd.lwd_lock = lock;
 	lock->l_last_activity = ktime_get_real_seconds();
 
-	if (ldlm_is_no_timeout(lock)) {
-		LDLM_DEBUG(lock, "waiting indefinitely because of NO_TIMEOUT");
-		lwi = LWI_INTR(interrupted_completion_wait, &lwd);
-	} else {
-		lwi = LWI_TIMEOUT_INTR(timeout * HZ,
-				       ldlm_expired_completion_wait,
-				       interrupted_completion_wait, &lwd);
-	}
-
-	if (imp) {
-		spin_lock(&imp->imp_lock);
-		lwd.lwd_conn_cnt = imp->imp_conn_cnt;
-		spin_unlock(&imp->imp_lock);
-	}
-
 	if (OBD_FAIL_CHECK_RESET(OBD_FAIL_LDLM_INTR_CP_AST,
 				 OBD_FAIL_LDLM_CP_BL_RACE | OBD_FAIL_ONCE)) {
 		ldlm_set_fail_loc(lock);
 		rc = -EINTR;
 	} else {
-		/* Go to sleep until the lock is granted or cancelled. */
-		rc = l_wait_event(lock->l_waitq,
-				  is_granted_or_cancelled(lock), &lwi);
+		/* Go to sleep until the lock is granted or canceled. */
+		if (!ldlm_is_no_timeout(lock)) {
+			/* Wait uninterruptible for a while first */
+			rc = wait_event_idle_timeout(lock->l_waitq,
+						     is_granted_or_cancelled(lock),
+						     timeout * HZ);
+			if (rc == 0)
+				ldlm_expired_completion_wait(lock, imp);
+		}
+		/* Now wait abortable */
+		if (rc == 0)
+			rc = l_wait_event_abortable(lock->l_waitq,
+						    is_granted_or_cancelled(lock));
+		else
+			rc = 0;
 	}
 
 	if (rc) {
