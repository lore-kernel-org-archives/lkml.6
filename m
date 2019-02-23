Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31191C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31CC206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955948;
	bh=rfHti6InJnbcuV1NHm5vunODzng4ghQ5zo2VuzfLzaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rishRKaN9jxfkfWHolnwhERQjcD8oNHjye4xp6ovD5H+30ZBmZ50Aq7kDOu0Nbfpf
	 tBrCYoTQT5QroxhaDz1GufBc8nkXa820wgRnb46cDDBK+xRLpXbzdf9XOFfLrnFEBg
	 5D/VhQrUUBGJ4nowo0m9C4bOJxUKgERHeaCnyKRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfBWVFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfBWVFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B6720675;
        Sat, 23 Feb 2019 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955941;
        bh=rfHti6InJnbcuV1NHm5vunODzng4ghQ5zo2VuzfLzaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqEIGeNL6ca5+k3Gjf6xDlvMgXvUDrQWlpIHrzureESZjGTTvnbCRoPP9OXoVsQFS
         aesCRFFtCeKAZU4jBzAZKFr4EsPAz80h/gNZJNFhVDgR3Mxd5mAZcLNbn+l0MBpBOP
         s2RJGK4HhowX5PtxlOMaeFKU46qXLF13+sACAVAI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 49/72] scsi: scsi_debug: fix write_same with virtual_gb problem
Date:   Sat, 23 Feb 2019 16:03:59 -0500
Message-Id: <20190223210422.199966-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Gilbert <dgilbert@interlog.com>

[ Upstream commit 40d07b523cf434f252b134c86b1f8f2d907ffb0b ]

The WRITE SAME(10) and (16) implementations didn't take account of the
buffer wrap required when the virtual_gb parameter is greater than 0.

Fix that and rename the fake_store() function to lba2fake_store() to lessen
confusion with the global fake_storep pointer. Bump version date.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Reported-by: Bart Van Assche <bvanassche@acm.org>
Tested by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 41 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 60bcc6df97a91..65305b3848bc5 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -62,7 +62,7 @@
 
 /* make sure inq_product_rev string corresponds to this version */
 #define SDEBUG_VERSION "0188"	/* format to fit INQUIRY revision field */
-static const char *sdebug_version_date = "20180128";
+static const char *sdebug_version_date = "20190125";
 
 #define MY_NAME "scsi_debug"
 
@@ -735,7 +735,7 @@ static inline bool scsi_debug_lbp(void)
 		(sdebug_lbpu || sdebug_lbpws || sdebug_lbpws10);
 }
 
-static void *fake_store(unsigned long long lba)
+static void *lba2fake_store(unsigned long long lba)
 {
 	lba = do_div(lba, sdebug_store_sectors);
 
@@ -2514,8 +2514,8 @@ static int do_device_access(struct scsi_cmnd *scmd, u32 sg_skip, u64 lba,
 	return ret;
 }
 
-/* If fake_store(lba,num) compares equal to arr(num), then copy top half of
- * arr into fake_store(lba,num) and return true. If comparison fails then
+/* If lba2fake_store(lba,num) compares equal to arr(num), then copy top half of
+ * arr into lba2fake_store(lba,num) and return true. If comparison fails then
  * return false. */
 static bool comp_write_worker(u64 lba, u32 num, const u8 *arr)
 {
@@ -2643,7 +2643,7 @@ static int prot_verify_read(struct scsi_cmnd *SCpnt, sector_t start_sec,
 		if (sdt->app_tag == cpu_to_be16(0xffff))
 			continue;
 
-		ret = dif_verify(sdt, fake_store(sector), sector, ei_lba);
+		ret = dif_verify(sdt, lba2fake_store(sector), sector, ei_lba);
 		if (ret) {
 			dif_errors++;
 			return ret;
@@ -3261,10 +3261,12 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 			   u32 ei_lba, bool unmap, bool ndob)
 {
+	int ret;
 	unsigned long iflags;
 	unsigned long long i;
-	int ret;
-	u64 lba_off;
+	u32 lb_size = sdebug_sector_size;
+	u64 block, lbaa;
+	u8 *fs1p;
 
 	ret = check_device_access_params(scp, lba, num);
 	if (ret)
@@ -3276,31 +3278,30 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 		unmap_region(lba, num);
 		goto out;
 	}
-
-	lba_off = lba * sdebug_sector_size;
+	lbaa = lba;
+	block = do_div(lbaa, sdebug_store_sectors);
 	/* if ndob then zero 1 logical block, else fetch 1 logical block */
+	fs1p = fake_storep + (block * lb_size);
 	if (ndob) {
-		memset(fake_storep + lba_off, 0, sdebug_sector_size);
+		memset(fs1p, 0, lb_size);
 		ret = 0;
 	} else
-		ret = fetch_to_dev_buffer(scp, fake_storep + lba_off,
-					  sdebug_sector_size);
+		ret = fetch_to_dev_buffer(scp, fs1p, lb_size);
 
 	if (-1 == ret) {
 		write_unlock_irqrestore(&atomic_rw, iflags);
 		return DID_ERROR << 16;
-	} else if (sdebug_verbose && !ndob && (ret < sdebug_sector_size))
+	} else if (sdebug_verbose && !ndob && (ret < lb_size))
 		sdev_printk(KERN_INFO, scp->device,
 			    "%s: %s: lb size=%u, IO sent=%d bytes\n",
-			    my_name, "write same",
-			    sdebug_sector_size, ret);
+			    my_name, "write same", lb_size, ret);
 
 	/* Copy first sector to remaining blocks */
-	for (i = 1 ; i < num ; i++)
-		memcpy(fake_storep + ((lba + i) * sdebug_sector_size),
-		       fake_storep + lba_off,
-		       sdebug_sector_size);
-
+	for (i = 1 ; i < num ; i++) {
+		lbaa = lba + i;
+		block = do_div(lbaa, sdebug_store_sectors);
+		memmove(fake_storep + (block * lb_size), fs1p, lb_size);
+	}
 	if (scsi_debug_lbp())
 		map_region(lba, num);
 out:
-- 
2.19.1

