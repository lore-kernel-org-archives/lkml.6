Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7DC2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qccQphSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7DC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbeK3B3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731418AbeK3B3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 808CE205C9;
        Thu, 29 Nov 2018 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501463;
        bh=W8kEC3KMC83Ryma53O4WoY+/r7KX83LowkTFnUHV+oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qccQphSGboD/Fmi4IZY9K29EYsjht82g7z2UbSjE376pIPhkP0zd3ePFSy8ioRuqU
         3n6RliKVrXN32iMXVB1S1dDN4R8gyKh3D5fV9dFmnjFj99TGK0/WCQNoUtBU7IT9zS
         mhz3my93CVo4CuSYcBLyefo1wL2WoEvb3lDx/F6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>,
        Benjamin Valentin <benpicco@googlemail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 58/92] Input: xpad - sync supported devices with 360Controller
Date:   Thu, 29 Nov 2018 15:12:27 +0100
Message-Id: <20181129140111.075191454@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c225370e01b87d3c4ef40d98295ac0bb1e5a3116 ]

360Controller [0] is an OpenSource driver for Xbox/Xbox360/XboxOne
controllers on macOS.

It contains a couple device IDs unknown to the Linux driver, so I wrote a
small Python script [1] to extract them and feed them into my previous
script [2] to compare them with the IDs known to Linux.

For most devices, this information is not really needed as xpad is able to
automatically detect the type of an unknown Xbox Controller at run-time.
I've therefore stripped all the generic/vague entries.

I've excluded the Logitech G920, it's handled by a HID driver already.
I've also excluded the Scene It! Big Button IR, it's handled by an
out-of-tree driver. [3]

[0] https://github.com/360Controller/360Controller
[1] http://codepad.org/v9GyLKMq
[2] http://codepad.org/qh7jclpD
[3] https://github.com/micolous/xbox360bb

