Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AE9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B092075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B092075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeGRBwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:52:51 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.87]:34943 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731296AbeGRBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:52:51 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 9CAB153B4C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:17:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fb5yfOzfQPvAdfb5yfU9qB; Tue, 17 Jul 2018 20:17:34 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=36798 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffb5y-0036SM-5A; Tue, 17 Jul 2018 20:17:34 -0500
Date:   Tue, 17 Jul 2018 20:17:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stefan =?iso-8859-1?Q?S=F8rensen?= 
        <stefan.sorensen@spectralink.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ptp: fix missing break in switch
Message-ID: <20180718011733.GA27872@embeddedor.com>
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
X-Exim-ID: 1ffb5y-0036SM-5A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:36798
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that a *break* is missing in order to avoid falling through
to the default case. Otherwise, checking *chan* makes no sense.

Fixes: 72df7a7244c0 ("ptp: Allow reassigning calibration pin function")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ptp/ptp_chardev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 547dbda..01b0e2b 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -89,6 +89,7 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	case PTP_PF_PHYSYNC:
 		if (chan != 0)
 			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.7.4

