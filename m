Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227Hzz+gp5ZQcH8+HSolupzv88mqaSu74ic2tFBSwtfMJU6NLdv7UGRFTVweaLS89XICoMun
ARC-Seal: i=1; a=rsa-sha256; t=1518479449; cv=none;
        d=google.com; s=arc-20160816;
        b=jVP+194xc82uOqvcGLQKphNSyB/pB7+UDBAVXL0QjPxxdVnhQn2Eurqk5Yp5nIV0Je
         5CNzv8SS55KDmtCfUAaN+bgRXmaTTZhSM6cEfgzauRhXMssuY2xoCL7cfhcZ69rzztAZ
         r0xZJjP67k+wF71zLpyaUAQRBJPS1WR0y6XfNN5yp7/9l9r1DOU1Dvwqg4d2V91Vha12
         6EvJXsMR7zTwp5WdLqksWgAzkPD4Qjwdpcqtd4OyiNlIHUBUWyyufypr6myOtJDOC2hR
         luOmCyug5qBXpkRP71KSWeys2WnvIJkZci/MIbRTtgWXF5dB9winPq+Va6Uea7OLC9+D
         hCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=3AGkfr/n+kwjzcH7/BRNulNM3tntd1v/5nz5qRkBi0I=;
        b=H9zQCH5NtuT7RljL3BQi52VL3ID1a6vt/O/k6ZO1x+8fddX/RYBolTSMdAKenI8K9H
         +Salac0Jq0T35eRKDUtnwczxKvdu7sq/F6dD+cz60rpiMGyfyKgVjpoV1/1sTPZeDWkS
         0pxIUx3Aui2rU/VDrTmgl4A6T+YES9yk8mnccvcC1Yx3kmWJStcjxd/4uu88r4FwCfGI
         qFwGfQ97J8dw2J/dpiD0/WON/YFRDVkCtOjeeZEDh40xFrz04dqJLf5IsdcJyCwyZExX
         DQPjTgPm8qwXoDC9hiL9Ipfj5cOzgohBQOfsJWo/SpftpfGGeREPsCj2ysfSU79HDLiI
         ERZA==
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
Subject: [PATCH 18/19] staging: lustre: replace
 l_wait_event_exclusive_head() with wait_event_idle_exclusive
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927926.19840.9872301796680320791.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241107103949181?=
X-GMAIL-MSGID: =?utf-8?q?1592241107103949181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This l_wait_event_exclusive_head() will wait indefinitely
if the timeout is zero.  If it does wait with a timeout
and times out, the timeout for next time is set to zero.

The can be mapped to a call to either
 wait_event_idle_exclusive()
or
 wait_event_idle_exclusive_timeout()
depending in the timeout setting.

The current code arranges for LIFO queuing of waiters,
but include/event.h doesn't support that yet.
Until it does, fall back on FIFO with
wait_event_idle_exclusive{,_timeout}().

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/service.c |   43 ++++++++++++++----------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/staging/lustre/lustre/ptlrpc/service.c
index 6e3403417434..29fdb54f16ca 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/service.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
@@ -1897,15 +1897,6 @@ ptlrpc_check_rqbd_pool(struct ptlrpc_service_part *svcpt)
 	}
 }
 
-static int
-ptlrpc_retry_rqbds(void *arg)
-{
-	struct ptlrpc_service_part *svcpt = arg;
-
-	svcpt->scp_rqbd_timeout = 0;
-	return -ETIMEDOUT;
-}
-
 static inline int
 ptlrpc_threads_enough(struct ptlrpc_service_part *svcpt)
 {
@@ -1968,13 +1959,17 @@ ptlrpc_server_request_incoming(struct ptlrpc_service_part *svcpt)
 	return !list_empty(&svcpt->scp_req_incoming);
 }
 
+/* We perfer lifo queuing, but kernel doesn't provide that yet. */
+#ifndef wait_event_idle_exclusive_lifo
+#define wait_event_idle_exclusive_lifo wait_event_idle_exclusive
+#define wait_event_idle_exclusive_lifo_timeout wait_event_idle_exclusive_timeout
+#endif
+
 static __attribute__((__noinline__)) int
 ptlrpc_wait_event(struct ptlrpc_service_part *svcpt,
 		  struct ptlrpc_thread *thread)
 {
 	/* Don't exit while there are replies to be handled */
-	struct l_wait_info lwi = LWI_TIMEOUT(svcpt->scp_rqbd_timeout,
-					     ptlrpc_retry_rqbds, svcpt);
 
 	/* XXX: Add this back when libcfs watchdog is merged upstream
 	lc_watchdog_disable(thread->t_watchdog);
@@ -1982,13 +1977,25 @@ ptlrpc_wait_event(struct ptlrpc_service_part *svcpt,
 
 	cond_resched();
 
-	l_wait_event_exclusive_head(svcpt->scp_waitq,
-				    ptlrpc_thread_stopping(thread) ||
-				    ptlrpc_server_request_incoming(svcpt) ||
-				    ptlrpc_server_request_pending(svcpt,
-								  false) ||
-				    ptlrpc_rqbd_pending(svcpt) ||
-				    ptlrpc_at_check(svcpt), &lwi);
+	if (svcpt->scp_rqbd_timeout == 0)
+		wait_event_idle_exclusive_lifo(
+			svcpt->scp_waitq,
+			ptlrpc_thread_stopping(thread) ||
+			ptlrpc_server_request_incoming(svcpt) ||
+			ptlrpc_server_request_pending(svcpt,
+						      false) ||
+			ptlrpc_rqbd_pending(svcpt) ||
+			ptlrpc_at_check(svcpt));
+	else if (0 == wait_event_idle_exclusive_lifo_timeout(
+			 svcpt->scp_waitq,
+			 ptlrpc_thread_stopping(thread) ||
+			 ptlrpc_server_request_incoming(svcpt) ||
+			 ptlrpc_server_request_pending(svcpt,
+						       false) ||
+			 ptlrpc_rqbd_pending(svcpt) ||
+			 ptlrpc_at_check(svcpt),
+			 svcpt->scp_rqbd_timeout))
+		svcpt->scp_rqbd_timeout = 0;
 
 	if (ptlrpc_thread_stopping(thread))
 		return -EINTR;
