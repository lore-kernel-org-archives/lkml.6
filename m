Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x224rFdNanuFpfTg7Fko0uwNiTBH/K3i1zT8Ee0W/OvK2qywQMLygbkOsbzGGQXa2dtquOZis
ARC-Seal: i=1; a=rsa-sha256; t=1518479429; cv=none;
        d=google.com; s=arc-20160816;
        b=tr99Cp9PodWpgX0ilxNxcHqILWAesjzP6rJxcp61qkmBk2w6n783gRouBIxWIZqL4x
         3WkkNODeUVo96IsIrtwp79klQrYmoDSOv2GpyS+ZrwFaH3UQoDTMvzv9qDTgFO9OiVp+
         Fg5WddSnf2p0RTQUnPOj3nKLk+TxjggRgVa8SLCK8YZfldac3ldl1jqwhEJAnBO/Y9Qd
         JzPVOJBSVDLUiz0IUK9MlhfNKHE4mPOrHJbFkSSflbtlwQE46gIFkBTWTstYZYv6QB70
         mGYezU4lEvFdLmUpwM6z2Feboc56Jy835wRJ21Ao3s30Pj6P/vRN+KIXIUxFdQSOG+4e
         9QHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=g4q+kTwGk9EJ04+RobQrbyfqszH1qyhMMpbNVwwr7jY=;
        b=0dD5OGFUtz9+p+y6t/wDlUxtlYPCVXVYLlhoULWOsMgPGkPZPZO3iJXCFm3E7WHfCl
         +zbsP/zwPNbR433criI71RbeP2c2ObSuFS1hkqxwjr6rek9c1VMO1lDJaq83YXWpXip/
         Sk+IrFkJIF4Y7KQPSOgPddJpZBWgftaonuSSOOQ1JpojVoU7P+JyXMtfX2IY5efnQk5I
         HZJLbcNRDL1tMjR3Nw99FYIN0sdCPqxlzRPKjL/IxqjYRCpdAVZR/xSxtYtQjuNEg5oa
         aSxZnBIgTow6w/yOCUx4opNc6QdLWLsqcMTRxwveYrjC6ENJIGZgXzO3UByt//GiOZ5/
         0WNQ==
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
Subject: [PATCH 16/19] staging: lustre: use explicit poll loop in
 ptlrpc_unregister_reply
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927920.19840.8201423653881194896.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241086229502605?=
X-GMAIL-MSGID: =?utf-8?q?1592241086229502605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

replace l_wait_event() with wait_event_idle_timeout() and explicit
loop.  This approach is easier to understand.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/client.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/client.c b/drivers/staging/lustre/lustre/ptlrpc/client.c
index f70176c6db08..ffdd3ffd62c6 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/client.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/client.c
@@ -2500,7 +2500,6 @@ static int ptlrpc_unregister_reply(struct ptlrpc_request *request, int async)
 {
 	int rc;
 	wait_queue_head_t *wq;
-	struct l_wait_info lwi;
 
 	/* Might sleep. */
 	LASSERT(!in_interrupt());
@@ -2543,16 +2542,17 @@ static int ptlrpc_unregister_reply(struct ptlrpc_request *request, int async)
 		 * Network access will complete in finite time but the HUGE
 		 * timeout lets us CWARN for visibility of sluggish NALs
 		 */
-		lwi = LWI_TIMEOUT_INTERVAL(LONG_UNLINK * HZ,
-					   HZ, NULL, NULL);
-		rc = l_wait_event(*wq, !ptlrpc_client_recv_or_unlink(request),
-				  &lwi);
-		if (rc == 0) {
+		int cnt = 0;
+		while (cnt < LONG_UNLINK &&
+		       (rc = wait_event_idle_timeout(*wq,
+						     !ptlrpc_client_recv_or_unlink(request),
+						     HZ)) == 0)
+			cnt += 1;
+		if (rc > 0) {
 			ptlrpc_rqphase_move(request, request->rq_next_phase);
 			return 1;
 		}
 
-		LASSERT(rc == -ETIMEDOUT);
 		DEBUG_REQ(D_WARNING, request,
 			  "Unexpectedly long timeout receiving_reply=%d req_ulinked=%d reply_unlinked=%d",
 			  request->rq_receiving_reply,
