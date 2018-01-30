Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeA3A40 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:56:26 -0500
Received: from gateway30.websitewelcome.com ([192.185.194.16]:26015 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752437AbeA3A4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:56:24 -0500
Date: Mon, 29 Jan 2018 18:33:18 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 8/8] platform: vivid-cec: fix potential integer overflow in
 vivid_cec_pin_adap_events
Message-ID: <00eea53890802b679c138fc7f68a0f162261d95c.1517268668.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1egJrT-001fNG-En
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.145.57.174]:35468
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 41
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast len to const u64 in order to avoid a potential integer
overflow. This variable is being used in a context that expects
an expression of type const u64.

Addresses-Coverity-ID: 1454996 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/vivid/vivid-cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-cec.c b/drivers/media/platform/vivid/vivid-cec.c
index b55d278..30240ab 100644
--- a/drivers/media/platform/vivid/vivid-cec.c
+++ b/drivers/media/platform/vivid/vivid-cec.c
@@ -83,7 +83,7 @@ static void vivid_cec_pin_adap_events(struct cec_adapter *adap, ktime_t ts,
 	if (adap == NULL)
 		return;
 	ts = ktime_sub_us(ts, (CEC_TIM_START_BIT_TOTAL +
-			       len * 10 * CEC_TIM_DATA_BIT_TOTAL));
+			       (const u64)len * 10 * CEC_TIM_DATA_BIT_TOTAL));
 	cec_queue_pin_cec_event(adap, false, ts);
 	ts = ktime_add_us(ts, CEC_TIM_START_BIT_LOW);
 	cec_queue_pin_cec_event(adap, true, ts);
-- 
2.7.4
