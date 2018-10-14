Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B99C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0520645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD0520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeJNXiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:38:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35972 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbeJNXLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:52 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLf-0004cC-Vs; Sun, 14 Oct 2018 16:30:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000kZ-29; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.354664640@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 349/366] ppp: fix device unregistration upon netns
 deletion
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

commit 8cb775bc0a34dc596837e7da03fd22c747be618b upstream.

PPP devices may get automatically unregistered when their network
namespace is getting removed. This happens if the ppp control plane
daemon (e.g. pppd) exits while it is the last user of this namespace.

This leads to several races:

  * ppp_exit_net() may destroy the per namespace idr (pn->units_idr)
    before all file descriptors were released. Successive ppp_release()
    calls may then cleanup PPP devices with ppp_shutdown_interface() and
    try to use the already destroyed idr.

  * Automatic device unregistration may also happen before the
    ppp_release() call for that device gets executed. Once called on
    the file owning the device, ppp_release() will then clean it up and
    try to unregister it a second time.

To fix these issues, operations defined in ppp_shutdown_interface() are
moved to the PPP device's ndo_uninit() callback. This allows PPP
devices to be properly cleaned up by unregister_netdev() and friends.
So checking for ppp->owner is now an accurate test to decide if a PPP
device should be unregistered.

Setting ppp->owner is done in ppp_create_interface(), before device
registration, in order to avoid unprotected modification of this field.

