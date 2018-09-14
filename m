Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E482F20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E482F20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeINHjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:39:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47858 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeINHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:39:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0dpa-0001g0-9o; Fri, 14 Sep 2018 02:27:38 +0000
Date:   Fri, 14 Sep 2018 03:27:38 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
Message-ID: <20180914022737.GX19965@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
 <20180913203145.GU19965@ZenIV.linux.org.uk>
 <CAK8P3a3LD58jnwP38OpnEWHMzAAfrqtfjHamWVU5PwaKoWyKjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3LD58jnwP38OpnEWHMzAAfrqtfjHamWVU5PwaKoWyKjg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:56:48PM +0200, Arnd Bergmann wrote:

> Yes, I saw that too, but couldn't figure out exactly what ipwireless
> does. I suppose it is some serial port driver that comes with a
> hardcoded ppp implementation instead of a switchable ldisc?

NFI...

> > > * SIOCGIFNAME, SIOCGIFENCAP, SIOCSIFENCAP,
> > >   SIOCSIFHWADDR, SIOCSKEEPALIVE, SIOCGKEEPALIVE,
> > >   SIOCSOUTFILL,  and SIOCGOUTFILL  are in the tty_ioctl
> > >   functions for multiple protocol handlers, comparable to
> > >   the PPP ones.
> >
> > Very definitely shared with sockets, and I prefer to handle the tty-side cases
> > in ldisc ->compat_ioctl().
> 
> Fair enough.

FWIW, a solution of sorts pushed into the same branch.  It does *not* cover
tty_operations ->compat_ioctl() - only ldisc ones.  Comments?

commit de36af5ca465156863b5fb7548e3660ea7d3bbcf
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Sep 13 22:12:15 2018 -0400

    change semantics of ldisc ->compat_ioctl()
    
    First of all, make it return int.  Returning long when native method
    had never allowed that is ridiculous and inconvenient.
    
    More importantly, change the caller; if ldisc ->compat_ioctl() is NULL
    or returns -ENOIOCTLCMD, tty_compat_ioctl() will try to feed cmd and
    compat_ptr(arg) to ldisc's native ->ioctl().
    
    That simplifies ->compat_ioctl() instances quite a bit - they only
    need to deal with ioctls that are neither generic tty ones (those
    would get shunted off to tty_ioctl()) nor simple compat pointer ones.
    
    For quite a few ldiscs it means that NULL ->compat_ioctl() does the
    right thing.  Those where it won't serve (see e.g. n_r3964.c) are
    also easily dealt with - we need to handle the numeric-argument
    ioctls (calling the native instance) and, if such would exist,
    the ioctls that need layout conversion, etc.
    
    All in-tree ldiscs dealt with.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 963bb0309e25..ae0dd57a8e99 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -821,6 +821,7 @@ static int __init hci_uart_init(void)
 	hci_uart_ldisc.read		= hci_uart_tty_read;
 	hci_uart_ldisc.write		= hci_uart_tty_write;
 	hci_uart_ldisc.ioctl		= hci_uart_tty_ioctl;
+	hci_uart_ldisc.compat_ioctl	= hci_uart_tty_ioctl;
 	hci_uart_ldisc.poll		= hci_uart_tty_poll;
 	hci_uart_ldisc.receive_buf	= hci_uart_tty_receive;
 	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index f8ead9f9c77e..5977b8a34ebe 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -226,7 +226,7 @@ static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
 
 #ifdef CONFIG_COMPAT
 #define COMPAT_SPIOCSTYPE	_IOW('q', 0x01, compat_ulong_t)
