Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B42C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFF5204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791234;
	bh=YSec+Rm0Fxia5Fn9XFaxxBG8WAuBnbHwcipAgFPb9zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BnzcB/Wd1UYDVhnDXUHEaE6WOtMQbe3mIfXwxZtQz2xgqXx1ixwCDbxFETe5dxxVF
	 BH81bW2wjtgvAEhLx2hOyM8ab8kPjTqDESMylbhAn3wnqayPwuKCwhbbkkCdlCC3Z1
	 9d4kPH9fW5ceLVyC/lDaSF+QJrAewOE31MoBqr74=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFF5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeLNMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbeLNMEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B3C82146F;
        Fri, 14 Dec 2018 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789044;
        bh=YSec+Rm0Fxia5Fn9XFaxxBG8WAuBnbHwcipAgFPb9zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ybtw13mecLXGEMseuW0KRhcJXuAdOVECErlxRuFLWj1D6Yq4tgwEwKLaceAvGa6/4
         e+9iMyZVF5HQUG/j2E3cQhxr/0daWia9AEKqkigfjpTTMUopED1lclCEQM5GEsk7en
         pTQDvsb2TMt8sJAIW894EJ/SAKXWzLDikY3pc1g8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/142] ASoC: Intel: Power down links before turning off display audio power
Date:   Fri, 14 Dec 2018 12:58:55 +0100
Message-Id: <20181214115749.061464808@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 4c10473d6ddf12ec124c9ff71a5d23bb5388478b ]

On certain platforms, Display HDMI HDA codec was not going to sleep state
after the use when links are powered down after turning off the display
power. As per the HW recommendation, links are powered down before turning
off the display power to ensure that the codec goes to sleep state.

This patch was updated from an earlier version submitted upstream [1]
which conflicted with the changes merged for HDaudio codec support
with the Intel DSP.

[1] https://patchwork.kernel.org/patch/10540213/

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c  | 11 +++++------
 sound/soc/intel/skylake/skl.c | 12 ++++++------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7b8533abf637..b61d518f4fef 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2184,11 +2184,6 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 	 */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D3);
-	err = snd_hdac_display_power(bus, false);
-	if (err < 0) {
-		dev_err(dev, "Cannot turn on display power on i915\n");
-		return err;
-	}
 
 	hlink = snd_hdac_ext_bus_get_link(bus, dev_name(dev));
 	if (!hlink) {
@@ -2198,7 +2193,11 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
-	return 0;
+	err = snd_hdac_display_power(bus, false);
+	if (err < 0)
+		dev_err(dev, "Cannot turn off display power on i915\n");
+
+	return err;
 }
 
 static int hdac_hdmi_runtime_resume(struct device *dev)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1d17be0f78a0..50f16a0f6535 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -752,6 +752,12 @@ static void skl_probe_work(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * we are done probing so decrement link counts
+	 */
+	list_for_each_entry(hlink, &bus->hlink_list, list)
+		snd_hdac_ext_bus_link_put(bus, hlink);
+
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
 		if (err < 0) {
@@ -761,12 +767,6 @@ static void skl_probe_work(struct work_struct *work)
 		}
 	}
 
-	/*
-	 * we are done probing so decrement link counts
-	 */
-	list_for_each_entry(hlink, &bus->hlink_list, list)
-		snd_hdac_ext_bus_link_put(bus, hlink);
-
 	/* configure PM */
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
-- 
2.19.1



