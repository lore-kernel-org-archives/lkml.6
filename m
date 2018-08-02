Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF939C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B02B208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B02B208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHBE60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:58:26 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:38590
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbeHBE60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:58:26 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id l3yUfHjc1q9i0l3yUfwUls; Wed, 01 Aug 2018 20:08:27 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fl3yU-0002oQ-Px; Wed, 01 Aug 2018 20:08:26 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/3] Drivers: hv: vmbus: Reset the channel callback in vmbus_onoffer_rescind()
Date:   Thu,  2 Aug 2018 03:08:23 +0000
Message-Id: <20180802030825.10768-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802030718.10708-1-kys@linuxonhyperv.com>
References: <20180802030718.10708-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfGj+5R+oLf1gbOIJZFqVo6xsg6hpzcDt0JrZA0mW8e9hFUk5dRuWaxwOpPtf+GVsjEcDf2OXxq0fg76qiXtijlZctLn2ogcIUaVgssfSnlMRe7uCN3sK
 jpuNgnsFe9bqAEk7yLo27EqJkU/OVNpPbnLwr7dy0SJZrqXfHGtjyJwC+nnSCF6AZ44JvEdyQt89GcMuGc1+OAtBJiSsRuatfPG7oZdlTxFCbp00Cj1F3WFP
 +/pe+GUwt+XVjWzL7Ss2NhfgHhBSTDRgz2BhmqV8xwH5AWxdI9L4ZzvOzKxlh4bk5dz7OqSycAGaN3xJ9W6CWYsqaUHBUy07Y8hRkT9DpQci2476vhpXHu4p
 kTPhU4yvtRv197Ht2U1tSAGj6gvoBPnXNn5EtqqdxuBO8a4MYL1g+vZFIMP+oZFPkf3MPCyqxactqJeMPyCDWLsxPBQzloeRm4+4JsMrTjuhx7L4h0Mrkn7M
 HTtDNKjt1+oQnE5Q6mQzvMq2ifN3BRr2qMghlRFWtKkbmqqtTJym9mw5YwT8kunzUERta9HtmxGso/qN3s3OskyC1oBShdlS3eC7BOZOzIlAhsLP1P/RTY53
 8L4F+UwRx8GrjIgkpNyFnKyzoY11MTe5WXuaNn5+X8uRRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

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
---
 drivers/hv/channel.c      | 40 +++++++++++++++++++++++----------------
 drivers/hv/channel_mgmt.c |  6 ++++++
 include/linux/hyperv.h    |  2 ++
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index ba0a092ae085..c3949220b770 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -558,11 +558,8 @@ static void reset_channel_cb(void *arg)
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
@@ -572,6 +569,29 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
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
@@ -585,16 +605,6 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
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
 
@@ -639,8 +649,6 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 		get_order(channel->ringbuffer_pagecount * PAGE_SIZE));
 
 out:
-	/* re-enable tasklet for use on re-open */
-	tasklet_enable(&channel->callback_event);
 	return ret;
 }
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index f3b551a50653..0f0e091c117c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -892,6 +892,12 @@ static void vmbus_onoffer_rescind(struct vmbus_channel_message_header *hdr)
 		return;
 	}
 
+	/*
+	 * Before setting channel->rescind in vmbus_rescind_cleanup(), we
+	 * should make sure the channel callback is not running any more.
+	 */
+	vmbus_reset_channel_cb(channel);
+
 	/*
 	 * Now wait for offer handling to complete.
 	 */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2330f08062c7..efda23cf32c7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1061,6 +1061,8 @@ extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
 				     u32 gpadl_handle);
 
+void vmbus_reset_channel_cb(struct vmbus_channel *channel);
+
 extern int vmbus_recvpacket(struct vmbus_channel *channel,
 				  void *buffer,
 				  u32 bufferlen,
-- 
2.17.1

