Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBINZ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:25:56 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeBINZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:25:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8192cu: remove pointless memcpy
Date: Fri,  9 Feb 2018 14:24:41 +0100
Message-Id: <20180209132531.2755482-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:RWBl3G8cH5p9u51X2ua0AkG1ltzUmI6b0tqV4YZ8t7HUck+ryPp
 CqPiaYJLbOXErZhien9xzrPJs1rKimHDChtW6Pptj5uaqs6UbenlR2Vw6XZT5WUagGgFd0z
 S5hJAzYajRe7LqTlSZ958RbtkjBlAR/OkUTVtQx8iJQBb+ruzwSEleELy67VcUma1NvCMBg
 K5A1w77cJnW4ezvFn3IWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iOmuxAw0i2A=:whEsezpDFz/1pd+SnDJgG2
 /D8pKk59JIdzRqpOwYXvDbQjTG27nH7Wn8FXRrh5RJqGoXBdPLRAQEa98AhSQtlfRQRWv800C
 tdLIygKFuIy5uyO9SoWe3p3tFG1PtnFUAXG4XGeW8YMAmZhZz5932dOvH1Wk8iZRYOptyOhQW
 o1dvXic4JVL9pv9kiI1qObfmT9pd96/2svqTVOoCYCTHqE9Dgz7Fpd6w5vKWNnFJ1uSdSorIY
 xcMhYXRnUmB5m0+xqDHlSpT53ib8sv82kbMpqW9vmqTndNB+D9bj2X6BktaoNd7tnG8WRPUav
 3bW/pCcf3XCiydzzfEWEmhVlS/lV5DmKkGRxFljC44YZ51pHKb9dpMMTstiVskrLYX0s/5WXQ
 /cj2UKSCvSg/ouUWHTPz78YK1G4ZKUUce4zIau76K60wy9b349nfZErZfnkCabjnCcxRt/fLy
 URN8/bb9iCOe8ptCbHXJDL9eHZUWHHiKKkiSM7JEuO46dbylhIWI5gonQOc+U2auReKUGOdd0
 F0tDxv0TfnEXYb2kMRXSzG+HtEHedBsDojfU0hd5klfxODU2vOjqcsiNHEGqwOwTZ4wiSP0rN
 MujyqujgtOXZOiZefcs4oOLo+ueOz9fOQviy822w4xjYOX7xxBwmcJu875VUuUDauuz7JFVlv
 Lx8wpLsDT4XYQZgLp9G++rN1aiOD2PkVHbvWrijEnkitmUaifjH6/3kWmXAvWCdGHDVPxUbDp
 RHEu9AKKZmLoSkO2+QW5Mxx/TCee1CqeHnrlwQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 points out that source and destination of the memcpy() are
always the same pointer, so the effect of memcpy() is undefined
here (its arguments must not overlap):

drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c: In function '_rtl_rx_process':
drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:430:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

Most likely this is harmless, but it's easy to just remove the
line and get rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index ac4a82de40c7..9ab56827124e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -427,7 +427,6 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 		 (u32)hdr->addr1[0], (u32)hdr->addr1[1],
 		 (u32)hdr->addr1[2], (u32)hdr->addr1[3],
 		 (u32)hdr->addr1[4], (u32)hdr->addr1[5]);
-	memcpy(IEEE80211_SKB_RXCB(skb), rx_status, sizeof(*rx_status));
 	ieee80211_rx(hw, skb);
 }
 
-- 
2.9.0
