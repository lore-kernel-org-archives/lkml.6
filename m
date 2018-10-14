Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B8C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB3520645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB3520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeJNXgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:36:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36080 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbeJNXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:56 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLi-0004io-Vr; Sun, 14 Oct 2018 16:30:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hr-Ra; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Marc Dionne" <marc.dionne@auristor.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "David Howells" <dhowells@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.197927745@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 324/366] afs: Ignore AFS_ACE_READ and AFS_ACE_WRITE
 for directories
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

From: Marc Dionne <marc.dionne@auristor.com>

commit fd2498211a551fd42b2d6b9050d649d43536e75c upstream.

The AFS_ACE_READ and AFS_ACE_WRITE permission bits should not
be used to make access decisions for the directory itself.  They
are meant to control access for the objects contained in that
directory.

Reading a directory is allowed if the AFS_ACE_LOOKUP bit is set.
This would cause an incorrect access denied error for a directory
with AFS_ACE_LOOKUP but not AFS_ACE_READ.

The AFS_ACE_WRITE bit does not allow operations that modify the
directory.  For a directory with AFS_ACE_WRITE but neither
AFS_ACE_INSERT nor AFS_ACE_DELETE, this would result in trying
operations that would ultimately be denied by the server.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/afs/security.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -327,12 +327,11 @@ int afs_permission(struct inode *inode,
 			if (!(access & AFS_ACE_LOOKUP))
 				goto permission_denied;
 		} else if (mask & MAY_READ) {
-			if (!(access & AFS_ACE_READ))
+			if (!(access & AFS_ACE_LOOKUP))
 				goto permission_denied;
 		} else if (mask & MAY_WRITE) {
 			if (!(access & (AFS_ACE_DELETE | /* rmdir, unlink, rename from */
-					AFS_ACE_INSERT | /* create, mkdir, symlink, rename to */
-					AFS_ACE_WRITE))) /* chmod */
+					AFS_ACE_INSERT))) /* create, mkdir, symlink, rename to */
 				goto permission_denied;
 		} else {
 			BUG();

