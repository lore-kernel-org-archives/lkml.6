Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832222146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832222146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeIMHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43572 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYn-0006Ot-Hc; Thu, 13 Sep 2018 02:40:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/50] move compat handling of tty ioctls to tty_compat_ioctl()
Date:   Thu, 13 Sep 2018 03:40:01 +0100
Message-Id: <20180913024049.24567-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

ioctls that are
	* callable only via tty_ioctl()
	* not driver-specific
	* not demand data structure conversions
	* either always need passing arg as is or always demand compat_ptr()
get intercepted in tty_compat_ioctl() from the very beginning and
redirecter to tty_ioctl().  As the result, their entries in fs/compat_ioctl.c
(some of those had been missing, BTW) got removed, as well as
n_tty_compat_ioctl_helper() (now it's never called with any cmd it would accept).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/tty_io.c    | 77 +++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/tty/tty_ioctl.c | 16 ----------
 fs/compat_ioctl.c       | 51 --------------------------------
 include/linux/tty.h     |  2 --
 4 files changed, 75 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3fe4d3..c2168b43df0f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2668,6 +2668,81 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	struct tty_ldisc *ld;
 	int retval = -ENOIOCTLCMD;
 
+	switch (cmd) {
+	case TIOCSTI:
+	case TIOCGWINSZ:
+	case TIOCSWINSZ:
+	case TIOCGEXCL:
+	case TIOCGETD:
+	case TIOCSETD:
+	case TIOCGDEV:
+	case TIOCMGET:
+	case TIOCMSET:
+	case TIOCMBIC:
+	case TIOCMBIS:
+	case TIOCGICOUNT:
+	case TIOCGPGRP:
+	case TIOCSPGRP:
+	case TIOCGSID:
+	case TIOCSERGETLSR:
+	case TIOCGRS485:
+	case TIOCSRS485:
+#ifdef TIOCGETP
+	case TIOCGETP:
+	case TIOCSETP:
+	case TIOCSETN:
+#endif
+#ifdef TIOCGETC
+	case TIOCGETC:
+	case TIOCSETC:
+#endif
+#ifdef TIOCGLTC
+	case TIOCGLTC:
+	case TIOCSLTC:
+#endif
+	case TCSETSF:
+	case TCSETSW:
+	case TCSETS:
+	case TCGETS:
+#ifdef TCGETS2
+	case TCGETS2:
+	case TCSETSF2:
+	case TCSETSW2:
+	case TCSETS2:
+#endif
+	case TCGETA:
+	case TCSETAF:
+	case TCSETAW:
+	case TCSETA:
+	case TIOCGLCKTRMIOS:
+	case TIOCSLCKTRMIOS:
+#ifdef TCGETX
+	case TCGETX:
+	case TCSETX:
+	case TCSETXW:
+	case TCSETXF:
+#endif
+	case TIOCGSOFTCAR:
+	case TIOCSSOFTCAR:
+		return tty_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+	case TIOCCONS:
+	case TIOCEXCL:
+	case TIOCNXCL:
+	case TIOCVHANGUP:
+	case TIOCSBRK:
+	case TIOCCBRK:
+	case TCSBRK:
+	case TCSBRKP:
+	case TCFLSH:
+	case TIOCGPTPEER:
+	case TIOCNOTTY:
+	case TIOCSCTTY:
+	case TCXONC:
+	case TIOCMIWAIT:
+	case TIOCSERCONFIG:
+		return tty_ioctl(file, cmd, arg);
+	}
+
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
@@ -2682,8 +2757,6 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 		return hung_up_tty_compat_ioctl(file, cmd, arg);
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, file, cmd, arg);
-	else
-		retval = n_tty_compat_ioctl_helper(tty, file, cmd, arg);
 	tty_ldisc_deref(ld);
 
 	return retval;
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d99fec44036c..9245fffdbceb 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -941,19 +941,3 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 	}
 }
 EXPORT_SYMBOL(n_tty_ioctl_helper);
-
-#ifdef CONFIG_COMPAT
-long n_tty_compat_ioctl_helper(struct tty_struct *tty, struct file *file,
-					unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case TIOCGLCKTRMIOS:
-	case TIOCSLCKTRMIOS:
-		return tty_mode_ioctl(tty, file, cmd, (unsigned long) compat_ptr(arg));
-	default:
-		return -ENOIOCTLCMD;
-	}
-}
-EXPORT_SYMBOL(n_tty_compat_ioctl_helper);
-#endif
-
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 53bc3659dcef..670b8cbd0896 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -711,52 +711,9 @@ COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain *
 COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
 
 /* Big T */
