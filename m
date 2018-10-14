Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8266C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767CA20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767CA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeJNXfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:35:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36089 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727792AbeJNXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:56 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLi-0004cF-Vf; Sun, 14 Oct 2018 16:30:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hw-TH; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Jonathan Billings" <jsbillings@jsbillings.org>,
        "David Howells" <dhowells@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.966029350@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 325/366] afs: Fix directory permissions check
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 378831e4daec75fbba6d3612bcf3b4dd00ddbf08 upstream.

Doing faccessat("/afs/some/directory", 0) triggers a BUG in the permissions
check code.

Fix this by just removing the BUG section.  If no permissions are asked
for, just return okay if the file exists.

Also:

 (1) Split up the directory check so that it has separate if-statements
     rather than if-else-if (e.g. checking for MAY_EXEC shouldn't skip the
     check for MAY_READ and MAY_WRITE).

 (2) Check for MAY_CHDIR as MAY_EXEC.

Without the main fix, the following BUG may occur:

 kernel BUG at fs/afs/security.c:386!
 invalid opcode: 0000 [#1] SMP PTI
 ...
 RIP: 0010:afs_permission+0x19d/0x1a0 [kafs]
 ...
 Call Trace:
  ? inode_permission+0xbe/0x180
  ? do_faccessat+0xdc/0x270
  ? do_syscall_64+0x60/0x1f0
  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 00d3b7a4533e ("[AFS]: Add security support.")
Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/afs/security.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -323,18 +323,14 @@ int afs_permission(struct inode *inode,
 	       mask, access, S_ISDIR(inode->i_mode) ? "dir" : "file");
 
 	if (S_ISDIR(inode->i_mode)) {
-		if (mask & MAY_EXEC) {
+		if (mask & (MAY_EXEC | MAY_READ | MAY_CHDIR)) {
 			if (!(access & AFS_ACE_LOOKUP))
 				goto permission_denied;
-		} else if (mask & MAY_READ) {
-			if (!(access & AFS_ACE_LOOKUP))
-				goto permission_denied;
-		} else if (mask & MAY_WRITE) {
+		}
+		if (mask & MAY_WRITE) {
 			if (!(access & (AFS_ACE_DELETE | /* rmdir, unlink, rename from */
 					AFS_ACE_INSERT))) /* create, mkdir, symlink, rename to */
 				goto permission_denied;
-		} else {
-			BUG();
 		}
 	} else {
 		if (!(access & AFS_ACE_LOOKUP))

