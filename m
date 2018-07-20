Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322FCECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC67E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC67E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbeGTNWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbeGTNWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:44 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBC3CBC8;
        Fri, 20 Jul 2018 12:32:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/92] net: macb: Fix ptp time adjustment for large negative delta
Date:   Fri, 20 Jul 2018 14:13:28 +0200
Message-Id: <20180720121418.930391941@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
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

From: Harini Katakam <harini.katakam@xilinx.com>

[ Upstream commit 64d7839af8c8f67daaf9bf387135052c55d85f90 ]

When delta passed to gem_ptp_adjtime is negative, the sign is
maintained in the ns_to_timespec64 conversion. Hence timespec_add
should be used directly. timespec_sub will just subtract the negative
value thus increasing the time difference.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_ptp.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -170,10 +170,7 @@ static int gem_ptp_adjtime(struct ptp_cl
 
 	if (delta > TSU_NSEC_MAX_VAL) {
 		gem_tsu_get_time(&bp->ptp_clock_info, &now);
-		if (sign)
-			now = timespec64_sub(now, then);
-		else
-			now = timespec64_add(now, then);
+		now = timespec64_add(now, then);
 
 		gem_tsu_set_time(&bp->ptp_clock_info,
 				 (const struct timespec64 *)&now);


