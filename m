Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B232084E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B232084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeKZLTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:19:44 -0500
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:48702
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbeKZLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:19:44 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id R4jDgRgszThUeR4jDgZY6z; Sun, 25 Nov 2018 17:26:20 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gR4jD-0001w1-My; Sun, 25 Nov 2018 17:26:19 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, ohering@suse.com,
        James.Bottomley@HansenPartnership.com, hch@infradead.org,
        linux-scsi@vger.kernel.org, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, martin.petersen@oracle.com, hare@suse.de
Cc:     Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH] scsi: storvsc: Fix a race in sub-channel creation that can cause panic
Date:   Mon, 26 Nov 2018 00:26:17 +0000
Message-Id: <20181126002617.7398-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAPJr72drq85secbNnXjw9dGXqTQof+NLx3XChbuVl1VyLwLfTXSfxXa4wPFy6LCnu3LoBzM16/N2cKyoigm+QQ2K2smilNbQegKek6X6jglDwN6sOBe
 /+pRMZfNbaNL3pY4HwNKbxTRDj29QiI4Vr+CzDj0RuHsGniEDUfQQXi+zWnoed6My9FHe3quY0XIX80GNcIc5V0U6iTu5BiZqCMP0LQ0CdHyeaTgOwmWvgUU
 ev7bKxVW18BZB758snw7gYzPtIBI0kn4jH3TOH/wdghowNsE8lWpq7i/DfVdd5aGqQRVCnvh41I0mwD0u545hh/2ehCYsLfgm/87sENm5x05y9SDGktmzyvS
 NYvrq7v48/h5n4OIb3Nd32ZW0mWBcqESbnlXff/n6CEwlz+1uo0YPUfi11/A2buqshOnn6NV176zR7q2v8Hwo8TfL8plrxoyGKPDdbFmVc19PcMu5tDOiANT
 5NWsH0zTndbJRM4TjX7SHD6bxMGsm+AvYqO7FxCuhBz511elraNeLJ1RUXpGEzM2UvmYbpHqIHCDzlPLfL+rPm2ATsZG1YNC4z+2vezVYK2CNNVujPqiQ92C
 NN3gOk5+kMlwGeubRkRKdbqQElTJsrjjVHypTO8WeVeBiEGXi3vh1ZsJVep/6UuungYZt3q36ZNIv6jMWnAdtqBAfm4+4Jo08LVF4DXyljxQ1dxLoFChBMFh
 fVsuX+72xJU+lfpRZLHP2HvcbvT0QBJ5EI9VjNQrEpBsqLhE+7pF23u2ibd1vwviecbkEa3a7WrR89s0FRm4yyejV/egx8L3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

We can concurrently try to open the same sub-channel from 2 paths:

path #1: vmbus_onoffer() -> vmbus_process_offer() -> handle_sc_creation().
path #2: storvsc_probe() -> storvsc_connect_to_vsp() ->
	 -> storvsc_channel_init() -> handle_multichannel_storage() ->
	 -> vmbus_are_subchannels_present() -> handle_sc_creation().

They conflict with each other, but it was not an issue before the recent
commit ae6935ed7d42 ("vmbus: split ring buffer allocation from open"),
because at the beginning of vmbus_open() we checked newchannel->state so
only one path could succeed, and the other would return with -EINVAL.

After ae6935ed7d42, the failing path frees the channel's ringbuffer by
vmbus_free_ring(), and this causes a panic later.

Commit ae6935ed7d42 itself is good, and it just reveals the longstanding
race. We can resolve the issue by removing path #2, i.e. removing the
second vmbus_are_subchannels_present() in handle_multichannel_storage().

BTW, the comment "Check to see if sub-channels have already been created"
in handle_multichannel_storage() is incorrect: when we unload the driver,
we first close the sub-channel(s) and then close the primary channel, next
the host sends rescind-offer message(s) so primary->sc_list will become
empty. This means the first vmbus_are_subchannels_present() in
handle_multichannel_storage() is never useful.

