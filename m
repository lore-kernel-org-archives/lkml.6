Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25F4C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47932083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47932083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeJBUOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34148 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731024AbeJBUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:52 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE095BF0;
        Tue,  2 Oct 2018 13:31:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 203/228] ice: Fix potential return of uninitialized value
Date:   Tue,  2 Oct 2018 06:25:00 -0700
Message-Id: <20181002132511.559476229@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit dab0588fb616c1774bbf108eab1749dda4ac6942 ]

In ice_vsi_setup_[tx|rx]_rings, err is uninitialized which can result in
a garbage value return to the caller. Fix that.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4888,7 +4888,7 @@ int ice_down(struct ice_vsi *vsi)
  */
 static int ice_vsi_setup_tx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!vsi->num_txq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Tx queues\n",
@@ -4913,7 +4913,7 @@ static int ice_vsi_setup_tx_rings(struct
  */
 static int ice_vsi_setup_rx_rings(struct ice_vsi *vsi)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!vsi->num_rxq) {
 		dev_err(&vsi->back->pdev->dev, "VSI %d has 0 Rx queues\n",


