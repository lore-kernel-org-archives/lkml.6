Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B37AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A89E206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977328;
	bh=CG0YJwJ9X5kc358AWe//lGl78jW6aKwyC/G9mXOhmlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yuUBGHquhK4aSg6Q22QG2YXbCjcAPzL4RdRp9L35DGuqeHZk6CfSp74yDQTW2Ofu6
	 VEVxm3d0lMop7dkBuItua0t6r/Rf8QU4atttzKS2Tak0rihFTMu0c8JhPFkr7E8sUo
	 QcRoX1EcSS8jd0Anc6hakKA6LxCcg05n2+Nls9zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfAHTaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729700AbfAHTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4007C20645;
        Tue,  8 Jan 2019 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975809;
        bh=CG0YJwJ9X5kc358AWe//lGl78jW6aKwyC/G9mXOhmlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=galxYBVAYJ2eGqxKkhwHCBfUD9rcnJWPJkET4tCNejaIJtlsRVYtQpgsdc6nrCZo/
         oKAO313FPyT/t1lAuxJ5MsMqwDpBtn8FFiaqRG761CVVP7ncaIsT0osIPI30HmRtos
         OjAm73gCI0DLu7DQnToiXQgsQqzgGSZ7DY3v822Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/97] ALSA: oxfw: add support for APOGEE duet FireWire
Date:   Tue,  8 Jan 2019 14:28:23 -0500
Message-Id: <20190108192949.122407-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit fba43f454cdf9caa3185219d116bd2a6e6354552 ]

This commit adds support for APOGEE duet FireWire, launched 2007, already
discontinued. This model uses Oxford Semiconductor FW971 as its
communication engine. Below is information on Configuration ROM of this
unit. The unit supports some AV/C commands defined by Audio subunit
specification and vendor dependent commands.

$ ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'adj': False,
                'bmc': False,
                'chip_ID': 42949742248,
                'cmc': False,
                'cyc_clk_acc': 255,
                'generation': 0,
                'imc': False,
                'isc': True,
                'link_spd': 3,
                'max_ROM': 0,
                'max_rec': 64,
                'name': '1394',
                'node_vendor_ID': 987,
                'pmc': False},
  'root-directory': [ ['VENDOR', 987],
                      ['DESCRIPTOR', 'Apogee Electronics'],
                      ['MODEL', 122333],
                      ['DESCRIPTOR', 'Duet'],
                      [ 'NODE_CAPABILITIES',
                        { 'addressing': {'64': True, 'fix': True, 'prv': False},
                          'misc': {'int': False, 'ms': False, 'spt': True},
                          'state': { 'atn': False,
                                     'ded': False,
                                     'drq': True,
                                     'elo': False,
                                     'init': False,
                                     'lst': True,
                                     'off': False},
                          'testing': {'bas': False, 'ext': False}}],
                      [ 'UNIT',
                        [ ['SPECIFIER_ID', 41005],
                          ['VERSION', 65537],
                          ['MODEL', 122333],
                          ['DESCRIPTOR', 'Duet']]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/Kconfig     | 1 +
 sound/firewire/oxfw/oxfw.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 529d9f405fa9..0cb65d0864cc 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -41,6 +41,7 @@ config SND_OXFW
 	   * Mackie(Loud) U.420/U.420d
 	   * TASCAM FireOne
 	   * Stanton Controllers & Systems 1 Deck/Mixer
+	   * APOGEE duet FireWire
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 2ea8be6c8584..5f82a375725a 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -20,6 +20,7 @@
 #define VENDOR_LACIE		0x00d04b
 #define VENDOR_TASCAM		0x00022e
 #define OUI_STANTON		0x001260
+#define OUI_APOGEE		0x0003db
 
 #define MODEL_SATELLITE		0x00200f
 
@@ -436,6 +437,13 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.vendor_id	= OUI_STANTON,
 		.model_id	= 0x002000,
 	},
+	// APOGEE, duet FireWire
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_APOGEE,
+		.model_id	= 0x01dddd,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
2.19.1

