Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0163FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81C72082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LcniHwSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81C72082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeKNE1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:27:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33208 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKNE1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CSLfmtmD7dMvDMMGq+Qg09rE35dIWaRdIL4w7XAT5us=; b=LcniHwSnKIiH
        zeIUxOw4flz0hrwqYQ9bHNubtyz29Qts7PFUoMQiQpQVO+EU3jj3EO4iV8a/FwfnrwQrjaM9avcre
        qBnU4Ycs9OCDff8vggmaNvUuowFHM4aYUDnABByFlnLUeC8dZ11odc+FRubFPGQNMQF+frucCE290
        zw0F8=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMdQ0-0002Ns-R5; Tue, 13 Nov 2018 18:28:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C98BA440078; Tue, 13 Nov 2018 18:28:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm_adsp: Factor out common init code" to the asoc tree
In-Reply-To:  <20181112133639.13444-2-rf@opensource.cirrus.com>
Message-Id: <20181113182802.C98BA440078@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 18:28:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm_adsp: Factor out common init code

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From dcad34f818f2a23b9a51c7c2a21e167fff441e52 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Mon, 12 Nov 2018 13:36:39 +0000
Subject: [PATCH] ASoC: wm_adsp: Factor out common init code

Factor out the duplicated initialization statements from
wm_adsp1_init() and wm_adsp2_init() into new function
wm_adsp_common_init().

The entire content of wm_adsp1_init() is the common code
but it is convenient to retain this exported function
to hide what we currently treat as common init (which might
change in the future) and also make clear the difference
between an ADSP1 entry point and common code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a53dc174bbf0..0ed44e5c58f7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2416,7 +2416,7 @@ static int wm_adsp_create_name(struct wm_adsp *dsp)
 	return 0;
 }
 
-int wm_adsp1_init(struct wm_adsp *dsp)
+static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
 	int ret;
 
@@ -2425,11 +2425,17 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 		return ret;
 
 	INIT_LIST_HEAD(&dsp->alg_regions);
+	INIT_LIST_HEAD(&dsp->ctl_list);
 
 	mutex_init(&dsp->pwr_lock);
 
 	return 0;
 }
+
+int wm_adsp1_init(struct wm_adsp *dsp)
+{
+	return wm_adsp_common_init(dsp);
+}
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
 
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
@@ -2914,7 +2920,7 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
-	ret = wm_adsp_create_name(dsp);
+	ret = wm_adsp_common_init(dsp);
 	if (ret)
 		return ret;
 
@@ -2936,12 +2942,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 		break;
 	}
 
-	INIT_LIST_HEAD(&dsp->alg_regions);
-	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
-	mutex_init(&dsp->pwr_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
-- 
2.19.1

