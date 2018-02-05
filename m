Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeBEUGr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:06:47 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.129]:11791 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbeBEUGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:06:40 -0500
Date: Mon, 5 Feb 2018 14:06:37 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2 1/8] rtl2832: use 64-bit arithmetic instead of 32-bit in
 rtl2832_set_frontend
Message-ID: <381d67326e15bfbb588947d13def3f6a1571db85.1517856716.git.gustavo@embeddedor.com>
References: <cover.1517856716.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517856716.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1ein2E-003HFO-Ub
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:46564
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 7 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression dev->pdata->clk * 7 is currently being evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1271223
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update subject and changelog to better reflect the proposed code changes.
 - Add suffix ULL to constant instead of casting a variable.

 drivers/media/dvb-frontends/rtl2832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 94bf5b7..fa3b816 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -498,7 +498,7 @@ static int rtl2832_set_frontend(struct dvb_frontend *fe)
 	* RSAMP_RATIO = floor(CrystalFreqHz * 7 * pow(2, 22)
 	*	/ ConstWithBandwidthMode)
 	*/
-	num = dev->pdata->clk * 7;
+	num = dev->pdata->clk * 7ULL;
 	num *= 0x400000;
 	num = div_u64(num, bw_mode);
 	resamp_ratio =  num & 0x3ffffff;
@@ -511,7 +511,7 @@ static int rtl2832_set_frontend(struct dvb_frontend *fe)
 	*	/ (CrystalFreqHz * 7))
 	*/
 	num = bw_mode << 20;
-	num2 = dev->pdata->clk * 7;
+	num2 = dev->pdata->clk * 7ULL;
 	num = div_u64(num, num2);
 	num = -num;
 	cfreq_off_ratio = num & 0xfffff;
-- 
2.7.4
