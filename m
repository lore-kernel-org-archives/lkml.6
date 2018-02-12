Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x224JSKSKjkP6z/91lfYIJRxb4+6BQyRyuOYUe/yS2lb78VI94RxMJoVMRAlc+Y92+vDmUOTX
ARC-Seal: i=1; a=rsa-sha256; t=1518470624; cv=none;
        d=google.com; s=arc-20160816;
        b=LkEZuNr4UvobPKQxWgL//CD4qwO6CL4rw7C/DObfZAKPwT+DsxgRtStF8tADVETr8I
         tEZF2hkimmufcdDdsZ5Ok0+gnTTjxf5pdw2sQrOBk+Zcjso9STDHqJH7hIpVQzU74poD
         1eqJF9bweddgRVQHB2MqSUSh7oOowFbRj3qmH+kqh7BjLrWmuI48vBol4QvYTkKgJDXN
         BfIzNsnLITlyNZwzM9oZMm/uVGyfDg6PKiCjkioC6S/Xzvr3cb4DgFRXKioeaQvsaLXF
         5eKt05TOMLOeq6cIkqpxfRlMhQHgZ+Fsf/4y2uOqrwqouKUkzOanMlyjZflY2DqaErbb
         Fs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=BLkOZYFDrxhcPc5fsA3KxOiDgWqvifMuMBHXQsfH9Qk=;
        b=T9VjLlYOtBquEvSz9KqGyZs/JCtZqg/u7FCZUy0Be8KCRKYBoxThOv3t66wMF5PPLN
         KXnHYP2FjwxH7wrhGH17n5BAel4l6Np8kT1euJSRM0vQImHEJYTP49GXqBdzcZTyguxW
         N+B//l9BNv2GGBKN1egzzKLvoQ15uh4wHhQ+YhX97AodC762dgC58+v3zOBa7+KVijG/
         GT84MFUdEE6FxB5DGlIy/h6fUQ/HBd33SuJD0+52O2sTJTgYQt3GNN3Z+z29ht4VABKH
         g8S8jmd6wzfzYt+uK8F2PKjq/Pv1fEcRGJ2Qyma9dtPECJmYn4QGkpr3Ev9/GIOU7BKb
         sCRg==
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
Subject: [PATCH 07/19] staging: lustre: simplify l_wait_event when intr
 handler but no timeout.
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847055671.22826.8688568641693262055.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231853626578407?=
X-GMAIL-MSGID: =?utf-8?q?1592231853626578407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If l_wait_event() is given a function to be called on a signal,
but no timeout or timeout handler, then the intr function is simply
called at the end if the wait was aborted by a signal.
So a simpler way to write the code (in the one place this case is
used) it to open-code the body of the function after the
wait_event, if -ERESTARTSYS was returned.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ldlm/ldlm_flock.c |   30 +++++------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ldlm/ldlm_flock.c b/drivers/staging/lustre/lustre/ldlm/ldlm_flock.c
index 657ab95091a0..411b540b96d9 100644
--- a/drivers/staging/lustre/lustre/ldlm/ldlm_flock.c
+++ b/drivers/staging/lustre/lustre/ldlm/ldlm_flock.c
@@ -310,24 +310,6 @@ static int ldlm_process_flock_lock(struct ldlm_lock *req)
 	return LDLM_ITER_CONTINUE;
 }
 
-struct ldlm_flock_wait_data {
-	struct ldlm_lock *fwd_lock;
-};
-
-static void
-ldlm_flock_interrupted_wait(void *data)
-{
-	struct ldlm_lock *lock;
-
-	lock = ((struct ldlm_flock_wait_data *)data)->fwd_lock;
-
-	lock_res_and_lock(lock);
-
-	/* client side - set flag to prevent lock from being put on LRU list */
-	ldlm_set_cbpending(lock);
-	unlock_res_and_lock(lock);
-}
-
 /**
  * Flock completion callback function.
  *
@@ -342,8 +324,6 @@ int
 ldlm_flock_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data)
 {
 	struct file_lock		*getlk = lock->l_ast_data;
-	struct ldlm_flock_wait_data	fwd;
-	struct l_wait_info		lwi;
 	int				rc = 0;
 
 	OBD_FAIL_TIMEOUT(OBD_FAIL_LDLM_CP_CB_WAIT2, 4);
@@ -372,13 +352,17 @@ ldlm_flock_completion_ast(struct ldlm_lock *lock, __u64 flags, void *data)
 
 	LDLM_DEBUG(lock,
 		   "client-side enqueue returned a blocked lock, sleeping");
-	fwd.fwd_lock = lock;
-	lwi = LWI_TIMEOUT_INTR(0, NULL, ldlm_flock_interrupted_wait, &fwd);
 
 	/* Go to sleep until the lock is granted. */
-	rc = l_wait_event(lock->l_waitq, is_granted_or_cancelled(lock), &lwi);
+	rc = l_wait_event_abortable(lock->l_waitq, is_granted_or_cancelled(lock));
 
 	if (rc) {
+		lock_res_and_lock(lock);
+
+		/* client side - set flag to prevent lock from being put on LRU list */
+		ldlm_set_cbpending(lock);
+		unlock_res_and_lock(lock);
+
 		LDLM_DEBUG(lock, "client-side enqueue waking up: failed (%d)",
 			   rc);
 		return rc;
