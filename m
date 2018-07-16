Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA1F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeGPIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:08:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:08:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F5BBC03;
        Mon, 16 Jul 2018 07:42:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Butterfield <david.butterfield@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 08/32] ata: Fix ZBC_OUT all bit handling
Date:   Mon, 16 Jul 2018 09:36:16 +0200
Message-Id: <20180716073505.462986205@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 6edf1d4cb0acde3a0a5dac849f33031bd7abb7b1 upstream.

If the ALL bit is set in the ZBC_OUT command, the command zone ID field
(block) should be ignored.

Reported-by: David Butterfield <david.butterfield@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3772,7 +3772,14 @@ static unsigned int ata_scsi_zbc_out_xla
 		 */
 		goto invalid_param_len;
 	}
-	if (block >= dev->n_sectors) {
+
+	all = cdb[14] & 0x1;
+	if (all) {
+		/*
+		 * Ignore the block address (zone ID) as defined by ZBC.
+		 */
+		block = 0;
+	} else if (block >= dev->n_sectors) {
 		/*
 		 * Block must be a valid zone ID (a zone start LBA).
 		 */
@@ -3780,8 +3787,6 @@ static unsigned int ata_scsi_zbc_out_xla
 		goto invalid_fld;
 	}
 
-	all = cdb[14] & 0x1;
-
 	if (ata_ncq_enabled(qc->dev) &&
 	    ata_fpdma_zac_mgmt_out_supported(qc->dev)) {
 		tf->protocol = ATA_PROT_NCQ_NODATA;