Fixes: ae6935ed7d42 ("vmbus: split ring buffer allocation from open")
Cc: stable@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 61 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index f03dc03a42c3..8f88348ebe42 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -446,7 +446,6 @@ struct storvsc_device {
 
 	bool	 destroy;
 	bool	 drain_notify;
-	bool	 open_sub_channel;
 	atomic_t num_outstanding_req;
 	struct Scsi_Host *host;
 
@@ -636,33 +635,38 @@ static inline struct storvsc_device *get_in_stor_device(
 static void handle_sc_creation(struct vmbus_channel *new_sc)
 {
 	struct hv_device *device = new_sc->primary_channel->device_obj;
+	struct device *dev = &device->device;
 	struct storvsc_device *stor_device;
 	struct vmstorage_channel_properties props;
+	int ret;
 
 	stor_device = get_out_stor_device(device);
 	if (!stor_device)
 		return;
 
-	if (stor_device->open_sub_channel == false)
-		return;
-
 	memset(&props, 0, sizeof(struct vmstorage_channel_properties));
 
-	vmbus_open(new_sc,
-		   storvsc_ringbuffer_size,
-		   storvsc_ringbuffer_size,
-		   (void *)&props,
-		   sizeof(struct vmstorage_channel_properties),
-		   storvsc_on_channel_callback, new_sc);
+	ret = vmbus_open(new_sc,
+			 storvsc_ringbuffer_size,
+			 storvsc_ringbuffer_size,
+			 (void *)&props,
+			 sizeof(struct vmstorage_channel_properties),
+			 storvsc_on_channel_callback, new_sc);
 
-	if (new_sc->state == CHANNEL_OPENED_STATE) {
-		stor_device->stor_chns[new_sc->target_cpu] = new_sc;
-		cpumask_set_cpu(new_sc->target_cpu, &stor_device->alloced_cpus);
+	/* In case vmbus_open() fails, we don't use the sub-channel. */
+	if (ret != 0) {
+		dev_err(dev, "Failed to open sub-channel: err=%d\n", ret);
+		return;
 	}
+
+	/* Add the sub-channel to the array of available channels. */
+	stor_device->stor_chns[new_sc->target_cpu] = new_sc;
+	cpumask_set_cpu(new_sc->target_cpu, &stor_device->alloced_cpus);
 }
 
 static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 {
+	struct device *dev = &device->device;
 	struct storvsc_device *stor_device;
 	int num_cpus = num_online_cpus();
 	int num_sc;
@@ -679,21 +683,11 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 	request = &stor_device->init_request;
 	vstor_packet = &request->vstor_packet;
 
-	stor_device->open_sub_channel = true;
 	/*
 	 * Establish a handler for dealing with subchannels.
 	 */
 	vmbus_set_sc_create_callback(device->channel, handle_sc_creation);
 
-	/*
-	 * Check to see if sub-channels have already been created. This
-	 * can happen when this driver is re-loaded after unloading.
-	 */
-
-	if (vmbus_are_subchannels_present(device->channel))
-		return;
-
-	stor_device->open_sub_channel = false;
 	/*
 	 * Request the host to create sub-channels.
 	 */
@@ -710,23 +704,29 @@ static void  handle_multichannel_storage(struct hv_device *device, int max_chns)
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 
-	if (ret != 0)
+	if (ret != 0) {
+		dev_err(dev, "Failed to create sub-channel: err=%d\n", ret);
 		return;
+	}
 
 	t = wait_for_completion_timeout(&request->wait_event, 10*HZ);
-	if (t == 0)
+	if (t == 0) {
+		dev_err(dev, "Failed to create sub-channel: timed out\n");
 		return;
+	}
 
 	if (vstor_packet->operation != VSTOR_OPERATION_COMPLETE_IO ||
-	    vstor_packet->status != 0)
+	    vstor_packet->status != 0) {
+		dev_err(dev, "Failed to create sub-channel: op=%d, sts=%d\n",
+			vstor_packet->operation, vstor_packet->status);
 		return;
+	}
 
 	/*
-	 * Now that we created the sub-channels, invoke the check; this
-	 * may trigger the callback.
+	 * We need to do nothing here, because vmbus_process_offer()
+	 * invokes channel->sc_creation_callback, which will open and use
+	 * the sub-channel(s).
 	 */
-	stor_device->open_sub_channel = true;
-	vmbus_are_subchannels_present(device->channel);
 }
 
 static void cache_wwn(struct storvsc_device *stor_device,
@@ -1794,7 +1794,6 @@ static int storvsc_probe(struct hv_device *device,
 	}
 
 	stor_device->destroy = false;
-	stor_device->open_sub_channel = false;
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
 	stor_device->host = host;
-- 
2.19.1

