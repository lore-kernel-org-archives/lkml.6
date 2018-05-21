Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeEUSrI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:47:08 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40299 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeEUSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:46:36 -0400
X-Google-Smtp-Source: AB8JxZrpwAIaGh4TBkAnKMWyJmgda7Dm95JIlDxLHgwp7+I0EAO+FvUr5VI1yCpzURMRdrkNwu2D3g==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>,
        Richard Cochran <richardcochran@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/5] net: ethernet: ti: cpts: Fix timestamp print
Date: Mon, 21 May 2018 11:45:52 -0700
Message-Id: <20180521184555.21555-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit hosts we will get the following warning:

drivers/net/ethernet/ti/cpts.c: In function 'cpts_overflow_check':
drivers/net/ethernet/ti/cpts.c:297:11: warning: format '%lld' expects
argument of type 'long long int', but argument 3 has type
'__kernel_time_t {aka long int}' [-Wformat=]
  pr_debug("cpts overflow check at %lld.%09lu\n", ts.tv_sec,
ts.tv_nsec);

Fix this by using an appropriate casting that works on all bit sizes.

Fixes: a5c79c26e168 ("ptp: cpts: convert to the 64 bit get/set time methods.")
Fixes: 87c0e764d43a ("cpts: introduce time stamping code and a PTP hardware clock.")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/cpts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 7842f094f2ef..6f63c8729afc 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -294,7 +294,8 @@ static long cpts_overflow_check(struct ptp_clock_info *ptp)
 		delay = CPTS_SKB_TX_WORK_TIMEOUT;
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
-	pr_debug("cpts overflow check at %lld.%09lu\n", ts.tv_sec, ts.tv_nsec);
+	pr_debug("cpts overflow check at %lld.%09ld\n",
+		 (long long)ts.tv_sec, ts.tv_nsec);
 	return (long)delay;
 }
 
-- 
2.14.1
