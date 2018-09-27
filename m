Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476F821582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476F821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeI0PZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:25:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0PZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:25:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 404BE10A4;
        Thu, 27 Sep 2018 09:08:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 25/88] ASoC: wm9712: fix replace codec to component
Date:   Thu, 27 Sep 2018 11:03:06 +0200
Message-Id: <20180927090303.641313606@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

commit 5e4cfadaf5b73a0801b2fa7fb007f98400ebfe6e upstream.

Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
"wm9712-codec" got renamed to "wm9712-component", however, this change
never got propagated down to the actual board/platform drivers. E.g. on
Colibri T20 this lead to the following spew upon boot with sound/touch
being broken:

[    2.214121] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.222137] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.344384] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.351885] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.668339] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.675811] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.208408] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.216312] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.235397] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.248938] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[   14.970443] ALSA device list:
[   14.996628]   No soundcards found.

This commit finally fixes this again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/wm9712.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -719,7 +719,7 @@ static int wm9712_probe(struct platform_
 
 static struct platform_driver wm9712_component_driver = {
 	.driver = {
-		.name = "wm9712-component",
+		.name = "wm9712-codec",
 	},
 
 	.probe = wm9712_probe,


