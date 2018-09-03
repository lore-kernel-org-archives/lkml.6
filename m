Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43544C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0429A20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0429A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeICVLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeICVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A267DCF5;
        Mon,  3 Sep 2018 16:50:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 20/56] bnx2x: Fix invalid memory access in rss hash config path.
Date:   Mon,  3 Sep 2018 18:49:10 +0200
Message-Id: <20180903164925.093417900@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
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

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit ae2dcb28c24794a87e424a726a1cf1a61980f52d ]

Rx hash/filter table configuration uses rss_conf_obj to configure filters
in the hardware. This object is initialized only when the interface is
brought up.
This patch adds driver changes to configure rss params only when the device
is in opened state. In port disabled case, the config will be cached in the
driver structure which will be applied in the successive load path.

Please consider applying it to 'net' branch.

Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -3296,14 +3296,18 @@ static int bnx2x_set_rss_flags(struct bn
 			DP(BNX2X_MSG_ETHTOOL,
 			   "rss re-configured, UDP 4-tupple %s\n",
 			   udp_rss_requested ? "enabled" : "disabled");
-			return bnx2x_rss(bp, &bp->rss_conf_obj, false, true);
+			if (bp->state == BNX2X_STATE_OPEN)
+				return bnx2x_rss(bp, &bp->rss_conf_obj, false,
+						 true);
 		} else if ((info->flow_type == UDP_V6_FLOW) &&
 			   (bp->rss_conf_obj.udp_rss_v6 != udp_rss_requested)) {
 			bp->rss_conf_obj.udp_rss_v6 = udp_rss_requested;
 			DP(BNX2X_MSG_ETHTOOL,
 			   "rss re-configured, UDP 4-tupple %s\n",
 			   udp_rss_requested ? "enabled" : "disabled");
-			return bnx2x_rss(bp, &bp->rss_conf_obj, false, true);
+			if (bp->state == BNX2X_STATE_OPEN)
+				return bnx2x_rss(bp, &bp->rss_conf_obj, false,
+						 true);
 		}
 		return 0;
 
@@ -3401,7 +3405,10 @@ static int bnx2x_set_rxfh(struct net_dev
 		bp->rss_conf_obj.ind_table[i] = indir[i] + bp->fp->cl_id;
 	}
 
-	return bnx2x_config_rss_eth(bp, false);
+	if (bp->state == BNX2X_STATE_OPEN)
+		return bnx2x_config_rss_eth(bp, false);
+
+	return 0;
 }
 
 /**


