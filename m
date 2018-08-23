Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD27AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811262147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811262147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbeHWMB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:01:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbeHWMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:01:55 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F387C9A;
        Thu, 23 Aug 2018 08:33:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 162/217] bnxt_en: Fix inconsistent BNXT_FLAG_AGG_RINGS logic.
Date:   Thu, 23 Aug 2018 09:54:35 +0200
Message-Id: <20180823075512.865475116@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 07f4fde53d12eb8d921b465bb298e964e0bdc38c ]

If there aren't enough RX rings available, the driver will attempt to
use a single RX ring without the aggregation ring.  If that also
fails, the BNXT_FLAG_AGG_RINGS flag is cleared but the other ring
parameters are not set consistently to reflect that.  If more RX
rings become available at the next open, the RX rings will be in
an inconsistent state and may crash when freeing the RX rings.

Fix it by restoring the BNXT_FLAG_AGG_RINGS if not enough RX rings are
available to run without aggregation rings.

Fixes: bdbd1eb59c56 ("bnxt_en: Handle no aggregation ring gracefully.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7884,8 +7884,11 @@ static int bnxt_get_dflt_rings(struct bn
 		/* Not enough rings, try disabling agg rings. */
 		bp->flags &= ~BNXT_FLAG_AGG_RINGS;
 		rc = bnxt_get_max_rings(bp, max_rx, max_tx, shared);
-		if (rc)
+		if (rc) {
+			/* set BNXT_FLAG_AGG_RINGS back for consistency */
+			bp->flags |= BNXT_FLAG_AGG_RINGS;
 			return rc;
+		}
 		bp->flags |= BNXT_FLAG_NO_AGG_RINGS;
 		bp->dev->hw_features &= ~NETIF_F_LRO;
 		bp->dev->features &= ~NETIF_F_LRO;


