Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeC3SeG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:34:06 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.126]:47642 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751275AbeC3SeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:34:04 -0400
Date: Fri, 30 Mar 2018 13:34:01 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ath9k: dfs: remove accidental use of stack VLA
Message-ID: <20180330183401.GA16758@embeddedgus>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f1yqh-00313p-2G
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:39056
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove accidental use of stack VLA.

This avoids an accidental stack VLA (since the compiler thinks
the value of FFT_NUM_SAMPLES can change, even when marked
"const"). This just replaces it with a #define.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 6fee9a4..c8844f5 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -41,7 +41,7 @@ static const int BIN_DELTA_MAX		= 10;
 
 /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
 #define NUM_DIFFS 3
-static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);
+#define FFT_NUM_SAMPLES		(NUM_DIFFS + 1)
 
 /* Threshold for difference of delta peaks */
 static const int MAX_DIFF		= 2;
@@ -114,7 +114,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
 
 		ath_dbg(common, DFS, "HT40: datalen=%d, num_fft_packets=%d\n",
 			datalen, num_fft_packets);
-		if (num_fft_packets < (FFT_NUM_SAMPLES)) {
+		if (num_fft_packets < FFT_NUM_SAMPLES) {
 			ath_dbg(common, DFS, "not enough packets for chirp\n");
 			return false;
 		}
@@ -136,7 +136,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
 			return false;
 		ath_dbg(common, DFS, "HT20: datalen=%d, num_fft_packets=%d\n",
 			datalen, num_fft_packets);
-		if (num_fft_packets < (FFT_NUM_SAMPLES)) {
+		if (num_fft_packets < FFT_NUM_SAMPLES) {
 			ath_dbg(common, DFS, "not enough packets for chirp\n");
 			return false;
 		}
-- 
2.7.4
