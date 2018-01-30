Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeA3A4k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:56:40 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.109]:41665 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751683AbeA3A4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:56:02 -0500
Date: Mon, 29 Jan 2018 18:31:20 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 2/8] dvb-frontends: ves1820: fix potential integer overflow
Message-ID: <2bc8d41c5ef755fbbe3f3e06c427928b97ed4731.1517268667.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1egJpZ-001dlT-5j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.145.57.174]:35450
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast state->config->xin to u64 in order to avoid a potential integer
overflow. This variable is being used in a context that expects an
expression of type u64.

Addresses-Coverity-ID: 200604 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/dvb-frontends/ves1820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/ves1820.c b/drivers/media/dvb-frontends/ves1820.c
index 1d89792..9dbd582 100644
--- a/drivers/media/dvb-frontends/ves1820.c
+++ b/drivers/media/dvb-frontends/ves1820.c
@@ -137,7 +137,7 @@ static int ves1820_set_symbolrate(struct ves1820_state *state, u32 symbolrate)
 		NDEC = 3;
 
 	/* yeuch! */
-	fpxin = state->config->xin * 10;
+	fpxin = (u64)state->config->xin * 10;
 	fptmp = fpxin; do_div(fptmp, 123);
 	if (symbolrate < fptmp)
 		SFIL = 1;
-- 
2.7.4
