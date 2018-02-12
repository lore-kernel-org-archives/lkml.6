Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x225W6QiVuUBUqfEV1E4G18tbE3+tyVDwVWlSl2lB51c4zVLf9AmgLN0l4UaC9F1Ra6KvM7Be
ARC-Seal: i=1; a=rsa-sha256; t=1518479394; cv=none;
        d=google.com; s=arc-20160816;
        b=0EEgjQAxyZtYjT4ZXeTBqajpR0Lx4aHtaX3sddtmq0mr9wiZnSgvEM86FYsyGU2xAx
         0uweqES2gADYO3p7J1/i7VrSg85DYcA9DGO5KCXQwNmlGVRtasrf4ulCwl/mZcHDlwNu
         IgdtJiTfmAGiVVXL2MsN1CpMK5Fh4AK0apBf2cVLTg0kRrnfNnQCz4B1aNwsRItKpUCI
         E6oSnA17xPN8CAm67/+kbfdlanr/MnJPb9nLEoJZnRhUlM3l1UCFivukfh2BWBAMje2s
         7swgXwhsLIePiomI2hLrlO74v3wcmyVfs+bpTN1BwLnhWciShfhGbMp6mfZYiye+84Tj
         7ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=goVGODzEZRzBeya78gzjWbox5nGfafuaLYqgI97Tny0=;
        b=qa7JYxxw/i8C80b3BL7YyQcBLgS0MhvUKVsjnk+eXmV/y67iqIvAu9bA6uDdJRixsX
         +CK/aTr9K2/n0OzPg6JFcaXw5ejqrd8Qn2R+9RBEZXPu+Fl/lNCKMXRxHumEvzkW2Npy
         4ia7L3DQMPZrnrwAboNiLqsaES/Gho+CVpJiiWxpPAa9U4nf739p0gZfb9ATLQGsckHR
         eZnxqZMWBCEouzMmwxR+Ns0x/LSTkSUuTm+Kf1zX/nXdGXMsPQl0Vj6Gz0XtVoGOLG8j
         rOKEEgaHZ8KiXwUK5wcjIqSEEMiJbMJ4Gw4OYEP4Nz8028LWcD+WSVRGaiZEou48DHSY
         QUvQ==
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
Subject: [PATCH 11/19] staging: lustre: remove back_to_sleep()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927903.19840.11717617846481237765.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241049909205495?=
X-GMAIL-MSGID: =?utf-8?q?1592241049909205495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When 'back_to_sleep()' is passed as the 'timeout' function,
the effect is to wait indefinitely for the event, polling
once after the timeout.
If LWI_ON_SIGNAL_NOOP is given, then after the timeout
we allow fatal signals to interrupt the wait.

Make this more obvious in both places "back_to_sleep()" is
used but using two explicit sleeps.

The code in ptlrpcd_add_req() looks odd - why not just have one
wait_event_idle()?  However I believe this is a faithful
transformation of the existing code.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/include/lustre_lib.h |    4 ----
 drivers/staging/lustre/lustre/ptlrpc/import.c      |   11 ++++++-----
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |    9 +++++----
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_lib.h b/drivers/staging/lustre/lustre/include/lustre_lib.h
index b2a64d0e682c..1939e959b92a 100644
--- a/drivers/staging/lustre/lustre/include/lustre_lib.h
+++ b/drivers/staging/lustre/lustre/include/lustre_lib.h
@@ -140,10 +140,6 @@ void target_send_reply(struct ptlrpc_request *req, int rc, int fail_id);
  * XXX nikita: some ptlrpc daemon threads have races of that sort.
  *
  */
-static inline int back_to_sleep(void *arg)
-{
-	return 0;
-}
 
 #define LWI_ON_SIGNAL_NOOP ((void (*)(void *))(-1))
 
diff --git a/drivers/staging/lustre/lustre/ptlrpc/import.c b/drivers/staging/lustre/lustre/ptlrpc/import.c
index 5d62c9de27eb..faf0f606f013 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/import.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/import.c
@@ -1496,7 +1496,6 @@ int ptlrpc_disconnect_import(struct obd_import *imp, int noclose)
 	}
 
 	if (ptlrpc_import_in_recovery(imp)) {
-		struct l_wait_info lwi;
 		long timeout;
 
 		if (AT_OFF) {
@@ -1510,10 +1509,12 @@ int ptlrpc_disconnect_import(struct obd_import *imp, int noclose)
 			timeout = at_get(&imp->imp_at.iat_service_estimate[idx]) * HZ;
 		}
 
-		lwi = LWI_TIMEOUT_INTR(cfs_timeout_cap(timeout),
-				       back_to_sleep, LWI_ON_SIGNAL_NOOP, NULL);
-		rc = l_wait_event(imp->imp_recovery_waitq,
-				  !ptlrpc_import_in_recovery(imp), &lwi);
+		if (wait_event_idle_timeout(imp->imp_recovery_waitq,
+					    !ptlrpc_import_in_recovery(imp),
+					    cfs_timeout_cap(timeout)) == 0)
+			l_wait_event_abortable(
+				imp->imp_recovery_waitq,
+				!ptlrpc_import_in_recovery(imp));
 	}
 
 	spin_lock(&imp->imp_lock);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c b/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
index dad2f9290f70..437b4b2a9072 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
@@ -230,12 +230,13 @@ void ptlrpcd_add_req(struct ptlrpc_request *req)
 
 	spin_lock(&req->rq_lock);
 	if (req->rq_invalid_rqset) {
-		struct l_wait_info lwi = LWI_TIMEOUT(5 * HZ,
-						     back_to_sleep, NULL);
-
 		req->rq_invalid_rqset = 0;
 		spin_unlock(&req->rq_lock);
-		l_wait_event(req->rq_set_waitq, !req->rq_set, &lwi);
+		if (wait_event_idle_timeout(req->rq_set_waitq,
+					    !req->rq_set,
+					    5 * HZ) == 0)
+			wait_event_idle(req->rq_set_waitq,
+					!req->rq_set);
 	} else if (req->rq_set) {
 		/* If we have a valid "rq_set", just reuse it to avoid double
 		 * linked.
