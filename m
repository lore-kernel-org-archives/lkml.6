Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6868BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255E921E5D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255E921E5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHISNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:13:19 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:48616 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730880AbeHISNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:13:19 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 9F43AC19F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 10:47:49 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id nn9lf2cogbXuJnnA2fRO6f; Thu, 09 Aug 2018 10:47:49 -0500
X-Authority-Reason: nr=8
Received: from [189.250.54.46] (port=51184 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fnn9k-002AAR-Vg; Thu, 09 Aug 2018 10:47:21 -0500
Date:   Thu, 9 Aug 2018 10:47:20 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] wimax: usb-tx: mark expected switch fall-through
Message-ID: <20180809154720.GA17920@embeddedor.com>
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
X-Exim-ID: 1fnn9k-002AAR-Vg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.54.46]:51184
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
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

Addresses-Coverity-ID: 115075 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wimax/i2400m/usb-tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/usb-tx.c b/drivers/net/wimax/i2400m/usb-tx.c
index 99ef81b..3a0e722 100644
--- a/drivers/net/wimax/i2400m/usb-tx.c
+++ b/drivers/net/wimax/i2400m/usb-tx.c
@@ -131,12 +131,12 @@ int i2400mu_tx(struct i2400mu *i2400mu, struct i2400m_msg_hdr *tx_msg,
 			dev_err(dev, "BM-CMD: too many stalls in "
 				"URB; resetting device\n");
 			usb_queue_reset_device(i2400mu->usb_iface);
-			/* fallthrough */
 		} else {
 			usb_clear_halt(i2400mu->usb_dev, usb_pipe);
 			msleep(10);	/* give the device some time */
 			goto retry;
 		}
+		/* fall through */
 	case -EINVAL:			/* while removing driver */
 	case -ENODEV:			/* dev disconnect ... */
 	case -ENOENT:			/* just ignore it */
-- 
2.7.4

