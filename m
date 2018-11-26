Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D8920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 02:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D8920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeKZNLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 08:11:35 -0500
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:37768
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726457AbeKZNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 08:11:35 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id R6TGg6axsvsMIR6TGgBLPe; Sun, 25 Nov 2018 19:17:58 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gR6TG-0002jf-Ab; Sun, 25 Nov 2018 19:17:58 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoing_channel()
Date:   Mon, 26 Nov 2018 02:17:56 +0000
Message-Id: <20181126021756.10476-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfL3bnR/ndj2syRF0wdk7ycvcqiXMu4Wu0qYwKvZWoy6o7D6sfgZM3W74nuW3YICDgezKuHbozHnF08Zf6H0V14oRXvQWZITx0p5477KjFLnb830ZC+oE
 s7/MDfVPgp3dnJQ78HeuPH2zLkLYw+T6PYNpMw6HkvgyVIJwdiWDJVg90j2oQ2C9tUWzwU5PVDm+rCbuGdHKa6cn0LbSA/QMP+5djAlBRQ3+A9M/pQh/hIgX
 kCgIalxtF2OyG8QhGaNAHydDkZwjsAu5EcHfxqt019dJ8Ap+JXYEqfKN2z9uAkjj1dDfkxbGdj5i4GyJeKOiQhVASMgU9HEJP4UtcW4InI27rhp5plRcHvWr
 0YfwRnZbmYVtyVNX0xiKcS+SyZPLwvaKlSS7Ee3BBvZDvszpudZuL/E9fvBySX2gsDuTmUbRov2CGdA5eznLBuu62VaZqzBCzFWx4FZoecn9pzuvG9yYh++z
 y5HZsxqNaO+H2va52ncnUnLtcMBgpnii6ntb7k58+Tq80hBBnG01VoZ0+v8SnX2UDF5nUwGfBRqFCXMbczPhEyako1xAbob9aMLKj+dyaYjTAzpDFFh1SVVc
 uKt1n69M66SUDjEIp9LHwsCbqy8tPyPQq2XVN+ETbCIgig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

Commit d86adf482b84 ("scsi: storvsc: Enable multi-queue support") removed
the usage of the API in Jan 2017, and the API is not used since then.

netvsc and storvsc have their own algorithms to determine the outgoing
channel, so this API is useless.

And the API is potentially unsafe, because it reads primary->num_sc without
any lock held. This can be risky considering the RESCIND-OFFER message.

Let's remove the API.

Cc: Long Li <longli@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel.c      |  1 -
 drivers/hv/channel_mgmt.c | 45 ---------------------------------------
 include/linux/hyperv.h    | 17 ---------------
 3 files changed, 63 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index de8193f3b838..f96a77b18bb9 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -703,7 +703,6 @@ int vmbus_disconnect_ring(struct vmbus_channel *channel)
 	/* Snapshot the list of subchannels */
 	spin_lock_irqsave(&channel->lock, flags);
 	list_splice_init(&channel->sc_list, &list);
-	channel->num_sc = 0;
 	spin_unlock_irqrestore(&channel->lock, flags);
 
 	list_for_each_entry_safe(cur_channel, tmp, &list, sc_list) {
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 6277597d3d58..82e673671087 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -405,7 +405,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 		primary_channel = channel->primary_channel;
 		spin_lock_irqsave(&primary_channel->lock, flags);
 		list_del(&channel->sc_list);
-		primary_channel->num_sc--;
 		spin_unlock_irqrestore(&primary_channel->lock, flags);
 	}
 
@@ -483,7 +482,6 @@ static void vmbus_process_offer(struct vmbus_channel *newchannel)
 			newchannel->primary_channel = channel;
 			spin_lock_irqsave(&channel->lock, flags);
 			list_add_tail(&newchannel->sc_list, &channel->sc_list);
-			channel->num_sc++;
 			spin_unlock_irqrestore(&channel->lock, flags);
 		} else {
 			goto err_free_chan;
@@ -1239,49 +1237,6 @@ int vmbus_request_offers(void)
 	return ret;
 }
 
-/*
- * Retrieve the (sub) channel on which to send an outgoing request.
- * When a primary channel has multiple sub-channels, we try to
- * distribute the load equally amongst all available channels.
- */
-struct vmbus_channel *vmbus_get_outgoing_channel(struct vmbus_channel *primary)
-{
-	struct list_head *cur, *tmp;
-	int cur_cpu;
-	struct vmbus_channel *cur_channel;
-	struct vmbus_channel *outgoing_channel = primary;
-	int next_channel;
-	int i = 1;
-
-	if (list_empty(&primary->sc_list))
-		return outgoing_channel;
-
-	next_channel = primary->next_oc++;
-
-	if (next_channel > (primary->num_sc)) {
-		primary->next_oc = 0;
-		return outgoing_channel;
-	}
-
-	cur_cpu = hv_cpu_number_to_vp_number(smp_processor_id());
-	list_for_each_safe(cur, tmp, &primary->sc_list) {
-		cur_channel = list_entry(cur, struct vmbus_channel, sc_list);
-		if (cur_channel->state != CHANNEL_OPENED_STATE)
-			continue;
-
-		if (cur_channel->target_vp == cur_cpu)
-			return cur_channel;
-
-		if (i == next_channel)
-			return cur_channel;
-
-		i++;
-	}
-
-	return outgoing_channel;
-}
-EXPORT_SYMBOL_GPL(vmbus_get_outgoing_channel);
-
 static void invoke_sc_cb(struct vmbus_channel *primary_channel)
 {
 	struct list_head *cur, *tmp;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index b3e24368930a..07a367f5e22f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -830,15 +830,6 @@ struct vmbus_channel {
 	 * All Sub-channels of a primary channel are linked here.
 	 */
 	struct list_head sc_list;
-	/*
-	 * Current number of sub-channels.
-	 */
-	int num_sc;
-	/*
-	 * Number of a sub-channel (position within sc_list) which is supposed
-	 * to be used as the next outgoing channel.
-	 */
-	int next_oc;
 	/*
 	 * The primary channel this sub-channel belongs to.
 	 * This will be NULL for the primary channel.
@@ -965,14 +956,6 @@ void vmbus_set_sc_create_callback(struct vmbus_channel *primary_channel,
 void vmbus_set_chn_rescind_callback(struct vmbus_channel *channel,
 		void (*chn_rescind_cb)(struct vmbus_channel *));
 
-/*
- * Retrieve the (sub) channel on which to send an outgoing request.
- * When a primary channel has multiple sub-channels, we choose a
- * channel whose VCPU binding is closest to the VCPU on which
- * this call is being made.
- */
-struct vmbus_channel *vmbus_get_outgoing_channel(struct vmbus_channel *primary);
-
 /*
  * Check if sub-channels have already been offerred. This API will be useful
  * when the driver is unloaded after establishing sub-channels. In this case,
-- 
2.19.1

