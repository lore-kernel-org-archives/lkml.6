Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC66EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A22208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ORu7gLbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A22208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934633AbeFRMAB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44644 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeFRL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=blTsMbSXb8QHJtXpxEo7TVTYN138dohaDH+uE/aO4PI=; b=ORu7gLbnoLh9
        OU5tmnuN8Rd2pujRM8giYApnjFi2mclkHN/Cm7iEvlHQ8XT3pXFrdmV2KrlecKqEygJp6JMZwEB/D
        M++QStFBI3RuqQ9hjVojrFVducQHsInC610SsRUjIcMe5FfFOisPJ41a/mi2SfrmCv9rqrG8AZAax
        RdrDs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsp0-0007wB-Qt; Mon, 18 Jun 2018 11:59:46 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsp0-0008P8-DO; Mon, 18 Jun 2018 12:59:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: PCM1789: unconditionally flush work" to the asoc tree
In-Reply-To:  <20180617134532.1070-1-stefan@agner.ch>
Message-Id: <E1fUsp0-0008P8-DO@debutante>
Date:   Mon, 18 Jun 2018 12:59:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: PCM1789: unconditionally flush work

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

From a7dc662c6a7b9209df600c64b16d33d72dbf56b1 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Sun, 17 Jun 2018 15:45:29 +0200
Subject: [PATCH] ASoC: codecs: PCM1789: unconditionally flush work

Work is guaranteed to be initialized on exit. Drop the unnecessary
if statement and always call flush_work.

This fixes a warning seen with clang:
sound/soc/codecs/pcm1789.c:265:13: warning: address of 'priv->work' will
      always evaluate to 'true' [-Wpointer-bool-conversion]
        if (&priv->work)
        ~~   ~~~~~~^~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm1789.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
index 21f15219b3ad..8df6447c76a6 100644
--- a/sound/soc/codecs/pcm1789.c
+++ b/sound/soc/codecs/pcm1789.c
@@ -262,8 +262,7 @@ int pcm1789_common_exit(struct device *dev)
 {
 	struct pcm1789_private *priv = dev_get_drvdata(dev);
 
-	if (&priv->work)
-		flush_work(&priv->work);
+	flush_work(&priv->work);
 
 	return 0;
 }
-- 
2.17.1

