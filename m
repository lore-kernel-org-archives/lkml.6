Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D2C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A424D21E1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A424D21E1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbeHIRea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:34:30 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:34332 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732368AbeHIRea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:34:30 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 22346663A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 10:09:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nmY7fTEGAPvAdnmYWfUFrt; Thu, 09 Aug 2018 10:09:09 -0500
X-Authority-Reason: nr=8
Received: from [189.250.54.46] (port=49984 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnmY6-001q4T-Ei; Thu, 09 Aug 2018 10:08:26 -0500
Date:   Thu, 9 Aug 2018 10:08:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: dp83640: Mark expected switch fall-throughs
Message-ID: <20180809150824.GA15116@embeddedor.com>
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
X-Source-IP: 189.250.54.46
X-Source-L: No
X-Exim-ID: 1fnmY6-001q4T-Ei
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.54.46]:49984
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

Notice that in this particular case, I replaced the code comment at the
top of the switch statement with a proper "fall through" annotation for
each case, which is what GCC is expecting to find.

Addresses-Coverity-ID: 1056542 ("Missing break in switch")
Addresses-Coverity-ID: 1339579 ("Missing break in switch")
Addresses-Coverity-ID: 1369526 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/phy/dp83640.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 79e9b10..29aa8d7 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -757,13 +757,16 @@ static int decode_evnt(struct dp83640_private *dp83640,
 
 	phy_txts = data;
 
-	switch (words) { /* fall through in every case */
+	switch (words) {
 	case 3:
 		dp83640->edata.sec_hi = phy_txts->sec_hi;
+		/* fall through */
 	case 2:
 		dp83640->edata.sec_lo = phy_txts->sec_lo;
+		/* fall through */
 	case 1:
 		dp83640->edata.ns_hi = phy_txts->ns_hi;
+		/* fall through */
 	case 0:
 		dp83640->edata.ns_lo = phy_txts->ns_lo;
 	}
-- 
2.7.4

