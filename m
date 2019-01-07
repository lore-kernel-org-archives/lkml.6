Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D16AC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342D20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865498;
	bh=Yd+/+7uQbII7zENUX5E6hinMLCoAVz18e64hTnSPAv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0w5K+oTHuS7N9bfhvMGfHZDoMQ0eHbRDniRY+5NUkt2hzICwIImi92HMtjfoJzc3b
	 2kdfdCd8hrP08WC6GZmnIdgyF60ZXCWLEnANOIoisdxmil7yR4hInREvVDxNJ8lmfu
	 3cbfQ5rt0K3TjegTwMSGATiAjPSdxnEFjmrxvMUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfAGMvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbfAGMvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:51:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C52206BB;
        Mon,  7 Jan 2019 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865494;
        bh=Yd+/+7uQbII7zENUX5E6hinMLCoAVz18e64hTnSPAv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWyJWjZAYid0TtkZL6HPObT2LaUhdI9h5/lMncHof3OcMCh8oAVQlnJZuctBWY7Cb
         aqh0UQKwgPULPvzO9KibbhlA0fneMuoKCXXxMztqTwXBiKxjQFheEv4+CQepP+cOQg
         DAFlUNA0Dy4LrvtA9Ck6N9fS1MJsWXAcSz/ImdFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 085/170] ASoC: intel: cht_bsw_max98090_ti: Add pmc_plt_clk_0 quirk for Chromebook Clapper
Date:   Mon,  7 Jan 2019 13:31:52 +0100
Message-Id: <20190107104503.056297937@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 984bfb398a3af6fa9b7e80165e524933b0616686 upstream.

The Clapper model Chromebook uses pmc_plt_clk_0 instead of pmc_plt_clk_3
for the mclk, just like the Swanky model.

This commit adds a DMI based quirk for this.

This fixing audio no longer working on these devices after
commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
that commit fixes us unnecessary keeping unused clocks on, but in case of
the Clapper that was breaking audio support since we were not using the
right clock in the cht_bsw_max98090_ti machine driver.

Cc: stable@vger.kernel.org
Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -390,6 +390,13 @@ static struct snd_soc_card snd_soc_card_
 
 static const struct dmi_system_id cht_max98090_quirk_table[] = {
 	{
+		/* Clapper model Chromebook */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Clapper"),
+		},
+		.driver_data = (void *)QUIRK_PMC_PLT_CLK_0,
+	},
+	{
 		/* Swanky model Chromebook (Toshiba Chromebook 2) */
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Swanky"),


