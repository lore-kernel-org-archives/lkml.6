Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeBAAYM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 19:24:12 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.131]:16273 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753846AbeBAAYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 19:24:09 -0500
Date: Wed, 31 Jan 2018 18:24:07 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Wong Hoi Sing, Edison" <hswong3i@gmail.com>,
        "Hung Hing Lun, Mike" <hlhung3i@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180201002407.GA1608@embeddedgus>
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
X-Exim-ID: 1eh2fg-000wkz-4r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:43454
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast to s64 some variables and a macro in order to give the
compiler complete information about the proper arithmetic to
use. Notice that these elements are used in contexts that
expect expressions of type s64 (64 bits, signed).

Currently such expression are being evaluated using 32-bit
arithmetic.

Addresses-Coverity-ID: 200687
Addresses-Coverity-ID: 200688
Addresses-Coverity-ID: 200689
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/ipv4/tcp_lp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_lp.c b/net/ipv4/tcp_lp.c
index ae10ed6..4999111 100644
--- a/net/ipv4/tcp_lp.c
+++ b/net/ipv4/tcp_lp.c
@@ -134,7 +134,7 @@ static u32 tcp_lp_remote_hz_estimator(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct lp *lp = inet_csk_ca(sk);
-	s64 rhz = lp->remote_hz << 6;	/* remote HZ << 6 */
+	s64 rhz = (s64)lp->remote_hz << 6;	/* remote HZ << 6 */
 	s64 m = 0;
 
 	/* not yet record reference time
@@ -147,7 +147,7 @@ static u32 tcp_lp_remote_hz_estimator(struct sock *sk)
 	    tp->rx_opt.rcv_tsecr == lp->local_ref_time)
 		goto out;
 
-	m = TCP_TS_HZ *
+	m = (s64)TCP_TS_HZ *
 	    (tp->rx_opt.rcv_tsval - lp->remote_ref_time) /
 	    (tp->rx_opt.rcv_tsecr - lp->local_ref_time);
 	if (m < 0)
@@ -193,8 +193,8 @@ static u32 tcp_lp_owd_calculator(struct sock *sk)
 
 	if (lp->flag & LP_VALID_RHZ) {
 		owd =
-		    tp->rx_opt.rcv_tsval * (LP_RESOL / lp->remote_hz) -
-		    tp->rx_opt.rcv_tsecr * (LP_RESOL / TCP_TS_HZ);
+		    (s64)tp->rx_opt.rcv_tsval * (LP_RESOL / lp->remote_hz) -
+		    (s64)tp->rx_opt.rcv_tsecr * (LP_RESOL / TCP_TS_HZ);
 		if (owd < 0)
 			owd = -owd;
 	}
-- 
2.7.4
