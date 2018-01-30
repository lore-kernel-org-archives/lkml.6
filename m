Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeA3A4D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:56:03 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.109]:32573 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752251AbeA3A4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:56:01 -0500
Date: Mon, 29 Jan 2018 18:32:21 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 5/8] pci: cx88-input: fix potential integer overflow
Message-ID: <7958c3115b5727c2272ce9cf7454cea8e6f4cc50.1517268668.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1egJqY-001eaY-AI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.145.57.174]:35460
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast ir->polling to ktime_t in order to avoid a potential integer
overflow. This variable is being used in a context that expects
an expression of type ktime_t (s64).

Addresses-Coverity-ID: 1392628 ("Unintentional integer overflow")
Addresses-Coverity-ID: 1392630 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/pci/cx88/cx88-input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx88/cx88-input.c b/drivers/media/pci/cx88/cx88-input.c
index 4e9953e..096b350 100644
--- a/drivers/media/pci/cx88/cx88-input.c
+++ b/drivers/media/pci/cx88/cx88-input.c
@@ -180,7 +180,7 @@ static enum hrtimer_restart cx88_ir_work(struct hrtimer *timer)
 	struct cx88_IR *ir = container_of(timer, struct cx88_IR, timer);
 
 	cx88_ir_handle_key(ir);
-	missed = hrtimer_forward_now(&ir->timer, ir->polling * 1000000);
+	missed = hrtimer_forward_now(&ir->timer, (ktime_t)ir->polling * 1000000);
 	if (missed > 1)
 		ir_dprintk("Missed ticks %ld\n", missed - 1);
 
@@ -200,7 +200,7 @@ static int __cx88_ir_start(void *priv)
 	if (ir->polling) {
 		hrtimer_init(&ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		ir->timer.function = cx88_ir_work;
-		hrtimer_start(&ir->timer, ir->polling * 1000000,
+		hrtimer_start(&ir->timer, (ktime_t)ir->polling * 1000000,
 			      HRTIMER_MODE_REL);
 	}
 	if (ir->sampling) {
-- 
2.7.4
