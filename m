Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE893C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9A620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9A620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeILUT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:19:57 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:19:57 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MqatE-1fVQrC2kbI-00mbAk; Wed, 12 Sep 2018 17:14:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/17] compat_ioctl: remove IGNORE_IOCTL()
Date:   Wed, 12 Sep 2018 17:13:04 +0200
Message-Id: <20180912151422.571531-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912151422.571531-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151422.571531-1-arnd@arndb.de>
X-Provags-ID: V03:K1:gLton/QV1r8eFUQyeN49XpjUg++0kxEvWRSZDudc72FgtlI/UiE
 5lx9vCFc6tshhyJggsDRpk5Af/VqPQGkypUfBhDITG6xj2RlkcIQ+5TESQY/p0tqR2Vnpg0
 iZWtaIZ5spidOVifE2xxUBBq9NZ5/tm4aRM1ox49gjf8EBYVG+rHs9NMJRqZ90Sn4+F8mTN
 u0SOBEd/Zi0l+d1nQmMgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g4KIWjGVyiM=:kJDRe5LvTzN4R1HeTaH1fO
 LpE99F1KSVQejGRkh2oCwKsrp2JRbAzOxaufylRuxHiRQbsiIapIbKjxI20QrTVAkSrB2pzV0
 R2+QGnBSROvfqr4dTgnm1n+2kBhsFO1Db82C85Q+P5tKPyqnjvACGZkZZben4K/At/S9MvtyV
 RAeWAMJ3ZZFzU8Dbit6zhUV292iuRKC6Lp6Q385j0W5tUMSazTJITxvtWnk+KcM62IhSEO7h0
 oZew0q0kylhH3fZyrcRgVOdEYDt+ggbrZhf6+sX02mWWzaQkngdMJ83MInR0OkDWgFuJxx03w
 lHku4nUhwg/OCBFq5U3lQ01AeliKq5S15k+JW/EtlXY5/jSlx3DtFHoyxXFzOcCWDoH+LK8BE
 AIWpsUZkGV6jRNGnbtbG3+5ogfPbfnFF75FoUs4g9mb7Q6/rx86gItbQaUn2pdqC36X7CkTuv
 wCdCirsRR4ieitvDhpTNr0tx8VG0/shsCfOm9sVsByl6V382lVqYmFB1M9Eg/h8r9U7H+Li1U
 aSQy3DL9mqQJbMgLnUsfS1RHaspgyPXAQloNoBHniI49EYrCBFwatbBZ9/kX7KOXu47ISXY5D
 8++bQy4FPRHkGppUVhxe4qXe/JlgJYVxUfBBkUPUBtuV8InwVXmRJ06UOSCSnTYWGkGcJzHIz
 tJ/uKtEdOAEVnwyX9hfqCM1koYvW8RLpsXXOFedYKv66vMJHD3SGwxMTzgctDP4AntRA=
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
index 379e04647f83..ca7f83976a3f 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -604,20 +604,7 @@ static int compat_ioctl_preallocate(struct file *file,
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
@@ -694,9 +681,6 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_SEND_COMMAND)
 COMPATIBLE_IOCTL(SCSI_IOCTL_PROBE_HOST)
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 #endif
-/* Big V (don't complain on serial console) */
-IGNORE_IOCTL(VT_OPENQRY)
-IGNORE_IOCTL(VT_GETMODE)
 /*
  * These two are only for the sbus rtc driver, but
  * hwclock tries them on every rtc device first when
@@ -708,11 +692,6 @@ COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
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
@@ -908,41 +887,6 @@ COMPATIBLE_IOCTL(JSIOCGNAME(0))
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

