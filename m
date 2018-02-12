Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226T1FAKkxc2MUTwfAmvJKJ7uARAJDzJGTr3uWffyUHPACT7oUoBhqqfStexiIQ5N3TRWj12
ARC-Seal: i=1; a=rsa-sha256; t=1518479422; cv=none;
        d=google.com; s=arc-20160816;
        b=pjY15DRldGI5pEDcJi0RvSPqXztyKoWKSQXZ5I4ajRs6HcDBOKU/PAVA7nWqG9yvou
         LXaA/3HQX/oVlL5SfBBR7elcVsQPksTEA7EqX1SgXApV0n2za1FEsWbwIUbBzAcoCIkQ
         ul1MrGcllVjLyDzJp6yEE1F47oktzGBqt+fMaiL7+ljYF+d7blbFS30mWt7E/DYbQYGl
         4SbPP0V3RL8Lw1GWUqk3rZryZQFz3lihfPYS4m0HLifYg47siT962CVoPGgiV7PRh4J+
         04yY+6I1ZiCnLik7negiEarXt1y1YN5FXVTCJZG0OvL/mivjvr5Tk5VkzlzSj4yTd8+1
         p9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=6knynw4R5N0MA0Yr8Da5vocR5IP6H8nJvjwr87Wa4D4=;
        b=Y0GvtjEcrsTJvq8XDHA9KGxsSpogxyBiJ6286GRSP41GrwyGRYpZhJv3sG7dBOGbWY
         k+DdYju0dbsxZrGorkIFKhM7GlSDmI6JhYfUAk5SQCD3ATz/zBNTDoamMJb0bfWj/sm6
         oV+OFOO6610DWLH4QFlfHuC/fA2N4lg5xCTeeipZIJGXiRo7Ppzco0uIHT7LWfNnx15I
         Gr0x+92Uvws9/nzA7iZRi5c3SlZcxm+SXh0RfIU1cR+vA/WBqQo5RmTijhRZw3jI3DkP
         D2KcwtY3h1k9qaiHZWNAWbe6MiP4h16IN6zzAIhElWP7ZBLAHR5zBw8t2TEhrJONO74J
         EbEA==
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
Subject: [PATCH 15/19] staging: lustre: use explicit poll loop in
 ptlrpc_service_unlink_rqbd
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847927917.19840.6241020862557231833.stgit@noble>
In-Reply-To: <151847037709.22826.16175867257667686132.stgit@noble>
References: <151847037709.22826.16175867257667686132.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592241078453031936?=
X-GMAIL-MSGID: =?utf-8?q?1592241078453031936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rather an using l_wait_event(), use wait_event_idle_timeout()
with an explicit loop so it is easier to see what is happening.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Patrick Farrell <paf@cray.com>
---
 drivers/staging/lustre/lustre/ptlrpc/service.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/staging/lustre/lustre/ptlrpc/service.c
index 5c41297d23d2..6e3403417434 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/service.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
@@ -2618,7 +2618,7 @@ ptlrpc_service_unlink_rqbd(struct ptlrpc_service *svc)
 {
 	struct ptlrpc_service_part *svcpt;
 	struct ptlrpc_request_buffer_desc *rqbd;
-	struct l_wait_info lwi;
+	int cnt;
 	int rc;
 	int i;
 
@@ -2658,12 +2658,13 @@ ptlrpc_service_unlink_rqbd(struct ptlrpc_service *svc)
 			 * the HUGE timeout lets us CWARN for visibility
 			 * of sluggish LNDs
 			 */
-			lwi = LWI_TIMEOUT_INTERVAL(
-					LONG_UNLINK * HZ,
-					HZ, NULL, NULL);
-			rc = l_wait_event(svcpt->scp_waitq,
-					  svcpt->scp_nrqbds_posted == 0, &lwi);
-			if (rc == -ETIMEDOUT) {
+			cnt = 0;
+			while (cnt < LONG_UNLINK &&
+			       (rc = wait_event_idle_timeout(svcpt->scp_waitq,
+							     svcpt->scp_nrqbds_posted == 0,
+							     HZ)) == 0)
+				cnt ++;
+			if (rc == 0) {
 				CWARN("Service %s waiting for request buffers\n",
 				      svcpt->scp_service->srv_name);
 			}
