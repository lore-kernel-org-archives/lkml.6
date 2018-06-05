Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeFELxy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:53:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFELxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:53:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: rpc: use designated initializers in ecard_default_ops
Date: Tue,  5 Jun 2018 13:53:19 +0200
Message-Id: <20180605115330.1733640-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:LUjdmY3vEd2QMazkDsR1SB+EbIymrQ1Pvqv2V6QgDq9n5L/TLsz
 gYW9t6mszJ3U0T/cAI4msYEDm5svDnZbwrBFwYaw7SjDuf6pPWelBtyWs6ISFEN3oA9JmY8
 7/FR2NM0NPwGwwICZJcBwYPkXMn/Y90/pnf6mt1kiGMTC+1lRkVliJKcbA01GgPJFPP35mo
 Qm9TTSM5OO71/5Y4klE8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CONq93MxcEI=:taQMPaTJb1S5ztfAdJ1FN/
 g/qRqjwZhOiDa848Ha6BoA/7Vi1/wdi14+qzbEyeXDFMwdvgawb+KVWy5hw80x8/AZ5Z30eVQ
 HTUDmHEVgn7beLPBEM9QwRsJtly9hha32Bbm3ObAFLkUW4WjKLCmqi9jaXklJD9OeBkaLiVHv
 wjaO0FGn44niRLOPPz4ZIbf6j1Gnh7jrZyIwpN/sjBcc+CIEY/CT0TWWyO3RMO11pDjPD1f/Z
 vtKprhZZTniiOJ8hNKOScutNC4aGgpiQa7I5YCWI2/VdTpuK4FtDpV6Ym3fpJX25ELsDEiKaj
 /WOZIcwsGJ2NsNxYSZ6ICoVMDkcqqO1t1ncMarrqFTMPVDbCSTtLLkB04ZiU0mjeLrF5gLtRs
 AspqRqSBti2UHaZsudYXR9JZyIE9YPhghWI75J2pBeN4CiEsXne9ZiLb/oIzem+f9qBsYe4RB
 5pE3ey5tkZ/PIcBfm+ENqYzxtSA6c8fK672Wdm5joApDZbofA07D/WoUosTpMcC0V7vbhq+UF
 4drbppOU8vmAN2RQiKUa5Db8QniF4qpMPsSyzUG9wBzqDZ22A5SRARSC3EOGWZ2JPciCAvJA1
 y08GOdq+0jj62crwYJJXb/hpH0UODK6ZNnvUIQqXb6/nbwM1w4mMXBJ0oshRxyS6HWRweNHyD
 y2qI9O3ympkJ5w5Xo7NM69m0JyATcJ7qCFMQixClNfdHMryW+/FkuMAk1Aosuy3m5lRc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the randstruct plugin is enabled, we get a warning about the
use of traditional struct initializers for this structure, which
results in incorrect behavior:

arch/arm/mach-rpc/ecard.c:416:2: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
  ecard_def_irq_enable,
  ^~~~~~~~~~~~~~~~~~~~
arch/arm/mach-rpc/ecard.c:416:2: note: (near initialization for 'ecard_default_ops')
arch/arm/mach-rpc/ecard.c:416:2: error: invalid initializer
arch/arm/mach-rpc/ecard.c:416:2: note: (near initialization for 'ecard_default_ops.<anonymous>')
arch/arm/mach-rpc/ecard.c:417:2: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
  ecard_def_irq_disable,
  ^~~~~~~~~~~~~~~~~~~~~

This changes it to use designated initializers like we do for all
other structures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-rpc/ecard.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 39aef4876ed4..d0c4e20de4f3 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -413,12 +413,12 @@ static int ecard_def_fiq_pending(ecard_t *ec)
 }
 
 static expansioncard_ops_t ecard_default_ops = {
-	ecard_def_irq_enable,
-	ecard_def_irq_disable,
-	ecard_def_irq_pending,
-	ecard_def_fiq_enable,
-	ecard_def_fiq_disable,
-	ecard_def_fiq_pending
+	.irqenable  = ecard_def_irq_enable,
+	.irqdisable = ecard_def_irq_disable,
+	.irqpending = ecard_def_irq_pending,
+	.fiqenable  = ecard_def_fiq_enable,
+	.fiqdisable = ecard_def_fiq_disable,
+	.fiqpending = ecard_def_fiq_pending
 };
 
 /*
-- 
2.9.0
