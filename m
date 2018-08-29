Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F3A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F3A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeH2SCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:02:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeH2SCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:02:19 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LfY1R-1fbKbZ1Bpx-00p8rz; Wed, 29 Aug 2018 16:04:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org
Cc:     mitch@sfgoth.com, mostrows@earthlink.net, jchapman@katalix.com,
        xeb@mail.ru, davem@davemloft.net, viro@zeniv.linux.org.uk,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH net-next 2/5] ppp: move simple ioctl compat handling out of fs_compat_ioctl.c
Date:   Wed, 29 Aug 2018 16:03:27 +0200
Message-Id: <20180829140409.833488-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829140409.833488-1-arnd@arndb.de>
References: <20180829140409.833488-1-arnd@arndb.de>
X-Provags-ID: V03:K1:CauIZwr8reoSSvIydQRyNDDUxamf8uYTNIwYWq/wYfeducsi7Y0
 /65pxUMrBvtN6fyTEQOIjdouqPrjexyZUCIMiVX4oQ3460WCv9D3tSWOQ6pHi7w9ZiezW/T
 rRmYMkS0Tlzl7jQnuJ6bzyZD8XOZfXlLnNZDyiP4UtF7NXyCgLESlXQlfYiyqKu/LJ8bhiY
 0HK9j1FS6dO9LHMSbOtHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:089jMsUmKcE=:Jml4qFP7jEHzeH2MEE7mOz
 abH+rHufgWPjDthJI5OeKDxJZwWZJASbxTLnqo7VhA1yAsFqNzAktQUB9tCfbVqfEpLjTzyJW
 s/RPC1yRduCOuwWfZ3qv2HS0t9aQKD73Epk0bLDQBLme+NPr0o35IVQY5PndGsKfrU2D7uD4t
 mmhPHzGT22AzjUjPVJklhBvT0XHNZiHy4MkRX1QmF9Gv522p83M2gRdfLEQ7+a5jh/dFNTD+5
 KTIUHnehYYz7bJTJlXAcj11GywpA1L7nDt/tSzgvPHG/8nvgev7SpU4wJlA8fN9lcWFQA3h9a
 01PKRdh8UCtgVfQ5NUvpeiy/vvRUTec72u8tE5og3DCdY9hDbUglTntXaxZYJ7U4tBzQve5mM
 DuUd8FePL6Kyn0ma31tK2ytpCNpEOQrSy81CWgvuywTQ5ZgnYZRIEXnL75zGTmmZfs9/00RvK
 Wfv0uP0dBKPxlSQgzwhuqu/AdKoqBx7bMJvvyxKT5S4yON/g/XxD+MXtnWdCE/xF5hc8S4c2t
 3HfwmgpKN/D0aYggfjcreb+R0CQAdg1cDxjoadbQXOB9o2n1Ge7QpNzlVCjfWa0l2672vrwu6
 cdGtljYByJqnerPERE2+YcuKWG/25QkQf5nd/geP8UfhkK+TFcSX/rO6pkwlg/qcJhEvXc4Uz
 kaKPihAMw9kOQjRdHl1noxcztuHk+w/mrf/vAM0BLTmBObnYTe9CYRrsWOw1DlRf+RoQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple implementations of the PPP ioctl interface in the
kernel:

- drivers/net/ppp/ppp_generic.c implements a generic interface
  for the /dev/ppp chardev used by some subdrivers.
- drivers/net/ppp/pppox.c implements a socket based interface
  for pppoe, pptp and l2tp.
- drivers/isdn/i4l/isdn_ppp.c is for the i4l ISDN stack

All ioctl commands in the respective functions are compatible between
32-bit and 64-bit kernels, so we can simply mark the handlers themselves
as compatible and stop listing the commands individually.

Four commands (PPPIOCSCOMPRESS, PPPIOCSPASS, PPPIOCSACTIVE, and
PPPIOCGIDLE) are incompatible on the user level but have a translation
handler to make them compatible. I'm simplifying that compat handling
in separate patches.

The PPPIOCGUNIT and PPPIOCGCHAN ioctl commands are special, they are
implemented on various other file descriptors, so we have to keep them
listed as COMPATIBLE_IOCTL().