Finally, ppp_exit_net() now starts by unregistering all remaining PPP
devices to ensure that none will get unregistered after the call to
idr_destroy().

Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ppp/ppp_generic.c | 78 +++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 36 deletions(-)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -269,9 +269,9 @@ static void ppp_ccp_peek(struct ppp *ppp
 static void ppp_ccp_closed(struct ppp *ppp);
 static struct compressor *find_compressor(int type);
 static void ppp_get_stats(struct ppp *ppp, struct ppp_stats *st);
-static struct ppp *ppp_create_interface(struct net *net, int unit, int *retp);
+static struct ppp *ppp_create_interface(struct net *net, int unit,
+					struct file *file, int *retp);
 static void init_ppp_file(struct ppp_file *pf, int kind);
-static void ppp_shutdown_interface(struct ppp *ppp);
 static void ppp_destroy_interface(struct ppp *ppp);
 static struct ppp *ppp_find_unit(struct ppp_net *pn, int unit);
 static struct channel *ppp_find_channel(struct ppp_net *pn, int unit);
@@ -392,8 +392,10 @@ static int ppp_release(struct inode *unu
 		file->private_data = NULL;
 		if (pf->kind == INTERFACE) {
 			ppp = PF_TO_PPP(pf);
+			rtnl_lock();
 			if (file == ppp->owner)
-				ppp_shutdown_interface(ppp);
+				unregister_netdevice(ppp->dev);
+			rtnl_unlock();
 		}
 		if (atomic_dec_and_test(&pf->refcnt)) {
 			switch (pf->kind) {
@@ -595,8 +597,10 @@ static long ppp_ioctl(struct file *file,
 		err = -EINVAL;
 		if (pf->kind == INTERFACE) {
 			ppp = PF_TO_PPP(pf);
+			rtnl_lock();
 			if (file == ppp->owner)
-				ppp_shutdown_interface(ppp);
+				unregister_netdevice(ppp->dev);
+			rtnl_unlock();
 		}
 		if (atomic_long_read(&file->f_count) < 2) {
 			ppp_release(NULL, file);
@@ -833,11 +837,10 @@ static int ppp_unattached_ioctl(struct n
 		/* Create a new ppp unit */
 		if (get_user(unit, p))
 			break;
-		ppp = ppp_create_interface(net, unit, &err);
+		ppp = ppp_create_interface(net, unit, file, &err);
 		if (!ppp)
 			break;
 		file->private_data = &ppp->file;
-		ppp->owner = file;
 		err = -EFAULT;
 		if (put_user(ppp->file.index, p))
 			break;
@@ -911,6 +914,16 @@ static __net_init int ppp_init_net(struc
 static __net_exit void ppp_exit_net(struct net *net)
 {
 	struct ppp_net *pn = net_generic(net, ppp_net_id);
+	struct ppp *ppp;
+	LIST_HEAD(list);
+	int id;
+
+	rtnl_lock();
+	idr_for_each_entry(&pn->units_idr, ppp, id)
+		unregister_netdevice_queue(ppp->dev, &list);
+
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
 
 	idr_destroy(&pn->units_idr);
 }
@@ -1083,8 +1096,28 @@ static int ppp_dev_init(struct net_devic
 	return 0;
 }
 
+static void ppp_dev_uninit(struct net_device *dev)
+{
+	struct ppp *ppp = netdev_priv(dev);
+	struct ppp_net *pn = ppp_pernet(ppp->ppp_net);
+
+	ppp_lock(ppp);
+	ppp->closing = 1;
+	ppp_unlock(ppp);
+
+	mutex_lock(&pn->all_ppp_mutex);
+	unit_put(&pn->units_idr, ppp->file.index);
+	mutex_unlock(&pn->all_ppp_mutex);
+
+	ppp->owner = NULL;
+
+	ppp->file.dead = 1;
+	wake_up_interruptible(&ppp->file.rwait);
+}
+
 static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_init	 = ppp_dev_init,
+	.ndo_uninit      = ppp_dev_uninit,
 	.ndo_start_xmit  = ppp_start_xmit,
 	.ndo_do_ioctl    = ppp_net_ioctl,
 	.ndo_get_stats64 = ppp_get_stats64,
@@ -2662,8 +2695,8 @@ ppp_get_stats(struct ppp *ppp, struct pp
  * or if there is already a unit with the requested number.
  * unit == -1 means allocate a new number.
  */
-static struct ppp *
-ppp_create_interface(struct net *net, int unit, int *retp)
+static struct ppp *ppp_create_interface(struct net *net, int unit,
+					struct file *file, int *retp)
 {
 	struct ppp *ppp;
 	struct ppp_net *pn;
@@ -2682,6 +2715,7 @@ ppp_create_interface(struct net *net, in
 	ppp->mru = PPP_MRU;
 	init_ppp_file(&ppp->file, INTERFACE);
 	ppp->file.hdrlen = PPP_HDRLEN - 2;	/* don't count proto bytes */
+	ppp->owner = file;
 	for (i = 0; i < NUM_NP; ++i)
 		ppp->npmode[i] = NPMODE_PASS;
 	INIT_LIST_HEAD(&ppp->channels);
@@ -2770,34 +2804,6 @@ init_ppp_file(struct ppp_file *pf, int k
 }
 
 /*
- * Take down a ppp interface unit - called when the owning file
- * (the one that created the unit) is closed or detached.
- */
-static void ppp_shutdown_interface(struct ppp *ppp)
-{
-	struct ppp_net *pn;
-
-	pn = ppp_pernet(ppp->ppp_net);
-	mutex_lock(&pn->all_ppp_mutex);
-
-	/* This will call dev_close() for us. */
-	ppp_lock(ppp);
-	if (!ppp->closing) {
-		ppp->closing = 1;
-		ppp_unlock(ppp);
-		unregister_netdev(ppp->dev);
-		unit_put(&pn->units_idr, ppp->file.index);
-	} else
-		ppp_unlock(ppp);
-
-	ppp->file.dead = 1;
-	ppp->owner = NULL;
-	wake_up_interruptible(&ppp->file.rwait);
-
-	mutex_unlock(&pn->all_ppp_mutex);
-}
-
-/*
  * Free the memory used by a ppp unit.  This is only called once
  * there are no channels connected to the unit and no file structs
  * that reference the unit.

