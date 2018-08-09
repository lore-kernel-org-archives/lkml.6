Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCDC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D954521EA0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D954521EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeHISFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:05:46 -0400
Received: from gateway36.websitewelcome.com ([192.185.185.36]:40457 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732330AbeHISFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:05:46 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 6A59A400C5AC4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 09:43:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nn2QfUvMNPvAdnn2jfVwmP; Thu, 09 Aug 2018 10:40:17 -0500
X-Authority-Reason: nr=8
Received: from [189.250.54.46] (port=50842 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnn2Q-0026FC-2t; Thu, 09 Aug 2018 10:39:46 -0500
Date:   Thu, 9 Aug 2018 10:39:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] wimax: usb-fw: mark expected switch fall-through
Message-ID: <20180809153944.GA16703@embeddedor.com>
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
X-Exim-ID: 1fnn2Q-0026FC-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.54.46]:50842
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I placed the "fall through"
annotation at the bottom of the case, which is what GCC is expecting
to find.

Addresses-Coverity-ID: 1369529 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wimax/i2400m/usb-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/usb-fw.c b/drivers/net/wimax/i2400m/usb-fw.c
index 502c346..529ebca 100644
--- a/drivers/net/wimax/i2400m/usb-fw.c
+++ b/drivers/net/wimax/i2400m/usb-fw.c
@@ -130,12 +130,12 @@ ssize_t i2400mu_tx_bulk_out(struct i2400mu *i2400mu, void *buf, size_t buf_size)
 			dev_err(dev, "BM-CMD: too many stalls in "
 				"URB; resetting device\n");
 			usb_queue_reset_device(i2400mu->usb_iface);
-			/* fallthrough */
 		} else {
 			usb_clear_halt(i2400mu->usb_dev, pipe);
 			msleep(10);	/* give the device some time */
 			goto retry;
 		}
+		/* fall through */
 	case -EINVAL:			/* while removing driver */
 	case -ENODEV:			/* dev disconnect ... */
 	case -ENOENT:			/* just ignore it */
-- 
2.7.4

