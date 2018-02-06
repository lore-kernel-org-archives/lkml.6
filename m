Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeBFQzc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:55:32 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.191]:33359 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753128AbeBFQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:53:45 -0500
Date: Tue, 6 Feb 2018 10:53:44 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v3 8/8] platform: vivid-cec: use 64-bit arithmetic instead of
 32-bit
Message-ID: <cca3c728f123d714dc8e4ed87510aeb2e2d63db6.1517929336.git.gustavo@embeddedor.com>
References: <cover.1517929336.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517929336.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ej6V6-000rzF-Qw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:46898
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 45
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 10 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression len * 10 * CEC_TIM_DATA_BIT_TOTAL is currently being
evaluated using 32-bit arithmetic.

Also, remove unnecessary parentheses and add a code comment to make it
clear what is the reason of the code change.

Addresses-Coverity-ID: 1454996 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update subject and changelog to better reflect the proposed code changes.
 - Add suffix ULL to constant instead of casting a variable.
 - Remove unnecessary parentheses.
 - Add code comment.

Changes in v3:
 - Mention the specific Coverity report in the commit message.

 drivers/media/platform/vivid/vivid-cec.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vivid/vivid-cec.c b/drivers/media/platform/vivid/vivid-cec.c
index b55d278..614787b 100644
--- a/drivers/media/platform/vivid/vivid-cec.c
+++ b/drivers/media/platform/vivid/vivid-cec.c
@@ -82,8 +82,15 @@ static void vivid_cec_pin_adap_events(struct cec_adapter *adap, ktime_t ts,
 
 	if (adap == NULL)
 		return;
-	ts = ktime_sub_us(ts, (CEC_TIM_START_BIT_TOTAL +
-			       len * 10 * CEC_TIM_DATA_BIT_TOTAL));
+
+	/*
+	 * Suffix ULL on constant 10 makes the expression
+	 * CEC_TIM_START_BIT_TOTAL + 10ULL * len * CEC_TIM_DATA_BIT_TOTAL
+	 * to be evaluated using 64-bit unsigned arithmetic (u64), which
+	 * is what ktime_sub_us expects as second argument.
+	 */
+	ts = ktime_sub_us(ts, CEC_TIM_START_BIT_TOTAL +
+			       10ULL * len * CEC_TIM_DATA_BIT_TOTAL);
 	cec_queue_pin_cec_event(adap, false, ts);
 	ts = ktime_add_us(ts, CEC_TIM_START_BIT_LOW);
 	cec_queue_pin_cec_event(adap, true, ts);
-- 
2.7.4