-COMPATIBLE_IOCTL(TCGETA)
-COMPATIBLE_IOCTL(TCSETA)
-COMPATIBLE_IOCTL(TCSETAW)
-COMPATIBLE_IOCTL(TCSETAF)
-COMPATIBLE_IOCTL(TCSBRK)
-COMPATIBLE_IOCTL(TCXONC)
-COMPATIBLE_IOCTL(TCFLSH)
-COMPATIBLE_IOCTL(TCGETS)
-COMPATIBLE_IOCTL(TCSETS)
-COMPATIBLE_IOCTL(TCSETSW)
-COMPATIBLE_IOCTL(TCSETSF)
 COMPATIBLE_IOCTL(TIOCLINUX)
-COMPATIBLE_IOCTL(TIOCSBRK)
-COMPATIBLE_IOCTL(TIOCGDEV)
-COMPATIBLE_IOCTL(TIOCCBRK)
-COMPATIBLE_IOCTL(TIOCGSID)
-COMPATIBLE_IOCTL(TIOCGICOUNT)
-COMPATIBLE_IOCTL(TIOCGEXCL)
 /* Little t */
-COMPATIBLE_IOCTL(TIOCGETD)
-COMPATIBLE_IOCTL(TIOCSETD)
-COMPATIBLE_IOCTL(TIOCEXCL)
-COMPATIBLE_IOCTL(TIOCNXCL)
-COMPATIBLE_IOCTL(TIOCCONS)
-COMPATIBLE_IOCTL(TIOCGSOFTCAR)
-COMPATIBLE_IOCTL(TIOCSSOFTCAR)
-COMPATIBLE_IOCTL(TIOCSWINSZ)
-COMPATIBLE_IOCTL(TIOCGWINSZ)
-COMPATIBLE_IOCTL(TIOCMGET)
-COMPATIBLE_IOCTL(TIOCMBIC)
-COMPATIBLE_IOCTL(TIOCMBIS)
-COMPATIBLE_IOCTL(TIOCMSET)
-COMPATIBLE_IOCTL(TIOCNOTTY)
-COMPATIBLE_IOCTL(TIOCSTI)
 COMPATIBLE_IOCTL(TIOCOUTQ)
-COMPATIBLE_IOCTL(TIOCSPGRP)
-COMPATIBLE_IOCTL(TIOCGPGRP)
-COMPATIBLE_IOCTL(TIOCSERGETLSR)
-COMPATIBLE_IOCTL(TIOCSRS485)
-COMPATIBLE_IOCTL(TIOCGRS485)
-#ifdef TCGETS2
-COMPATIBLE_IOCTL(TCGETS2)
-COMPATIBLE_IOCTL(TCSETS2)
-COMPATIBLE_IOCTL(TCSETSW2)
-COMPATIBLE_IOCTL(TCSETSF2)
-#endif
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)
@@ -1219,10 +1176,6 @@ COMPATIBLE_IOCTL(JSIOCGAXES)
 COMPATIBLE_IOCTL(JSIOCGBUTTONS)
 COMPATIBLE_IOCTL(JSIOCGNAME(0))
 
-#ifdef TIOCGLTC
-COMPATIBLE_IOCTL(TIOCGLTC)
-COMPATIBLE_IOCTL(TIOCSLTC)
-#endif
 #ifdef TIOCSTART
 /*
  * For these two we have definitions in ioctls.h and/or termios.h on
@@ -1312,10 +1265,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	 * so we must not do a compat_ptr() translation.
 	 */
 	switch (cmd) {
-	/* Big T */
-	case TCSBRKP:
-	case TIOCMIWAIT:
-	case TIOCSCTTY:
 	/* RAID */
 	case HOT_REMOVE_DISK:
 	case HOT_ADD_DISK:
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e3978b00f..414db2bce715 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -746,8 +746,6 @@ static inline int tty_audit_push(void)
 /* tty_ioctl.c */
 extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 		       unsigned int cmd, unsigned long arg);
-extern long n_tty_compat_ioctl_helper(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg);
 
 /* vt.c */
 
-- 
2.11.0

