Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B1C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E612086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E612086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeIHTQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:16:40 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:16:39 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mzhzd-1fc9Ql2W1Z-00vgsF; Sat, 08 Sep 2018 16:30:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] compat_ioctl: remove IGNORE_IOCTL()
Date:   Sat,  8 Sep 2018 16:28:11 +0200
Message-Id: <20180908142837.2819693-5-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:nGbJ5rDoHoRTqGmMjwVxk1EKcIjD3EJ4qLojhrz8TGe5tT+v4vw
 wShQKhuSiQodO+1Y/rvhQQgjbBFG15AfpNpwXsNKzDwJYzoro7wPQsg7PL/0+JHIIEYZYnt
 g3HYDhDVdkqNc8lxT7dZFgKeqv2SkcIvgcJKiXi8zPQhW/jDSJkEZrkFUxpeEoOHkIx1p45
 6yAaspwr2GgTn84kY2izg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OdVvqWONxx8=:KOdinIiFeW80teagBmcu9c
 Uj691wMWWSrTqvMjFTmBe02FhdKpw0F8AbYxxdqLevsZIs1+Qxhp/wEwpMWpIVjUoLwaZvO9j
 Go9Wa4UZU34AnqZ68Ko8r/7B9zoQ0vIphOqsCvH2vHwBxq1zR13lu2xyzf3WfwBbngzb4uGK/
 ECs4rWABxwvZr+MBt6wETmljILAgXjb86JzKyrv2g39wilYC2I7rTaGSvoIXMcBdD5dPvbpwC
 XTZSSlOb1zX7Te9HuYVBW71GWwv2cPl4f+m8nRuyzX7WZtiHwxhDnSwwmmX9F34qOXQk3FVxs
 IuTn8qHSAHdNRcQ/SJpWchhW8UtFmiizyr2Cs4bZ3dHXCuZnCHGNBFM/uCZszr7sVLTd7RPrz
 qxnFO/D8yPkzgXq6HkkqhkVnydv0LWhmttmFkRD4Y/0yYyFdpFCPwD9MuI5M1QXyLS1l/GMb9
 qpKbViThyCzbKpy3MiZqzumrdUsAS9Cffqsk7P/gmDoMl8GVBZGN2NOeR4lBTVsq40UC5CT9Y
 2x/jVkz4ze3rmX5nIDt1Ex+2VJhhi9vwvjLEpdmxBicQdvuBB1CvC9fhndg+uj90AKeT8mJPc
 mlQtIOhATBWfmpHS26tMlT9DNfHAw4m5dgyU1Z4EZbRyuio49pdxZo/W0lnh2/JOU/LF7paab
 rfwF1bsvbN1TanbDngbYB+0G3D8iFkiZa725mDpDQs4YyMBMryhNgEElTQnaOn2vM5Mo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 07d106d0a33d ("vfs: fix up ENOIOCTLCMD error handling"),
we don't warn about unhandled compat-ioctl command code any more, but
just return the same error that a native file descriptor returns when
there is no handler.

This means the IGNORE_IOCTL() annotations are completely useless and
can all be removed. TIOCSTART/TIOCSTOP and KDGHWCLK/KDSHWCLK fall into
the same category, but for some reason were listed as COMPATIBLE_IOCTL().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 56 -----------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 7d8c5722fd0a..b56a3842d61d 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -463,20 +463,7 @@ static int compat_ioctl_preallocate(struct file *file,
 #define XFORM(i) (((i) ^ ((i) << 27) ^ ((i) << 17)) & 0xffffffff)
 
 #define COMPATIBLE_IOCTL(cmd) XFORM((u32)cmd),
-/* ioctl should not be warned about even if it's not implemented.
-   Valid reasons to use this:
-   - It is implemented with ->compat_ioctl on some device, but programs
-   call it on others too.
-   - The ioctl is not implemented in the native kernel, but programs
-   call it commonly anyways.
-   Most other reasons are not valid. */
-#define IGNORE_IOCTL(cmd) COMPATIBLE_IOCTL(cmd)
-
 static unsigned int ioctl_pointer[] = {
-/* compatible ioctls first */
-COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
-COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
-
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
 COMPATIBLE_IOCTL(TCSETA)
@@ -553,9 +540,6 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_SEND_COMMAND)
 COMPATIBLE_IOCTL(SCSI_IOCTL_PROBE_HOST)
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 #endif
-/* Big V (don't complain on serial console) */
-IGNORE_IOCTL(VT_OPENQRY)
-IGNORE_IOCTL(VT_GETMODE)
 /*
  * These two are only for the sbus rtc driver, but
  * hwclock tries them on every rtc device first when
@@ -569,11 +553,6 @@ COMPATIBLE_IOCTL(MTIOCTOP)
 /* Socket level stuff */
 COMPATIBLE_IOCTL(FIOQSIZE)
 #ifdef CONFIG_BLOCK
-/* md calls this on random blockdevs */
-IGNORE_IOCTL(RAID_VERSION)
-/* qemu/qemu-img might call these two on plain files for probing */
-IGNORE_IOCTL(CDROM_DRIVE_STATUS)
-IGNORE_IOCTL(FDGETPRM32)
 /* SG stuff */
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
@@ -684,41 +663,6 @@ COMPATIBLE_IOCTL(JSIOCGNAME(0))
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
 #endif
-#ifdef TIOCSTART
-/*
- * For these two we have definitions in ioctls.h and/or termios.h on
- * some architectures but no actual implemention.  Some applications
- * like bash call them if they are defined in the headers, so we provide
- * entries here to avoid syslog message spew.
- */
-COMPATIBLE_IOCTL(TIOCSTART)
-COMPATIBLE_IOCTL(TIOCSTOP)
-#endif
-
-/* fat 'r' ioctls. These are handled by fat with ->compat_ioctl,
-   but we don't want warnings on other file systems. So declare
-   them as compatible here. */
-#define VFAT_IOCTL_READDIR_BOTH32       _IOR('r', 1, struct compat_dirent[2])
-#define VFAT_IOCTL_READDIR_SHORT32      _IOR('r', 2, struct compat_dirent[2])
-
-IGNORE_IOCTL(VFAT_IOCTL_READDIR_BOTH32)
-IGNORE_IOCTL(VFAT_IOCTL_READDIR_SHORT32)
-
-#ifdef CONFIG_SPARC
-/* Sparc framebuffers, handled in sbusfb_compat_ioctl() */
-IGNORE_IOCTL(FBIOGTYPE)
-IGNORE_IOCTL(FBIOSATTR)
-IGNORE_IOCTL(FBIOGATTR)
-IGNORE_IOCTL(FBIOSVIDEO)
-IGNORE_IOCTL(FBIOGVIDEO)
-IGNORE_IOCTL(FBIOSCURPOS)
-IGNORE_IOCTL(FBIOGCURPOS)
-IGNORE_IOCTL(FBIOGCURMAX)
-IGNORE_IOCTL(FBIOPUTCMAP32)
-IGNORE_IOCTL(FBIOGETCMAP32)
-IGNORE_IOCTL(FBIOSCURSOR32)
-IGNORE_IOCTL(FBIOGCURSOR32)
-#endif
 };
 
 /*
-- 
2.18.0

