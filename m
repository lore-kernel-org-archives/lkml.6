Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD6AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C8E23F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C8E23F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934460AbeGFFv7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934440AbeGFFvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:55 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDE2DC8D;
        Fri,  6 Jul 2018 05:51:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Billings <jsbillings@jsbillings.org>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 46/61] afs: Fix directory permissions check
Date:   Fri,  6 Jul 2018 07:47:10 +0200
Message-Id: <20180706054714.105324259@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 378831e4daec75fbba6d3612bcf3b4dd00ddbf08 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/security.c |   10 +++-------
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


