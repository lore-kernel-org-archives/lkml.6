Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB5521855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864597;
	bh=ZQb629oDc8bohg4SFlVQhlDr2ETdC6JAGp9Ry++gj+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKqYQhr9jMA1nJ47ag0DdhuhqfYclO65VXmG7EzfuYn1YaSRGgKSQ0cKN2+cjJPgW
	 GtY0RXYpk3IKZdsINSD4prOJiKTnWUQbsRKKGq6r1rUF6TVo+HEckCXVyO8kll4SGJ
	 guQyLM2i2Ywvi1y1iEgvAU4IF/A25zCGduiRj6+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfAGMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfAGMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:36:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 484EC206BB;
        Mon,  7 Jan 2019 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864594;
        bh=ZQb629oDc8bohg4SFlVQhlDr2ETdC6JAGp9Ry++gj+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1tLx8uPxM6DUkRTk+O5/2aqqNdT6/m91zUX+x8h13cWyIrTxX/y8gnyrmE3K9Duea
         tWSX5U6GFCBDeb4jERyiGktRF+GTnVRnIag9DBy5+Qsm1Wh0EJEGussXPNQQH/NIlO
         bomCRtBBcLxMq/RDfG3P1866RIvnIlmnr/LprXCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jaime=20P=C3=A9rez?= <19.jaime.91@gmail.com>
Subject: [PATCH 4.20 050/145] ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromebook Gnawty
Date:   Mon,  7 Jan 2019 13:31:27 +0100
Message-Id: <20190107104443.972407093@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 94ea56cff506c769a509c5dd87904c7fe3806a81 upstream.

The Gnawty model Chromebook uses pmc_plt_clk_0 instead of pmc_plt_clk_3
for the mclk, just like the Clapper and Swanky models.

This commit adds a DMI based quirk for this.

This fixing audio no longer working on these devices after
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
that commit fixes us unnecessary keeping unused clocks on, but in case of
the Gnawty that was breaking audio support since we were not using the
right clock in the cht_bsw_max98090_ti machine driver.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201787
Cc: stable@vger.kernel.org
Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reported-and-tested-by: Jaime Pérez <19.jaime.91@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -397,6 +397,13 @@ static const struct dmi_system_id cht_ma
 		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
 	},
 	{
+		/* Gnawty model Chromebook (Acer Chromebook CB3-111) */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Gnawty"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
 		/* Swanky model Chromebook (Toshiba Chromebook 2) */
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Swanky"),


