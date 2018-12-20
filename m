Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512212177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297663;
	bh=jZ5m6WP7W5JWf1fCzOhZvYfIDCChzV/Dkakz1e/UhvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gIthMOplUet+xJCpMoRWci4pTuTvrJcl39PJlJFgAhXIKPA9Pll8bOF9fOV3cMY1G
	 TLSCSr4sRDBTxybXhjCTr4lFNbOh2Une2eIoro18hf4KmbDOjTu//KguE6kdQhe0Vb
	 LNn/vpRmex7uC+3kUmUxhI5ZPT91vsV47e9pqsxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbeLTJVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbeLTJU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB428218C3;
        Thu, 20 Dec 2018 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297658;
        bh=jZ5m6WP7W5JWf1fCzOhZvYfIDCChzV/Dkakz1e/UhvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6zTvI8PuTR/VHjPG+yegS9E+vIr/9EMuyFI1eUJ3r/nicipOhLxOfgIpfE8b/yC3
         n26v0+DvPdL6PszmTiYI6GxDprXzTysI2fXHzIB7b3TVyw/B4W0gtHd9V/qgY8wqqB
         kgdvyqOBhSgWdbD96U9qPmUh+T59okPnd6Ig3x9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
        Andrzej Zaborowski <balrogg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 10/40] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310
Date:   Thu, 20 Dec 2018 10:18:22 +0100
Message-Id: <20181220085826.892464060@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit e8cde625bfe8a714a856e1366bcbb259d7346095 upstream.

Since v2.6.22 or so there has been reports [1] about OMAP MMC being
broken on OMAP15XX based hardware (OMAP5910 and OMAP310). The breakage
seems to have been caused by commit 46a6730e3ff9 ("mmc-omap: Fix
omap to use MMC_POWER_ON") that changed clock enabling to be done
on MMC_POWER_ON. This can happen multiple times in a row, and on 15XX
the hardware doesn't seem to like it and the MMC just stops responding.
Fix by memorizing the power mode and do the init only when necessary.

Before the patch (on Palm TE):

	mmc0: new SD card at address b368
	mmcblk0: mmc0:b368 SDC   977 MiB
	mmci-omap mmci-omap.0: command timeout (CMD18)
	mmci-omap mmci-omap.0: command timeout (CMD13)
	mmci-omap mmci-omap.0: command timeout (CMD13)
	mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
	mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
	mmcblk0: error -110 requesting status
	mmci-omap mmci-omap.0: command timeout (CMD8)
	mmci-omap mmci-omap.0: command timeout (CMD18)
	mmci-omap mmci-omap.0: command timeout (CMD13)
	mmci-omap mmci-omap.0: command timeout (CMD13)
	mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
	mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
	mmcblk0: error -110 requesting status
	mmcblk0: recovery failed!
	print_req_error: I/O error, dev mmcblk0, sector 0
	Buffer I/O error on dev mmcblk0, logical block 0, async page read
	 mmcblk0: unable to read partition table

After the patch:

	mmc0: new SD card at address b368
	mmcblk0: mmc0:b368 SDC   977 MiB
	 mmcblk0: p1

The patch is based on a fix and analysis done by Ladislav Michl.

Tested on OMAP15XX/OMAP310 (Palm TE), OMAP1710 (Nokia 770)
and OMAP2420 (Nokia N810).

[1] https://marc.info/?t=123175197000003&r=1&w=2

Fixes: 46a6730e3ff9 ("mmc-omap: Fix omap to use MMC_POWER_ON")
Reported-by: Ladislav Michl <ladis@linux-mips.org>
Reported-by: Andrzej Zaborowski <balrogg@gmail.com>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/omap.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -105,6 +105,7 @@ struct mmc_omap_slot {
 	unsigned int		vdd;
 	u16			saved_con;
 	u16			bus_mode;
+	u16			power_mode;
 	unsigned int		fclk_freq;
 
 	struct tasklet_struct	cover_tasklet;
@@ -1156,7 +1157,7 @@ static void mmc_omap_set_ios(struct mmc_
 	struct mmc_omap_slot *slot = mmc_priv(mmc);
 	struct mmc_omap_host *host = slot->host;
 	int i, dsor;
-	int clk_enabled;
+	int clk_enabled, init_stream;
 
 	mmc_omap_select_slot(slot, 0);
 
@@ -1166,6 +1167,7 @@ static void mmc_omap_set_ios(struct mmc_
 		slot->vdd = ios->vdd;
 
 	clk_enabled = 0;
+	init_stream = 0;
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_omap_set_power(slot, 0, ios->vdd);
@@ -1173,13 +1175,17 @@ static void mmc_omap_set_ios(struct mmc_
 	case MMC_POWER_UP:
 		/* Cannot touch dsor yet, just power up MMC */
 		mmc_omap_set_power(slot, 1, ios->vdd);
+		slot->power_mode = ios->power_mode;
 		goto exit;
 	case MMC_POWER_ON:
 		mmc_omap_fclk_enable(host, 1);
 		clk_enabled = 1;
 		dsor |= 1 << 11;
+		if (slot->power_mode != MMC_POWER_ON)
+			init_stream = 1;
 		break;
 	}
+	slot->power_mode = ios->power_mode;
 
 	if (slot->bus_mode != ios->bus_mode) {
 		if (slot->pdata->set_bus_mode != NULL)
@@ -1195,7 +1201,7 @@ static void mmc_omap_set_ios(struct mmc_
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
 	slot->saved_con = dsor;
-	if (ios->power_mode == MMC_POWER_ON) {
+	if (init_stream) {
 		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
 		int usecs = 250;
 
@@ -1233,6 +1239,7 @@ static int mmc_omap_new_slot(struct mmc_
 	slot->host = host;
 	slot->mmc = mmc;
 	slot->id = id;
+	slot->power_mode = MMC_POWER_UNDEFINED;
 	slot->pdata = &host->pdata->slots[id];
 
 	host->slots[id] = slot;


