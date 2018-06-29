Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32367C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7D127F0A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7D127F0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965819AbeF2VI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:08:28 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:50832
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932577AbeF2VI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:08:26 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id Z0c0fA3Dm0KO8Z0c0fwe4v; Fri, 29 Jun 2018 14:07:25 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1fZ0c0-0001mM-NX; Fri, 29 Jun 2018 14:07:24 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_netvsc: split sub-channel setup into async and sync
Date:   Fri, 29 Jun 2018 14:07:16 -0700
Message-Id: <20180629210716.6798-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfNYrlplXXz88xMWwH/YTEl8RRQXTjCSmZxeXXI3gt6cfHdy9uDbQcl2iVVuVbYCoPuEZQoWvIVbAHZwiODFspxp0jnSNHnE10h9yffRFD0LOPpXFYQQI
 KEyjc20GghwsTHvuXnle0tdEDkpDgDLGAyXINYRRmf0wiT5ZZYT1jQoGrXg99bJf2R0cqVxlpZ/t6MSI57mFBGXYGQ2VWxtmB75OpDL3ElW76KvTXgMWn0FJ
 bax0FzAeSe7qN1lNm9+a6gjA+Yjxl+MA2AHuVB8Mvq6lkKTwQ/05nm2VLlMQTUzji1p5/ZNv0w2h27w6PA88URy7jF82rLDxY5FdItVMKW/vMMrrdYVLSfCg
 xekjQAVCROPvzro0XqxFPFzXUopsMSw9wjpJ5ulZrfQQJ0HeL40fhjzSTryc0Ia3Apy0XiC+Hqzs2qHOf86f8Y4jwfmL+CbqDVEPYoiFztfAw3okTWbtuWtt
 +e+gHQaxBhRljYNRUJTAjreSzzHl5Ul4kH0Syg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <sthemmin@microsoft.com>

When doing device hotplug the sub channel must be async to avoid
deadlock issues because device is discovered in softirq context.

When doing changes to MTU and number of channels, the setup
must be synchronous to avoid races such as when MTU and device
settings are done in a single ip command.

Reported-by: Thomas Walker <Thomas.Walker@twosigma.com>
Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Fixes: 732e49850c5e ("netvsc: fix race on sub channel creation")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h   |  2 +-
 drivers/net/hyperv/netvsc.c       | 37 ++++++++++++++++++-
 drivers/net/hyperv/netvsc_drv.c   | 17 ++++++++-
 drivers/net/hyperv/rndis_filter.c | 61 ++++++-------------------------
 4 files changed, 65 insertions(+), 52 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 1a924b867b07..4b6e308199d2 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -210,7 +210,7 @@ int netvsc_recv_callback(struct net_device *net,
 void netvsc_channel_cb(void *context);
 int netvsc_poll(struct napi_struct *napi, int budget);
 
-void rndis_set_subchannel(struct work_struct *w);
+int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev);
 int rndis_filter_open(struct netvsc_device *nvdev);
 int rndis_filter_close(struct netvsc_device *nvdev);
 struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 5d5bd513847f..8e9d0ee1572b 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -65,6 +65,41 @@ void netvsc_switch_datapath(struct net_device *ndev, bool vf)
 			       VM_PKT_DATA_INBAND, 0);
 }
 
