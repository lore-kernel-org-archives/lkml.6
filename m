Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1026217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297774;
	bh=EwowOeuAQQdDGRKIWiLBKc8YLv+5YxZRknfLTOrPDxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kk9DpvnTho03kBrwvUaB1KKVziXbJ59uUKTd+oGEfxw9rIMiT6mnWdldazGghU0r3
	 92B0/QO7qFv4qnF0LnA6qPlhcM4m4xqdvm/CHLw773+l6ASleqar1UnSqX05Xk8iUx
	 QqnNQ8mOzUWGQydQ25651ZvEhCGZ+d43cP/zmNdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbeLTJWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730050AbeLTJWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6543620656;
        Thu, 20 Dec 2018 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297768;
        bh=EwowOeuAQQdDGRKIWiLBKc8YLv+5YxZRknfLTOrPDxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EExEgyduZN3Y32lJR0ATCUfbcrKYdbjXdAoTqr/nP2Zysb1uDoeRJP4avoPbIaZsy
         8FhcWDx0CrjOCs+VEGUSZp5X2NEcxwKHvx+5l2aW/UD7sO/TujkKcOJYLpaUADO98k
         a6GWMz6WBDwShGbYGsvHatKzmUz1RJf9LfKrS8s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
        Andrzej Zaborowski <balrogg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 10/61] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310
Date:   Thu, 20 Dec 2018 10:18:10 +0100
Message-Id: <20181220085844.140650279@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -104,6 +104,7 @@ struct mmc_omap_slot {
 	unsigned int		vdd;
 	u16			saved_con;
 	u16			bus_mode;
+	u16			power_mode;
 	unsigned int		fclk_freq;
 
 	struct tasklet_struct	cover_tasklet;
@@ -1157,7 +1158,7 @@ static void mmc_omap_set_ios(struct mmc_
 	struct mmc_omap_slot *slot = mmc_priv(mmc);
 	struct mmc_omap_host *host = slot->host;
 	int i, dsor;
-	int clk_enabled;
+	int clk_enabled, init_stream;
 
 	mmc_omap_select_slot(slot, 0);
 
@@ -1167,6 +1168,7 @@ static void mmc_omap_set_ios(struct mmc_
 		slot->vdd = ios->vdd;
 
 	clk_enabled = 0;
+	init_stream = 0;
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_omap_set_power(slot, 0, ios->vdd);
@@ -1174,13 +1176,17 @@ static void mmc_omap_set_ios(struct mmc_
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
@@ -1196,7 +1202,7 @@ static void mmc_omap_set_ios(struct mmc_
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
 	slot->saved_con = dsor;
-	if (ios->power_mode == MMC_POWER_ON) {
+	if (init_stream) {
 		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
 		int usecs = 250;
 
@@ -1234,6 +1240,7 @@ static int mmc_omap_new_slot(struct mmc_
 	slot->host = host;
 	slot->mmc = mmc;
 	slot->id = id;
+	slot->power_mode = MMC_POWER_UNDEFINED;
 	slot->pdata = &host->pdata->slots[id];
 
 	host->slots[id] = slot;


