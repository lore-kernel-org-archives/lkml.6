Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC9C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA25224B3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF0VWjPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA25224B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbeKLIVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733175AbeKLIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDA19223DD;
        Sun, 11 Nov 2018 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975503;
        bh=h40ACLgup/xNmytv9Npy9OB8xS6Ctf4bbaMgdMBGGnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nF0VWjPvAUKikQnrqZalncsQiSYmL28s2yPaSSynk9h/+5pYZFyvDIOF5Ca4ZkvKV
         4sPbzDIC08zHIMdKNAKUmAfj3fnExO/hnErDPqB/ZSc+jlCkud9DyWb/h8nVDRKmEM
         boNEFhrvzaBUVGXf90XCKp5+uTS8OeIdxndMVmD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 321/350] btrfs: fix error handling in btrfs_dev_replace_start
Date:   Sun, 11 Nov 2018 14:23:05 -0800
Message-Id: <20181111221721.495847126@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/dev-replace.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -445,6 +445,7 @@ int btrfs_dev_replace_start(struct btrfs
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
+		ASSERT(0);
 		ret = BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
 		goto leave;
 	}
@@ -487,6 +488,10 @@ int btrfs_dev_replace_start(struct btrfs
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		btrfs_dev_replace_write_lock(dev_replace);
+		dev_replace->replace_state =
+			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
+		dev_replace->srcdev = NULL;
+		dev_replace->tgtdev = NULL;
 		goto leave;
 	}
 
@@ -508,8 +513,6 @@ int btrfs_dev_replace_start(struct btrfs
 	return ret;
 
 leave:
-	dev_replace->srcdev = NULL;
-	dev_replace->tgtdev = NULL;
 	btrfs_dev_replace_write_unlock(dev_replace);
 	btrfs_destroy_dev_replace_tgtdev(fs_info, tgt_device);
 	return ret;


