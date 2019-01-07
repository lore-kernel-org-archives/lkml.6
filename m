Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30480C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8121736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865933;
	bh=jEj6smEIWfUEYmidbyfSzdsdqu1uhcK1vHFy2K2EdQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRjz6s7RVpZJIL+EdI2whwom4hmmfMduPJxD2bLGDDKjaCHrSku6jV6CUQdU3bnbY
	 x+OdHj5U+oxz8YCKzkJvH6Z69m0v+r9RS95z1f//J0PzlcBPLTba7vbP2jaz27aXpz
	 +QLa92QF2ecODtNkAB9GTGiubsjNQWg6zJ20a/vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfAGM6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:58:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbfAGM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B5E206BB;
        Mon,  7 Jan 2019 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865924;
        bh=jEj6smEIWfUEYmidbyfSzdsdqu1uhcK1vHFy2K2EdQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VG5BllciUqHO/9TT76hk2F8Ou2B8oCoVDuj1DHko3iGCgbEmllQPz3AH+ne1IPyZm
         Rm611JkbvWay2T/gLI984Y8QsK7iZFr9FaYIjKnwjIcOdcoV+SChMbipY57t44oYH8
         6AZnQWE8RiKv/BG0Cq4Swb9up0oEQg53fTIHIh5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 142/170] media: cec: keep track of outstanding transmits
Date:   Mon,  7 Jan 2019 13:32:49 +0100
Message-Id: <20190107104509.692804458@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 32804fcb612bf867034a093f459415e485cf044b upstream.

I noticed that repeatedly running 'cec-ctl --playback' would occasionally
select 'Playback Device 2' instead of 'Playback Device 1', even though there
were no other Playback devices in the HDMI topology. This happened both with
'real' hardware and with the vivid CEC emulation, suggesting that this was an
issue in the core code that claims a logical address.

What 'cec-ctl --playback' does is to first clear all existing logical addresses,
and immediately after that configure the new desired device type.

The core code will poll the logical addresses trying to find a free address.
When found it will issue a few standard messages as per the CEC spec and return.
Those messages are queued up and will be transmitted asynchronously.

What happens is that if you run two 'cec-ctl --playback' commands in quick
succession, there is still a message of the first cec-ctl command being transmitted
when you reconfigure the adapter again in the second cec-ctl command.

When the logical addresses are cleared, then all information about outstanding
transmits inside the CEC core is also cleared, and the core is no longer aware
that there is still a transmit in flight.

When the hardware finishes the transmit it calls transmit_done and the CEC core
thinks it is actually in response of a POLL messages that is trying to find a
free logical address. The result of all this is that the core thinks that the
logical address for Playback Device 1 is in use, when it is really an earlier
transmit that ended.

The main transmit thread looks at adap->transmitting to check if a transmit
is in progress, but that is set to NULL when the adapter is unconfigured.
adap->transmitting represents the view of userspace, not that of the hardware.
So when unconfiguring the adapter the message is marked aborted from the point
of view of userspace, but seen from the PoV of the hardware it is still ongoing.

So introduce a new bool transmit_in_progress that represents the hardware state
and use that instead of adap->transmitting. Now the CEC core waits until the
hardware finishes the transmit before starting a new transmit.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v4.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/cec/cec-adap.c |   27 ++++++++++++++++++---------
 include/media/cec.h          |    1 +
 2 files changed, 19 insertions(+), 9 deletions(-)

--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -442,7 +442,7 @@ int cec_thread_func(void *_adap)
 				(adap->needs_hpd &&
 				 (!adap->is_configured && !adap->is_configuring)) ||
 				kthread_should_stop() ||
-				(!adap->transmitting &&
+				(!adap->transmit_in_progress &&
 				 !list_empty(&adap->transmit_queue)),
 				msecs_to_jiffies(CEC_XFER_TIMEOUT_MS));
 			timeout = err == 0;
