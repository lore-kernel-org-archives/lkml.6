Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E6C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E26920815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfBCOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:01:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53216 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728086AbfBCNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:49 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-0003tj-6t; Sun, 03 Feb 2019 13:49:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006v0-Vo; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David Sterba" <dsterba@suse.com>, "Jeff Mahoney" <jeffm@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.670221568@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 082/305] btrfs: fix error handling in btrfs_dev_replace_start
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

From: Jeff Mahoney <jeffm@suse.com>

commit 5c06147128fbbdf7a84232c5f0d808f53153defe upstream.

When we fail to start a transaction in btrfs_dev_replace_start, we leave
dev_replace->replace_start set to STARTED but clear ->srcdev and
->tgtdev.  Later, that can result in an Oops in
btrfs_dev_replace_progress when having state set to STARTED or SUSPENDED
implies that ->srcdev is valid.

Also fix error handling when the state is already STARTED or SUSPENDED
while starting.  That, too, will clear ->srcdev and ->tgtdev even though
it doesn't own them.  This should be an impossible case to hit since we
should be protected by the BTRFS_FS_EXCL_OP bit being set.  Let's add an
ASSERT there while we're at it.

Fixes: e93c89c1aaaaa (Btrfs: add new sources for device replace code)
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/dev-replace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -362,6 +362,7 @@ int btrfs_dev_replace_start(struct btrfs
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
+		ASSERT(0);
 		args->result = BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
 		goto leave;
 	}
@@ -406,6 +407,10 @@ int btrfs_dev_replace_start(struct btrfs
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_dev_replace_lock(dev_replace);
+		dev_replace->replace_state =
+			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
+		dev_replace->srcdev = NULL;
+		dev_replace->tgtdev = NULL;
 		goto leave;
 	}
 
@@ -423,8 +428,6 @@ int btrfs_dev_replace_start(struct btrfs
 	return 0;
 
 leave:
-	dev_replace->srcdev = NULL;
-	dev_replace->tgtdev = NULL;
 	btrfs_dev_replace_unlock(dev_replace);
 leave_no_lock:
 	if (tgt_device)

