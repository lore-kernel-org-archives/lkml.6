Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x224f7+cw/2rrNaZG3urZi/yFEMISSIhLrpg4/qwRQE7yAEELtX874dfbilGT2k3FgJJ9CZF7
ARC-Seal: i=1; a=rsa-sha256; t=1518479408; cv=none;
        d=google.com; s=arc-20160816;
        b=VVCJWbU5GtQqtOXfoaAH0RW6hg/LyNlgy+4S9O/93NVuFyS4Sg5E5tWwM7B4QSfFE9
         dBDJTEsjhOCiGjb5uIpL/dRYSMLGmS1Xh1FWE7UML3WFTUPq82QX6+578mkLjNFKgPwt
         u/X4lJS7/41Ihlv3H2ghGHMeY8a3Aaz4bhH2ENIExTjv+jbYEz1GP1FPWI77uTJA8k56
         POnZDm9/2e21AgR0dfnJ4CE9MTR0t53RAhPMMaFi/2RPwgTL5GGBfbvfKbiJL2kKjf25
         ivCitnG56djf1qs6QuJmkk/ahK8deV79nENDILM/YV+R63Y+680Tj9lFQLjLfWNzXQtX
         FjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=i2AAcY1WJ7um84rKA0huprwsTKEBFWBuL/mfFujapyk=;
        b=YDnu+Pl++R0cn4arI8siXqQcDLF2H/Ut75DKnWyMe4KHbWSJ7u54dcirB49px5AjGo
         cITFFJar9ApAVHQVNk7WL4X76Sa+T677GF0ribk+sqPk9HT4vz6dEddSJu4ioCNYRR51
         WPzqUcYQHstzRS6dd/4o4LlsU/8fo8ky0+WnOecWTE7h/vl4Iod3Vk3PsUDbGFmYDVqM
         dOwj8PZN6X2vqnEp32fJ1Ds+3a2MjKG4FEK9yX9HHkneTth8/JftytdHKLo5kUwGez2r
         7tRHA3InarD9Fhu71YlsrXTOSRfvl4HgQ9Y3fW1cazGQmLNjKS+QdEt9/uUrlFnuFa7x
         tErQ==
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
Subject: [PATCH 13/19] staging: lustre: use wait_event_idle_timeout in
 ptlrpcd()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927909.19840.2781972409839568492.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241064473297611?=
X-GMAIL-MSGID: =?utf-8?q?1592241064473297611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can replace l_wait_event() with
wait_event_idle_timeout() here providing we call the
timeout function when wait_event_idle_timeout() returns zero.

As ptlrpc_expired_set() returns 1, the l_wait_event() aborts of the
first timeout.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/client.c      |   12 ++++++++----
 .../staging/lustre/lustre/ptlrpc/ptlrpc_internal.h |    2 +-
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |    9 +++++----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/client.c b/drivers/staging/lustre/lustre/ptlrpc/client.c
index 81b7a7046d82..f70176c6db08 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/client.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/client.c
@@ -2125,9 +2125,8 @@ int ptlrpc_expire_one_request(struct ptlrpc_request *req, int async_unlink)
  * Callback used when waiting on sets with l_wait_event.
  * Always returns 1.
  */
-int ptlrpc_expired_set(void *data)
+void ptlrpc_expired_set(struct ptlrpc_request_set *set)
 {
-	struct ptlrpc_request_set *set = data;
 	struct list_head *tmp;
 	time64_t now = ktime_get_real_seconds();
 
@@ -2156,7 +2155,12 @@ int ptlrpc_expired_set(void *data)
 		 */
 		ptlrpc_expire_one_request(req, 1);
 	}
+}
+static int ptlrpc_expired_set_void(void *data)
+{
+	struct ptlrpc_request_set *set = data;
 
+	ptlrpc_expired_set(set);
 	/*
 	 * When waiting for a whole set, we always break out of the
 	 * sleep so we can recalculate the timeout, or enable interrupts
@@ -2286,7 +2290,7 @@ int ptlrpc_set_wait(struct ptlrpc_request_set *set)
 			 * so we allow interrupts during the timeout.
 			 */
 			lwi = LWI_TIMEOUT_INTR_ALL(HZ,
-						   ptlrpc_expired_set,
+						   ptlrpc_expired_set_void,
 						   ptlrpc_interrupted_set, set);
 		else
 			/*
@@ -2295,7 +2299,7 @@ int ptlrpc_set_wait(struct ptlrpc_request_set *set)
 			 * complete, or an in-flight req times out.
 			 */
 			lwi = LWI_TIMEOUT((timeout ? timeout : 1) * HZ,
-					  ptlrpc_expired_set, set);
+					  ptlrpc_expired_set_void, set);
 
 		rc = l_wait_event(set->set_waitq, ptlrpc_check_set(NULL, set), &lwi);
 
diff --git a/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_internal.h b/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_internal.h
index f9decbd1459d..b7a8d7537a66 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_internal.h
+++ b/drivers/staging/lustre/lustre/ptlrpc/ptlrpc_internal.h
@@ -68,7 +68,7 @@ void ptlrpc_request_cache_free(struct ptlrpc_request *req);
 void ptlrpc_init_xid(void);
 void ptlrpc_set_add_new_req(struct ptlrpcd_ctl *pc,
 			    struct ptlrpc_request *req);
-int ptlrpc_expired_set(void *data);
+void ptlrpc_expired_set(struct ptlrpc_request_set *set);
 int ptlrpc_set_next_timeout(struct ptlrpc_request_set *set);
 void ptlrpc_resend_req(struct ptlrpc_request *request);
 void ptlrpc_set_bulk_mbits(struct ptlrpc_request *req);
diff --git a/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c b/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
index 437b4b2a9072..6ed77521d025 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c
@@ -435,16 +435,17 @@ static int ptlrpcd(void *arg)
 	 * new_req_list and ptlrpcd_check() moves them into the set.
 	 */
 	do {
-		struct l_wait_info lwi;
 		int timeout;
 
 		timeout = ptlrpc_set_next_timeout(set);
-		lwi = LWI_TIMEOUT((timeout ? timeout : 1) * HZ,
-				  ptlrpc_expired_set, set);
 
 		lu_context_enter(&env.le_ctx);
 		lu_context_enter(env.le_ses);
-		l_wait_event(set->set_waitq, ptlrpcd_check(&env, pc), &lwi);
+		if (wait_event_idle_timeout(set->set_waitq,
+					    ptlrpcd_check(&env, pc),
+					    (timeout ? timeout : 1) * HZ) == 0)
+			ptlrpc_expired_set(set);
+
 		lu_context_exit(&env.le_ctx);
 		lu_context_exit(env.le_ses);
 
