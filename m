Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B9AC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8BF2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X59RxIP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8BF2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeKCEAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:45 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A632082D;
        Fri,  2 Nov 2018 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184749;
        bh=aeVUKLCgPrSoL1jWzEjmAxM0sBVH5BrooVThCgamick=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X59RxIP1jvUHTuJgsp7Zf1PasWw6lXUoPqDDmur163PLF860KWy+9DFPsLJMArcDP
         7lpQQy1RQUwCZbT8R0g52NQyEiyuT19/MItL772DLcnN4nscn/R/WgPBEbuHze4tWU
         O0CWyOuUljHgD6UEznDRbVKrVKzpQzeYfc8qKfIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 087/143] scsi: ibmvfc: Avoid unnecessary port relogin
Date:   Fri,  2 Nov 2018 19:34:32 +0100
Message-Id: <20181102182904.716236988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



