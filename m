Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A34FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FA020883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976035;
	bh=8keGdUdHxyAwXdHv2afyW1Cww0fg2opklaYeqLCoSMg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vs9NtbHjjeEts2dWWE5gP5JEd+osWJYUBxGE3ld27tN0RYYsVoSm4iuhKXkb5T1tW
	 CuX8NiQ4AqIFUhrF3yTpVZbdN30Uw+e63airUQ5sB5k90/RUAfR73N3UtwjVmib4dM
	 RU2J3yaJa/fzIGhrDgXSz+tYUGwE4dvtXozpEiM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfAHTdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731817AbfAHTdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3802205C9;
        Tue,  8 Jan 2019 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976030;
        bh=8keGdUdHxyAwXdHv2afyW1Cww0fg2opklaYeqLCoSMg=;
        h=From:To:Cc:Subject:Date:From;
        b=fWRCrROsNX0Yu0iuD2bVnrnVI3wIpdYvDiKlMJ1VFY0yqBel/tGIZK3xFM6edIKXz
         DjBNmqg0WmSV3Hqhe0/zbUEKSwHx8U8ZYnBno/5G8qP5tj6jg+TE127VBdWxouLA5a
         oSd/t3na7QppGW27Qnf9mCxl9mm5vMKp+jxq/F/E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/36] platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey
Date:   Tue,  8 Jan 2019 14:33:13 -0500
Message-Id: <20190108193348.123880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: João Paulo Rechi Vita <jprvita@gmail.com>

[ Upstream commit 78f3ac76d9e5219589718b9e4733bee21627b3f5 ]

In the past, Asus firmwares would change the panel backlight directly
through the EC when the display off hotkey (Fn+F7) was pressed, and
only notify the OS of such change, with 0x33 when the LCD was ON and
0x34 when the LCD was OFF. These are currently mapped to
KEY_DISPLAYTOGGLE and KEY_DISPLAY_OFF, respectively.

Most recently the EC on Asus most machines lost ability to toggle the
LCD backlight directly, but unless the OS informs the firmware it is
going to handle the display toggle hotkey events, the firmware still
tries change the brightness through the EC, to no effect. The end result
is a long list (at Endless we counted 11) of Asus laptop models where
the display toggle hotkey does not perform any action. Our firmware
engineers contacts at Asus were surprised that there were still machines
out there with the old behavior.

Calling WMNB(ASUS_WMI_DEVID_BACKLIGHT==0x00050011, 2) on the _WDG device
tells the firmware that it should let the OS handle the display toggle
event, in which case it will simply notify the OS of a key press with
0x35, as shown by the DSDT excerpts bellow.

 Scope (_SB)
 {
     (...)

     Device (ATKD)
     {
         (...)

         Name (_WDG, Buffer (0x28)
         {
             /* 0000 */  0xD0, 0x5E, 0x84, 0x97, 0x6D, 0x4E, 0xDE, 0x11,
             /* 0008 */  0x8A, 0x39, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66,
             /* 0010 */  0x4E, 0x42, 0x01, 0x02, 0x35, 0xBB, 0x3C, 0x0B,
             /* 0018 */  0xC2, 0xE3, 0xED, 0x45, 0x91, 0xC2, 0x4C, 0x5A,
             /* 0020 */  0x6D, 0x19, 0x5D, 0x1C, 0xFF, 0x00, 0x01, 0x08
         })
         Method (WMNB, 3, Serialized)
         {
             CreateDWordField (Arg2, Zero, IIA0)
             CreateDWordField (Arg2, 0x04, IIA1)
             Local0 = (Arg1 & 0xFFFFFFFF)

             (...)

             If ((Local0 == 0x53564544))
             {
                 (...)

                 If ((IIA0 == 0x00050011))
                 {
                     If ((IIA1 == 0x02))
                     {
                         ^^PCI0.SBRG.EC0.SPIN (0x72, One)
                         ^^PCI0.SBRG.EC0.BLCT = One
                     }

                     Return (One)
                 }
             }
             (...)
         }
         (...)
     }
     (...)
 }
 (...)

 Scope (_SB.PCI0.SBRG.EC0)
 {
     (...)

     Name (BLCT, Zero)

     (...)

     Method (_Q10, 0, NotSerialized)  // _Qxx: EC Query
     {
         If ((BLCT == Zero))
         {
             Local0 = One
             Local0 = RPIN (0x72)
             Local0 ^= One
             SPIN (0x72, Local0)
             If (ATKP)
             {
                 Local0 = (0x34 - Local0)
                 ^^^^ATKD.IANE (Local0)
             }
         }
         ElseIf ((BLCT == One))
         {
             If (ATKP)
             {
                 ^^^^ATKD.IANE (0x35)
             }
         }
     }
     (...)
 }

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ed277685da1d..10bd13b30178 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2154,7 +2154,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_backlight_init(asus);
 		if (err && err != -ENODEV)
 			goto fail_backlight;
-	}
+	} else
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
 	status = wmi_install_notify_handler(asus->driver->event_guid,
 					    asus_wmi_notify, asus);
-- 
2.19.1

