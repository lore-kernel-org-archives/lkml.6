Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeA3Av4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:51:56 -0500
Received: from gateway23.websitewelcome.com ([192.185.49.184]:37989 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751448AbeA3Avz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:51:55 -0500
Date: Mon, 29 Jan 2018 18:30:56 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 1/8] rtl2832: fix potential integer overflow in
 rtl2832_set_frontend
Message-ID: <1c57e607fbde1e598b2ca9380889e9fc1be6daa4.1517268667.git.gustavo@embeddedor.com>
References: <cover.1517268667.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517268667.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.57.174
X-Source-L: No
X-Exim-ID: 1egJpB-001dPz-Ki
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.145.57.174]:35448
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast dev->pdata->clk to u64 in order to avoid a potential integer
overflow. This variable is being used in a context that expects
an expression of type u64.

Addresses-Coverity-ID: 1271223 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/dvb-frontends/rtl2832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2832.c b/drivers/media/dvb-frontends/rtl2832.c
index 94bf5b7..eefc301 100644
--- a/drivers/media/dvb-frontends/rtl2832.c
+++ b/drivers/media/dvb-frontends/rtl2832.c
@@ -498,7 +498,7 @@ static int rtl2832_set_frontend(struct dvb_frontend *fe)
 	* RSAMP_RATIO = floor(CrystalFreqHz * 7 * pow(2, 22)
 	*	/ ConstWithBandwidthMode)
 	*/
-	num = dev->pdata->clk * 7;
+	num = (u64)dev->pdata->clk * 7;
 	num *= 0x400000;
 	num = div_u64(num, bw_mode);
 	resamp_ratio =  num & 0x3ffffff;
@@ -511,7 +511,7 @@ static int rtl2832_set_frontend(struct dvb_frontend *fe)
 	*	/ (CrystalFreqHz * 7))
 	*/
 	num = bw_mode << 20;
-	num2 = dev->pdata->clk * 7;
+	num2 = (u64)dev->pdata->clk * 7;
 	num = div_u64(num, num2);
 	num = -num;
 	cfreq_off_ratio = num & 0xfffff;
-- 
2.7.4
