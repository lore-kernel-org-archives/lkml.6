Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D6C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D073B24E64
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D073B24E64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeGAQLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:11:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeGAQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8D6EDAD8;
        Sun,  1 Jul 2018 16:11:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 11/85] scsi: isci: Fix infinite loop in while loop
Date:   Sun,  1 Jul 2018 18:01:29 +0200
Message-Id: <20180701153122.808899386@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 4bc83b3f272fe8f36450f9c003df49cf07ffe5fd ]

In the case when the phy_mask is bitwise anded with the phy_index bit is
zero the continue statement currently jumps to the next iteration of the
while loop and phy_index is never actually incremented, potentially
causing an infinite loop if phy_index is less than SCI_MAX_PHS. Fix this
by turning the while loop into a for loop.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/isci/port_config.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/scsi/isci/port_config.c
+++ b/drivers/scsi/isci/port_config.c
@@ -291,7 +291,7 @@ sci_mpc_agent_validate_phy_configuration
 		 * Note: We have not moved the current phy_index so we will actually
 		 *       compare the startting phy with itself.
 		 *       This is expected and required to add the phy to the port. */
-		while (phy_index < SCI_MAX_PHYS) {
+		for (; phy_index < SCI_MAX_PHYS; phy_index++) {
 			if ((phy_mask & (1 << phy_index)) == 0)
 				continue;
 			sci_phy_get_sas_address(&ihost->phys[phy_index],
@@ -311,7 +311,6 @@ sci_mpc_agent_validate_phy_configuration
 					      &ihost->phys[phy_index]);
 
 			assigned_phy_mask |= (1 << phy_index);
-			phy_index++;
 		}
 
 	}


