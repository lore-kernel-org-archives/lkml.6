Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C740C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23DD206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865396;
	bh=Prjf2tlYIea2JF3+P0kZ5xRdN2Zftm897yHVNnOh9is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBKYITyCm9rcEFgqiTumyJc9f0QbWZDZnF6liFltckndAGHgbhIHFbpu4UGGcD3pU
	 i0G/XUe25vYKpaz3qXO4hUCLBmFW6ASloDbb+F7iQIvZeoLZZJ4+fjcmo9uXccwZxW
	 Xu78uLmYt1k0SOPrKv+NI8ISl8SezPD8GDHWXiVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfAGMty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbfAGMtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65555206BB;
        Mon,  7 Jan 2019 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865390;
        bh=Prjf2tlYIea2JF3+P0kZ5xRdN2Zftm897yHVNnOh9is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gctqjA30NIeqvkEzplrrn0Ui2CEpPsZ08aE1RDiOWtssPAb+yI7SPl719UkNAUS1p
         nZW8PT07y/a9jG/Lbhr73XlhH6Ml3x8VU7ao3mwZ5Jx8+0LtsAVy10kvb+TVsbr2D3
         icO8T2GvuGLlCdw7MuXBCa/28/RHlgqJ2Qh/h9uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Terin Stock <terin@terinstock.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.19 076/170] usb: dwc2: host: use hrtimer for NAK retries
Date:   Mon,  7 Jan 2019 13:31:43 +0100
Message-Id: <20190107104502.035670459@linuxfoundation.org>
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

From: Terin Stock <terin@terinstock.com>

commit 6ed30a7d8ec29d3aba46e47aa8b4a44f077dda4e upstream.

Modify the wait delay utilize the high resolution timer API to allow for
more precisely scheduled callbacks.

A previous commit added a 1ms retry delay after multiple consecutive
NAKed transactions using jiffies. On systems with a low timer interrupt
frequency, this delay may be significantly longer than specified,
resulting in misbehavior with some USB devices.

This scenario was reached on a Raspberry Pi 3B with a Macally FDD-USB
floppy drive (identified as 0424:0fdc Standard Microsystems Corp.
Floppy, based on the USB97CFDC USB FDC). With the relay delay, the drive
would be unable to mount a disk, replying with NAKs until the device was
reset.

Using ktime, the delta between starting the timer (in dwc2_hcd_qh_add)
and the callback function can be determined. With the original delay
implementation, this value was consistently approximately 12ms. (output
in us).

    <idle>-0     [000] ..s.  1600.559974: dwc2_wait_timer_fn: wait_timer delta: 11976
    <idle>-0     [000] ..s.  1600.571974: dwc2_wait_timer_fn: wait_timer delta: 11977
    <idle>-0     [000] ..s.  1600.583974: dwc2_wait_timer_fn: wait_timer delta: 11976
    <idle>-0     [000] ..s.  1600.595974: dwc2_wait_timer_fn: wait_timer delta: 11977

After converting the relay delay to using a higher resolution timer, the
delay was much closer to 1ms.

    <idle>-0     [000] d.h.  1956.553017: dwc2_wait_timer_fn: wait_timer delta: 1002
    <idle>-0     [000] d.h.  1956.554114: dwc2_wait_timer_fn: wait_timer delta: 1002
    <idle>-0     [000] d.h.  1957.542660: dwc2_wait_timer_fn: wait_timer delta: 1004
    <idle>-0     [000] d.h.  1957.543701: dwc2_wait_timer_fn: wait_timer delta: 1002

The floppy drive operates properly with delays up to approximately 5ms,
and sends NAKs for any delays that are longer.

Fixes: 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")
Cc: <stable@vger.kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Terin Stock <terin@terinstock.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc2/hcd.h       |    2 +-
 drivers/usb/dwc2/hcd_queue.c |   19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -366,7 +366,7 @@ struct dwc2_qh {
 	u32 desc_list_sz;
 	u32 *n_bytes;
 	struct timer_list unreserve_timer;
-	struct timer_list wait_timer;
+	struct hrtimer wait_timer;
 	struct dwc2_tt *dwc_tt;
 	int ttport;
 	unsigned tt_buffer_dirty:1;
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -59,7 +59,7 @@
 #define DWC2_UNRESERVE_DELAY (msecs_to_jiffies(5))
 
 /* If we get a NAK, wait this long before retrying */
-#define DWC2_RETRY_WAIT_DELAY (msecs_to_jiffies(1))
+#define DWC2_RETRY_WAIT_DELAY 1*1E6L
 
 /**
  * dwc2_periodic_channel_available() - Checks that a channel is available for a
@@ -1464,10 +1464,12 @@ static void dwc2_deschedule_periodic(str
  * qh back to the "inactive" list, then queues transactions.
  *
  * @t: Pointer to wait_timer in a qh.
+ *
+ * Return: HRTIMER_NORESTART to not automatically restart this timer.
  */
-static void dwc2_wait_timer_fn(struct timer_list *t)
+static enum hrtimer_restart dwc2_wait_timer_fn(struct hrtimer *t)
 {
-	struct dwc2_qh *qh = from_timer(qh, t, wait_timer);
+	struct dwc2_qh *qh = container_of(t, struct dwc2_qh, wait_timer);
 	struct dwc2_hsotg *hsotg = qh->hsotg;
 	unsigned long flags;
 
@@ -1491,6 +1493,7 @@ static void dwc2_wait_timer_fn(struct ti
 	}
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
+	return HRTIMER_NORESTART;
 }
 
 /**
@@ -1521,7 +1524,8 @@ static void dwc2_qh_init(struct dwc2_hso
 	/* Initialize QH */
 	qh->hsotg = hsotg;
 	timer_setup(&qh->unreserve_timer, dwc2_unreserve_timer_fn, 0);
-	timer_setup(&qh->wait_timer, dwc2_wait_timer_fn, 0);
+	hrtimer_init(&qh->wait_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	qh->wait_timer.function = &dwc2_wait_timer_fn;
 	qh->ep_type = ep_type;
 	qh->ep_is_in = ep_is_in;
 
@@ -1690,7 +1694,7 @@ void dwc2_hcd_qh_free(struct dwc2_hsotg
 	 * won't do anything anyway, but we want it to finish before we free
 	 * memory.
 	 */
-	del_timer_sync(&qh->wait_timer);
+	hrtimer_cancel(&qh->wait_timer);
 
 	dwc2_host_put_tt_info(hsotg, qh->dwc_tt);
 
@@ -1716,6 +1720,7 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *h
 {
 	int status;
 	u32 intr_mask;
+	ktime_t delay;
 
 	if (dbg_qh(qh))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
@@ -1734,8 +1739,8 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *h
 			list_add_tail(&qh->qh_list_entry,
 				      &hsotg->non_periodic_sched_waiting);
 			qh->wait_timer_cancel = false;
-			mod_timer(&qh->wait_timer,
-				  jiffies + DWC2_RETRY_WAIT_DELAY + 1);
+			delay = ktime_set(0, DWC2_RETRY_WAIT_DELAY);
+			hrtimer_start(&qh->wait_timer, delay, HRTIMER_MODE_REL);
 		} else {
 			list_add_tail(&qh->qh_list_entry,
 				      &hsotg->non_periodic_sched_inactive);


