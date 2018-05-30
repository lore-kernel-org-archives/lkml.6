Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbeE3N3c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:29:32 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.130]:9911 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbeE3N2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:28:21 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx7oJE8yFU0CFyS7Uq+kmFDrWBCuLGqeCYZgEsPw="
X-RZG-CLASS-ID: mo05
From: Frieder Schrempf <frieder.schrempf@exceet.de>
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com, han.xu@nxp.com,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Philipp Puschmann <pp@emlix.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] mtd: m25p80: Call spi_mem_get_name() to let controller set a custom name
Date: Wed, 30 May 2018 15:14:31 +0200
Message-Id: <1527686082-15142-3-git-send-email-frieder.schrempf@exceet.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
set a custom name for the memory device if necessary.
This is useful to keep mtdparts compatible when controller drivers are
ported from the MTD to the SPI layer.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 drivers/mtd/devices/m25p80.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 3dc022d..e1ee3b9 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -199,8 +199,7 @@ static int m25p_probe(struct spi_mem *spimem)
 			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
 	}
 
-	if (data && data->name)
-		nor->mtd.name = data->name;
+	nor->mtd.name = spi_mem_get_name(spimem);
 
 	/* For some (historical?) reason many platforms provide two different
 	 * names in flash_platform_data: "name" and "type". Quite often name is
-- 
2.7.4
