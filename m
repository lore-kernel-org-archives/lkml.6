Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227C1AVlQp2+nhcr6tDkw1Jp/KDpxzD2Jf4HE1nLhbTPiZmcvBG/cRdtYr0mNObXqspLneKd
ARC-Seal: i=1; a=rsa-sha256; t=1518479415; cv=none;
        d=google.com; s=arc-20160816;
        b=yiidPYuZMYyUnfQGQF6E51k88FJPzSVwauO3r0cAru1Gxmt5xaTpq8aISYl2TW99R3
         5+XeMATOx6Z+ODsGA92QjWlgJZcDEp1ENBN+kGKG3B61gUrRkNdhuSBxj4bYpZMLaEa3
         BFe/fWTteExM0qUYP99v5mquyaVozbT9fDWZFigD2D6mmJ5JFDnKGKtCW76yf1Yw9bd9
         IxE0oDPmfmXzVUK/TI9MImdhclc8Lwbkb9T1+YVzQf3bDjQLLKLioROgAcKRSuCtNGYI
         Z0P1PuZOOxvBnJqq2VUu4fcKJIi8koLzhLLptOe7h80iAScGqcoLQ2n630yFHIRkURd2
         k52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=iUfDi4Yzmwt1otOT9TjhDH0plcMwNNILFdnjl/D4gJA=;
        b=BhcjaAq+0kIkKybo8AJGIl1SsUfLrdhEqt4m2N5fG+MpLjrUaaVBo4PDmcdHhE4bZ0
         grymPF8H9A+HCfvR09ptWQwVThnuYyh1/mSRimsTe/U6NuwR6FwraLTkNL3db0E1srPo
         bfo/dAa2r8tgG7WLivrwD1q6UmmBru1HGKv+KX+YH4JEPmTgloyMThjPRGbCudcw/hz4
         Rh4tYvJWdos/j9ZkKQej83tIUFvWryWrVpIrAhZI5CQFz3J3U9VkodKcSvk9gdj7yzPi
         LtKlK+ukvEnpqMgq0EKN4WFZ/9x+KTjRRAwAH5tVS52kB10IUOl9DmYbc1Q9+7cBR4IG
         rLEA==
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
Subject: [PATCH 14/19] staging: lustre: improve waiting in
 sptlrpc_req_refresh_ctx
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927912.19840.9343278155250610050.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241071677995719?=
X-GMAIL-MSGID: =?utf-8?q?1592241071677995719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace l_wait_event with wait_event_idle_timeout() and call the
handler function explicitly.  This makes it more clear
what is happening.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/sec.c |   34 ++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec.c b/drivers/staging/lustre/lustre/ptlrpc/sec.c
index 617e004d00f8..90e3b3022106 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
@@ -554,9 +554,8 @@ int ctx_check_refresh(struct ptlrpc_cli_ctx *ctx)
 }
 
 static
-int ctx_refresh_timeout(void *data)
+int ctx_refresh_timeout(struct ptlrpc_request *req)
 {
-	struct ptlrpc_request *req = data;
 	int rc;
 
 	/* conn_cnt is needed in expire_one_request */
@@ -575,10 +574,8 @@ int ctx_refresh_timeout(void *data)
 }
 
 static
-void ctx_refresh_interrupt(void *data)
+void ctx_refresh_interrupt(struct ptlrpc_request *req)
 {
-	struct ptlrpc_request *req = data;
-
 	spin_lock(&req->rq_lock);
 	req->rq_intr = 1;
 	spin_unlock(&req->rq_lock);
@@ -611,7 +608,6 @@ int sptlrpc_req_refresh_ctx(struct ptlrpc_request *req, long timeout)
 {
 	struct ptlrpc_cli_ctx *ctx = req->rq_cli_ctx;
 	struct ptlrpc_sec *sec;
-	struct l_wait_info lwi;
 	int rc;
 
 	LASSERT(ctx);
@@ -743,10 +739,28 @@ int sptlrpc_req_refresh_ctx(struct ptlrpc_request *req, long timeout)
 	req->rq_restart = 0;
 	spin_unlock(&req->rq_lock);
 
-	lwi = LWI_TIMEOUT_INTR(msecs_to_jiffies(timeout * MSEC_PER_SEC),
-			       ctx_refresh_timeout, ctx_refresh_interrupt,
-			       req);
-	rc = l_wait_event(req->rq_reply_waitq, ctx_check_refresh(ctx), &lwi);
+	rc = wait_event_idle_timeout(req->rq_reply_waitq,
+				     ctx_check_refresh(ctx),
+				     timeout * HZ);
+	if (rc == 0 && ctx_refresh_timeout(req) == 0) {
+		/* Keep waiting, but enable some signals */
+		rc = l_wait_event_abortable(req->rq_reply_waitq,
+					    ctx_check_refresh(ctx));
+		if (rc == 0)
+			rc = 1;
+	}
+
+	if (rc > 0)
+		/* condition is true */
+		rc = 0;
+	else if (rc == 0)
+		/* Timed out */
+		rc = -ETIMEDOUT;
+	else {
+		/* Aborted by signal */
+		rc = -EINTR;
+		ctx_refresh_interrupt(req);
+	}
 
 	/*
 	 * following cases could lead us here:
