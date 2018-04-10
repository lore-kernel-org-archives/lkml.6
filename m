Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49YjJKnodENM1N70yAcw9ijtruQ1qkJhPKcelli9ai4K+kuhMv/j3U5lBrGIGz5f2vZIvxL
ARC-Seal: i=1; a=rsa-sha256; t=1523399248; cv=none;
        d=google.com; s=arc-20160816;
        b=R7XYWpKnJbVBYDJFZj4j30ZF7RnpjE+7aXGMS4A3SSm+Uwna9j+B/W9fn6EGcXE4ZH
         nFGN1vGz/j0VfvYK2L1P5o//BxPcWAaJQdVVH8IbM4KWc1SJUeQ9NRSAEKHhnsYrZj98
         f2LYcI2F+wkheWa/5Ii3EBJ9tx3MaN5qkDUFz7iZnnw5wGFs2EmIU8DwH6JIkNIrnXtF
         eUjWjTvPF80tU66MJ7RhWwpmNYQNmG33OPXIP/Gmt68PIUFOzLWV+eaMHN/KeLDg17io
         qt5s4UGWWGccm9Z0Fp6OSyHGluXVLd0v13ol1S3xHfvhSLZeulspwwhLjI+Dk02Wj2mO
         VMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O+zNQZLdICet/NlHgIYvoONOwEnck+R15Pf3hgkZ2Y0=;
        b=alYcQdZUDOCjtMl+MS82OnSL5olw3plnkWtD2EEr8pvrRQi6/gjaGo7//KIaxnJ9kY
         JaQzUMCZPNGhRdkMqJDSCIoMS/teSXRJhgvcoF6ASAUDtzKkfEdbo0McKhW1JPfhgc95
         lacrWmF8jacZZYeQwRzaM12zMHtgDdA0WciJx6MK15do3eab3hKyOTNfyy1PxGxSxt7W
         3dfD6UiWsfv8Q12PMkPrFgFa2PZ2ttfoaI8hBhkAwlzXtDB4TlTz871UMSPBFjN7pfW7
         whEcRLzlT4RTNcrBtUHXBo+KbSqMotCUs8NLVltmOzH4j5nrM4qG8Ody5DIjyAQ+ZaCh
         zdHA==
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
Subject: [PATCH 4.15 040/168] scsi: libiscsi: Allow sd_shutdown on bad transport
Date: Wed, 11 Apr 2018 00:23:02 +0200
Message-Id: <20180410212801.896558612@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399890639530166?=
X-GMAIL-MSGID: =?utf-8?q?1597399890639530166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1979,6 +1988,19 @@ enum blk_eh_timer_return iscsi_eh_cmd_ti
 
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
@@ -2082,7 +2104,7 @@ done:
 		task->last_timeout = jiffies;
 	spin_unlock(&session->frwd_lock);
 	ISCSI_DBG_EH(session, "return %s\n", rc == BLK_EH_RESET_TIMER ?
-		     "timer reset" : "nh");
+		     "timer reset" : "shutdown or nh");
 	return rc;
 }
 EXPORT_SYMBOL_GPL(iscsi_eh_cmd_timed_out);
