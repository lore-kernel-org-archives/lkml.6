Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeAaEzq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:55:46 -0500
Received: from gateway23.websitewelcome.com ([192.185.47.80]:13161 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751399AbeAaEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:55:45 -0500
Date: Tue, 30 Jan 2018 22:55:33 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] openvswitch: meter: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180131045533.GA15485@embeddedgus>
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
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1egkQt-002Oi1-DE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:55566
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix LL to constant 1000 in order to give the compiler
complete information about the proper arithmetic to use. Notice
that this constant is used in a context that expects an expression
of type long long int (64 bits, signed).

The expression (band->burst_size + band->rate) * 1000 is currently
being evaluated using 32-bit arithmetic.

Addresses-Coverity-ID: 1461563 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/openvswitch/meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index 3fbfc78..04b9428 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -488,7 +488,7 @@ bool ovs_meter_execute(struct datapath *dp, struct sk_buff *skb,
 		long long int max_bucket_size;
 
 		band = &meter->bands[i];
-		max_bucket_size = (band->burst_size + band->rate) * 1000;
+		max_bucket_size = (band->burst_size + band->rate) * 1000LL;
 
 		band->bucket += delta_ms * band->rate;
 		if (band->bucket > max_bucket_size)
-- 
2.7.4
