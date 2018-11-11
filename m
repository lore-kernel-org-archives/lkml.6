Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B57C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4498A2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4498A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbeKLGGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:06:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53262 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730996AbeKLGGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:06:31 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000lG-6L; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001gN-Jp; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Aurelien Aptel" <aaptel@suse.com>,
        "Paulo Alcantara" <palcantara@suse.de>,
        "Paulo Alcantara" <paulo@paulo.ac>,
        "Steve French" <stfrench@microsoft.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.302942432@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 232/366] cifs: Fix infinite loop when using hard
 mount option
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <paulo@paulo.ac>

commit 7ffbe65578b44fafdef577a360eb0583929f7c6e upstream.

For every request we send, whether it is SMB1 or SMB2+, we attempt to
reconnect tcon (cifs_reconnect_tcon or smb2_reconnect) before carrying
out the request.

So, while server->tcpStatus != CifsNeedReconnect, we wait for the
reconnection to succeed on wait_event_interruptible_timeout(). If it
returns, that means that either the condition was evaluated to true, or
timeout elapsed, or it was interrupted by a signal.

Since we're not handling the case where the process woke up due to a
received signal (-ERESTARTSYS), the next call to
wait_event_interruptible_timeout() will _always_ fail and we end up
looping forever inside either cifs_reconnect_tcon() or smb2_reconnect().

Here's an example of how to trigger that:

$ mount.cifs //foo/share /mnt/test -o
username=foo,password=foo,vers=1.0,hard

(break connection to server before executing bellow cmd)
$ stat -f /mnt/test & sleep 140
[1] 2511

$ ps -aux -q 2511
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      2511  0.0  0.0  12892  1008 pts/0    S    12:24   0:00 stat -f
/mnt/test

$ kill -9 2511

(wait for a while; process is stuck in the kernel)
$ ps -aux -q 2511
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      2511 83.2  0.0  12892  1008 pts/0    R    12:24  30:01 stat -f
/mnt/test

By using 'hard' mount point means that cifs.ko will keep retrying
indefinitely, however we must allow the process to be killed otherwise
it would hang the system.

Signed-off-by: Paulo Alcantara <palcantara@suse.de>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifssmb.c | 10 ++++++++--
 fs/cifs/smb2pdu.c | 18 ++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -150,8 +150,14 @@ cifs_reconnect_tcon(struct cifs_tcon *tc
 	 * greater than cifs socket timeout which is 7 seconds
 	 */
 	while (server->tcpStatus == CifsNeedReconnect) {
-		wait_event_interruptible_timeout(server->response_q,
-			(server->tcpStatus != CifsNeedReconnect), 10 * HZ);
+		rc = wait_event_interruptible_timeout(server->response_q,
+						      (server->tcpStatus != CifsNeedReconnect),
+						      10 * HZ);
+		if (rc < 0) {
+			cifs_dbg(FYI, "%s: aborting reconnect due to a received"
+				 " signal by the process\n", __func__);
+			return -ERESTARTSYS;
+		}
 
 		/* are we still trying to reconnect? */
 		if (server->tcpStatus != CifsNeedReconnect)
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -158,7 +158,7 @@ out:
 static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 {
-	int rc = 0;
+	int rc;
 	struct nls_table *nls_codepage;
 	struct cifs_ses *ses;
 	struct TCP_Server_Info *server;
@@ -169,10 +169,10 @@ smb2_reconnect(__le16 smb2_command, stru
 	 * for those three - in the calling routine.
 	 */
 	if (tcon == NULL)
-		return rc;
+		return 0;
 
 	if (smb2_command == SMB2_TREE_CONNECT)
-		return rc;
+		return 0;
 
 	if (tcon->tidStatus == CifsExiting) {
 		/*
@@ -215,8 +215,14 @@ smb2_reconnect(__le16 smb2_command, stru
 			return -EAGAIN;
 		}
 
-		wait_event_interruptible_timeout(server->response_q,
-			(server->tcpStatus != CifsNeedReconnect), 10 * HZ);
+		rc = wait_event_interruptible_timeout(server->response_q,
+						      (server->tcpStatus != CifsNeedReconnect),
+						      10 * HZ);
+		if (rc < 0) {
+			cifs_dbg(FYI, "%s: aborting reconnect due to a received"
+				 " signal by the process\n", __func__);
+			return -ERESTARTSYS;
+		}
 
 		/* are we still trying to reconnect? */
 		if (server->tcpStatus != CifsNeedReconnect)
@@ -234,7 +240,7 @@ smb2_reconnect(__le16 smb2_command, stru
 	}
 
 	if (!tcon->ses->need_reconnect && !tcon->need_reconnect)
-		return rc;
+		return 0;
 
 	nls_codepage = load_nls_default();
 

