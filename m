Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4032077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4032077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJNXkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:40:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35920 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cZ-Oo; Sun, 14 Oct 2018 16:30:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000l3-8F; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Mackerras" <paulus@ozlabs.org>,
        syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com,
        "Eric Biggers" <ebiggers@google.com>,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.45379651@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 354/366] ppp: remove the PPPIOCDETACH ioctl
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit af8d3c7c001ae7df1ed2b2715f058113efc86187 upstream.

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
remove the PPPIOCDETACH ioctl and see if anyone actually notices.  Leave
a stub in place that prints a one-time warning and returns EINVAL.

Reported-by: syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Guillaume Nault <g.nault@alphalink.fr>
Tested-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/networking/ppp_generic.txt |  6 ------
 drivers/net/ppp/ppp_generic.c            | 27 +++++-------------------
 include/uapi/linux/ppp-ioctl.h           |  2 +-
 3 files changed, 6 insertions(+), 29 deletions(-)

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
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -584,30 +584,13 @@ static long ppp_ioctl(struct file *file,
 
 	if (cmd == PPPIOCDETACH) {
 		/*
-		 * We have to be careful here... if the file descriptor
-		 * has been dup'd, we could have another process in the
-		 * middle of a poll using the same file *, so we had
-		 * better not free the interface data structures -
-		 * instead we fail the ioctl.  Even in this case, we
-		 * shut down the interface if we are the owner of it.
-		 * Actually, we should get rid of PPPIOCDETACH, userland
-		 * (i.e. pppd) could achieve the same effect by closing
-		 * this fd and reopening /dev/ppp.
+		 * PPPIOCDETACH is no longer supported as it was heavily broken,
+		 * and is only known to have been used by pppd older than
+		 * ppp-2.4.2 (released November 2003).
 		 */
+		pr_warn_once("%s (%d) used obsolete PPPIOCDETACH ioctl\n",
+			     current->comm, current->pid);
 		err = -EINVAL;
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
 		goto out;
 	}
 
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -105,7 +105,7 @@ struct pppol2tp_ioc_stats {
 #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
 #define PPPIOCNEWUNIT	_IOWR('t', 62, int)	/* create new ppp unit */
 #define PPPIOCATTACH	_IOW('t', 61, int)	/* attach to ppp unit */
-#define PPPIOCDETACH	_IOW('t', 60, int)	/* detach from ppp unit/chan */
+#define PPPIOCDETACH	_IOW('t', 60, int)	/* obsolete, do not use */
 #define PPPIOCSMRRU	_IOW('t', 59, int)	/* set multilink MRU */
 #define PPPIOCCONNECT	_IOW('t', 58, int)	/* connect channel to unit */
 #define PPPIOCDISCONN	_IO('t', 57)		/* disconnect channel */

