Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeFAEwU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:52:20 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:26586 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFAEwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:52:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w514pT3d024922
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Emese Revfy <re.emese@gmail.com>,
        linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] gcc-plugins: disable GCC_PLUGIN_STRUCTLEAK_BYREF_ALL for COMPILE_TEST
Date: Fri,  1 Jun 2018 13:51:23 +0900
Message-Id: <1527828683-4518-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have enabled GCC_PLUGINS for COMPILE_TEST, but allmodconfig now
produces new warnings.

  CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.o
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function ‘wlc_phy_workarounds_nphy_rev7’:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16563:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function ‘wlc_phy_workarounds_nphy_rev3’:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16905:1: warning: the frame size of 2800 bytes is larger than 2048 bytes [-Wframe-larger-than=]
 }
 ^
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c: In function ‘wlc_phy_cal_txiqlo_nphy’:
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:26033:1: warning: the frame size of 2488 bytes is larger than 2048 bytes [-Wframe-larger-than=]
 }
 ^

It looks like GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is causing this.
Add "depends on !COMPILE_TEST" to not dirturb the compile test.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index e9475d0..e5ff804 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -489,6 +489,7 @@ config GCC_PLUGIN_STRUCTLEAK
 config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
 	bool "Force initialize all struct type variables passed by reference"
 	depends on GCC_PLUGIN_STRUCTLEAK
+	depends on !COMPILE_TEST
 	help
 	  Zero initialize any struct type local variable that may be passed by
 	  reference without having been initialized.
-- 
2.7.4
