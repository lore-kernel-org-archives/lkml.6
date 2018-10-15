Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3867CC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E937220652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E937220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeJOVLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:11:00 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:48545 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJOVLA (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 15 Oct 2018 17:11:00 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 15 Oct 2018 15:25:40 +0200
Received: from linux-nq5u.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Mon, 15 Oct 2018 14:25:14 +0100
From:   Vasilis Liaskovitis <vliaskovitis@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        konrad.wilk@oracle.com, axboe@kernel.dk
Subject: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference on device removal
Date:   Mon, 15 Oct 2018 15:25:08 +0200
Message-Id: <20181015132508.23293-1-vliaskovitis@suse.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a block device is hot-added when we are out of grants,
gnttab_grant_foreign_access fails with -ENOSPC (log message "28
granting access to ring page") in this code path:

  talk_to_blkback ->
	setup_blkring ->
		xenbus_grant_ring ->
			gnttab_grant_foreign_access

and the failing path in talk_to_blkback sets the driver_data to NULL:

 destroy_blkring:
        blkif_free(info, 0);

        mutex_lock(&blkfront_mutex);
        free_info(info);
        mutex_unlock(&blkfront_mutex);

        dev_set_drvdata(&dev->dev, NULL);

This results in a NULL pointer BUG when blkfront_remove and blkif_free
try to access the failing device's NULL struct blkfront_info.

Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 drivers/block/xen-blkfront.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 429d20131c7e..8871bf4c8a2e 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2493,6 +2493,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 
 	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
 
+	if (!info)
+		return 0;
+
 	blkif_free(info, 0);
 
 	mutex_lock(&info->mutex);
-- 
2.19.0

