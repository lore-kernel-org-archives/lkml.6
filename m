Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7653EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDBF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDBF20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeIMTLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeIMTLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 07274D19;
        Thu, 13 Sep 2018 14:01:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 138/197] btrfs: check-integrity: Fix NULL pointer dereference for degraded mount
Date:   Thu, 13 Sep 2018 15:31:27 +0200
Message-Id: <20180913131847.077236851@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 9912bbf6440ba0555e91d3306520da01872c7c1d ]

Commit f8f84b2dfda5 ("btrfs: index check-integrity state hash by a dev_t")
changed how btrfsic indexes device state.

Now we need to access device->bdev->bd_dev, while for degraded mount
it's completely possible to have device->bdev as NULL, thus it will
trigger a NULL pointer dereference at mount time.

Fix it by checking if the device is degraded before accessing
device->bdev->bd_dev.

There are a lot of other places accessing device->bdev->bd_dev, however
the other call sites have either checked device->bdev, or the
device->bdev is passed from btrfsic_map_block(), so it won't cause harm.

Fixes: f8f84b2dfda5 ("btrfs: index check-integrity state hash by a dev_t")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/check-integrity.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1539,7 +1539,12 @@ static int btrfsic_map_block(struct btrf
 	}
 
 	device = multi->stripes[0].dev;
-	block_ctx_out->dev = btrfsic_dev_state_lookup(device->bdev->bd_dev);
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state) ||
+	    !device->bdev || !device->name)
+		block_ctx_out->dev = NULL;
+	else
+		block_ctx_out->dev = btrfsic_dev_state_lookup(
+							device->bdev->bd_dev);
 	block_ctx_out->dev_bytenr = multi->stripes[0].physical;
 	block_ctx_out->start = bytenr;
 	block_ctx_out->len = len;


