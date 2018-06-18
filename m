Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF0CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A865208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A865208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeFRPmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:42:31 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFRPma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:42:30 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MWseJ-1fjT9m2SCp-00XrGv; Mon, 18 Jun 2018 17:41:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Kees Cook <keescook@chromium.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: line6: stop using get_seconds()
Date:   Mon, 18 Jun 2018 17:41:01 +0200
Message-Id: <20180618154108.2227779-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180618154108.2227779-1-arnd@arndb.de>
References: <20180618154108.2227779-1-arnd@arndb.de>
X-Provags-ID: V03:K1:1tH0sVUHDQdRbxJeB9m+C0hMkpePO78Cctp9xs4OwP4yeH1A0F2
 QW843IGYDToD6c/Eb+oOPJ1IOoroaZ9gAtpPf1kLIYUeI89KmeimA7rp8THacuhCShV6HMY
 wSfvxGLddcouOhNdwLd5jCemCwubnT9nI5QDnCktwCVAJ2WKY4afxLsyVGqDzspxU8GJ4dE
 Z29DRaw0XWTyvMUQzUQog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0hXb8ET96kY=:OHHqYDOtJu518W1LZPe1IP
 /CUzVD31RrEDqk+uXhGd2yveHW+NeejexR9NYfXIju9L/sWHzXazYhFO96pkrsjxxwpBVcdE5
 8s2NjLDse8T4jHd44xo+wWFYb7l31INUjW73eSGapIBsTES/JOLtSuCtPuGuNDgErTq1AvwyG
 3hB5wds9Nq2ieWke3hnzcVA3NIJX72Fb6jqeTB24epSHUl2L+glznE/icUuE32JFtwDbU2cNs
 0sRHWoi6Uly6u0RlXXWserdJ+8/JbX3OZTAAij34llr4xf1KGNb9TQTOLVVAPctDdB7l3UOCo
 otjJMDkPASvxWkoITtCx/3HQStcrUYerNjrxFOtvfeWxCOW+988d60eyOrQdh4t4FTD2YhuFl
 BcbFdukKfExAdA1fUWtpel7gKTDQbnf8AGlvtbOYr0y2DWut+KhU/V/Ev9LUKcm2wunll234z
 q/5EL678B7siyLztkqhpwI0jcde7VqOEfwNbslq6th5RxEYeuXA9hTDmTdGAYa53Uzm2cle3U
 39yO1BHlZBgwClHDIzzP/nzISwPjilDjYzNmJnt2kAcJx/Ft2pnN5TgVwu4BlyQQP2fG6tAUK
 istdESRU7YRbt69xtDLENxZ00mgomaf+E9zmauel9iloQMX1lgS6+FuRIMpft/LfI/o+vs7/R
 atFPRxBgFNN2PWKJ+Hpjdinsnl6eaGd/yY1sGpefKZuta89ifW/5284wZK1SlUfrGJdw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() function is deprecated because it truncates the
timestamp to 32 bits, so all users should change to ktime_get_seconds()
or ktime_get_real_seconds().

The firmware interface for passing the timestamp is also limited to
32 bits, so this patch only has the cosmetic effect of avoiding the
old interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/usb/line6/toneport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 750467fb95db..f47ba94e6f4a 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -367,12 +367,13 @@ static bool toneport_has_source_select(struct usb_line6_toneport *toneport)
 */
 static void toneport_setup(struct usb_line6_toneport *toneport)
 {
-	int ticks;
+	u32 ticks;
 	struct usb_line6 *line6 = &toneport->line6;
 	struct usb_device *usbdev = line6->usbdev;
 
 	/* sync time on device with host: */
-	ticks = (int)get_seconds();
+	/* note: 32-bit timestamps overflow in year 2106 */
+	ticks = (u32)ktime_get_real_seconds();
 	line6_write_data(line6, 0x80c6, &ticks, 4);
 
 	/* enable device: */
-- 
2.9.0

