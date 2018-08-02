Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7311BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3BA21525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="WG0iEYde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3BA21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbeHBOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:45:45 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.182]:17108 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbeHBOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533214479;
        s=strato-dkim-0002; d=as-electronics.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Z+3vqqSZo8xz681gBxM4nJCvZiYwbbDIV18OBHmuLzM=;
        b=WG0iEYdebqdbKaHv5sp87J2alnZKWH5FGGQvy6GvdzSLE7FJYaJAEo4DF9UvX6N6Ux
        XBXkJKTk/YPLf0MH6R5wD8mFnu2knJdBrRW8z1Owdb95GD3Ypxv8Ql5xKGQcdg4CU74H
        In7aWDKtLClqWBmq7HIBajq15ao7kEVmHPVGSU3pWiYrQy5gNI5B3+DukyNfFw2exiPJ
        Eq7MuOw7ft67BxuhbdfBv2eY3MNdCxvWPH1HUqyhT+CZPXim7JWg3GGJmf4QEYBWRKpR
        IA/zwFt6mlCQ5/cMmxMOwjeqD/vJz+5yqjRdsRBDKjCdpb4YhcYmBDquYyvohKXR3jR/
        aILg==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+ReE5zXU1i255vGQvjM+ToVYx2MGL/3gV0P3t0="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 43.14 AUTH)
        with ESMTPSA id Z0998bu72CsU7Pf
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 2 Aug 2018 14:54:30 +0200 (CEST)
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, marek.vasut@gmail.com, richard@nod.at,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org
Cc:     cyrille.pitchen@wedev4u.fr, frieder.schrempf@exceet.de,
        pp@emlix.com, Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] mtd: m25p80: Call spi_mem_get_name() to let controller set a custom name
Date:   Thu,  2 Aug 2018 14:53:54 +0200
Message-Id: <1533214434-28761-4-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
set a custom name for the memory device if necessary.
This is useful to keep mtdparts compatible when controller drivers are
ported from the MTD to the SPI layer.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/mtd/devices/m25p80.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e84563d..aac48800 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -202,6 +202,9 @@ static int m25p_probe(struct spi_mem *spimem)
 	if (data && data->name)
 		nor->mtd.name = data->name;
 
+	if (!nor->mtd.name)
+		nor->mtd.name = spi_mem_get_name(spimem);
+
 	/* For some (historical?) reason many platforms provide two different
 	 * names in flash_platform_data: "name" and "type". Quite often name is
 	 * set to "m25p80" and then "type" provides a real chip name.
-- 
2.7.4

