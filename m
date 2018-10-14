Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29851C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF7120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF7120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJNXLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35929 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbeJNXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLe-0004cS-Sf; Sun, 14 Oct 2018 16:30:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000kv-7A; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.58413525@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 353/366] ppp: unlock all_ppp_mutex before registering
 device
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

commit 0171c41835591e9aa2e384b703ef9a6ae367c610 upstream.

ppp_dev_uninit(), which is the .ndo_uninit() handler of PPP devices,
needs to lock pn->all_ppp_mutex. Therefore we mustn't call
register_netdevice() with pn->all_ppp_mutex already locked, or we'd
deadlock in case register_netdevice() fails and calls .ndo_uninit().

Fortunately, we can unlock pn->all_ppp_mutex before calling
register_netdevice(). This lock protects pn->units_idr, which isn't
used in the device registration process.

However, keeping pn->all_ppp_mutex locked during device registration
did ensure that no device in transient state would be published in
pn->units_idr. In practice, unlocking it before calling
register_netdevice() doesn't change this property: ppp_unit_register()
is called with 'ppp_mutex' locked and all searches done in
pn->units_idr hold this lock too.

Fixes: 8cb775bc0a34 ("ppp: fix device unregistration upon netns deletion")
Reported-and-tested-by: syzbot+367889b9c9e279219175@syzkaller.appspotmail.com
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ppp/ppp_generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2788,6 +2788,8 @@ static struct ppp *ppp_create_interface(
 	ppp->file.index = unit;
 	sprintf(dev->name, "ppp%d", unit);
 
+	mutex_unlock(&pn->all_ppp_mutex);
+
 	ret = register_netdevice(dev);
 	if (ret != 0) {
 		/* register_netdevice() may have called ppp_dev_init()
@@ -2796,6 +2798,7 @@ static struct ppp *ppp_create_interface(
 		 */
 		if (dev->qdisc_tx_busylock)
 			ppp_dev_priv_destructor(dev);
+		mutex_lock(&pn->all_ppp_mutex);
 		unit_put(&pn->units_idr, unit);
 		netdev_err(ppp->dev, "PPP: couldn't register device %s (%d)\n",
 			   dev->name, ret);
@@ -2803,7 +2806,6 @@ static struct ppp *ppp_create_interface(
 	}
 
 	atomic_inc(&ppp_unit_count);
-	mutex_unlock(&pn->all_ppp_mutex);
 	rtnl_unlock();
 
 	*retp = 0;

