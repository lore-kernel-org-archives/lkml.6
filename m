Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523A23ED7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D523A23ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbeGFMzp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:55:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932569AbeGFMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:55:44 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M0iAY-1gORLm307q-00un52; Fri, 06 Jul 2018 14:55:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: fix i.MX6SLL build
Date:   Fri,  6 Jul 2018 14:54:48 +0200
Message-Id: <20180706125523.3480661-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:ADlBXXsBUcF+iwsDPPVUFUxpJKnEXgFbnfxNkCerIuTc69RPfBu
 whs3AqUociKj5jEPVgTYWhXRC6hiPafjK0432W+VuRRDifzyhW7Q0AIjP4P66KV9vb8pU5S
 wwybP2eZDdDiACyq8mhj0E7TYl6lIAWQ71XYD0NcH2T/BSfOiFlWSz3RIGkgiZkfCe1r9AL
 kAlrOxuhwanHL0GOKVmAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:efo/kRdU3ao=:8mjfFSxVY/896y6tTONnFu
 GlRiYmeJiJn3AsEXbV6uSl/MbPfh+Vi+7M3dMoNDyW2OBlgmj41oItMe4sNjE7/HJKl+xCQuE
 wE+iw7J7xbBH+1+btjxzg/bMPFh4Ra6k/CKz+1Us5gZtwGrZ+mOuoD+9utf8xb4jWHqoiSFCK
 n9CtGGiU8f4wOeaDVbmuMYI3CFOkjg0+v6UoHbxEcBGfOPn/Cxzl7aTxzel18aknH1zLGYp87
 BWruTJzg9hal1KLqMowY7VjKSOVRc9Erow5sKFVABYmgMrC9FAugJPJTDtgzytjmTc5wIiUi4
 sh76HANa7vtE4PiZ78s3L3h4UKeAMr7c/DH6rx/yh8Q9wnl3tUFeT9ZCMJogP6P/eagULxHid
 E6v4tivnOxbGaBC+wIbwhOCLcsFfiAA8LPkO9kTJSK9C9B06FFe/9PMTXxDngy9tZtPZ0ZH8m
 atrUZ0yuYXAQsq+YrkYZlTRgYXiS4oCFLV1jNU4pjsrMLSQXFQdQDpdUbTYVujHqrLI8k4SEK
 9L2YFv/i+glflIXidrNX9UlDqUSWyblwr8YvWShV7jT5a4l4pTiFNFPBXuGJxW2F3Fqy4lyH0
 ulud9wDLBd5W5StPjPnh74FplRA0aaBVAPFzGHLgcJUm5qgzRQ8R7DGX6J0Oxozj+vouVSbix
 8BcNeGknQgJ4dW2ITNKhkDL+xCIIWdRF5LoPPW64+W/Epi5Z2LGq66UqJsTOpNfmoUXo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX6SLL cpuidle support reuses the i.MX6SX implementation, but
the Makefile accidentally enables the i.MX6SL one as well, which
then fails with a link error unless the kernel also enables the
the i.MX6SL clock driver:

arch/arm/mach-imx/cpuidle-imx6sl.o: In function `imx6sl_enter_wait':
cpuidle-imx6sl.c:(.text+0x24): undefined reference to `imx6sl_set_wait_clk'

This changes the two lines that were just modified again, hopefully
getting every case right this time.

Fixes: e7fa1fb39b11 ("ARM: imx: add cpu idle support for i.MX6SLL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 146ebf97b7eb..bae179af21f6 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -25,8 +25,8 @@ obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
-obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
-obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
-- 
2.9.0

