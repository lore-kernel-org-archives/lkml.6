Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D2C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623A021480
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623A021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbeJBUOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbeJBUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:08 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6CEFABF0;
        Tue,  2 Oct 2018 13:30:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 199/228] ice: Use order_base_2 to calculate higher power of 2
Date:   Tue,  2 Oct 2018 06:24:56 -0700
Message-Id: <20181002132511.373049505@linuxfoundation.org>
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

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 1eb43fc754485d772b1165118a8fb80c385f0492 ]

Currently, we use a combination of ilog2 and is_power_of_2() to
calculate the next power of 2 for the qcount. This appears to be causing
a warning on some combinations of GCC and the Linux kernel:

MODPOST 1 modules
WARNING: "____ilog2_NaN" [ice.ko] undefined!

This appears to because because GCC realizes that qcount could be zero
in some circumstances and thus attempts to link against the
intentionally undefined ___ilog2_NaN function.

The order_base_2 function is intentionally defined to return 0 when
passed 0 as an argument, and thus will be safe to use here.

This not only fixes the warning but makes the resulting code slightly
cleaner, and is really what we should have used originally.

Also update the comment to make it more clear that we are rounding up,
not just incrementing the ilog2 of qcount unconditionally.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1313,11 +1313,8 @@ static void ice_vsi_setup_q_map(struct i
 		qcount = numq_tc;
 	}
 
-	/* find higher power-of-2 of qcount */
-	pow = ilog2(qcount);
-
-	if (!is_power_of_2(qcount))
-		pow++;
+	/* find the (rounded up) power-of-2 of qcount */
+	pow = order_base_2(qcount);
 
 	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
 		if (!(vsi->tc_cfg.ena_tc & BIT(i))) {


