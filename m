Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeAaEVx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 23:21:53 -0500
Received: from gateway23.websitewelcome.com ([192.185.47.80]:33793 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752009AbeAaEVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 23:21:51 -0500
Date: Tue, 30 Jan 2018 22:21:48 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] tcp_nv: fix potential integer overflow in tcpnv_acked
Message-ID: <20180131042147.GA13245@embeddedgus>
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
X-Exim-ID: 1egju9-001pQP-IJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:55160
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 80000 in order to avoid a potential integer
overflow and give the compiler complete information about the proper
arithmetic to use. Notice that this constant is used in a context that
expects an expression of type u64.

The current cast to u64 effectively applies to the whole expression
as an argument of type u64 to be passed to div64_u64, but it does
not prevent it from being evaluated using 32-bit arithmetic instead
of 64-bit arithmetic.

Also, once the expression is properly evaluated using 64-bit arithmentic,
there is no need for the parentheses and the external cast to u64.

Addresses-Coverity-ID: 1357588 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/ipv4/tcp_nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_nv.c b/net/ipv4/tcp_nv.c
index ddbce73..764298e 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -364,7 +364,7 @@ static void tcpnv_acked(struct sock *sk, const struct ack_sample *sample)
 		 */
 		cwnd_by_slope = (u32)
 			div64_u64(((u64)ca->nv_rtt_max_rate) * ca->nv_min_rtt,
-				  (u64)(80000 * tp->mss_cache));
+				  80000ULL * tp->mss_cache);
 		max_win = cwnd_by_slope + nv_pad;
 
 		/* If cwnd > max_win, decrease cwnd
-- 
2.7.4
