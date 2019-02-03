Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355EAC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E419218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfBCNzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:55:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54484 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728995AbfBCNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEK-0003wN-Cv; Sun, 03 Feb 2019 13:54:40 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9p-0007NI-Vl; Sun, 03 Feb 2019 14:50:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Tony Lindgren" <tony@atomide.com>,
        "Ladislav Michl" <ladis@linux-mips.org>,
        "Andrzej Zaborowski" <balrogg@gmail.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.582290100@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 259/305] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16: Set initial state to MMC_POWER_OFF instead of
 MMC_POWER_UNDEFINED]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/host/omap.c | 11 +++++++++--
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
@@ -1155,7 +1156,7 @@ static void mmc_omap_set_ios(struct mmc_
 	struct mmc_omap_slot *slot = mmc_priv(mmc);
 	struct mmc_omap_host *host = slot->host;
 	int i, dsor;
-	int clk_enabled;
+	int clk_enabled, init_stream;
 
 	mmc_omap_select_slot(slot, 0);
 
@@ -1165,6 +1166,7 @@ static void mmc_omap_set_ios(struct mmc_
 		slot->vdd = ios->vdd;
 
 	clk_enabled = 0;
+	init_stream = 0;
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_omap_set_power(slot, 0, ios->vdd);
@@ -1172,13 +1174,17 @@ static void mmc_omap_set_ios(struct mmc_
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
@@ -1194,7 +1200,7 @@ static void mmc_omap_set_ios(struct mmc_
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
 	slot->saved_con = dsor;
-	if (ios->power_mode == MMC_POWER_ON) {
+	if (init_stream) {
 		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
 		int usecs = 250;
 
@@ -1232,6 +1238,7 @@ static int mmc_omap_new_slot(struct mmc_
 	slot->host = host;
 	slot->mmc = mmc;
 	slot->id = id;
+	slot->power_mode = MMC_POWER_OFF;
 	slot->pdata = &host->pdata->slots[id];
 
 	host->slots[id] = slot;

