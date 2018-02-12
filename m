Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227mEDAJLhOMGmklLmAYNCbJqfsfR1KsbeVlsqNFN90Vi5nj+GhlDxxWh1/FTP73mM68HanT
ARC-Seal: i=1; a=rsa-sha256; t=1518479402; cv=none;
        d=google.com; s=arc-20160816;
        b=bW1g3QxR6wy8G7o7UH/Y0MidBi/ZqYNCDzoAcm1c+kXLuHNv43Eak0bGwSRKS283jV
         0oywXygAOYw4/KgmqRPaXEOoGruLE8RkejEuJIz1svyN5Lfh0Gj6zz4INVl/nJepVrPd
         obxtTkQyc6ZXSMuiO9oC4u/9rMFW1126p/857oxjBTPvuRCEkL5LlhmR+CM4wUWh6vtJ
         wixfGGdReys3Vp2/XsaZdV7sdOcG2GF0jtEiDf7xOXrWALGzjr3gXkImLtJlbNgYhUsJ
         azrikPgb4OXMQg35gF5VxZD3Yzez6WYu3CU9EYMG2TcL1Ifk7OZiV0QJSNKhZtEBNkg2
         cCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=JoEQJxzX22IYNdh/1przx7m18/5M8aa5LcytCiRtcvg=;
        b=QeRJYBW5xfQWHxAeQJ/kLU0EUzyHUYFwQY5j0tZ7+QoCSYRj+Pl+YxIdud2lK576n5
         gG6+2socvw3bEfUBAGqMxSKWG0POYfoPqlO8iZef5/20dD5eU01zWSvzX2iKvR68vvnk
         Xw0ohp7P/Ek3LvKMZnXYx2Rn6HYNy/qjce1eYs7/m1qbHTmR0yBbJRWggCBlXUFrDevu
         rYZ9yzQh0RfV9g5y1OYIeD2LnzaW2N5iQ9yzCxlw7A8dp12P18P/0RprGm5fzDi+goXN
         xV5b7nSKwInt07IDDa8HpM6EgFcMS7bpfGHZTQnAq657wAH4dKEjeXyYkRQG+JymeXJt
         ohjg==
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
Subject: [PATCH 12/19] staging: lustre: make polling loop in
 ptlrpc_unregister_bulk more obvious
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927906.19840.2239613687503242193.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241057869806521?=
X-GMAIL-MSGID: =?utf-8?q?1592241057869806521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This use of l_wait_event() is a polling loop that re-checks
every second.  Make this more obvious with a while loop
and wait_event_idle_timeout().

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/niobuf.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/niobuf.c b/drivers/staging/lustre/lustre/ptlrpc/niobuf.c
index 0c2ded721c49..86883abaad2c 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/niobuf.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/niobuf.c
@@ -229,7 +229,6 @@ int ptlrpc_unregister_bulk(struct ptlrpc_request *req, int async)
 {
 	struct ptlrpc_bulk_desc *desc = req->rq_bulk;
 	wait_queue_head_t *wq;
-	struct l_wait_info lwi;
 	int rc;
 
 	LASSERT(!in_interrupt());     /* might sleep */
@@ -246,7 +245,7 @@ int ptlrpc_unregister_bulk(struct ptlrpc_request *req, int async)
 
 	/* the unlink ensures the callback happens ASAP and is the last
 	 * one.  If it fails, it must be because completion just happened,
-	 * but we must still l_wait_event() in this case to give liblustre
+	 * but we must still wait_event() in this case to give liblustre
 	 * a chance to run client_bulk_callback()
 	 */
 	mdunlink_iterate_helper(desc->bd_mds, desc->bd_md_max_brw);
@@ -270,15 +269,17 @@ int ptlrpc_unregister_bulk(struct ptlrpc_request *req, int async)
 		/* Network access will complete in finite time but the HUGE
 		 * timeout lets us CWARN for visibility of sluggish LNDs
 		 */
-		lwi = LWI_TIMEOUT_INTERVAL(LONG_UNLINK * HZ,
-					   HZ, NULL, NULL);
-		rc = l_wait_event(*wq, !ptlrpc_client_bulk_active(req), &lwi);
-		if (rc == 0) {
+		int cnt = 0;
+		while (cnt < LONG_UNLINK &&
+		       (rc = wait_event_idle_timeout(*wq,
+						     !ptlrpc_client_bulk_active(req),
+						     HZ)) == 0)
+			cnt += 1;
+		if (rc > 0) {
 			ptlrpc_rqphase_move(req, req->rq_next_phase);
 			return 1;
 		}
 
-		LASSERT(rc == -ETIMEDOUT);
 		DEBUG_REQ(D_WARNING, req, "Unexpectedly long timeout: desc %p",
 			  desc);
 	}
