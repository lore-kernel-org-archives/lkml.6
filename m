Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeFELeb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:34:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeFELe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:34:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: radio: aimslab: restore RADIO_ISA dependency
Date: Tue,  5 Jun 2018 13:33:21 +0200
Message-Id: <20180605113420.1092324-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:YL1zofV+O2bUHkPx3Qx+MmYIXh4gpOYSUsFrKhEsoK47XOr3feJ
 CikXLBfHFYn5pwG1F0sYcTu05mv7WLBRPRNkzxMkuJ9VmNqqybjPcVOisDB3ynxDwJvRdLB
 7XggkZ1D56XCmBFY96bPa15r3+lQssF6uTFhzCowhzWdKhzke82+WoZtzbRdhC3YkhX5D3M
 wLHKvy1+0BnvtuL4cApvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NlAG5jlho2Y=:l+MSBV8pvbTcCnKOCHXRSA
 S+asyt3zmU5HjKlLniZN19825Vo3HuWcbNpX3pIfRr3v8d/SmVmOAufKnk5hdWpS/rA+bEG6T
 tMt2h71dM4o2VgejFIneKWCjCcnnZgbZhIlMzEX6WDFlXRTquXnQqGoG4BZfv70z1JB3QaZqo
 S/6XtMC4POTmMOD1GfhH4iiNBvFHp/NbY2RofPa/sERgc9VH3JPZkTfQCPtYqM9gSOM7Hqevs
 Jh/Bu7PI070pAGi2/gfhaT/KbZcSLO9KRLXo9rt5nku6dgfzJf/M/SahRBZAN4rcEfhfgZsFY
 5IHpYlcE2m/RJOSohu7X5xBDoKrJqrEl9dfDY369bzxqUN8Y6qkleG9fDGVxy048tDVY/+y7t
 gSQRRGQlvul0KwZ7SmFL1FO7aylonQQH/cqTA/za2A9iGzS9gm2FQizuoUS7Nmr4L+PLR27Vy
 4iIiV56hxsf+85STgJHrkOAhSMj8EEbZZ65zroUg6TmORLkKb9LLEKFQeGiZoYGSpntk6AN3J
 NupZiyDU2PXdw61acUiNl3cL4U4mGE8eOAx1eWqaXaQffyrIifi1HbsT19/1l0Nd+o6tJ5UU6
 aEa5oYuUt0FaVjWeywsa1JXPGKYUWtqSu60J8KlUbdP6XGb3vMfyvBXAONp38aSX11h9JbMZn
 ZECD2NhMKhjker2YDHaawuyQ2k0ndFQIEWBJWsAx4L4iMHWDzdXevsmjuBLiwst5QDo8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that allowed all the ISA drivers to build across architectures
accidentally removed one 'select' statement, which now causes a rare
randconfig build failure in case all the other drivers are disabled:

drivers/media/radio/radio-aimslab.o:(.data+0x0): undefined reference to `radio_isa_match'
drivers/media/radio/radio-aimslab.o:(.data+0x4): undefined reference to `radio_isa_probe'
drivers/media/radio/radio-aimslab.o:(.data+0x8): undefined reference to `radio_isa_remove'

This puts the statement back where it belongs.

Fixes: 258c524bdaab ("media: radio: allow building ISA drivers with COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/radio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 8fa403c7149e..39b04ad924c0 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -257,6 +257,7 @@ config RADIO_RTRACK
 	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
 	depends on ISA || COMPILE_TEST
 	depends on VIDEO_V4L2
+	select RADIO_ISA
 	---help---
 	  Choose Y here if you have one of these FM radio cards, and then fill
 	  in the port address below.
-- 
2.9.0