+/* Worker to setup sub channels on initial setup
+ * Initial hotplug event occurs in softirq context
+ * and can't wait for channels.
+ */
+static void netvsc_subchan_work(struct work_struct *w)
+{
+	struct netvsc_device *nvdev =
+		container_of(w, struct netvsc_device, subchan_work);
+	struct rndis_device *rdev;
+	int i, ret;
+
+	/* Avoid deadlock with device removal already under RTNL */
+	if (!rtnl_trylock()) {
+		schedule_work(w);
+		return;
+	}
+
+	rdev = nvdev->extension;
+	if (rdev) {
+		ret = rndis_set_subchannel(rdev->ndev, nvdev);
+		if (ret == 0) {
+			netif_device_attach(rdev->ndev);
+		} else {
+			/* fallback to only primary channel */
+			for (i = 1; i < nvdev->num_chn; i++)
+				netif_napi_del(&nvdev->chan_table[i].napi);
+
+			nvdev->max_chn = 1;
+			nvdev->num_chn = 1;
+		}
+	}
+
+	rtnl_unlock();
+}
+
 static struct netvsc_device *alloc_net_device(void)
 {
 	struct netvsc_device *net_device;
@@ -81,7 +116,7 @@ static struct netvsc_device *alloc_net_device(void)
 
 	init_completion(&net_device->channel_init_wait);
 	init_waitqueue_head(&net_device->subchan_open);
-	INIT_WORK(&net_device->subchan_work, rndis_set_subchannel);
+	INIT_WORK(&net_device->subchan_work, netvsc_subchan_work);
 
 	return net_device;
 }
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index fe2256bf1d13..dd1d6e115145 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -905,8 +905,20 @@ static int netvsc_attach(struct net_device *ndev,
 	if (IS_ERR(nvdev))
 		return PTR_ERR(nvdev);
 
-	/* Note: enable and attach happen when sub-channels setup */
+	if (nvdev->num_chn > 1) {
+		ret = rndis_set_subchannel(ndev, nvdev);
+
+		/* if unavailable, just proceed with one queue */
+		if (ret) {
+			nvdev->max_chn = 1;
+			nvdev->num_chn = 1;
+		}
+	}
+
+	/* In any case device is now ready */
+	netif_device_attach(ndev);
 
+	/* Note: enable and attach happen when sub-channels setup */
 	netif_carrier_off(ndev);
 
 	if (netif_running(ndev)) {
@@ -2089,6 +2101,9 @@ static int netvsc_probe(struct hv_device *dev,
 
 	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
 
+	if (nvdev->num_chn > 1)
+		schedule_work(&nvdev->subchan_work);
+
 	/* hw_features computed in rndis_netdev_set_hwcaps() */
 	net->features = net->hw_features |
 		NETIF_F_HIGHDMA | NETIF_F_SG |
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 5428bb261102..9b4e3c3787e5 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1062,29 +1062,15 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
  * This breaks overlap of processing the host message for the
  * new primary channel with the initialization of sub-channels.
  */
-void rndis_set_subchannel(struct work_struct *w)
+int rndis_set_subchannel(struct net_device *ndev, struct netvsc_device *nvdev)
 {
-	struct netvsc_device *nvdev
-		= container_of(w, struct netvsc_device, subchan_work);
 	struct nvsp_message *init_packet = &nvdev->channel_init_pkt;
-	struct net_device_context *ndev_ctx;
-	struct rndis_device *rdev;
-	struct net_device *ndev;
-	struct hv_device *hv_dev;
+	struct net_device_context *ndev_ctx = netdev_priv(ndev);
+	struct hv_device *hv_dev = ndev_ctx->device_ctx;
+	struct rndis_device *rdev = nvdev->extension;
 	int i, ret;
 
-	if (!rtnl_trylock()) {
-		schedule_work(w);
-		return;
-	}
-
-	rdev = nvdev->extension;
-	if (!rdev)
-		goto unlock;	/* device was removed */
-
-	ndev = rdev->ndev;
-	ndev_ctx = netdev_priv(ndev);
-	hv_dev = ndev_ctx->device_ctx;
+	ASSERT_RTNL();
 
 	memset(init_packet, 0, sizeof(struct nvsp_message));
 	init_packet->hdr.msg_type = NVSP_MSG5_TYPE_SUBCHANNEL;
@@ -1100,13 +1086,13 @@ void rndis_set_subchannel(struct work_struct *w)
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret) {
 		netdev_err(ndev, "sub channel allocate send failed: %d\n", ret);
-		goto failed;
+		return ret;
 	}
 
 	wait_for_completion(&nvdev->channel_init_wait);
 	if (init_packet->msg.v5_msg.subchn_comp.status != NVSP_STAT_SUCCESS) {
 		netdev_err(ndev, "sub channel request failed\n");
-		goto failed;
+		return -EIO;
 	}
 
 	nvdev->num_chn = 1 +
@@ -1125,21 +1111,7 @@ void rndis_set_subchannel(struct work_struct *w)
 	for (i = 0; i < VRSS_SEND_TAB_SIZE; i++)
 		ndev_ctx->tx_table[i] = i % nvdev->num_chn;
 
-	netif_device_attach(ndev);
-	rtnl_unlock();
-	return;
-
-failed:
-	/* fallback to only primary channel */
-	for (i = 1; i < nvdev->num_chn; i++)
-		netif_napi_del(&nvdev->chan_table[i].napi);
-
-	nvdev->max_chn = 1;
-	nvdev->num_chn = 1;
-
-	netif_device_attach(ndev);
-unlock:
-	rtnl_unlock();
+	return 0;
 }
 
 static int rndis_netdev_set_hwcaps(struct rndis_device *rndis_device,
@@ -1360,21 +1332,12 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
 		netif_napi_add(net, &net_device->chan_table[i].napi,
 			       netvsc_poll, NAPI_POLL_WEIGHT);
 
-	if (net_device->num_chn > 1)
-		schedule_work(&net_device->subchan_work);
+	return net_device;
 
 out:
-	/* if unavailable, just proceed with one queue */
-	if (ret) {
-		net_device->max_chn = 1;
-		net_device->num_chn = 1;
-	}
-
-	/* No sub channels, device is ready */
-	if (net_device->num_chn == 1)
-		netif_device_attach(net);
-
-	return net_device;
+	/* setting up multiple channels failed */
+	net_device->max_chn = 1;
+	net_device->num_chn = 1;
 
 err_dev_remv:
 	rndis_filter_device_remove(dev, net_device);
-- 
2.17.1

