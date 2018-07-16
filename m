Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5132020864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5132020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbeGPIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5E71CA0;
        Mon, 16 Jul 2018 07:37:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Butterfield <david.butterfield@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.17 15/67] ata: Fix ZBC_OUT command block check
Date:   Mon, 16 Jul 2018 09:34:44 +0200
Message-Id: <20180716073445.457040404@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@wdc.com>

commit b320a0a9f23c98f21631eb27bcbbca91c79b1c6e upstream.

The block (LBA) specified must not exceed the last addressable LBA,
which is dev->nr_sectors - 1. So fix the correct check is
"if (block >= dev->n_sectors)" and not "if (block > dev->n_sectords)".

Additionally, the asc/ascq to return for an LBA that is not a zone start
LBA should be ILLEGAL REQUEST, regardless if the bad LBA is out of
range.

Reported-by: David Butterfield <david.butterfield@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-scsi.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3802,8 +3802,13 @@ static unsigned int ata_scsi_zbc_out_xla
 		 */
 		goto invalid_param_len;
 	}
-	if (block > dev->n_sectors)
-		goto out_of_range;
+	if (block >= dev->n_sectors) {
+		/*
+		 * Block must be a valid zone ID (a zone start LBA).
+		 */
+		fp = 2;
+		goto invalid_fld;
+	}
 
 	all = cdb[14] & 0x1;
 
@@ -3834,10 +3839,6 @@ static unsigned int ata_scsi_zbc_out_xla
  invalid_fld:
 	ata_scsi_set_invalid_field(qc->dev, scmd, fp, 0xff);
 	return 1;
- out_of_range:
-	/* "Logical Block Address out of range" */
-	ata_scsi_set_sense(qc->dev, scmd, ILLEGAL_REQUEST, 0x21, 0x00);
-	return 1;
 invalid_param_len:
 	/* "Parameter list length error" */
 	ata_scsi_set_sense(qc->dev, scmd, ILLEGAL_REQUEST, 0x1a, 0x0);