@@ -450,7 +450,7 @@ int cec_thread_func(void *_adap)
 			/* Otherwise we just wait for something to happen. */
 			wait_event_interruptible(adap->kthread_waitq,
 				kthread_should_stop() ||
-				(!adap->transmitting &&
+				(!adap->transmit_in_progress &&
 				 !list_empty(&adap->transmit_queue)));
 		}
 
@@ -475,6 +475,7 @@ int cec_thread_func(void *_adap)
 			pr_warn("cec-%s: message %*ph timed out\n", adap->name,
 				adap->transmitting->msg.len,
 				adap->transmitting->msg.msg);
+			adap->transmit_in_progress = false;
 			adap->tx_timeouts++;
 			/* Just give up on this. */
 			cec_data_cancel(adap->transmitting,
@@ -486,7 +487,7 @@ int cec_thread_func(void *_adap)
 		 * If we are still transmitting, or there is nothing new to
 		 * transmit, then just continue waiting.
 		 */
-		if (adap->transmitting || list_empty(&adap->transmit_queue))
+		if (adap->transmit_in_progress || list_empty(&adap->transmit_queue))
 			goto unlock;
 
 		/* Get a new message to transmit */
@@ -532,6 +533,8 @@ int cec_thread_func(void *_adap)
 		if (adap->ops->adap_transmit(adap, data->attempts,
 					     signal_free_time, &data->msg))
 			cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+		else
+			adap->transmit_in_progress = true;
 
 unlock:
 		mutex_unlock(&adap->lock);
@@ -562,14 +565,17 @@ void cec_transmit_done_ts(struct cec_ada
 	data = adap->transmitting;
 	if (!data) {
 		/*
-		 * This can happen if a transmit was issued and the cable is
+		 * This might happen if a transmit was issued and the cable is
 		 * unplugged while the transmit is ongoing. Ignore this
 		 * transmit in that case.
 		 */
-		dprintk(1, "%s was called without an ongoing transmit!\n",
-			__func__);
-		goto unlock;
+		if (!adap->transmit_in_progress)
+			dprintk(1, "%s was called without an ongoing transmit!\n",
+				__func__);
+		adap->transmit_in_progress = false;
+		goto wake_thread;
 	}
+	adap->transmit_in_progress = false;
 
 	msg = &data->msg;
 
@@ -635,7 +641,6 @@ wake_thread:
 	 * for transmitting or to retry the current message.
 	 */
 	wake_up_interruptible(&adap->kthread_waitq);
-unlock:
 	mutex_unlock(&adap->lock);
 }
 EXPORT_SYMBOL_GPL(cec_transmit_done_ts);
@@ -1483,8 +1488,11 @@ void __cec_s_phys_addr(struct cec_adapte
 		if (adap->monitor_all_cnt)
 			WARN_ON(call_op(adap, adap_monitor_all_enable, false));
 		mutex_lock(&adap->devnode.lock);
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs))
+		if (adap->needs_hpd || list_empty(&adap->devnode.fhs)) {
 			WARN_ON(adap->ops->adap_enable(adap, false));
+			adap->transmit_in_progress = false;
+			wake_up_interruptible(&adap->kthread_waitq);
+		}
 		mutex_unlock(&adap->devnode.lock);
 		if (phys_addr == CEC_PHYS_ADDR_INVALID)
 			return;
@@ -1492,6 +1500,7 @@ void __cec_s_phys_addr(struct cec_adapte
 
 	mutex_lock(&adap->devnode.lock);
 	adap->last_initiator = 0xff;
+	adap->transmit_in_progress = false;
 
 	if ((adap->needs_hpd || list_empty(&adap->devnode.fhs)) &&
 	    adap->ops->adap_enable(adap, true)) {
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -155,6 +155,7 @@ struct cec_adapter {
 	unsigned int transmit_queue_sz;
 	struct list_head wait_queue;
 	struct cec_data *transmitting;
+	bool transmit_in_progress;
 
 	struct task_struct *kthread_config;
 	struct completion config_completion;


