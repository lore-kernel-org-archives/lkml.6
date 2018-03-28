Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeC1WHb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:07:31 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeC1WH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:07:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kalle Valo <kvalo@qca.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Carl Huang <cjhuang@codeaurora.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ath10k: avoid possible string overflow
Date: Thu, 29 Mar 2018 00:06:10 +0200
Message-Id: <20180328220635.3704458-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:ol4ZTKAL9L6O2dOmcE8jghQF/h9jA3ll+3QK4mGY2XBNiOgkAye
 jJ5JwTJ9WNM2mjPZve1OJNwQnjM3eRmgDU0XIarJYqRW28cEBDfLTFfLZJLjDf/xMEPoCB6
 IRDWVdVe7ShViKZBe/jwaS8rKckRLDA2CVZQHA4QiHqHN8ZgAxSTWtTceKq8fmPkboo6Qnr
 3aDZz2HnwhvkGJZ4OKvjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I/KSEhES4yo=:HzyI0XbLO53J7iZhSGZlPy
 JPyjzObmnuy6g5Iq9lC6TwcMxafBLev4UBL1MriYposCGsfUg+84P3oRvFAzr56x3ETdDXJ/j
 at+bT/267zTnsFBrnB+7uE1G89PxQg/tVWwqom1wr1+q2m38DHQ++NPC+mQgvr1HE7pqmvUgi
 2rBy8qqvq8D+TsQS88hqXeLqfN0dFn+zlQc1gGzHI1UPk5MDhygjBg3crDODbOsP+WSuXxf8Q
 EFdjcGr8xaJnQMX9Afqm44AWpWFxJf55moT+aA/FtcDuKkiD960zs8IIRAD89JKqUY+G9WQxL
 lw4c3ttBGsWSJV7QBRThbnph1p0+WRWoxAXgiRBWSpzes9u4nIP3LL0BsXvQnW8opiWHt4mmh
 DReUlUUzfsUDyWwL7ZVD7YwfMJeR+zv+SsuE0R4Lrh7/ygWx3qru/0eaTYzEvZEf53KEAFjfe
 gNk/lV+9+tRrgTLE4lkR1k3Qbxdal0IsQWa68hKJokDHnj6H37Kq1MgIZQnSzd1/G7ua5MpXI
 SJJu23udL4TneOGK36REXvEVhEuqxBydiesLfPsRwvTa7baBDfYdMpq3exK0jN1v5UrjvjdSJ
 PCIyOxAGWyJ4XGT1Xlzq+TAxOY2CGJTEd50aJO9ujfBfYCtDZhqUkRI/a0pOVpMSb/QswqTDW
 DhPLOB946ItnYL50L0oEgb5ZJSd4/cT1sUW3tTrRbdytKu9jZmgvDs39XKQbf1L20EOt8ck5I
 GlZf9fa7IaxXIrc4V1dWZB0z0klq4I7IjDAifQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way that 'strncat' is used here raised a warning in gcc-8:

drivers/net/wireless/ath/ath10k/wmi.c: In function 'ath10k_wmi_tpc_stats_final_disp_tables':
drivers/net/wireless/ath/ath10k/wmi.c:4649:4: error: 'strncat' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]

Effectively, this is simply a strcat() but the use of strncat() suggests
some form of overflow check. Regardless of whether this might actually
overflow, using strlcat() instead of strncat() avoids the warning and
makes the code more robust.

Fixes: bc64d05220f3 ("ath10k: debugfs support to get final TPC stats for 10.4 variants")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 9649bb752bbd..42522ed115f3 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -4309,7 +4309,7 @@ static void ath10k_tpc_config_disp_tables(struct ath10k *ar,
 							    rate_code[i],
 							    type);
 			snprintf(buff, sizeof(buff), "%8d ", tpc[j]);
-			strncat(tpc_value, buff, strlen(buff));
+			strlcat(tpc_value, buff, sizeof(tpc_value));
 		}
 		tpc_stats->tpc_table[type].pream_idx[i] = pream_idx;
 		tpc_stats->tpc_table[type].rate_code[i] = rate_code[i];
@@ -4646,7 +4646,7 @@ ath10k_wmi_tpc_stats_final_disp_tables(struct ath10k *ar,
 							       rate_code[i],
 							       type, pream_idx);
 			snprintf(buff, sizeof(buff), "%8d ", tpc[j]);
-			strncat(tpc_value, buff, strlen(buff));
+			strlcat(tpc_value, buff, sizeof(tpc_value));
 		}
 		tpc_stats->tpc_table_final[type].pream_idx[i] = pream_idx;
 		tpc_stats->tpc_table_final[type].rate_code[i] = rate_code[i];
-- 
2.9.0
