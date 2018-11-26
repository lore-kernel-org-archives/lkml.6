Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79B3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975A220663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5GjeUnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975A220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeK0EaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeK0EaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:30:22 -0500
Received: from localhost.localdomain (unknown [136.62.81.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8152086B;
        Mon, 26 Nov 2018 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543253734;
        bh=qJDW8bMoYKeCM3xnA/soWeSyA0ukKDLXhfMwLcnhPlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5GjeUnOWgWD6e+EsSL4CHRaSN/3VIIT/LFgAssahqORtHyTcG+OERAh8cMlTqzQp
         eglCSKoXR7c90AugKVMKqAP2yZpzBGRXXEIeACDOxG0rAGv1zcDGc65lBeDjXN54g8
         fpxqI2jrTlkYAuuXW2RKpj3HOuwf9O1B4XLtDl2Q=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 2/2] fpga: mgr: altera-ps-spi: enable usage on non-dt platforms
Date:   Mon, 26 Nov 2018 11:35:28 -0600
Message-Id: <1543253728-26542-3-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543253728-26542-1-git-send-email-atull@kernel.org>
References: <1543253728-26542-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatolij Gustschin <agust@denx.de>

Driver probing fails on non-dt platforms since of_match_device()
always returns NULL here. Add spi ids with device names and
matching driver data as an index of a map array with data for
supported devices. Add this map array and a function for mapping
spi ids to driver data. This allows driver binding to dynamically
added PS-SPI devices (e.g. when added via spi_new_device() after
hot-plugging).

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 33aafda..8c18bee 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -75,6 +75,12 @@ static struct altera_ps_data a10_data = {
 	.t_st2ck_us = 10, /* min(t_ST2CK) */
 };
 
+/* Array index is enum altera_ps_devtype */
+static const struct altera_ps_data *altera_ps_data_map[] = {
+	&c5_data,
+	&a10_data,
+};
+
 static const struct of_device_id of_ef_match[] = {
 	{ .compatible = "altr,fpga-passive-serial", .data = &c5_data },
 	{ .compatible = "altr,fpga-arria10-passive-serial", .data = &a10_data },
@@ -234,6 +240,22 @@ static const struct fpga_manager_ops altera_ps_ops = {
 	.write_complete = altera_ps_write_complete,
 };
 
+static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
+{
+	kernel_ulong_t devtype = id->driver_data;
+	const struct altera_ps_data *data;
+
+	/* someone added a altera_ps_devtype without adding to the map array */
+	if (devtype >= ARRAY_SIZE(altera_ps_data_map))
+		return NULL;
+
+	data = altera_ps_data_map[devtype];
+	if (!data || data->devtype != devtype)
+		return NULL;
+
+	return data;
+}
+
 static int altera_ps_probe(struct spi_device *spi)
 {
 	struct altera_ps_conf *conf;
@@ -244,11 +266,17 @@ static int altera_ps_probe(struct spi_device *spi)
 	if (!conf)
 		return -ENOMEM;
 
-	of_id = of_match_device(of_ef_match, &spi->dev);
-	if (!of_id)
-		return -ENODEV;
+	if (spi->dev.of_node) {
+		of_id = of_match_device(of_ef_match, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
+		conf->data = of_id->data;
+	} else {
+		conf->data = id_to_data(spi_get_device_id(spi));
+		if (!conf->data)
+			return -ENODEV;
+	}
 
-	conf->data = of_id->data;
 	conf->spi = spi;
 	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
@@ -294,7 +322,9 @@ static int altera_ps_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
-	{"cyclone-ps-spi", 0},
+	{ "cyclone-ps-spi", CYCLONE5 },
+	{ "fpga-passive-serial", CYCLONE5 },
+	{ "fpga-arria10-passive-serial", ARRIA10 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
-- 
2.7.4

