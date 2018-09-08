Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FCC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93552086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93552086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeIHTOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:14:51 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHTOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:14:51 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MQusJ-1gC2Fg0z9r-00O0Hd; Sat, 08 Sep 2018 16:28:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] compat_ioctl: remove HIDIO translation
Date:   Sat,  8 Sep 2018 16:28:08 +0200
Message-Id: <20180908142837.2819693-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:1I7Gcze/afAgmffd/3BD2ZlxrLv3YnhRyEl67SMr2RW79rV+nw6
 9xDXgu89vBFFY4343FDY/bphWCuqeVrHTjzmx5Qzr4mMnc3y2KPsd4mq9wtPFzoOiqt6m9V
 tuZC3KfeiFYYBpUqReoiB0+vMrIbeHwbyGsCa7JxOdlhm50ruymRLiiEQ2DCc2Et3ZaTkC9
 1SJtdld4JYRTkl/VjXeBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IjpLeV6cdrY=:xBVd5L/OjCLh7ic+RKjJ/C
 4EnnCtZH6/a/caSeTKpIisQaejYJt1dN1yrVlhXIeWSJcLUn8NwW3oarsFFzS2qMFgITKT2Vi
 ECD3fya2lOHkvFxrl7iu7wmAm21alDrfBvb70fxEDtRPldlDYtmIinDy+UCAVsJGtOycONMqe
 kdG7ktr7tZk4uHXs/aYyogI1dWVZABadxX3s7TcHmruSuLRBoV5ovBvaBV6WPToooMrmvHe7s
 QhQph8iWfpTNPntV9X3Vs7mNLBzLEbn57qZGx17t6YajDkxd0UUCleFWmq3P8ojGSiE846+qe
 XXBADtVORCdbAdxffzyPFunXEmnvilnXPuV3DsFxNAOcE2pLYX/6K7bdFBO44OWDw5sUEwo9N
 gfgAzB8dp5do2EywwW+2pCsqaWr3qEHegZot0cEsTbrKUWRCfpKFujCQ9j4xura8hwujKKlVC
 yiHxAFRkiXGA1E+zv0iiWshs3fVlbrKmnzUTKOc4BpamyocMdQGW+ScLU860HHxlFtmqHizTn
 Vr8ddQvaOSK5AZZEwD//5pvhpFIM1vMAKqY+BL+4eYrrf9OKwd++eRhuX3aTrv1k/bC9nDJlS
 9W9NjDPpW4hc9Rt8LLcJWE/xMNLxZYRq+R3qw+4P//PU+6O5l1Q/w4RuBidc0ZA4LGcCIsDhy
 F6S76PTZzexI8tPc9Hq8X0pzd5+hTZ/ibPCrHw0KKQU2pGjq//10DQz2Tov+kChoGYFw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two drivers implementing these both gained proper compat_ioctl()
handlers a long time ago with commits bb6c8d8fa9b5 ("HID: hiddev:
Add 32bit ioctl compatibilty") and ae5e49c79c05 ("HID: hidraw: add
compatibility ioctl() for 32-bit applications."), so the lists in
fs/compat_ioctl.c are no longer used.

It appears that the lists were also incomplete, so the translation
didn't actually work correctly when it was still in use.

Remove them as cleanup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 4c2f83a386a2..c2c73b802fb3 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -853,23 +853,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* hiddev */
-COMPATIBLE_IOCTL(HIDIOCGVERSION)
-COMPATIBLE_IOCTL(HIDIOCAPPLICATION)
-COMPATIBLE_IOCTL(HIDIOCGDEVINFO)
-COMPATIBLE_IOCTL(HIDIOCGSTRING)
-COMPATIBLE_IOCTL(HIDIOCINITREPORT)
-COMPATIBLE_IOCTL(HIDIOCGREPORT)
-COMPATIBLE_IOCTL(HIDIOCSREPORT)
-COMPATIBLE_IOCTL(HIDIOCGREPORTINFO)
-COMPATIBLE_IOCTL(HIDIOCGFIELDINFO)
-COMPATIBLE_IOCTL(HIDIOCGUSAGE)
-COMPATIBLE_IOCTL(HIDIOCSUSAGE)
-COMPATIBLE_IOCTL(HIDIOCGUCODE)
-COMPATIBLE_IOCTL(HIDIOCGFLAG)
-COMPATIBLE_IOCTL(HIDIOCSFLAG)
-COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINDEX)
-COMPATIBLE_IOCTL(HIDIOCGCOLLECTIONINFO)
 /* joystick */
 COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
-- 
2.18.0

