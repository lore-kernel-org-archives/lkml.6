Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227JvrAERPDl+VEfX6Wg5xodnYzlvF6ysEP251ibTBrVCtTpumcXS+4XAqQeF6HqZp9vLDi+
ARC-Seal: i=1; a=rsa-sha256; t=1518479387; cv=none;
        d=google.com; s=arc-20160816;
        b=mSFKG0rsf5WHWUYoqrTjlBk1aCTxbHuUXPAJUD9770aobzwAEhsaZiQg9Y5yuSpzg8
         3+5CHjHOMEjVNz0QIZublQt/dDfh0o7624g0nXkNkS2wA5t7C7bqZW56PA8OnpSrbgb9
         v2HDeJul5613HdcrJbDgFbca5SKRIJCP6/A3H7v23gqe3aVYozR9ty8hHqLHdhiymZjw
         1XMOmII68qRKAtGuQFTe+B3/68mXCyuxBU8OUsUx/jCPuqNDRYNUYFcYi18VkBUFwMVa
         jUu9nJgjO5wnAIVeYNT7O4FHsGjbj+XEAytQrk8qPHgziiBuHjXCKjWNVZx0XmTCtRC9
         l8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=wbwOGWpdWpbgV75+GkAcEUgShw79pKVtJpmGrjqJfyk=;
        b=nj8vyfXS2zb2uZ4f5ra7FssL3k2fV8UtVNyi9ZM7OYn3bL1gFuvsN70A7JXL0Wnw4I
         xuG8XNpkhlRNZPm1OK5WKuG9SGN+L35MZEK1hOmZ7ANUphNuZFUKKVMXuSMqz9hcZUTQ
         xchgrMAD+NRqBdauKB5UeVsl7iSuNs3hBs5qywwaAYyIl2jEISI3J02SS5b9J9ZddQ75
         yHZMdtIMEl6wZINzVCI4hl2ZufZUCiym2e4Q5WxMeY3L1g49AgUC89Nd4aAsvl9FGS2Q
         b4dc2wY5qfxUfCv0hUDlGyXHdQ8ctuFFnxai35TU2rGg+iCzp3rv+TREuMBr2NDdhb2O
         rLNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 10:47:59 +1100
Subject: [PATCH 10/19] staging: lustre: simplify waiting in
 ptlrpc_invalidate_import()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927900.19840.18432480230541523283.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241042610966334?=
X-GMAIL-MSGID: =?utf-8?q?1592241042610966334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This waiter currently wakes up every second to re-test if
imp_flight is zero.  If we ensure wakeup is called whenever
imp_flight is decremented to zero, we can just have a simple
wait_event_idle_timeout().

So add a wake_up_all to the one place it is missing, and simplify
the wait_event.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/client.c |    3 ++-
 drivers/staging/lustre/lustre/ptlrpc/import.c |   21 ++++++++-------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/client.c b/drivers/staging/lustre/lustre/ptlrpc/client.c
index 0ab13f8e5993..81b7a7046d82 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/client.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/client.c
@@ -1588,7 +1588,8 @@ static int ptlrpc_send_new_req(struct ptlrpc_request *req)
 		spin_lock(&imp->imp_lock);
 		if (!list_empty(&req->rq_list)) {
 			list_del_init(&req->rq_list);
-			atomic_dec(&req->rq_import->imp_inflight);
+			if (atomic_dec_and_test(&req->rq_import->imp_inflight))
+				wake_up_all(&req->rq_import->imp_recovery_waitq);
 		}
 		spin_unlock(&imp->imp_lock);
 		ptlrpc_rqphase_move(req, RQ_PHASE_NEW);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/staging/lustre/lustre/ptlrpc/import.c
index ed210550f61f..5d62c9de27eb 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/import.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
@@ -265,7 +265,6 @@ void ptlrpc_invalidate_import(struct obd_import *imp)
 {
 	struct list_head *tmp, *n;
 	struct ptlrpc_request *req;
-	struct l_wait_info lwi;
 	unsigned int timeout;
 	int rc;
 
@@ -306,19 +305,15 @@ void ptlrpc_invalidate_import(struct obd_import *imp)
 		 * callbacks. Cap it at obd_timeout -- these should all
 		 * have been locally cancelled by ptlrpc_abort_inflight.
 		 */
-		lwi = LWI_TIMEOUT_INTERVAL(
-			cfs_timeout_cap(timeout * HZ),
-			(timeout > 1) ? HZ :
-			HZ / 2,
-			NULL, NULL);
-		rc = l_wait_event(imp->imp_recovery_waitq,
-				  (atomic_read(&imp->imp_inflight) == 0),
-				  &lwi);
-		if (rc) {
+		rc = wait_event_idle_timeout(imp->imp_recovery_waitq,
+					     atomic_read(&imp->imp_inflight) == 0,
+					     obd_timeout * HZ);
+
+		if (rc == 0) {
 			const char *cli_tgt = obd2cli_tgt(imp->imp_obd);
 
-			CERROR("%s: rc = %d waiting for callback (%d != 0)\n",
-			       cli_tgt, rc,
+			CERROR("%s: timeout waiting for callback (%d != 0)\n",
+			       cli_tgt,
 			       atomic_read(&imp->imp_inflight));
 
 			spin_lock(&imp->imp_lock);
@@ -365,7 +360,7 @@ void ptlrpc_invalidate_import(struct obd_import *imp)
 			}
 			spin_unlock(&imp->imp_lock);
 		}
-	} while (rc != 0);
+	} while (rc == 0);
 
 	/*
 	 * Let's additionally check that no new rpcs added to import in
