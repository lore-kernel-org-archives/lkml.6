Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7980122353
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxiPRLWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7980122353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405258AbeKTDYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:24:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404390AbeKTDYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5BD21722;
        Mon, 19 Nov 2018 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646803;
        bh=AZKndL1XHOLkxMdQ/WxDHhY9eOOOjeTTS03o7TT9z2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxiPRLWZQ9Lp5g4pGNuKkDuy6o9GLFE2UHnFsmFr53pyyvV1fiV5izjCOeTll9Sj7
         9p1SndVhJzsBcPhyPi/je33q3jCLzI8I2B+SUTxoLgo8vFSuhz/bwYTxABj+wHOtlT
         ha9+OBRRRTg5rc8d9+SUF0prIoAyvje8LwlLLIts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>
Subject: [PATCH 4.4 095/160] MD: fix invalid stored role for a disk - try2
Date:   Mon, 19 Nov 2018 17:28:54 +0100
Message-Id: <20181119162640.358782061@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaohua Li <shli@fb.com>

commit 9e753ba9b9b405e3902d9f08aec5f2ea58a0c317 upstream.

Commit d595567dc4f0 (MD: fix invalid stored role for a disk) broke linear
hotadd. Let's only fix the role for disks in raid1/10.
Based on Guoqing's original patch.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Gioh Kim <gi-oh.kim@profitbricks.com>
Cc: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c     |    4 ----
 drivers/md/raid1.c  |    1 +
 drivers/md/raid10.c |    1 +
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1670,10 +1670,6 @@ static int super_1_validate(struct mddev
 			} else
 				set_bit(In_sync, &rdev->flags);
 			rdev->raid_disk = role;
-			if (role >= mddev->raid_disks) {
-				rdev->saved_raid_disk = -1;
-				rdev->raid_disk = -1;
-			}
 			break;
 		}
 		if (sb->devflags & WriteMostly1)
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1605,6 +1605,7 @@ static int raid1_add_disk(struct mddev *
 	 */
 	if (rdev->saved_raid_disk >= 0 &&
 	    rdev->saved_raid_disk >= first &&
+	    rdev->saved_raid_disk < conf->raid_disks &&
 	    conf->mirrors[rdev->saved_raid_disk].rdev == NULL)
 		first = last = rdev->saved_raid_disk;
 
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1737,6 +1737,7 @@ static int raid10_add_disk(struct mddev
 		first = last = rdev->raid_disk;
 
 	if (rdev->saved_raid_disk >= first &&
+	    rdev->saved_raid_disk < conf->geo.raid_disks &&
 	    conf->mirrors[rdev->saved_raid_disk].rdev == NULL)
 		mirror = rdev->saved_raid_disk;
 	else


