Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422706AbeE1Mcm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164656AbeE1K7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:59:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 408/496] spi: bcm-qspi: fIX some error handling paths
Date: Mon, 28 May 2018 12:03:13 +0200
Message-Id: <20180528100336.955006444@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>

[ Upstream commit bc3cc75281b3c2b1c5355d88d147b66a753bb9a5 ]

For some reason, commit c0368e4db4a3 ("spi: bcm-qspi: Fix use after free
in bcm_qspi_probe() in error path") has updated some gotos, but not all of
them.

This looks spurious, so fix it.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-bcm-qspi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1255,7 +1255,7 @@ int bcm_qspi_probe(struct platform_devic
 		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[MSPI])) {
 			ret = PTR_ERR(qspi->base[MSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 	} else {
 		goto qspi_resource_err;
@@ -1266,7 +1266,7 @@ int bcm_qspi_probe(struct platform_devic
 		qspi->base[BSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[BSPI])) {
 			ret = PTR_ERR(qspi->base[BSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 		qspi->bspi_mode = true;
 	} else {
