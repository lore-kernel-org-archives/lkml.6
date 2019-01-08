Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DBDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D5820827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977949;
	bh=MiGngHx/F+dixiuqPDdJHWZyQWb3SCGUvEU5gJhrBXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymnoZlBQGebYDuhp+wvjW+SYDxyt1f4TBiikKpFd680XH3QD/YyCK9lJ6uGroERCY
	 JRACB85iJarQfWk5u2u8Z/NEuzAitA7E9tBXh+eB4I8U5pHyfkFhCDSPSX6zRacK9E
	 yS9jpnFRKE1mq1DRpV3rbsMQ9Mv8XfpFNu1NjkMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfAHUFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729938AbfAHT2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C228C20883;
        Tue,  8 Jan 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975692;
        bh=MiGngHx/F+dixiuqPDdJHWZyQWb3SCGUvEU5gJhrBXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdGNjAhnwcAvsGm46oBWEKF/6shILF/aCzHBiIkpo8wd6PJ2LyzDlmB/M0zUHCc11
         kgPyL1EjpdQ0VCeaodCcUUxVRDIumYTZ7vMkfiy37r15dnf6yKdiyjVNv13FuOQGV1
         bYFXESqNU06d8BP8Pc6+fV5huNwoTCMfEN4NDKzg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 058/117] scsi: target: use consistent left-aligned ASCII INQUIRY data
Date:   Tue,  8 Jan 2019 14:25:26 -0500
Message-Id: <20190108192628.121270-58-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Disseldorp <ddiss@suse.de>

[ Upstream commit 0de263577de5d5e052be5f4f93334e63cc8a7f0b ]

spc5r17.pdf specifies:

  4.3.1 ASCII data field requirements
  ASCII data fields shall contain only ASCII printable characters (i.e.,
  code values 20h to 7Eh) and may be terminated with one or more ASCII null
  (00h) characters.  ASCII data fields described as being left-aligned
  shall have any unused bytes at the end of the field (i.e., highest
  offset) and the unused bytes shall be filled with ASCII space characters
  (20h).

LIO currently space-pads the T10 VENDOR IDENTIFICATION and PRODUCT
IDENTIFICATION fields in the standard INQUIRY data. However, the PRODUCT
REVISION LEVEL field in the standard INQUIRY data as well as the T10 VENDOR
IDENTIFICATION field in the INQUIRY Device Identification VPD Page are
zero-terminated/zero-padded.

Fix this inconsistency by using space-padding for all of the above fields.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bryant G. Ly <bly@catalogicsoftware.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_spc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index f459118bc11b..c37dd36ec77d 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -108,12 +108,17 @@ spc_emulate_inquiry_std(struct se_cmd *cmd, unsigned char *buf)
 
 	buf[7] = 0x2; /* CmdQue=1 */
 
-	memcpy(&buf[8], "LIO-ORG ", 8);
-	memset(&buf[16], 0x20, 16);
+	/*
+	 * ASCII data fields described as being left-aligned shall have any
+	 * unused bytes at the end of the field (i.e., highest offset) and the
+	 * unused bytes shall be filled with ASCII space characters (20h).
+	 */
+	memset(&buf[8], 0x20, 8 + 16 + 4);
+	memcpy(&buf[8], "LIO-ORG", sizeof("LIO-ORG") - 1);
 	memcpy(&buf[16], dev->t10_wwn.model,
-	       min_t(size_t, strlen(dev->t10_wwn.model), 16));
+	       strnlen(dev->t10_wwn.model, 16));
 	memcpy(&buf[32], dev->t10_wwn.revision,
-	       min_t(size_t, strlen(dev->t10_wwn.revision), 4));
+	       strnlen(dev->t10_wwn.revision, 4));
 	buf[4] = 31; /* Set additional length to 31 */
 
 	return 0;
@@ -251,7 +256,9 @@ spc_emulate_evpd_83(struct se_cmd *cmd, unsigned char *buf)
 	buf[off] = 0x2; /* ASCII */
 	buf[off+1] = 0x1; /* T10 Vendor ID */
 	buf[off+2] = 0x0;
-	memcpy(&buf[off+4], "LIO-ORG", 8);
+	/* left align Vendor ID and pad with spaces */
+	memset(&buf[off+4], 0x20, 8);
+	memcpy(&buf[off+4], "LIO-ORG", sizeof("LIO-ORG") - 1);
 	/* Extra Byte for NULL Terminator */
 	id_len++;
 	/* Identifier Length */
-- 
2.19.1

