Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2177DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1D208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D1D208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeHWM3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:29:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbeHWM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:29:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 81D4CCB5;
        Thu, 23 Aug 2018 09:00:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Teel <scott.teel@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 234/324] scsi: hpsa: correct enclosure sas address
Date:   Thu, 23 Aug 2018 09:55:00 +0200
Message-Id: <20180823075007.828571858@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Don Brace <don.brace@microsemi.com>

[ Upstream commit 01d0e789a14aa735ddcfddd468ef06d4f917e06d ]

The original complaint was the lsscsi -t showed the same SAS address of the
two enclosures (SEP devices). In fact the SAS address was being set to the
Enclosure Logical Identifier (ELI).

Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/hpsa.c |   25 +++++++++++++++++++++----
 drivers/scsi/hpsa.h |    1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -3438,11 +3438,11 @@ static void hpsa_get_enclosure_info(stru
 	struct ext_report_lun_entry *rle = &rlep->LUN[rle_index];
 	u16 bmic_device_index = 0;
 
-	bmic_device_index = GET_BMIC_DRIVE_NUMBER(&rle->lunid[0]);
-
-	encl_dev->sas_address =
+	encl_dev->eli =
 		hpsa_get_enclosure_logical_identifier(h, scsi3addr);
 
+	bmic_device_index = GET_BMIC_DRIVE_NUMBER(&rle->lunid[0]);
+
 	if (encl_dev->target == -1 || encl_dev->lun == -1) {
 		rc = IO_OK;
 		goto out;
@@ -9695,7 +9695,24 @@ hpsa_sas_get_linkerrors(struct sas_phy *
 static int
 hpsa_sas_get_enclosure_identifier(struct sas_rphy *rphy, u64 *identifier)
 {
-	*identifier = rphy->identify.sas_address;
+	struct Scsi_Host *shost = phy_to_shost(rphy);
+	struct ctlr_info *h;
+	struct hpsa_scsi_dev_t *sd;
+
+	if (!shost)
+		return -ENXIO;
+
+	h = shost_to_hba(shost);
+
+	if (!h)
+		return -ENXIO;
+
+	sd = hpsa_find_device_by_sas_rphy(h, rphy);
+	if (!sd)
+		return -ENXIO;
+
+	*identifier = sd->eli;
+
 	return 0;
 }
 
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -68,6 +68,7 @@ struct hpsa_scsi_dev_t {
 #define RAID_CTLR_LUNID "\0\0\0\0\0\0\0\0"
 	unsigned char device_id[16];    /* from inquiry pg. 0x83 */
 	u64 sas_address;
+	u64 eli;			/* from report diags. */
 	unsigned char vendor[8];        /* bytes 8-15 of inquiry data */
 	unsigned char model[16];        /* bytes 16-31 of inquiry data */
 	unsigned char rev;		/* byte 2 of inquiry data */


