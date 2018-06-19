Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D9C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lFKieYgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A8A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030717AbeFSTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:45:04 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43186 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966747AbeFSTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:44:59 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJipJo014312;
        Tue, 19 Jun 2018 14:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437491;
        bh=m8IdMhS6rbzYAI22SHT9fE63vEWnVwzmJPYy8qeKG1U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lFKieYgdDZ84LJlEHjl1ZOL/AJnX3mhzICGxWYWVy2i51Ol/k8E73IZ8PxKrq4a9G
         yVTOmkAM2t/dJz7VBUgx1bTp8LZJgbth+csTBOIz9uCvVglzgt0QEFMfChycaQ+RVL
         rMEml7xkpIj80Jz2PvpSPfNqip14vt10z/qh8Y/Q=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJioVu010688;
        Tue, 19 Jun 2018 14:44:50 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:44:50 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:44:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiokw018210;
        Tue, 19 Jun 2018 14:44:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/2] serial: 8250_omap: Add support for AM654 UART controller
Date:   Tue, 19 Jun 2018 14:44:50 -0500
Message-ID: <20180619194450.6353-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194450.6353-1-nm@ti.com>
References: <20180619194450.6353-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 uses a UART controller that is compatible (partially) with
existing 8250 UART, however, has a few differences with respect to DMA
support and control paths. Introduce a base definition that allows us
to build up the differences in follow on patches.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since RFC: Driver change has been split out with corresponding description.

RFC: https://patchwork.kernel.org/patch/10447641/

 drivers/tty/serial/8250/8250_omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 1b337fee07ed..a019286f8bb6 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1115,6 +1115,7 @@ static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
 static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
+	{ .compatible = "ti,am654-uart" },
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
 	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
-- 
2.15.1

