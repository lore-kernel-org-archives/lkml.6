Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B7FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141AF20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141AF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeIHCKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:10:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeIHCJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:09:59 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53367EF6;
        Fri,  7 Sep 2018 21:27:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 4.14 35/89] Drivers: hv: vmbus: Reset the channel callback in vmbus_onoffer_rescind()
Date:   Fri,  7 Sep 2018 23:09:29 +0200
Message-Id: <20180907210856.678994879@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit d3b26dd7cb0e3433bfd3c1d4dcf74c6039bb49fb upstream.

Before setting channel->rescind in vmbus_rescind_cleanup(), we should make
sure the channel callback won't run any more, otherwise a high-level
driver like pci_hyperv, which may be infinitely waiting for the host VSP's
response and notices the channel has been rescinded, can't safely give
up: e.g., in hv_pci_protocol_negotiation() -> wait_for_response(), it's
unsafe to exit from wait_for_response() and proceed with the on-stack
variable "comp_pkt" popped. The issue was originally spotted by
Michael Kelley <mikelley@microsoft.com>.

In vmbus_close_internal(), the patch also minimizes the range protected by
disabling/enabling channel->callback_event: we don't really need that for
the whole function.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hv/channel.c      |   40 ++++++++++++++++++++++++----------------
 drivers/hv/channel_mgmt.c |    6 ++++++
 include/linux/hyperv.h    |    2 ++
 3 files changed, 32 insertions(+), 16 deletions(-)

--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -541,11 +541,8 @@ static void reset_channel_cb(void *arg)
 	channel->onchannel_callback = NULL;
 }
 
-static int vmbus_close_internal(struct vmbus_channel *channel)
+void vmbus_reset_channel_cb(struct vmbus_channel *channel)
 {
-	struct vmbus_channel_close_channel *msg;
-	int ret;
-
 	/*
 	 * vmbus_on_event(), running in the per-channel tasklet, can race
 	 * with vmbus_close_internal() in the case of SMP guest, e.g., when
@@ -555,6 +552,29 @@ static int vmbus_close_internal(struct v
 	 */
 	tasklet_disable(&channel->callback_event);
 
+	channel->sc_creation_callback = NULL;
+
+	/* Stop the callback asap */
+	if (channel->target_cpu != get_cpu()) {
+		put_cpu();
+		smp_call_function_single(channel->target_cpu, reset_channel_cb,
+					 channel, true);
+	} else {
+		reset_channel_cb(channel);
+		put_cpu();
+	}
+
+	/* Re-enable tasklet for use on re-open */
+	tasklet_enable(&channel->callback_event);
+}
+
+static int vmbus_close_internal(struct vmbus_channel *channel)
+{
+	struct vmbus_channel_close_channel *msg;
+	int ret;
+
+	vmbus_reset_channel_cb(channel);
+
 	/*
 	 * In case a device driver's probe() fails (e.g.,
 	 * util_probe() -> vmbus_open() returns -ENOMEM) and the device is
@@ -568,16 +588,6 @@ static int vmbus_close_internal(struct v
 	}
 
 	channel->state = CHANNEL_OPEN_STATE;
-	channel->sc_creation_callback = NULL;
-	/* Stop callback and cancel the timer asap */
-	if (channel->target_cpu != get_cpu()) {
-		put_cpu();
-		smp_call_function_single(channel->target_cpu, reset_channel_cb,
-					 channel, true);
-	} else {
-		reset_channel_cb(channel);
-		put_cpu();
-	}
 
 	/* Send a closing message */
 
@@ -620,8 +630,6 @@ static int vmbus_close_internal(struct v
 		get_order(channel->ringbuffer_pagecount * PAGE_SIZE));
 
 out:
-	/* re-enable tasklet for use on re-open */
-	tasklet_enable(&channel->callback_event);
 	return ret;
 }
 
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -882,6 +882,12 @@ static void vmbus_onoffer_rescind(struct
 	}
 
 	/*
+	 * Before setting channel->rescind in vmbus_rescind_cleanup(), we
+	 * should make sure the channel callback is not running any more.
+	 */
+	vmbus_reset_channel_cb(channel);
+
+	/*
 	 * Now wait for offer handling to complete.
 	 */
 	vmbus_rescind_cleanup(channel);
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1026,6 +1026,8 @@ extern int vmbus_establish_gpadl(struct
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
 				     u32 gpadl_handle);
 
+void vmbus_reset_channel_cb(struct vmbus_channel *channel);
+
 extern int vmbus_recvpacket(struct vmbus_channel *channel,
 				  void *buffer,
 				  u32 bufferlen,


