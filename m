Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C6220449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864980;
	bh=wJ51zndPBIvbHsMFF43gSS6yb1sZOs0xDW2oMRvQhBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vs4n91Lwtbb4c5Qf7lbncgqIo412WGVdO9U0cWzo+kEsBvrvZ2hKQGmNlM0AM/ypO
	 pAUkGjIGuOWJ1R2su9i6tpctoDgd2pOgHqaSk/KnsOKncrI/CAHHAV0x4GrNIeIbnj
	 5cSwhbgJ0sAx7QWHHOJdJv/liNYX6bXXqphFZSSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfAGMm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfAGMmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CFC20449;
        Mon,  7 Jan 2019 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864973;
        bh=wJ51zndPBIvbHsMFF43gSS6yb1sZOs0xDW2oMRvQhBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzZfXvYkcIufLJMvmThaBO3N3U1hx/6OMlHCh7E4Fl1JoyKSNsjl1MTFoDtlfP70F
         670v2p6YDxGHVWHn/Arv0h+9dt2IStA5GIBhVgpvxcu5GXaRGZmlIJLxbgY0pMXS0i
         F0f0qtUtO85XZ7FdYcHjVbZPdb3sgUIBchL1gv1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 110/145] media: cec: keep track of outstanding transmits
Date:   Mon,  7 Jan 2019 13:32:27 +0100
Message-Id: <20190107104451.578206516@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -455,7 +455,7 @@ int cec_thread_func(void *_adap)
 				(adap->needs_hpd &&
 				 (!adap->is_configured && !adap->is_configuring)) ||
 				kthread_should_stop() ||
-				(!adap->transmitting &&
+				(!adap->transmit_in_progress &&
 				 !list_empty(&adap->transmit_queue)),
 				msecs_to_jiffies(CEC_XFER_TIMEOUT_MS));
 			timeout = err == 0;
@@ -463,7 +463,7 @@ int cec_thread_func(void *_adap)
 			/* Otherwise we just wait for something to happen. */
 			wait_event_interruptible(adap->kthread_waitq,
 				kthread_should_stop() ||
-				(!adap->transmitting &&
+				(!adap->transmit_in_progress &&
 				 !list_empty(&adap->transmit_queue)));
 		}
 
@@ -488,6 +488,7 @@ int cec_thread_func(void *_adap)
 			pr_warn("cec-%s: message %*ph timed out\n", adap->name,
 				adap->transmitting->msg.len,
 				adap->transmitting->msg.msg);
+			adap->transmit_in_progress = false;
 			adap->tx_timeouts++;
 			/* Just give up on this. */
 			cec_data_cancel(adap->transmitting,
@@ -499,7 +500,7 @@ int cec_thread_func(void *_adap)
 		 * If we are still transmitting, or there is nothing new to
 		 * transmit, then just continue waiting.
 		 */
-		if (adap->transmitting || list_empty(&adap->transmit_queue))
+		if (adap->transmit_in_progress || list_empty(&adap->transmit_queue))
 			goto unlock;
 
 		/* Get a new message to transmit */
@@ -545,6 +546,8 @@ int cec_thread_func(void *_adap)
 		if (adap->ops->adap_transmit(adap, data->attempts,
 					     signal_free_time, &data->msg))
 			cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+		else
+			adap->transmit_in_progress = true;
 
 unlock:
 		mutex_unlock(&adap->lock);
@@ -575,14 +578,17 @@ void cec_transmit_done_ts(struct cec_ada
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
 
@@ -648,7 +654,6 @@ wake_thread:
 	 * for transmitting or to retry the current message.
 	 */
 	wake_up_interruptible(&adap->kthread_waitq);
-unlock:
 	mutex_unlock(&adap->lock);
 }
 EXPORT_SYMBOL_GPL(cec_transmit_done_ts);
@@ -1496,8 +1501,11 @@ void __cec_s_phys_addr(struct cec_adapte
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
@@ -1505,6 +1513,7 @@ void __cec_s_phys_addr(struct cec_adapte
 
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