-static long serport_ldisc_compat_ioctl(struct tty_struct *tty,
+static int serport_ldisc_compat_ioctl(struct tty_struct *tty,
 				       struct file *file,
 				       unsigned int cmd, unsigned long arg)
 {
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index d79a69dd2146..17e6dcd2eb42 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -34,7 +34,6 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/semaphore.h>
-#include <linux/compat.h>
 #include <linux/refcount.h>
 
 #define SIXPACK_VERSION    "Revision: 0.3.0"
@@ -752,23 +751,6 @@ static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
-static long sixpack_compat_ioctl(struct tty_struct * tty, struct file * file,
-				unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case SIOCGIFNAME:
-	case SIOCGIFENCAP:
-	case SIOCSIFENCAP:
-	case SIOCSIFHWADDR:
-		return sixpack_ioctl(tty, file, cmd,
-				(unsigned long)compat_ptr(arg));
-	}
-
-	return -ENOIOCTLCMD;
-}
-#endif
-
 static struct tty_ldisc_ops sp_ldisc = {
 	.owner		= THIS_MODULE,
 	.magic		= TTY_LDISC_MAGIC,
@@ -776,9 +758,6 @@ static struct tty_ldisc_ops sp_ldisc = {
 	.open		= sixpack_open,
 	.close		= sixpack_close,
 	.ioctl		= sixpack_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= sixpack_compat_ioctl,
-#endif
 	.receive_buf	= sixpack_receive_buf,
 	.write_wakeup	= sixpack_write_wakeup,
 };
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 13e4c1eff353..802233d41b25 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -35,7 +35,6 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 #include <linux/jiffies.h>
-#include <linux/compat.h>
 
 #include <net/ax25.h>
 
@@ -875,23 +874,6 @@ static int mkiss_ioctl(struct tty_struct *tty, struct file *file,
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
-static long mkiss_compat_ioctl(struct tty_struct *tty, struct file *file,
-	unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case SIOCGIFNAME:
-	case SIOCGIFENCAP:
-	case SIOCSIFENCAP:
-	case SIOCSIFHWADDR:
-		return mkiss_ioctl(tty, file, cmd,
-				   (unsigned long)compat_ptr(arg));
-	}
-
-	return -ENOIOCTLCMD;
-}
-#endif
-
 /*
  * Handle the 'receiver data ready' interrupt.
  * This function is called by the 'tty_io' module in the kernel when
@@ -966,9 +948,6 @@ static struct tty_ldisc_ops ax_ldisc = {
 	.open		= mkiss_open,
 	.close		= mkiss_close,
 	.ioctl		= mkiss_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= mkiss_compat_ioctl,
-#endif
 	.receive_buf	= mkiss_receive_buf,
 	.write_wakeup	= mkiss_write_wakeup
 };
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index b008266e91ea..9757f1fc104f 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -79,7 +79,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/if_arp.h>
 #include <linux/if_slip.h>
-#include <linux/compat.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1167,27 +1166,6 @@ static int slip_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long slip_compat_ioctl(struct tty_struct *tty, struct file *file,
-					unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case SIOCGIFNAME:
-	case SIOCGIFENCAP:
-	case SIOCSIFENCAP:
-	case SIOCSIFHWADDR:
-	case SIOCSKEEPALIVE:
-	case SIOCGKEEPALIVE:
-	case SIOCSOUTFILL:
-	case SIOCGOUTFILL:
-		return slip_ioctl(tty, file, cmd,
-				  (unsigned long)compat_ptr(arg));
-	}
-
-	return -ENOIOCTLCMD;
-}
-#endif
-
 /* VSV changes start here */
 #ifdef CONFIG_SLIP_SMART
 /* function do_ioctl called from net/core/dev.c
@@ -1280,9 +1258,6 @@ static struct tty_ldisc_ops sl_ldisc = {
 	.close	 	= slip_close,
 	.hangup	 	= slip_hangup,
 	.ioctl		= slip_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= slip_compat_ioctl,
-#endif
 	.receive_buf	= slip_receive_buf,
 	.write_wakeup	= slip_write_wakeup,
 };
diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index 74c06a5f586f..1098263ab862 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -33,7 +33,6 @@
 #include <linux/lapb.h>
 #include <linux/init.h>
 #include <linux/rtnetlink.h>
-#include <linux/compat.h>
 #include <linux/slab.h>
 #include <net/x25device.h>
 #include "x25_asy.h"
@@ -703,21 +702,6 @@ static int x25_asy_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long x25_asy_compat_ioctl(struct tty_struct *tty, struct file *file,
-			 unsigned int cmd,  unsigned long arg)
-{
-	switch (cmd) {
-	case SIOCGIFNAME:
-	case SIOCSIFHWADDR:
-		return x25_asy_ioctl(tty, file, cmd,
-				     (unsigned long)compat_ptr(arg));
-	}
-
-	return -ENOIOCTLCMD;
-}
-#endif
-
 static int x25_asy_open_dev(struct net_device *dev)
 {
 	struct x25_asy *sl = netdev_priv(dev);
@@ -769,9 +753,6 @@ static struct tty_ldisc_ops x25_ldisc = {
 	.open		= x25_asy_open_tty,
 	.close		= x25_asy_close_tty,
 	.ioctl		= x25_asy_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= x25_asy_compat_ioctl,
-#endif
 	.receive_buf	= x25_asy_receive_buf,
 	.write_wakeup	= x25_asy_write_wakeup,
 };
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 86b7e20ffd7f..6f7da9a9d76f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2614,14 +2614,6 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static long gsmld_compat_ioctl(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
-{
-	return gsmld_ioctl(tty, file, cmd, arg);
-}
-#endif
-
 /*
  *	Network interface
  *
@@ -2833,9 +2825,6 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
 	.flush_buffer    = gsmld_flush_buffer,
 	.read            = gsmld_read,
 	.write           = gsmld_write,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl    = gsmld_compat_ioctl,
-#endif
 	.ioctl           = gsmld_ioctl,
 	.poll            = gsmld_poll,
 	.receive_buf     = gsmld_receive_buf,
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index dbf1ab36758e..749a608c40b0 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -134,6 +134,10 @@ static ssize_t r3964_write(struct tty_struct *tty, struct file *file,
 		const unsigned char *buf, size_t nr);
 static int r3964_ioctl(struct tty_struct *tty, struct file *file,
 		unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+static int r3964_compat_ioctl(struct tty_struct *tty, struct file *file,
+		unsigned int cmd, unsigned long arg);
+#endif
 static void r3964_set_termios(struct tty_struct *tty, struct ktermios *old);
 static __poll_t r3964_poll(struct tty_struct *tty, struct file *file,
 		struct poll_table_struct *wait);
@@ -149,6 +153,9 @@ static struct tty_ldisc_ops tty_ldisc_N_R3964 = {
 	.read = r3964_read,
 	.write = r3964_write,
 	.ioctl = r3964_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = r3964_compat_ioctl,
+#endif
 	.set_termios = r3964_set_termios,
 	.poll = r3964_poll,
 	.receive_buf = r3964_receive_buf,
@@ -1210,6 +1217,21 @@ static int r3964_ioctl(struct tty_struct *tty, struct file *file,
 	}
 }
 
+#ifdef CONFIG_COMPAT
+static int r3964_compat_ioctl(struct tty_struct *tty, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case R3964_ENABLE_SIGNALS:
+	case R3964_SETPRIORITY:
+	case R3964_USE_BCC:
+		return r3964_ioctl(tty, file, cmd, arg);
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+#endif
+
 static void r3964_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	TRACE_L("set_termios");
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0f75ae6bfaa7..483ad432d906 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2824,6 +2824,9 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 		return hung_up_tty_compat_ioctl(file, cmd, arg);
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, file, cmd, arg);
+	if (retval == -ENOIOCTLCMD && ld->ops->ioctl)
+		retval = ld->ops->ioctl(tty, file,
+				(unsigned long)compat_ptr(cmd), arg);
 	tty_ldisc_deref(ld);
 
 	return retval;
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 840894ca3fc0..275c772c52c5 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -184,7 +184,7 @@ struct tty_ldisc_ops {
 			 const unsigned char *buf, size_t nr);
 	int	(*ioctl)(struct tty_struct *tty, struct file *file,
 			 unsigned int cmd, unsigned long arg);
-	long	(*compat_ioctl)(struct tty_struct *tty, struct file *file,
+	int	(*compat_ioctl)(struct tty_struct *tty, struct file *file,
 				unsigned int cmd, unsigned long arg);
 	void	(*set_termios)(struct tty_struct *tty, struct ktermios *old);
 	__poll_t (*poll)(struct tty_struct *, struct file *,
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index a66f102c6c01..d1fa0f22c10c 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -465,6 +465,7 @@ static struct tty_ldisc_ops nci_uart_ldisc = {
 	.receive_buf	= nci_uart_tty_receive,
 	.write_wakeup	= nci_uart_tty_wakeup,
 	.ioctl		= nci_uart_tty_ioctl,
+	.compat_ioctl	= nci_uart_tty_ioctl,
 };
 
 static int __init nci_uart_init(void)
