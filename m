Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeDEBqG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 21:46:06 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.77]:31084 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752642AbeDEBqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 21:46:05 -0400
Date: Wed, 4 Apr 2018 20:25:40 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [rtlwifi-btcoex] Suspicious code in halbtc8821a1ant driver
Message-ID: <20180405012540.GA24241@embeddedor.com>
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
X-Exim-ID: 1f3teo-001Lpk-A4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:35834
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While doing some static analysis I came across the following piece of code at drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c:1581:

1581 static void btc8821a1ant_act_bt_sco_hid_only_busy(struct btc_coexist *btcoexist,
1582                                                   u8 wifi_status)
1583 {
1584         /* tdma and coex table */
1585         btc8821a1ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 5);
1586 
1587         if (BT_8821A_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN ==
1588             wifi_status)
1589                 btc8821a1ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 1);
1590         else
1591                 btc8821a1ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 1);
1592 }

The issue here is that the code for both branches of the if-else statement is identical.

The if-else was introduced a year ago in this commit c6821613e653

I wonder if an argument should be changed in any of the calls to btc8821a1ant_coex_table_with_type?

What do you think?

Thanks
--
Gustavo
