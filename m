Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeAaF3y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 00:29:54 -0500
Received: from gateway32.websitewelcome.com ([192.185.144.98]:15087 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751163AbeAaF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 00:29:52 -0500
Date: Tue, 30 Jan 2018 23:29:48 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] libceph: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180131052948.GA16419@embeddedgus>
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
X-Exim-ID: 1egkxz-002zhY-J3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:56046
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast objsetno to u64 in order to give the compiler complete
information about the proper arithmetic to use. Notice
that this variable is used in a context that expects an
expression of type u64 (64 bits, unsigned).

The expression objsetno * sc + stripepos is currently
being evaluated using 32-bit arithmetic.

In general, the use of incorrect arithmetic has security
implications.

Addresses-Coverity-ID: 200686
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 0da27c6..58dc965 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2183,7 +2183,7 @@ int ceph_calc_file_object_mapping(struct ceph_file_layout *layout,
 	stripepos = bl % sc;
 	objsetno = stripeno / su_per_object;
 
-	*ono = objsetno * sc + stripepos;
+	*ono = (u64)objsetno * sc + stripepos;
 	dout("objset %u * sc %u = ono %u\n", objsetno, sc, (unsigned int)*ono);
 
 	/* *oxoff = *off % layout->fl_stripe_unit;  # offset in su */
-- 
2.7.4
