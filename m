Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560F20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YOiGHZ9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeIFPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:45:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeIFPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fmLorZLHWkixDREH4GEjpa/Ss2b+md0qV3Zj1AMqMqo=; b=YOiGHZ9kQ2fr
        yD+xw/MY2hWdPeiou0k3ksztroDhDtrvbzhQ2qCyatkLJVHeXAXG7a691WuQPAWpTJdZcy1WP1qMK
        IIUuCvSKpNqcOdVlOdbBwWU/oLf/47oOJdkxj3AEXMToZgy99C52IVPiHhD6kT7G+jDEzZyk+ob3Q
        1GYFA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxsAe-0004Ap-6v; Thu, 06 Sep 2018 11:09:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ED53D1122A1F; Thu,  6 Sep 2018 12:09:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sgtl5000: avoid division by zero if lo_vag is zero" to the asoc tree
In-Reply-To:  <20180906104152.17977-1-colin.king@canonical.com>
Message-Id: <20180906110955.ED53D1122A1F@debutante.sirena.org.uk>
Date:   Thu,  6 Sep 2018 12:09:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sgtl5000: avoid division by zero if lo_vag is zero

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

From 9ab708aef61f5620113269a9d1bdb1543d1207d0 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 6 Sep 2018 11:41:52 +0100
Subject: [PATCH] ASoC: sgtl5000: avoid division by zero if lo_vag is zero

In the case where lo_vag <= SGTL5000_LINE_OUT_GND_BASE, lo_vag
is set to zero and later vol_quot is computed by dividing by
lo_vag causing a division by zero error.  Fix this by avoiding
a zero division and set vol_quot to zero in this specific case
so that the lowest setting for i is correctly set.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 60764f6201b1..add18d6d77da 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1218,7 +1218,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_component *component)
 	 * Searching for a suitable index solving this formula:
 	 * idx = 40 * log10(vag_val / lo_cagcntrl) + 15
 	 */
-	vol_quot = (vag * 100) / lo_vag;
+	vol_quot = lo_vag ? (vag * 100) / lo_vag : 0;
 	lo_vol = 0;
 	for (i = 0; i < ARRAY_SIZE(vol_quot_table); i++) {
 		if (vol_quot >= vol_quot_table[i])
-- 
2.19.0.rc1

