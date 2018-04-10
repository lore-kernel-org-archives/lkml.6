Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx480VCn6zg50wJAp+WVQe3K2i4aU/zUseLhY19bfYHmWcJYBHCka1Hem1cw6Sqh4NGqtKU0T
ARC-Seal: i=1; a=rsa-sha256; t=1523399743; cv=none;
        d=google.com; s=arc-20160816;
        b=ER6/shh7jUlANupHjR62N4J4M9NiPBkyQTkVB5idSlhRvUqid7v5OyO16lk9Aj2TwV
         R9KL9Q3rz0FMGaJzOqTSnqC+yI1DaTxofUmaMRBx5XBkh8+F24K935HlMLWe0/esfRls
         D6mLE8ydPmo1VhWpoZjFrcU7i2tp1hMmhvATTeQDp51GuV7uVcteimBtfm3Lu6xOgqAz
         d7D4DBASrKy33+UHupD0NUV/zmgisVVkkb5rvYwzOprnhDg6LGgr3t2y0HlfgxOE+a80
         tmlnGWfyz5paEoALLZzG0d4GQU3ZxhwNU+YLt64DXDw2k2w3aVyzp5bdXR6CUtN96KDz
         x4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qX/r3oL0Xs8Yo7aUrunCsgERAg2h92JdUDX0+h0ocms=;
        b=WHkP/szoz8+lUjH2yhpAHrji3l7HaceofsZtsCf8ZQIgx4dHfOhHydjd22b65xkuhT
         WGf8u4hYMIfmxHxKVIS1UCTghBMdTk6QSseujhXz0H4osqmFcdosQTC4rsoaSF52bgZu
         U0+yyZYj34kPe9YwlhDua5oouQuyFzgz4XwGGCS6AN3w2XG/dXp/jzqeZsBKQvw/79wb
         vC0AB09c5zec8JMHxBS8VIfwIHPBvzI42fG6gyNBlgS0I+F9Zyk09hC0/oarB+NE50Ys
         1tGStK6ty1sK+veBUeDGKkWFFmA9SpSee/aI3JZgpR/7BKlSwUOnZw7ntbcAxxx3r26D
         cK8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	Lee Duncan <lduncan@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 030/138] scsi: libiscsi: Allow sd_shutdown on bad transport
Date: Wed, 11 Apr 2018 00:23:40 +0200
Message-Id: <20180410212905.633331449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399890639530166?=
X-GMAIL-MSGID: =?utf-8?q?1597400409023853698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael David Tinoco <rafael.tinoco@canonical.com>


[ Upstream commit d754941225a7dbc61f6dd2173fa9498049f9a7ee ]

If, for any reason, userland shuts down iscsi transport interfaces
before proper logouts - like when logging in to LUNs manually, without
logging out on server shutdown, or when automated scripts can't
umount/logout from logged LUNs - kernel will hang forever on its
sd_sync_cache() logic, after issuing the SYNCHRONIZE_CACHE cmd to all
still existent paths.

PID: 1 TASK: ffff8801a69b8000 CPU: 1 COMMAND: "systemd-shutdow"
 #0 [ffff8801a69c3a30] __schedule at ffffffff8183e9ee
 #1 [ffff8801a69c3a80] schedule at ffffffff8183f0d5
 #2 [ffff8801a69c3a98] schedule_timeout at ffffffff81842199
 #3 [ffff8801a69c3b40] io_schedule_timeout at ffffffff8183e604
 #4 [ffff8801a69c3b70] wait_for_completion_io_timeout at ffffffff8183fc6c
 #5 [ffff8801a69c3bd0] blk_execute_rq at ffffffff813cfe10
 #6 [ffff8801a69c3c88] scsi_execute at ffffffff815c3fc7
 #7 [ffff8801a69c3cc8] scsi_execute_req_flags at ffffffff815c60fe
 #8 [ffff8801a69c3d30] sd_sync_cache at ffffffff815d37d7
 #9 [ffff8801a69c3da8] sd_shutdown at ffffffff815d3c3c

This happens because iscsi_eh_cmd_timed_out(), the transport layer
timeout helper, would tell the queue timeout function (scsi_times_out)
to reset the request timer over and over, until the session state is
back to logged in state. Unfortunately, during server shutdown, this
might never happen again.

Other option would be "not to handle" the issue in the transport
layer. That would trigger the error handler logic, which would also need
the session state to be logged in again.

Best option, for such case, is to tell upper layers that the command was
handled during the transport layer error handler helper, marking it as
DID_NO_CONNECT, which will allow completion and inform about the
problem.

After the session was marked as ISCSI_STATE_FAILED, due to the first
timeout during the server shutdown phase, all subsequent cmds will fail
to be queued, allowing upper logic to fail faster.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@canonical.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/libiscsi.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1696,6 +1696,15 @@ int iscsi_queuecommand(struct Scsi_Host
 		 */
 		switch (session->state) {
 		case ISCSI_STATE_FAILED:
+			/*
+			 * cmds should fail during shutdown, if the session
+			 * state is bad, allowing completion to happen
+			 */
+			if (unlikely(system_state != SYSTEM_RUNNING)) {
+				reason = FAILURE_SESSION_FAILED;
+				sc->result = DID_NO_CONNECT << 16;
+				break;
+			}
 		case ISCSI_STATE_IN_RECOVERY:
 			reason = FAILURE_SESSION_IN_RECOVERY;
 			sc->result = DID_IMM_RETRY << 16;
@@ -1981,6 +1990,19 @@ enum blk_eh_timer_return iscsi_eh_cmd_ti
 
 	if (session->state != ISCSI_STATE_LOGGED_IN) {
 		/*
+		 * During shutdown, if session is prematurely disconnected,
+		 * recovery won't happen and there will be hung cmds. Not
+		 * handling cmds would trigger EH, also bad in this case.
+		 * Instead, handle cmd, allow completion to happen and let
+		 * upper layer to deal with the result.
+		 */
+		if (unlikely(system_state != SYSTEM_RUNNING)) {
+			sc->result = DID_NO_CONNECT << 16;
+			ISCSI_DBG_EH(session, "sc on shutdown, handled\n");
+			rc = BLK_EH_HANDLED;
+			goto done;
+		}
+		/*
 		 * We are probably in the middle of iscsi recovery so let
 		 * that complete and handle the error.
 		 */
@@ -2084,7 +2106,7 @@ done:
 		task->last_timeout = jiffies;
 	spin_unlock(&session->frwd_lock);
 	ISCSI_DBG_EH(session, "return %s\n", rc == BLK_EH_RESET_TIMER ?
-		     "timer reset" : "nh");
+		     "timer reset" : "shutdown or nh");
 	return rc;
 }
 EXPORT_SYMBOL_GPL(iscsi_eh_cmd_timed_out);
