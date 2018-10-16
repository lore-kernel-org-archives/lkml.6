Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3759C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E7214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0O0cJRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E7214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeJPMEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbeJPMEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BDA21477;
        Tue, 16 Oct 2018 04:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663357;
        bh=v8gY7DhRJyHQ+HJ3Ron0sCXFh17pegSjSZuJ4xbk8nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0O0cJRgZ+jmzgzooDx0pwuWn3sH7KjzQXM2z6o4El8PUYoRK6gjEoZQeANmYkqiD
         paMSFzAq+J2ceVheNPH5j0UOMuK6zewBdjR/xQlJsGgunQvBkBBiAQWJu6w8Hl+TGt
         m4bWxInWPoBOQP+Y7RW8TWsyTolmUhrZ4eYQo6/U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 36/38] net/usb: cancel pending work when unbinding smsc75xx
Date:   Tue, 16 Oct 2018 00:15:20 -0400
Message-Id: <20181016041522.135789-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit f7b2a56e1f3dcbdb4cf09b2b63e859ffe0e09df8 ]

Cancel pending work before freeing smsc75xx private data structure
during binding. This fixes the following crash in the driver:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
IP: mutex_lock+0x2b/0x3f
<snipped>
Workqueue: events smsc75xx_deferred_multicast_write [smsc75xx]
task: ffff8caa83e85700 task.stack: ffff948b80518000
RIP: 0010:mutex_lock+0x2b/0x3f
<snipped>
Call Trace:
 smsc75xx_deferred_multicast_write+0x40/0x1af [smsc75xx]
 process_one_work+0x18d/0x2fc
 worker_thread+0x1a2/0x269
 ? pr_cont_work+0x58/0x58
 kthread+0xfa/0x10a
 ? pr_cont_work+0x58/0x58
 ? rcu_read_unlock_sched_notrace+0x48/0x48
 ret_from_fork+0x22/0x40

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc75xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index f7aacd73b5a8..977d9c772554 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -1521,6 +1521,7 @@ static void smsc75xx_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
 	struct smsc75xx_priv *pdata = (struct smsc75xx_priv *)(dev->data[0]);
 	if (pdata) {
+		cancel_work_sync(&pdata->set_multicast);
 		netif_dbg(dev, ifdown, dev->net, "free pdata\n");
 		kfree(pdata);
 		pdata = NULL;
-- 
2.17.1

