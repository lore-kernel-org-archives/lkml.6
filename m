Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF4C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA86220834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRXij10U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA86220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeJYWpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbeJYWon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:43 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586EF2083E;
        Thu, 25 Oct 2018 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476708;
        bh=3eeziPS8YGoEMsVZtZ4UZIFWtx4imf9YIg+S2rOY9OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRXij10UHxM63g4ckRP/bTKnUOSNVskIaIRr9q+jgLzEJHx27j8IMFKpcfySknJLJ
         xVnX+SFfSdvdlM4pey5Hv6hqhCaGoaVA3nhaJTuDQWNoLsF8UnHesjOfhzMT+PIwlH
         ix1bGqlI+Oik++1L0Ku+/WfivhWPMKpYvXZYGogM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Brian King <brking@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 38/46] scsi: ibmvfc: Avoid unnecessary port relogin
Date:   Thu, 25 Oct 2018 10:10:45 -0400
Message-Id: <20181025141053.213330-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian King <brking@linux.vnet.ibm.com>

[ Upstream commit 09dd15e0d9547ca424de4043bcd429bab6f285c8 ]

Following an RSCN, ibmvfc will issue an ADISC to determine if the
underlying target has changed, comparing the SCSI ID, WWPN, and WWNN to
determine how to handle the rport in discovery. However, the comparison
of the WWPN and WWNN was performing a memcmp between a big endian field
against a CPU endian field, which resulted in the wrong answer on LE
systems. This was observed as unexpected errors getting logged at boot
time as targets were getting relogins when not needed.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index b491af31a5f8..a06b24a61622 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3580,11 +3580,9 @@ static void ibmvfc_tgt_implicit_logout(struct ibmvfc_target *tgt)
 static int ibmvfc_adisc_needs_plogi(struct ibmvfc_passthru_mad *mad,
 				    struct ibmvfc_target *tgt)
 {
-	if (memcmp(&mad->fc_iu.response[2], &tgt->ids.port_name,
-		   sizeof(tgt->ids.port_name)))
+	if (wwn_to_u64((u8 *)&mad->fc_iu.response[2]) != tgt->ids.port_name)
 		return 1;
-	if (memcmp(&mad->fc_iu.response[4], &tgt->ids.node_name,
-		   sizeof(tgt->ids.node_name)))
+	if (wwn_to_u64((u8 *)&mad->fc_iu.response[4]) != tgt->ids.node_name)
 		return 1;
 	if (be32_to_cpu(mad->fc_iu.response[6]) != tgt->scsi_id)
 		return 1;
-- 
2.17.1

