Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE2C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D63D20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D63D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeILURy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:17:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:17:54 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtwEO-1fhbQy253E-00uJYI; Wed, 12 Sep 2018 17:12:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/17] compat_ioctl: remove HIDIO translation
Date:   Wed, 12 Sep 2018 17:08:56 +0200
Message-Id: <20180912151134.436719-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/0bZN4heVjAGdCq1qjneAxHCTRXoDIffTOWZjMByUY0l6I4tLut
 sgVexmMO9fzAnFzkJUqKLZqxRJzzUMdw98n9v3MpjvIvAC/Xz/A1+IZeFjUJ6GHKCxmVXZv
 2gbGYavQhRpp3MlE1JBLzH3YrMZgpre2JTA7aXw77wZaJ9TqOTd698GE3ZzOQTIZ9EjQVx9
 rU7b7+UmuzVmJqgu92xog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hKj+/QgYaKM=:FP6Gp1JOt60VnlnCPo9puL
 bfIn/ZTqPWj8sYz9X+uKjUSHpZu2SLN0+aCmD2kliMTTh7rSkky2CisPBnVgyDzLXplmJatxv
 PHTar3fFAb7Yo0s9SzupYOkWbShYemgvZ6MmtPlZDlGKOqGE0tdrRjgpIYKCuDKHkuVtuRYcN
 EgtFWAqI8QDLdzSOviVm0yr31OZnVHtgR9G1etnhKIWwwEKy7W5P6Nh3HOE4SkKjvabrdqq+z
 Ve5UlB6qUYdWpjD9FKuVR7hY8PfA960Jalx9OvGffWfmGXUns55PadoEfsDgLFBaZOO8ZOtY7
 lHNdvupsO7o0VC22Fg+SnZr1cNyodrfMzIHIUqH+PK2pNCyeyt2tJYUsBFQh90k1CyCgiVCXm
 n6yRO+Y1sqEWkjfOPmtcWxvQKCc7p7k/AzfGtp7zUv25dRFm8ntQJxS5j1tKfwmeQvmlpar1D
 GUj92b8sk/i+S9KW90zcoSUljFw81tbv9715udvcrmZsaHN1zcA0r2m9O8VPAwxEyixszlRDU
 5lIQSLTih9zmOJ0VWvDE+2QY2Wx6KHUKVe4T3xBdEO1o6OJ3y4qztHHiP6elEU7Lp8argHqnL
 6TgwOOxwktF4nXIHWsY3rdg8/2hlFiZJepuCPOuNaCFf1VkfC3pHIBNZcAP+eL9LUiK2lIkUL
 q3YpshW6ASykEY+zdz8+9916/qFs4o72+rWo8v/g2pg5o4Avh8XmN/DI01GgB8vH4LSs=
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
 fs/compat_ioctl.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e245deb684b5..001c9fd89d30 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1023,23 +1023,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
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
 /* dvb */
 COMPATIBLE_IOCTL(AUDIO_STOP)
 COMPATIBLE_IOCTL(AUDIO_PLAY)
@@ -1094,7 +1077,6 @@ COMPATIBLE_IOCTL(CEC_S_MODE)
 COMPATIBLE_IOCTL(CEC_TRANSMIT)
 COMPATIBLE_IOCTL(CEC_RECEIVE)
 COMPATIBLE_IOCTL(CEC_DQEVENT)
-
 /* joystick */
 COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
-- 
2.18.0

