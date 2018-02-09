Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeBIQQz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:16:55 -0500
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:58933 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751029AbeBIQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:16:53 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12555:12679:12740:12760:12895:12986:13161:13229:13439:14181:14659:14721:21080:21451:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: vase85_1a48ec10c026
X-Filterd-Recvd-Size: 3368
Message-ID: <1518193009.14014.6.camel@perches.com>
Subject: Re: [PATCH] rtlwifi: rtl8192cu: remove pointless memcpy
From: Joe Perches <joe@perches.com>
To: Arnd Bergmann <arnd@arndb.de>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 09 Feb 2018 08:16:49 -0800
In-Reply-To: <20180209132531.2755482-1-arnd@arndb.de>
References: <20180209132531.2755482-1-arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 14:24 +0100, Arnd Bergmann wrote:
> gcc-8 points out that source and destination of the memcpy() are
> always the same pointer, so the effect of memcpy() is undefined
> here (its arguments must not overlap):
> 
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c: In function '_rtl_rx_process':
> drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:430:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
> 
> Most likely this is harmless, but it's easy to just remove the
> line and get rid of the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> index ac4a82de40c7..9ab56827124e 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
> @@ -427,7 +427,6 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
>  		 (u32)hdr->addr1[0], (u32)hdr->addr1[1],
>  		 (u32)hdr->addr1[2], (u32)hdr->addr1[3],
>  		 (u32)hdr->addr1[4], (u32)hdr->addr1[5]);
> -	memcpy(IEEE80211_SKB_RXCB(skb), rx_status, sizeof(*rx_status));
>  	ieee80211_rx(hw, skb);
>  }

trivia:

The RT_TRACE above this should probably use %pM too.
Not submitted as it would just cause a conflict.

---

 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index ac4a82de40c7..61da667ed8ba 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -422,11 +422,8 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 	if (ieee80211_is_data(fc))
 		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Got data frame\n");
 	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "Fram: fc = 0x%X addr1 = 0x%02X:0x%02X:0x%02X:0x%02X:0x%02X:0x%02X\n",
-		 fc,
-		 (u32)hdr->addr1[0], (u32)hdr->addr1[1],
-		 (u32)hdr->addr1[2], (u32)hdr->addr1[3],
-		 (u32)hdr->addr1[4], (u32)hdr->addr1[5]);
+		 "Fram: fc = 0x%X addr1 = %pM\n",
+		 fc, hdr->addr1);
 	memcpy(IEEE80211_SKB_RXCB(skb), rx_status, sizeof(*rx_status));
 	ieee80211_rx(hw, skb);
 }