For the isdn_ppp code, additional ioctl commands are needed that have
never had working compat handling, so I'm leaving that part out: If
they are remaining users of i4l's ippp, they are not using compat
mode today, and are highly unlikely in the future before the last
ISDN network gets shut down. I4L has been deprecated since 2002.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ppp/ppp_generic.c |  1 +
 drivers/net/ppp/pppoe.c       |  3 +++
 drivers/net/ppp/pptp.c        |  3 +++
 fs/compat_ioctl.c             | 31 -------------------------------
 net/l2tp/l2tp_ppp.c           |  3 +++
 5 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 02ad03a2fab7..41a6e9851a4a 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -899,6 +899,7 @@ static const struct file_operations ppp_device_fops = {
 	.write		= ppp_write,
 	.poll		= ppp_poll,
 	.unlocked_ioctl	= ppp_ioctl,
+	.compat_ioctl	= ppp_ioctl,
 	.open		= ppp_open,
 	.release	= ppp_release,
 	.llseek		= noop_llseek,
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index d1c3f9292c54..25174fa7a470 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -1120,6 +1120,9 @@ static const struct proto_ops pppoe_ops = {
 	.recvmsg	= pppoe_recvmsg,
 	.mmap		= sock_no_mmap,
 	.ioctl		= pppox_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= pppox_ioctl,
+#endif
 };
 
 static const struct pppox_proto pppoe_proto = {
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 67ffe74747a1..3b5ab3f6745c 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -632,6 +632,9 @@ static const struct proto_ops pptp_ops = {
 	.recvmsg    = sock_no_recvmsg,
 	.mmap       = sock_no_mmap,
 	.ioctl      = pppox_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = pppox_ioctl,
+#endif
 };
 
 static const struct pppox_proto pppox_pptp_proto = {
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a8bb193fdfd5..142ca673b9cc 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -864,39 +864,8 @@ COMPATIBLE_IOCTL(SG_SET_KEEP_ORPHAN)
 COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
 #endif
 /* PPP stuff */
-COMPATIBLE_IOCTL(PPPIOCGFLAGS)
-COMPATIBLE_IOCTL(PPPIOCSFLAGS)
-COMPATIBLE_IOCTL(PPPIOCGASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSASYNCMAP)
 COMPATIBLE_IOCTL(PPPIOCGUNIT)
-COMPATIBLE_IOCTL(PPPIOCGRASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSRASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCGMRU)
-COMPATIBLE_IOCTL(PPPIOCSMRU)
-COMPATIBLE_IOCTL(PPPIOCSMAXCID)
-COMPATIBLE_IOCTL(PPPIOCGXASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSXASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCXFERUNIT)
-/* PPPIOCSCOMPRESS is translated */
-COMPATIBLE_IOCTL(PPPIOCGNPMODE)
-COMPATIBLE_IOCTL(PPPIOCSNPMODE)
-COMPATIBLE_IOCTL(PPPIOCGDEBUG)
-COMPATIBLE_IOCTL(PPPIOCSDEBUG)
-/* PPPIOCSPASS is translated */
-/* PPPIOCSACTIVE is translated */
-/* PPPIOCGIDLE is translated */
-COMPATIBLE_IOCTL(PPPIOCNEWUNIT)
-COMPATIBLE_IOCTL(PPPIOCATTACH)
-COMPATIBLE_IOCTL(PPPIOCDETACH)
-COMPATIBLE_IOCTL(PPPIOCSMRRU)
-COMPATIBLE_IOCTL(PPPIOCCONNECT)
-COMPATIBLE_IOCTL(PPPIOCDISCONN)
-COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
-COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
-/* PPPOX */
-COMPATIBLE_IOCTL(PPPOEIOCSFWD32)
-COMPATIBLE_IOCTL(PPPOEIOCDFWD)
 /* Big A */
 /* sparc only */
 /* Big Q for sound/OSS */
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 04d9946dcdba..8ef66513fbe0 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1686,6 +1686,9 @@ static const struct proto_ops pppol2tp_ops = {
 	.recvmsg	= pppol2tp_recvmsg,
 	.mmap		= sock_no_mmap,
 	.ioctl		= pppox_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = pppox_ioctl,
+#endif
 };
 
 static const struct pppox_proto pppol2tp_proto = {
-- 
2.18.0

