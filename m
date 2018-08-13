Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BCEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EC921765
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EC921765
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbeHNBWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:22:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbeHNBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:22:03 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LZfCu-1gJDAH40uy-00lRpH; Tue, 14 Aug 2018 00:37:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: ast: select GENERIC_ALLOCATOR
Date:   Tue, 14 Aug 2018 00:37:18 +0200
Message-Id: <20180813223733.991653-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:q1vC0qCz1pVldSsUhOqm7fnYwL1ZtgyjVUOMDeXOtrY82Lr51xH
 Lmo3Zcol5z2MiNRlLL1M5k7ot7jXfCuS05LABwOUcUIR/Is4/qNAHTudVf6ncso9u0v8gFm
 aivmdBHd6tKlvDYXOj06piWsKyEmmRh6ihq3N0O4BXBTXAUXV8yOTVEtPt9vtBQvb14sD7d
 OCRkd1cqAwREIaIJ7pg6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bLv0huDxRSk=:bbKmLxMsVzUx1XyFS29Ydn
 qYwO1lDQ1HocDxFCX+C2Ofhc9IUsw3HIxsD4ht0XNY8M+a4jokyaaKVBYZk3vGcL3DKNPMTXC
 jHMvBZx7hlrLY/QMKpB/lUX8vt7RP8q9C3KbRFEXAu1Df/IIh7HW9R1IwlO4+O1LrBUwUTCR3
 D2GR6/4yBwyaGfZy2ImlUO0EHwugnHv4m2L8QfU92llCdE8oTqVJRfe94CzpjxFa0YPTuX0Q6
 L3J8q/SJXE8B9f+OebuM1arxQ9y3k3lI8c8xQbwXFj3hADuh/WXrFAp6eMuSW3a87nMbI8zth
 myLO8QKIu7e7S3J9NipSo6ruJKzhawH+h2BdayJCY8H1yPhiALQk1oajcCxEzxPmzNvF02cwK
 uGNlPS7WMzUisfdgxRiHDe0l/vAhEy4hhxpiyfhF3lJONgu3Vgk22xqQ7HYvbNtRX8/fhJ01O
 jr+kZtZ/3PG+u2PjGBf6FQ8sSltHRCqcCpB8N727iK8Y6MUUR/vxDNlEiPQQF35WWbZ9/R6S6
 R6cFOyxlHDUVvmgZ7jdqGzfBfrc5Cn7cFPJ2uOYzRWsuXJh5y0JdxOXBD+UMFvfMu+4Zpglxd
 dMDSGJIa2Tg8vX1ieajJoyADA7IRSsnxr/0LrjzO4vGp0xvn4f5RwsV71i5clozuMSadFMy1n
 4exnq+kjSsRSXPHre6NJaxZpIi3ojTculpXOsKkBKR+qLAsD1fuZ2o/OaZpyBp00Pi5I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In randconfig builds without CONFIG_GENERIC_ALLOCATOR, this driver
fails to link:

ERROR: "gen_pool_alloc_algo" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
ERROR: "gen_pool_fixed_alloc" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
ERROR: "of_gen_pool_get" [drivers/fsi/fsi-master-ast-cf.ko] undefined!
ERROR: "gen_pool_free" [drivers/fsi/fsi-master-ast-cf.ko] undefined!

Select the dependency as all other users do.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/fsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
index af3a20dd5aa4..99c99a5d57fe 100644
--- a/drivers/fsi/Kconfig
+++ b/drivers/fsi/Kconfig
@@ -46,6 +46,7 @@ config FSI_MASTER_AST_CF
 	tristate "FSI master based on Aspeed ColdFire coprocessor"
 	depends on GPIOLIB
 	depends on GPIO_ASPEED
+	select GENERIC_ALLOCATOR
 	---help---
 	This option enables a FSI master using the AST2400 and AST2500 GPIO
 	lines driven by the internal ColdFire coprocessor. This requires
-- 
2.18.0

