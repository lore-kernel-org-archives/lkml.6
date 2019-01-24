Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E10C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36EF218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358209;
	bh=UGTDyMf07w+YPycs4BffwGdittFxvPdzcsZt9sBmmKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAfC1Wz1dpnV/R01YSTCjQjNdN8rsIOIslyePU2/C3xvXQmxHaw59DzZCb6pitDsZ
	 X5OPmCBUhI8fQQcTr6xBLIsZ0QoGBQ9vPW/6TDJsaMcrj5ZY590rXLLK9jgRZOPnPz
	 6e7SuWz+Tcrf7HNGGfjJg0QI8O/oFI+9XC6jbTns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfAXTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:30:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbfAXTaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:30:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9294218D4;
        Thu, 24 Jan 2019 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358204;
        bh=UGTDyMf07w+YPycs4BffwGdittFxvPdzcsZt9sBmmKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bot6G4mYUb4SUlCH++KEaaLJ89eq5+1BIjAtwLPXd8o7qsRTAA691R8G6toGKLZKX
         rNYngYABIXyLKsJWNXbb1VP3FUj1P3Pdlj9sF4JR0bETj5ybaRzQkXkSKv56J2tbf5
         oAzKCm8YGOuGkrdnd8rimwOYJnMEHvAbx2BWEFz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/39] ALSA: oxfw: add support for APOGEE duet FireWire
Date:   Thu, 24 Jan 2019 20:20:11 +0100
Message-Id: <20190124190448.526288968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
References: <20190124190448.232316246@linuxfoundation.org>
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
index ab894ed1ff67..8557e54d2659 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -40,6 +40,7 @@ config SND_OXFW
 	   * Mackie(Loud) U.420/U.420d
 	   * TASCAM FireOne
 	   * Stanton Controllers & Systems 1 Deck/Mixer
+	   * APOGEE duet FireWire
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 696b6cf35003..b0395c4209ab 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -20,6 +20,7 @@
 #define VENDOR_LACIE		0x00d04b
 #define VENDOR_TASCAM		0x00022e
 #define OUI_STANTON		0x001260
+#define OUI_APOGEE		0x0003db
 
 #define MODEL_SATELLITE		0x00200f
 
@@ -441,6 +442,13 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
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



