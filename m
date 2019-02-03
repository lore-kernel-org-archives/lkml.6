Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4041DC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6782073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfBCOUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55334 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729725AbfBCOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:15 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqId3-0006FB-Cf; Sun, 03 Feb 2019 14:20:13 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-0006zQ-1r; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Steve French" <stfrench@microsoft.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.174683592@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 113/305] smb3: do not attempt cifs operation in smb3
 query info error path
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 1e77a8c204c9d1b655c61751b8ad0fde22421dbb upstream.

If backupuid mount option is sent, we can incorrectly retry
(on access denied on query info) with a cifs (FindFirst) operation
on an smb3 mount which causes the server to force the session close.

We set backup intent on open so no need for this fallback.

See kernel bugzilla 201435

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -735,7 +735,15 @@ cifs_get_inode_info(struct inode **inode
 	} else if (rc == -EREMOTE) {
 		cifs_create_dfs_fattr(&fattr, sb);
 		rc = 0;
-	} else if (rc == -EACCES && backup_cred(cifs_sb)) {
+	} else if ((rc == -EACCES) && backup_cred(cifs_sb) &&
+		   (strcmp(server->vals->version_string, SMB1_VERSION_STRING)
+		      == 0)) {
+			/*
+			 * For SMB2 and later the backup intent flag is already
+			 * sent if needed on open and there is no path based
+			 * FindFirst operation to use to retry with
+			 */
+
 			srchinf = kzalloc(sizeof(struct cifs_search_info),
 						GFP_KERNEL);
 			if (srchinf == NULL) {

