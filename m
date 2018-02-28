Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964889AbeB1XSP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:18:15 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935525AbeB1XSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:18:14 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH] ixgbevf: fix unused variable warning
Date: Thu,  1 Mar 2018 00:17:36 +0100
Message-Id: <20180228231745.366681-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:JV203kg1ndtkp8VLJB14a5YA4p2UMRFELb5q/BXOY3xzcbB5N6T
 jQQF4FLuDmzA9HiuUmvBDPd+xBNRgNg3z+ESacmi6KQMKVh9WUdbKanrJI8D8UEqm79xnad
 G3CEmJVtT2jqd1kk0DgtWHFn9KG6dNxgcgmhToj0lU0GR5Gs1zD+6ilpkGEzEQKJlyOSq1k
 UdkFBdrw2uBwRas2slM7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TmhZGPBsTvQ=:Q3dWf35C4iaFxdSEt5C9UJ
 ZYbGZIARnz9Amgwq8JkkGYhstofUSkpYDR26Ez/riqElD2I81WecdQVarWFQiMdUojITpi5f3
 0/v4x+MakChR3r6VIcJh9gBPr5Ll7w9FwbHHELX4GsaColLQbynE7rMmYrgXepRa3QOGlew7p
 OY3zZfBce52s/wLijHneMyVRnBE/ayj7+I/p+WeXpKIu7PoNyGGEbPDns36F2i4xM0yoi7B+i
 iBV6YX2BVzBq9hsGwnXMudDxED3mELrpF0Vj9WjZzfavvv7Mu/ueVveFgudI+ce6pG6HbrOkU
 SF/c4BTgh/eruFhD2bBH2++1G83d20TBNaY3XzveSE+JAfE5/V7FLULT7qc+R+RnpLfBa/9lX
 sqmA/iV77Igwcaqu+KoXPinY5/ZaXb6jCptvteKnNvPE68lmgrOIE0C5F7kDF/IyvjFkI8aAw
 uYatfXnkRna2PS5HsTeAZraEu2iKiikpOXeDKJ6SuM7v5/HFiTnHLG9S52RfWcUB/c0ZHDYOR
 /PchVYAwJ/uVVqoFlD1j4xhOfx+klIyZWjx7PUUftFqYPX6ciYz7Gps+u0Mf77bR/UoKShxZC
 bclF/tkXxVshwfWilz67w44gJhcdv6/QpIOOnlLlvVDi6J1iCOpNEpWLsziJMpmSx1rhfe1L/
 xBRXlqiUkK5N8sbiKmdlv0sy+w/wROH1B9QZIe/pYmYT5KtMZcesrxMHYpPB9ysQlH5Me0Zrn
 qYbwgzjpkNCWh8+z8yWF2YZOFIOY2Yf2N663bg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new ixgbevf_set_rx_buffer_len() function causes a harmless warnings
in configurations with large page size:

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_set_rx_buffer_len':
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:1758:15: error: unused variable 'max_frame' [-Werror=unused-variable]

This rephrases the code so that the compiler can see the use of that
variable, making it slightly easier to read in the process.

Fixes: f15c5ba5b6cd ("ixgbevf: add support for using order 1 pages to receive large frames")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index f37307131eb6..4da449e0a4ba 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1766,12 +1766,12 @@ static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
 
 	set_ring_build_skb_enabled(rx_ring);
 
-#if (PAGE_SIZE < 8192)
-	if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
-		return;
+	if (PAGE_SIZE < 8192) {
+		if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
+			return;
 
-	set_ring_uses_large_buffer(rx_ring);
-#endif
+		set_ring_uses_large_buffer(rx_ring);
+	}
 }
 
 /**
-- 
2.9.0
