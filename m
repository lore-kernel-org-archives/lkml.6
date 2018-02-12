Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x224JzWVsQYN3EateLpcQ8vwJHSVVKoq/yThRxF/MuOOnYghPkq1Qj3iR4S7cF8Jx+qB1mqdR
ARC-Seal: i=1; a=rsa-sha256; t=1518470585; cv=none;
        d=google.com; s=arc-20160816;
        b=v1lfTAdxXlXxIkhS48MnmyTTv6cLEEP451yQ8LXXomLjM1WFBwG5P4PBTxJpF8xB3I
         4fWx1XtlCQy7gl2Bbn4JH4vMPWbKDixFwjz/EShz06d4Y8KiSUZTNuGMiYdvv3yGGXOm
         rELqAXMGSGOntDEnBjogCHehSbhkwNBtaAe3/7I/7lbvxZ7uzdH+yB4Z1phbnXK+Qiwo
         kL+T4b5VGtoBXCSeIAwGN75jeP4DbyHu2M2+Pof5eXnyvBbfHNbLgSH4/F28+llVcF00
         maR/NCCipz6RI9oJ4M+ehWI9/TXtAS5CJOV476JQC9GucUnz+7Xnss3hJ2WTjqYTY4mb
         +cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=XE3twOeP21DKJe0QcTkqM0tlkiVdm1JHFdKn9YeXrdQ=;
        b=go5Yu61h5PBcnekOf6xFbaZ90xIkpAKlIoYLp8s4eLiKRLhFPdex+FWGXS2Ot/ANrJ
         WeYLPG6DCncykdTLAwKu8HBSV3oO4apkx1X2tGN6zo+1J1AIKz/x3yy6qZNdYcL6HyX/
         Mw9u9OHM/GAG49JZ67e6GXth82MNeUPDYsPeTFQoOCKOHonrgy0eBjqb05apFaxekH7P
         kfJ60KZsWL3fHLQtZqsCslLP5bnRgGos+hOlF4uBCk1kqQSVomOt8IRgHMtMIyp92Q7g
         mx/gJ3shwAgbcEgJdSNv5FRa3fdd1+KaoPqR0NumrDZ2s7MlGquC4Asch4dXKhK8x4I3
         +SOQ==
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
Subject: [PATCH 02/19] staging: lustre: discard SVC_SIGNAL and related
 functions
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847055648.22826.5480938397433602648.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592231812938823604?=
X-GMAIL-MSGID: =?utf-8?q?1592231812938823604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This flag is never set, so remove checks and remove
the flag.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/include/lustre_net.h |    6 ------
 drivers/staging/lustre/lustre/ptlrpc/sec_gc.c      |    4 +---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lustre_net.h b/drivers/staging/lustre/lustre/include/lustre_net.h
index 3ff5de4770e8..4c665eca2467 100644
--- a/drivers/staging/lustre/lustre/include/lustre_net.h
+++ b/drivers/staging/lustre/lustre/include/lustre_net.h
@@ -1260,7 +1260,6 @@ enum {
 	SVC_STARTING    = 1 << 2,
 	SVC_RUNNING     = 1 << 3,
 	SVC_EVENT       = 1 << 4,
-	SVC_SIGNAL      = 1 << 5,
 };
 
 #define PTLRPC_THR_NAME_LEN		32
@@ -1333,11 +1332,6 @@ static inline int thread_is_event(struct ptlrpc_thread *thread)
 	return !!(thread->t_flags & SVC_EVENT);
 }
 
-static inline int thread_is_signal(struct ptlrpc_thread *thread)
-{
-	return !!(thread->t_flags & SVC_SIGNAL);
-}
-
 static inline void thread_clear_flags(struct ptlrpc_thread *thread, __u32 flags)
 {
 	thread->t_flags &= ~flags;
diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c b/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c
index 8d1e0edfcede..d85c8638c009 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec_gc.c
@@ -153,7 +153,6 @@ static int sec_gc_main(void *arg)
 	while (1) {
 		struct ptlrpc_sec *sec;
 
-		thread_clear_flags(thread, SVC_SIGNAL);
 		sec_process_ctx_list();
 again:
 		/* go through sec list do gc.
@@ -184,8 +183,7 @@ static int sec_gc_main(void *arg)
 		lwi = LWI_TIMEOUT(msecs_to_jiffies(SEC_GC_INTERVAL * MSEC_PER_SEC),
 				  NULL, NULL);
 		l_wait_event(thread->t_ctl_waitq,
-			     thread_is_stopping(thread) ||
-			     thread_is_signal(thread),
+			     thread_is_stopping(thread),
 			     &lwi);
 
 		if (thread_test_and_clear_flags(thread, SVC_STOPPING))
