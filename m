Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0660C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE13121902
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358100;
	bh=2mzWcXgTUuaI6DdvRgb4N2EBbs69OgzVSvVT81vbenc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7ExpVVAoKKQrwqFs4qjX1uknaLKj3Ahj9VkrBkI9ze4DalcANiJv/D6vX/pA6cZA
	 D3FZ5y+gNVt3EBDZILoA5uCLJhz8sdl3XUg0ZLldk4jnbKmIJ1vk7pE/NyEV34+EXY
	 Z/gVDVTYDIGumyQjanU906D4wvEwO+X2gK4whPQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfAXT2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:28:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbfAXT2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEAE1218FC;
        Thu, 24 Jan 2019 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358094;
        bh=2mzWcXgTUuaI6DdvRgb4N2EBbs69OgzVSvVT81vbenc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9e0jE4BzASlUQmog+605ILZ58C95pEVKOUyrdZg+6kKhxrMa2NOj3hYL9IXHbimV
         jVYRqLKtTp7QGOFtQkSnvfM1HIitTH2LhkaG6ENsGJd7nR4NR5RdqO3kvTBHX3hMlj
         Pa4HL+Z/Ruv7TLn5t/BnhccEduuZ4f/Yxe4lYruA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 097/104] ALSA: bebob: fix model-id of unit for Apogee Ensemble
Date:   Thu, 24 Jan 2019 20:20:26 +0100
Message-Id: <20190124190205.436087701@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 644b2e97405b0b74845e1d3c2b4fe4c34858062b ]

This commit fixes hard-coded model-id for an unit of Apogee Ensemble with
a correct value. This unit uses DM1500 ASIC produced ArchWave AG (formerly
known as BridgeCo AG).

I note that this model supports three modes in the number of data channels
in tx/rx streams; 8 ch pairs, 10 ch pairs, 18 ch pairs. The mode is
switched by Vendor-dependent AV/C command, like:

$ cd linux-firewire-utils
$ ./firewire-request /dev/fw1 fcp 0x00ff000003dbeb0600000000 (8ch pairs)
$ ./firewire-request /dev/fw1 fcp 0x00ff000003dbeb0601000000 (10ch pairs)
$ ./firewire-request /dev/fw1 fcp 0x00ff000003dbeb0602000000 (18ch pairs)

When switching between different mode, the unit disappears from IEEE 1394
bus, then appears on the bus with different combination of stream formats.
In a mode of 18 ch pairs, available sampling rate is up to 96.0 kHz, else
up to 192.0 kHz.

$ ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'adj': False,
                'bmc': True,
                'chip_ID': 21474898341,
                'cmc': True,
                'cyc_clk_acc': 100,
                'generation': 2,
                'imc': True,
                'isc': True,
                'link_spd': 2,
                'max_ROM': 1,
                'max_rec': 512,
                'name': '1394',
                'node_vendor_ID': 987,
                'pmc': False},
  'root-directory': [ ['HARDWARE_VERSION', 19],
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
                      ['VENDOR', 987],
                      ['DESCRIPTOR', 'Apogee Electronics'],
                      ['MODEL', 126702],
                      ['DESCRIPTOR', 'Ensemble'],
                      ['VERSION', 5297],
                      [ 'UNIT',
                        [ ['SPECIFIER_ID', 41005],
                          ['VERSION', 65537],
                          ['MODEL', 126702],
                          ['DESCRIPTOR', 'Ensemble']]],
                      [ 'DEPENDENT_INFO',
                        [ ['SPECIFIER_ID', 2037],
                          ['VERSION', 1],
                          [(58, 'IMMEDIATE'), 16777159],
                          [(59, 'IMMEDIATE'), 1048576],
                          [(60, 'IMMEDIATE'), 16777159],
                          [(61, 'IMMEDIATE'), 6291456]]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/bebob/bebob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 091290d1f3ea..1898fa4228ad 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -382,7 +382,7 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* Apogee Electronics, DA/AD/DD-16X (X-FireWire card) */
 	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048, &spec_normal),
 	/* Apogee Electronics, Ensemble */
-	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00001eee, &spec_normal),
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x01eeee, &spec_normal),
 	/* ESI, Quatafire610 */
 	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064, &spec_normal),
 	/* AcousticReality, eARMasterOne */
-- 
2.19.1



