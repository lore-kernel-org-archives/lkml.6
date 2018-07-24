Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0769C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576A920875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576A920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mixed-mode.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeGXLAq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:00:46 -0400
Received: from mailgate.pixel-group.de ([145.253.133.146]:49238 "EHLO
        mailgate.pixel-group.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbeGXLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:00:46 -0400
Received: from mail.pixel.de (unknown [10.63.25.81])
        by mailgate.pixel-group.de (Postfix) with ESMTP id C5BE45E16A;
        Tue, 24 Jul 2018 11:46:03 +0200 (CEST)
Received: from tragicomix (localhost [127.0.0.1])
        by mail.pixel.de (Postfix) with ESMTP id 8811A1A1A7;
        Tue, 24 Jul 2018 11:46:03 +0200 (CEST)
Received: from neckar.pixel-group.local (10.63.25.31)
 by tragicomix (F-Secure/fsigk_smtp/550/tragicomix);
 Tue, 24 Jul 2018 11:46:03 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/tragicomix)
Received: from lippe.pixel-group.local (10.63.25.67) by
 Neckar.pixel-group.local (10.63.25.31) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 11:46:03 +0200
Received: from lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb]) by
 lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb%16]) with mapi id
 15.00.1367.000; Tue, 24 Jul 2018 11:46:03 +0200
From:   Sven Schmitt <Sven.Schmitt@mixed-mode.de>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
Thread-Topic: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
Thread-Index: AQHUIzE2wa1SDOEVZU+1lGyGXEPU0g==
Date:   Tue, 24 Jul 2018 09:46:03 +0000
Message-ID: <1532425558626.11533@mixed-mode.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.25.69]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx6_pm_domain_power_off() reads iso and iso2sw from GPC_PGC_PUPSCR_OFFS 
which stores the power up delays. 
So use GPC_PGC_PDNSCR_OFFS for the correct delays.

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 0097a939487f..5126185e68c6 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -73,7 +73,7 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 		return -EBUSY;
 
 	/* Read ISO and ISO2SW power down delays */
-	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
+	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PDNSCR_OFFS, &val);
 	iso = val & 0x3f;
 	iso2sw = (val >> 8) & 0x3f;
 
-- 
2.17.1

