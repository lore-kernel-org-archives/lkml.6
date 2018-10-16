Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C94C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7192098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJrenpQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7192098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbeJQBJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543982098A;
        Tue, 16 Oct 2018 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710259;
        bh=ljTvFsOxhX7q0A2qdTWyc2VStDYuGSv24EciN4aILPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJrenpQT5uskumf188Pn5RnfIH2eusRoJYd9XExtECiBtc5lJWRwBJzUnAM9Gxu+l
         gnx2fWyvND+gUPh+1Rt5fBWmX7VGWPg40gzaOTdpxk/SqsQtvGzjHJ1VXHXDHsRJa0
         2pSwXF073lcWdXyY7l8QONFzFTPzG/jAu5T0qf7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 002/109] bnxt_en: free hwrm resources, if driver probe fails.
Date:   Tue, 16 Oct 2018 19:04:30 +0200
Message-Id: <20181016170524.681060910@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>

[ Upstream commit a2bf74f4e1b82395dad2b08d2a911d9151db71c1 ]

When the driver probe fails, all the resources that were allocated prior
to the failure must be freed. However, hwrm dma response memory is not
getting freed.

This patch fixes the problem described above.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2964,10 +2964,11 @@ static void bnxt_free_hwrm_resources(str
 {
 	struct pci_dev *pdev = bp->pdev;
 
-	dma_free_coherent(&pdev->dev, PAGE_SIZE, bp->hwrm_cmd_resp_addr,
-			  bp->hwrm_cmd_resp_dma_addr);
-
-	bp->hwrm_cmd_resp_addr = NULL;
+	if (bp->hwrm_cmd_resp_addr) {
+		dma_free_coherent(&pdev->dev, PAGE_SIZE, bp->hwrm_cmd_resp_addr,
+				  bp->hwrm_cmd_resp_dma_addr);
+		bp->hwrm_cmd_resp_addr = NULL;
+	}
 	if (bp->hwrm_dbg_resp_addr) {
 		dma_free_coherent(&pdev->dev, HWRM_DBG_REG_BUF_SIZE,
 				  bp->hwrm_dbg_resp_addr,
@@ -8217,6 +8218,7 @@ init_err_cleanup_tc:
 	bnxt_clear_int_mode(bp);
 
 init_err_pci_clean:
+	bnxt_free_hwrm_resources(bp);
 	bnxt_cleanup_pci(bp);
 
 init_err_free:


