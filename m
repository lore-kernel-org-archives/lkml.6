Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeDSQVy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:21:54 -0400
Received: from gateway36.websitewelcome.com ([192.185.200.11]:35195 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753869AbeDSQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:21:53 -0400
X-Authority-Reason: nr=8
Date: Thu, 19 Apr 2018 10:59:58 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] mmc: sdhci-cadence: fix logically and structurally dead
 code
Message-ID: <20180419155958.GA18593@embeddedor.com>
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
X-Source-IP: 189.175.6.211
X-Source-L: No
X-Exim-ID: 1f9ByZ-003SB0-FH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.6.211]:41278
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the code block inside the for loop will never execute
more than once, because the function returns inmediately after
the first iteration, hence the execution of the code at the second
iteration is structurally dead and, code at line 281: return 0; is
never reached.

Fix this by checking _ret_ before return.

Addresses-Coverity-ID: 1468009 ("Logically dead code")
Addresses-Coverity-ID: 1468002 ("Structurally dead code")
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update changelog.
 - Drop the 'Fixes' tag.
 - Add check on ret instead of removing the "return ret;" line.
 - Thanks to Masahiro Yamada for the feedback provided.

 drivers/mmc/host/sdhci-cadence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index bc30d16..7a343b8 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -274,8 +274,8 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 		ret = readl_poll_timeout(reg, tmp,
 					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
 					 0, 1);
-
-		return ret;
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.7.4