Reviewed-by: Cameron Gutman <aicommander@gmail.com>
Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index def96cd2479b..b8d08f2296ff 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -131,8 +131,10 @@ static const struct xpad_device {
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
+	{ 0x045e, 0x0288, "Microsoft Xbox Controller S v2", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
+	{ 0x045e, 0x028f, "Microsoft X-Box 360 pad v2", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
@@ -145,6 +147,7 @@ static const struct xpad_device {
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
+	{ 0x046d, 0xcaa3, "Logitech DriveFx Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x056e, 0x2004, "Elecom JC-U3613M", 0, XTYPE_XBOX360 },
 	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX },
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
@@ -158,14 +161,19 @@ static const struct xpad_device {
 	{ 0x0738, 0x4718, "Mad Catz Street Fighter IV FightStick SE", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4726, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4728, "Mad Catz Street Fighter IV FightPad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0738, 0x4736, "Mad Catz MicroCon Gamepad", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0x4740, "Mad Catz Beat Pad", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0x4758, "Mad Catz Arcade Game Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0x4a01, "Mad Catz FightStick TE 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x0738, 0x9871, "Mad Catz Portable Drum", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xb726, "Mad Catz Xbox controller - MW2", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0xb738, "Mad Catz MVC2TE Stick 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0xbeef, "Mad Catz JOYTECH NEO SE Advanced GamePad", XTYPE_XBOX360 },
 	{ 0x0738, 0xcb02, "Saitek Cyborg Rumble Pad - PC/Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xcb03, "Saitek P3200 Rumble Pad - PC/Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0xcb29, "Saitek Aviator Stick AV8R02", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xf738, "Super SFIV FightStick TE S", 0, XTYPE_XBOX360 },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", DANCEPAD_MAP_CONFIG, XTYPE_XBOX },
@@ -181,30 +189,52 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0105, "HSM3 Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0113, "Afterglow AX.1 Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x011f, "Rock Candy Gamepad Wired Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0131, "PDP EA Sports Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0133, "Xbox 360 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0139, "Afterglow Prismatic Wired Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x013a, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0146, "Rock Candy Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0147, "PDP Marvel Xbox One Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x015c, "PDP Xbox One Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0161, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0162, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0163, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0164, "PDP Battlefield One", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0165, "PDP Titanfall 2", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0201, "Pelican PL-3601 'TSZ' Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0413, "Afterglow AX.1 Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0x0501, "PDP Xbox 360 Controller", 0, XTYPE_XBOX360 },
+	{ 0x0e6f, 0xf900, "PDP Afterglow AX.1", 0, XTYPE_XBOX360 },
 	{ 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", 0, XTYPE_XBOX },
 	{ 0x0e8f, 0x3008, "Generic xbox control (dealextreme)", 0, XTYPE_XBOX },
 	{ 0x0f0d, 0x000a, "Hori Co. DOA4 FightStick", 0, XTYPE_XBOX360 },
+	{ 0x0f0d, 0x000c, "Hori PadEX Turbo", 0, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x000d, "Hori Fighting Stick EX2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0f0d, 0x001b, "Hori Real Arcade Pro VX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x0f0d, 0x0063, "Hori Real Arcade Pro Hayabusa (USA) Xbox One", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
+	{ 0x0f0d, 0x0078, "Hori Real Arcade Pro V Kai Xbox One", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
 	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", 0, XTYPE_XBOX },
+	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
+	{ 0x12ab, 0x0303, "Mortal Kombat Klassic FightStick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", 0, XTYPE_XBOX360 },
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
+	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
@@ -215,22 +245,42 @@ static const struct xpad_device {
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0x0130, "Ion Drum Rocker", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf016, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf018, "Mad Catz Street Fighter IV SE Fighting Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf019, "Mad Catz Brawlstick for Xbox 360", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf021, "Mad Cats Ghost Recon FS GamePad", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf023, "MLG Pro Circuit Controller (Xbox)", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf025, "Mad Catz Call Of Duty", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf027, "Mad Catz FPS Pro", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf028, "Street Fighter IV FightPad", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf02e, "Mad Catz Fightpad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf038, "Street Fighter IV FightStick TE", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf039, "Mad Catz MvC2 TE", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf03a, "Mad Catz SFxT Fightstick Pro", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf03d, "Street Fighter IV Arcade Stick TE - Chun Li", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf03e, "Mad Catz MLG FightStick TE", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf03f, "Mad Catz FightStick SoulCaliber", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf042, "Mad Catz FightStick TES+", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf080, "Mad Catz FightStick TE2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf501, "HoriPad EX2 Turbo", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf502, "Hori Real Arcade Pro.VX SA", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf503, "Hori Fighting Stick VX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf504, "Hori Real Arcade Pro. EX", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf505, "Hori Fighting Stick EX2B", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf506, "Hori Real Arcade Pro.EX Premium VLX", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf900, "Harmonix Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf901, "Gamestop Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xf903, "Tron Xbox 360 controller", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf904, "PDP Versus Fighting Pad", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xf906, "MortalKombat FightStick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x1bad, 0xfa01, "MadCatz GamePad", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
+	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5000, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5300, "PowerA MINI PROEX Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5303, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x530a, "Xbox 360 Pro EX Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x531a, "PowerA Pro Ex", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5397, "FUS1ON Tournament Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x541a, "PowerA Xbox One Mini Wired Controller", 0, XTYPE_XBOXONE },
@@ -238,12 +288,18 @@ static const struct xpad_device {
 	{ 0x24c6, 0x543a, "PowerA Xbox One wired controller", 0, XTYPE_XBOXONE },
 	{ 0x24c6, 0x5500, "Hori XBOX 360 EX 2 with Turbo", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5501, "Hori Real Arcade Pro VX-SA", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x5502, "Hori Fighting Stick VX Alt", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5503, "Hori Fighting Edge", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5506, "Hori SOULCALIBUR V Stick", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x550d, "Hori GEM Xbox controller", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0x550e, "Hori Real Arcade Pro V Kai 360", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+	{ 0x24c6, 0x551a, "PowerA FUSION Pro Controller", 0, XTYPE_XBOXONE },
+	{ 0x24c6, 0x561a, "PowerA FUSION Controller", 0, XTYPE_XBOXONE },
+	{ 0x24c6, 0x5b00, "ThrustMaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5b02, "Thrustmaster, Inc. GPX Controller", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
 	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
 };
@@ -338,6 +394,7 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
+	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
-- 
2.17.1



