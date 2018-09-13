Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2369C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FA320861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FA320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIMTVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:21:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbeIMTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5952D1A;
        Thu, 13 Sep 2018 13:50:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 018/197] hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()
Date:   Thu, 13 Sep 2018 15:29:27 +0200
Message-Id: <20180913131842.299183283@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit e04e7a7bbd4bbabef4e1a58367e5fc9b2edc3b10 ]

This patch fixes the race between netvsc_probe() and
rndis_set_subchannel(), which can cause a deadlock.

These are the related 3 paths which show the deadlock:

path #1:
    Workqueue: hv_vmbus_con vmbus_onmessage_work [hv_vmbus]
    Call Trace:
     schedule
     schedule_preempt_disabled
     __mutex_lock
     __device_attach
     bus_probe_device
     device_add
     vmbus_device_register
     vmbus_onoffer
     vmbus_onmessage_work
     process_one_work
     worker_thread
     kthread
     ret_from_fork

path #2:
    schedule
     schedule_preempt_disabled
     __mutex_lock
     netvsc_probe
     vmbus_probe
     really_probe
     __driver_attach
     bus_for_each_dev
     driver_attach_async
     async_run_entry_fn
     process_one_work
     worker_thread
     kthread
     ret_from_fork

path #3:
    Workqueue: events netvsc_subchan_work [hv_netvsc]
    Call Trace:
     schedule
     rndis_set_subchannel
     netvsc_subchan_work
     process_one_work
     worker_thread
     kthread
     ret_from_fork

Before path #1 finishes, path #2 can start to run, because just before
the "bus_probe_device(dev);" in device_add() in path #1, there is a line
"object_uevent(&dev->kobj, KOBJ_ADD);", so systemd-udevd can
immediately try to load hv_netvsc and hence path #2 can start to run.

Next, path #2 offloads the subchannal's initialization to a workqueue,
i.e. path #3, so we can end up in a deadlock situation like this:

Path #2 gets the device lock, and is trying to get the rtnl lock;
Path #3 gets the rtnl lock and is waiting for all the subchannel messages
to be processed;
Path #1 is trying to get the device lock, but since #2 is not releasing
the device lock, path #1 has to sleep; since the VMBus messages are
processed one by one, this means the sub-channel messages can't be
procedded, so #3 has to sleep with the rtnl lock held, and finally #2
has to sleep... Now all the 3 paths are sleeping and we hit the deadlock.

With the patch, we can make sure #2 gets both the device lock and the
rtnl lock together, gets its job done, and releases the locks, so #1
and #3 will not be blocked for ever.

Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2101,6 +2101,16 @@ static int netvsc_probe(struct hv_device
 
 	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
 
+	/* We must get rtnl lock before scheduling nvdev->subchan_work,
+	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
+	 * all subchannels to show up, but that may not happen because
+	 * netvsc_probe() can't get rtnl lock and as a result vmbus_onoffer()
+	 * -> ... -> device_add() -> ... -> __device_attach() can't get
+	 * the device lock, so all the subchannels can't be processed --
+	 * finally netvsc_subchan_work() hangs for ever.
+	 */
+	rtnl_lock();
+
 	if (nvdev->num_chn > 1)
 		schedule_work(&nvdev->subchan_work);
 
@@ -2119,7 +2129,6 @@ static int netvsc_probe(struct hv_device
 	else
 		net->max_mtu = ETH_DATA_LEN;
 
-	rtnl_lock();
 	ret = register_netdevice(net);
 	if (ret != 0) {
 		pr_err("Unable to register netdev.\n");


