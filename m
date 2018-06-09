Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tYD4Gr/1G1sDcQAAmS7hNA
	; Sat, 09 Jun 2018 15:44:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC93C608C8; Sat,  9 Jun 2018 15:44:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwBeGpxA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43CA1605A5;
	Sat,  9 Jun 2018 15:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43CA1605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932832AbeFIPe2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753750AbeFIPeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:22 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325FF204EC;
        Sat,  9 Jun 2018 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558461;
        bh=WIQUWKB7AYaa+RasWTeb2xxLdvwZKk/0gwlPIX+O1ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwBeGpxA7L2SXG77ObTJ9xbdDiq9HvDym6lujzZgz5CPDukDxc5mGkivU34x3BsF4
         kI4lwWQcjlz0y8NyApWL9D3XuadfD4hVondjwM08g35vDcIDKU6DemdlPt3jRqpt/4
         +JsuXS/WKAYnUEKRrUZOKhZXs5JUqa4vE2qTL9xE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "David.butterfield" <david.butterfield@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 01/41] scsi: sd_zbc: Fix potential memory leak
Date: Sat,  9 Jun 2018 17:29:33 +0200
Message-Id: <20180609152926.475797635@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 4b433924b2755a94f99258c178684a0e05c344de upstream.

Rework sd_zbc_check_zone_size() to avoid a memory leak due to an early
return if sd_zbc_report_zones() fails.

Reported-by: David.butterfield <david.butterfield@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -425,7 +425,7 @@ static int sd_zbc_check_capacity(struct
 
 static int sd_zbc_check_zone_size(struct scsi_disk *sdkp)
 {
-	u64 zone_blocks;
+	u64 zone_blocks = 0;
 	sector_t block = 0;
 	unsigned char *buf;
 	unsigned char *rec;
@@ -443,10 +443,8 @@ static int sd_zbc_check_zone_size(struct
 
 	/* Do a report zone to get the same field */
 	ret = sd_zbc_report_zones(sdkp, buf, SD_ZBC_BUF_SIZE, 0);
-	if (ret) {
-		zone_blocks = 0;
-		goto out;
-	}
+	if (ret)
+		goto out_free;
 
 	same = buf[4] & 0x0f;
 	if (same > 0) {
@@ -489,7 +487,7 @@ static int sd_zbc_check_zone_size(struct
 			ret = sd_zbc_report_zones(sdkp, buf,
 						  SD_ZBC_BUF_SIZE, block);
 			if (ret)
-				return ret;
+				goto out_free;
 		}
 
 	} while (block < sdkp->capacity);
@@ -497,34 +495,32 @@ static int sd_zbc_check_zone_size(struct
 	zone_blocks = sdkp->zone_blocks;
 
 out:
-	kfree(buf);
-
 	if (!zone_blocks) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Devices with non constant zone "
 				  "size are not supported\n");
-		return -ENODEV;
-	}
-
-	if (!is_power_of_2(zone_blocks)) {
+		ret = -ENODEV;
+	} else if (!is_power_of_2(zone_blocks)) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Devices with non power of 2 zone "
 				  "size are not supported\n");
-		return -ENODEV;
-	}
-
-	if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
+		ret = -ENODEV;
+	} else if (logical_to_sectors(sdkp->device, zone_blocks) > UINT_MAX) {
 		if (sdkp->first_scan)
 			sd_printk(KERN_NOTICE, sdkp,
 				  "Zone size too large\n");
-		return -ENODEV;
+		ret = -ENODEV;
+	} else {
+		sdkp->zone_blocks = zone_blocks;
+		sdkp->zone_shift = ilog2(zone_blocks);
 	}
 
-	sdkp->zone_blocks = zone_blocks;
+out_free:
+	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int sd_zbc_setup(struct scsi_disk *sdkp)
