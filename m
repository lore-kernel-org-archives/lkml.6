Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7C921855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900359;
	bh=Ssmq42dyYH0ghnib7FEJPklZDcQ4Fhc3zxLADoM2Ci4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1+cYW1JuX6Bgyi0AFliEfC+7nB1oj9Fny5ST8/HTBh2wfXY82tvabF+9ptl3sBCGE
	 zWymIpiIAHqAARV4iFx0t0irfmZ+1fjGBHeluJwX7eXI8i70ggiM7CTufiIknY+d+q
	 BO9oDMsarBfjMTXQEKuD83jp+UxN/VzZxiVTlDzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbfBKPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731400AbfBKOhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893DD20700;
        Mon, 11 Feb 2019 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895831;
        bh=Ssmq42dyYH0ghnib7FEJPklZDcQ4Fhc3zxLADoM2Ci4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwgQlF11BdKZDfrZwtLoMMk6MwdafdXmNLgLu4KdKi/6qiHyvSGamf/hbrx9dE+YU
         5GwXZst04EPXldHA+wfys3RL4KP05Qk90YsCgx0B3+WvnLsxt4dpAkupFdU2shuOox
         FEG7WnYPzzvlsp0KfDX0UXjLipWKuLTM76ZS2IJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.20 336/352] scsi: sd_zbc: Fix zone information messages
Date:   Mon, 11 Feb 2019 15:19:23 +0100
Message-Id: <20190211141908.485761888@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 88fc41c407158a7d2eaa4b2f7cfa289749d456c6 upstream.

Commit bf5054569653 ("block: Introduce blk_revalidate_disk_zones()")
inadvertently broke the message output of sd_zbc_print_zones() because the
zone information initialization of the scsi disk structure was moved to the
second scan run while sd_zbc_print_zones() is called on the first
scan. This leads to the following incorrect message to be printed for any
ZBC or ZAC zoned disks.

"...[sdX] 4294967295 zones of 0 logical blocks + 1 runt zone"

Fix this by initializing sdkp zone size and number of zones early on the
first scan. This does not impact the execution of
blk_revalidate_zones(). This functions is still called only once the block
device capacity is set on the second revalidate run on boot, or if the disk
zone configuration changed (i.e. the disk changed).

Fixes: bf5054569653 ("block: Introduce blk_revalidate_disk_zones()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -462,12 +462,16 @@ int sd_zbc_read_zones(struct scsi_disk *
 	sdkp->device->use_10_for_rw = 0;
 
 	/*
-	 * If something changed, revalidate the disk zone bitmaps once we have
-	 * the capacity, that is on the second revalidate execution during disk
-	 * scan and always during normal revalidate.
+	 * Revalidate the disk zone bitmaps once the block device capacity is
+	 * set on the second revalidate execution during disk scan and if
+	 * something changed when executing a normal revalidate.
 	 */
-	if (sdkp->first_scan)
+	if (sdkp->first_scan) {
+		sdkp->zone_blocks = zone_blocks;
+		sdkp->nr_zones = nr_zones;
 		return 0;
+	}
+
 	if (sdkp->zone_blocks != zone_blocks ||
 	    sdkp->nr_zones != nr_zones ||
 	    disk->queue->nr_zones != nr_zones) {


