Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E1CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE12D24FA9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE12D24FA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeGBSLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:11:22 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:30785 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753203AbeGBSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:11:19 -0400
X-Greylist: delayed 1309 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 14:11:19 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 353B6400C6CD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 12:49:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id a2wifcb85kBj6a2wvf1HLw; Mon, 02 Jul 2018 12:49:28 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=36230 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fa2wi-002H6V-8x; Mon, 02 Jul 2018 12:49:04 -0500
Date:   Mon, 2 Jul 2018 12:49:02 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drbd: mark expected switch fall-throughs
Message-ID: <20180702174902.GA18713@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fa2wi-002H6V-8x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:36230
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used in this case: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/drbd/drbd_receiver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index be9450f..a36a307 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2790,6 +2790,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		   then we would do something smarter here than reading
 		   the block... */
 		peer_req->flags |= EE_RS_THIN_REQ;
+		/* fall through */
 	case P_RS_DATA_REQUEST:
 		peer_req->w.cb = w_e_end_rsdata_req;
 		fault_type = DRBD_FAULT_RS_RD;
@@ -2968,6 +2969,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		/* Else fall through to one of the other strategies... */
 		drbd_warn(device, "Discard younger/older primary did not find a decision\n"
 		     "Using discard-least-changes instead\n");
+		/* fall through */
 	case ASB_DISCARD_ZERO_CHG:
 		if (ch_peer == 0 && ch_self == 0) {
 			rv = test_bit(RESOLVE_CONFLICTS, &peer_device->connection->flags)
@@ -2979,6 +2981,7 @@ static int drbd_asb_recover_0p(struct drbd_peer_device *peer_device) __must_hold
 		}
 		if (after_sb_0p == ASB_DISCARD_ZERO_CHG)
 			break;
+		/* else: fall through */
 	case ASB_DISCARD_LEAST_CHG:
 		if	(ch_self < ch_peer)
 			rv = -1;
-- 
2.7.4

