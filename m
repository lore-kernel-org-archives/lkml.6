Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeBVXFU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:05:20 -0500
Received: from mout.perfora.net ([74.208.4.197]:58615 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbeBVXFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:05:18 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org
Cc: Dmitry Osipenko <digetx@gmail.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: tegra: fix pllu rate configuration
Date: Fri, 23 Feb 2018 00:04:51 +0100
Message-Id: <20180222230451.15515-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:EdCBaCHSAK1FzZzYgL6foMPVMDrwbGaqAssYvVkzD360P3mRRgl
 ILgCMkVQrhqNyYmpA1Tct5o2FV4FCha0bzWGyEtAyhM228aJSOMQwaHsAT7pPaANUfXiD0U
 H0QfJ+iyHInYGWU5T3AodRu9vpojh9F4bxtQ7qWTRqYq0rbVqjX6F1Iw3GQncldJhGALfGT
 4D5pBBb96YpPiAGuiRRIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:03d7WfIxWm0=:nLnME4JdKpXkj2c4ABN9yM
 xsrIz8dP+FWdSXv76i3axk/3l/uA8e/W4vYesao17i3IU6m3bphFkKa5g1K6rScR0WBsTN4zZ
 A+urqSlz7xYM16nlRm7jW6wWtoXqu572K410k65WdZChFEdk7355Q/wF7ZIhXKiA78++l/N3H
 8nWx950E2RIEdNTPesjKZHlFSUCx0Tpxa5sAnW1fAhKJx5ypsXJYvTQU+YRSLsusniIcxewMd
 GmYUtrJM7x2cof+qx9u+rHY8bGUwfjuTT0OgzBi0rHUM6QrkP/ncVHG6a6pTd7KBaaXe/R/Ag
 7Bo9DIBTLnW4ajRL2lTZ71ObvYGVJ/mi9vWUeLuJRyu0FgJtNKBmdq0BLTmwyu8X7ynXwkycz
 F5lzUUMI9LFkkVU3F14+B/+SkuRr7NEHICVvwXDwr4Sllins7YZOh4m8QGtlygmIYL69/7y+I
 VbAp+Lp0GPtOZRSoF0ElAnbxLzu8H1vPNxzjwjClR7J7l6nz5fnuObQh41XWp0WAWevQeMVxc
 y/KkRwsRLL/dW8pSDHH+q75JUcHT85+bcdGE/fN3crm8TSC3FBPxEXK/43OiaeIVWlheN52H2
 DGj7NEwkRQV2IDb+kh4OqroU18J0+HPdrojKFMEz91lHtDrPGgjPZiZYwLNzIfmpCtzKz8Obs
 LyFLibp18rHvWMSFBi427U+qu0UX9OdzO3VUL7otDMxke0HIRMnddDCdbEoJrYF26t2sPC5Sh
 q+mYTd0541PxGKIs6K9nX22jiGxCyWLrWzSq1g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out latest upstream U-Boot does not configure/enable pllu which
leaves it at some default rate of 500 kHz:

root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep pll_u
       pll_u                  3        3        0      500000          0

Of course this won't quite work leading to the following messages:

[    6.559593] usb 2-1: new full-speed USB device number 2 using tegra-
ehci
[   11.759173] usb 2-1: device descriptor read/64, error -110
[   27.119453] usb 2-1: device descriptor read/64, error -110
[   27.389217] usb 2-1: new full-speed USB device number 3 using tegra-
ehci
[   32.559454] usb 2-1: device descriptor read/64, error -110
[   47.929777] usb 2-1: device descriptor read/64, error -110
[   48.049658] usb usb2-port1: attempt power cycle
[   48.759475] usb 2-1: new full-speed USB device number 4 using tegra-
ehci
[   59.349457] usb 2-1: device not accepting address 4, error -110
[   59.509449] usb 2-1: new full-speed USB device number 5 using tegra-
ehci
[   70.069457] usb 2-1: device not accepting address 5, error -110
[   70.079721] usb usb2-port1: unable to enumerate USB device

Fix this by actually allowing the rate also being set from within
the Linux kernel.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/clk/tegra/clk-pll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 7c369e21c91c..830d1c87fa7c 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1151,6 +1151,8 @@ static const struct clk_ops tegra_clk_pllu_ops = {
 	.enable = clk_pllu_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
+	.round_rate = clk_pll_round_rate,
+	.set_rate = clk_pll_set_rate,
 };
 
 static int _pll_fixed_mdiv(struct tegra_clk_pll_params *pll_params,
-- 
2.14.3
