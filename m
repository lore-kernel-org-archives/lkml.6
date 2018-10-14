Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16208C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCFD20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCFD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeJNXj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:39:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35926 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727483AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cD-SF; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000kj-4g; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Beniamino Galvani" <bgalvani@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.583563981@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 351/366] ppp: fix race in ppp device destruction
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

From: Guillaume Nault <g.nault@alphalink.fr>

commit 6151b8b37b119e8e3a8401b080d532520c95faf4 upstream.

ppp_release() tries to ensure that netdevices are unregistered before
decrementing the unit refcount and running ppp_destroy_interface().

This is all fine as long as the the device is unregistered by
ppp_release(): the unregister_netdevice() call, followed by
rtnl_unlock(), guarantee that the unregistration process completes
before rtnl_unlock() returns.

However, the device may be unregistered by other means (like
ppp_nl_dellink()). If this happens right before ppp_release() calling
rtnl_lock(), then ppp_release() has to wait for the concurrent
unregistration code to release the lock.
But rtnl_unlock() releases the lock before completing the device
unregistration process. This allows ppp_release() to proceed and
eventually call ppp_destroy_interface() before the unregistration
process completes. Calling free_netdev() on this partially unregistered
device will BUG():

 ------------[ cut here ]------------
 kernel BUG at net/core/dev.c:8141!
 invalid opcode: 0000 [#1] SMP

 CPU: 1 PID: 1557 Comm: pppd Not tainted 4.14.0-rc2+ #4
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014

 Call Trace:
  ppp_destroy_interface+0xd8/0xe0 [ppp_generic]
  ppp_disconnect_channel+0xda/0x110 [ppp_generic]
  ppp_unregister_channel+0x5e/0x110 [ppp_generic]
  pppox_unbind_sock+0x23/0x30 [pppox]
  pppoe_connect+0x130/0x440 [pppoe]
  SYSC_connect+0x98/0x110
  ? do_fcntl+0x2c0/0x5d0
  SyS_connect+0xe/0x10
  entry_SYSCALL_64_fastpath+0x1a/0xa5

 RIP: free_netdev+0x107/0x110 RSP: ffffc28a40573d88
 ---[ end trace ed294ff0cc40eeff ]---

We could set the ->needs_free_netdev flag on PPP devices and move the
ppp_destroy_interface() logic in the ->priv_destructor() callback. But
that'd be quite intrusive as we'd first need to unlink from the other
channels and units that depend on the device (the ones that used the
PPPIOCCONNECT and PPPIOCATTACH ioctls).

Instead, we can just let the netdevice hold a reference on its
ppp_file. This reference is dropped in ->priv_destructor(), at the very
end of the unregistration process, so that neither ppp_release() nor
ppp_disconnect_channel() can call ppp_destroy_interface() in the interim.

Reported-by: Beniamino Galvani <bgalvani@redhat.com>
Fixes: 8cb775bc0a34 ("ppp: fix device unregistration upon netns deletion")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Set net_device::destructor instead of
 priv_destructor, and call ppp_dev_priv_destructor() if register_netdevice()
 fails after call ppp_dev_init().]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ppp/ppp_generic.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1092,7 +1092,17 @@ ppp_get_stats64(struct net_device *dev,
 static struct lock_class_key ppp_tx_busylock;
 static int ppp_dev_init(struct net_device *dev)
 {
+	struct ppp *ppp;
+
 	dev->qdisc_tx_busylock = &ppp_tx_busylock;
+
+	ppp = netdev_priv(dev);
+	/* Let the netdevice take a reference on the ppp file. This ensures
+	 * that ppp_destroy_interface() won't run before the device gets
+	 * unregistered.
+	 */
+	atomic_inc(&ppp->file.refcnt);
+
 	return 0;
 }
 
@@ -1115,6 +1125,15 @@ static void ppp_dev_uninit(struct net_de
 	wake_up_interruptible(&ppp->file.rwait);
 }
 
+static void ppp_dev_priv_destructor(struct net_device *dev)
+{
+	struct ppp *ppp;
+
+	ppp = netdev_priv(dev);
+	if (atomic_dec_and_test(&ppp->file.refcnt))
+		ppp_destroy_interface(ppp);
+}
+
 static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_init	 = ppp_dev_init,
 	.ndo_uninit      = ppp_dev_uninit,
@@ -1134,6 +1153,7 @@ static void ppp_setup(struct net_device
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->features |= NETIF_F_NETNS_LOCAL;
 	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	dev->destructor = ppp_dev_priv_destructor;
 }
 
 /*
@@ -2769,6 +2789,12 @@ static struct ppp *ppp_create_interface(
 
 	ret = register_netdevice(dev);
 	if (ret != 0) {
+		/* register_netdevice() may have called ppp_dev_init()
+		 * but will not have called our destructor, so do that
+		 * now.
+		 */
+		if (dev->qdisc_tx_busylock)
+			ppp_dev_priv_destructor(dev);
 		unit_put(&pn->units_idr, unit);
 		netdev_err(ppp->dev, "PPP: couldn't register device %s (%d)\n",
 			   dev->name, ret);

