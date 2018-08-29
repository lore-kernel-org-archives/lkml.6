Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC22C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED8A20844
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED8A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=CARNet.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeH2LNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:13:49 -0400
Received: from mail.CARNet.hr ([161.53.123.6]:34200 "EHLO mail.carnet.hr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH2LNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:13:49 -0400
X-Greylist: delayed 1557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2018 07:13:47 EDT
Received: from [2001:b68:ff:12::131] (port=57870 helo=gavran.carpriv.carnet.hr)
        by mail.carnet.hr with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Valentin.Vidic@CARNet.hr>)
        id 1fuuL1-000771-0L; Wed, 29 Aug 2018 08:52:23 +0200
Received: by gavran.carpriv.carnet.hr (Postfix, from userid 1000)
        id 6355820235; Wed, 29 Aug 2018 08:52:22 +0200 (CEST)
From:   Valentin Vidic <Valentin.Vidic@CARNet.hr>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        stable@vger.kernel.org
Date:   Wed, 29 Aug 2018 08:52:14 +0200
Message-Id: <20180829065214.23546-1-Valentin.Vidic@CARNet.hr>
X-Mailer: git-send-email 2.18.0
X-SA-Exim-Connect-IP: 2001:b68:ff:12::131
Subject: [PATCH] xen-blkback: Switch to closed state after releasing the backing device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to closed state earlier can cause the block-drbd
script to fail with 'Device is held open by someone':

root: /etc/xen/scripts/block-drbd: remove XENBUS_PATH=backend/vbd/6/51712
kernel: [ 2222.278235] block drbd6: State change failed: Device is held open by someone
kernel: [ 2222.278304] block drbd6:   state = { cs:Connected ro:Primary/Secondary ds:UpToDate/UpToDate r----- }
kernel: [ 2222.278340] block drbd6:  wanted = { cs:Connected ro:Secondary/Secondary ds:UpToDate/UpToDate r----- }
root: /etc/xen/scripts/block-drbd: Writing backend/vbd/6/51712/hotplug-error /etc/xen/scripts/block-drbd failed; error detected. backend/vbd/6/51712/hotplug-status error to xenstore.
root: /etc/xen/scripts/block-drbd: /etc/xen/scripts/block-drbd failed; error detected.

Signed-off-by: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: stable@vger.kernel.org
---
 drivers/block/xen-blkback/xenbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index a4bc74e72c39..43bddc996709 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -323,6 +323,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
 {
 	WARN_ON(xen_blkif_disconnect(blkif));
 	xen_vbd_free(&blkif->vbd);
+	xenbus_switch_state(blkif->be->dev, XenbusStateClosed);
 	kfree(blkif->be->mode);
 	kfree(blkif->be);
 
@@ -814,7 +815,6 @@ static void frontend_changed(struct xenbus_device *dev,
 
 	case XenbusStateClosed:
 		xen_blkif_disconnect(be->blkif);
-		xenbus_switch_state(dev, XenbusStateClosed);
 		if (xenbus_dev_is_online(dev))
 			break;
 		/* fall through */
-- 
2.18.0

