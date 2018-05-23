Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeEWEBw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:01:52 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40572 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeEWEBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:01:48 -0400
X-Google-Smtp-Source: AB8JxZpRHIM86hfmoLW4XxIMzKd96USplNeFLoJnN74pIrtwx/EqQSmYl8dGIwYka4+U8k3hHfqCDg==
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-ppp@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        syzkaller-bugs@googlegroups.com, Eric Biggers <ebiggers@google.com>
Subject: [PATCH] ppp: remove the PPPIOCDETACH ioctl
Date: Tue, 22 May 2018 20:59:52 -0700
Message-Id: <20180523035952.25768-1-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523032958.GE658@sol.localdomain>
References: <20180523032958.GE658@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The PPPIOCDETACH ioctl effectively tries to "close" the given ppp file
before f_count has reached 0, which is fundamentally a bad idea.  It
does check 'f_count < 2', which excludes concurrent operations on the
file since they would only be possible with a shared fd table, in which
case each fdget() would take a file reference.  However, it fails to
account for the fact that even with 'f_count == 1' the file can still be
linked into epoll instances.  As reported by syzbot, this can trivially
be used to cause a use-after-free.

Yet, the only known user of PPPIOCDETACH is pppd versions older than
ppp-2.4.2, which was released almost 15 years ago (November 2003).
Also, PPPIOCDETACH apparently stopped working reliably at around the
same time, when the f_count check was added to the kernel, e.g. see
https://lkml.org/lkml/2002/12/31/83.  Also, the current 'f_count < 2'
check makes PPPIOCDETACH only work in single-threaded applications; it
always fails if called from a multithreaded application.

All pppd versions released in the last 15 years just close() the file
descriptor instead.

Therefore, instead of hacking around this bug by exporting epoll
internals to modules, and probably missing other related bugs, just
remove the PPPIOCDETACH ioctl and see if anyone actually notices.

Reported-by: syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/networking/ppp_generic.txt |  6 -----
 drivers/net/ppp/ppp_generic.c            | 29 ------------------------
 fs/compat_ioctl.c                        |  1 -
 include/uapi/linux/ppp-ioctl.h           |  1 -
 4 files changed, 37 deletions(-)

diff --git a/Documentation/networking/ppp_generic.txt b/Documentation/networking/ppp_generic.txt
index 091d20273dcb..61daf4b39600 100644
--- a/Documentation/networking/ppp_generic.txt
+++ b/Documentation/networking/ppp_generic.txt
@@ -300,12 +300,6 @@ unattached instance are:
 The ioctl calls available on an instance of /dev/ppp attached to a
 channel are:
 
-* PPPIOCDETACH detaches the instance from the channel.  This ioctl is
-  deprecated since the same effect can be achieved by closing the
-  instance.  In order to prevent possible races this ioctl will fail
-  with an EINVAL error if more than one file descriptor refers to this
-  instance (i.e. as a result of dup(), dup2() or fork()).
-
 * PPPIOCCONNECT connects this channel to a PPP interface.  The
   argument should point to an int containing the interface unit
   number.  It will return an EINVAL error if the channel is already
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index dc7c7ec43202..dce8812fe802 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -603,35 +603,6 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		goto out;
 	}
 
-	if (cmd == PPPIOCDETACH) {
-		/*
-		 * We have to be careful here... if the file descriptor
-		 * has been dup'd, we could have another process in the
-		 * middle of a poll using the same file *, so we had
-		 * better not free the interface data structures -
-		 * instead we fail the ioctl.  Even in this case, we
-		 * shut down the interface if we are the owner of it.
-		 * Actually, we should get rid of PPPIOCDETACH, userland
-		 * (i.e. pppd) could achieve the same effect by closing
-		 * this fd and reopening /dev/ppp.
-		 */
-		err = -EINVAL;
-		if (pf->kind == INTERFACE) {
-			ppp = PF_TO_PPP(pf);
-			rtnl_lock();
-			if (file == ppp->owner)
-				unregister_netdevice(ppp->dev);
-			rtnl_unlock();
-		}
-		if (atomic_long_read(&file->f_count) < 2) {
-			ppp_release(NULL, file);
-			err = 0;
-		} else
-			pr_warn("PPPIOCDETACH file->f_count=%ld\n",
-				atomic_long_read(&file->f_count));
-		goto out;
-	}
-
 	if (pf->kind == CHANNEL) {
 		struct channel *pch;
 		struct ppp_channel *chan;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index ef80085ed564..8285b570d635 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -917,7 +917,6 @@ COMPATIBLE_IOCTL(PPPIOCSDEBUG)
 /* PPPIOCGIDLE is translated */
 COMPATIBLE_IOCTL(PPPIOCNEWUNIT)
 COMPATIBLE_IOCTL(PPPIOCATTACH)
-COMPATIBLE_IOCTL(PPPIOCDETACH)
 COMPATIBLE_IOCTL(PPPIOCSMRRU)
 COMPATIBLE_IOCTL(PPPIOCCONNECT)
 COMPATIBLE_IOCTL(PPPIOCDISCONN)
diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
index b19a9c249b15..d46caf217ea4 100644
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -106,7 +106,6 @@ struct pppol2tp_ioc_stats {
 #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
 #define PPPIOCNEWUNIT	_IOWR('t', 62, int)	/* create new ppp unit */
 #define PPPIOCATTACH	_IOW('t', 61, int)	/* attach to ppp unit */
-#define PPPIOCDETACH	_IOW('t', 60, int)	/* detach from ppp unit/chan */
 #define PPPIOCSMRRU	_IOW('t', 59, int)	/* set multilink MRU */
 #define PPPIOCCONNECT	_IOW('t', 58, int)	/* connect channel to unit */
 #define PPPIOCDISCONN	_IO('t', 57)		/* disconnect channel */
-- 
2.17.0
