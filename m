Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6CF93C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1794420020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1794420020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935722AbeFMN5H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:57:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935183AbeFMN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5D6787A80;
        Wed, 13 Jun 2018 13:57:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 595192026609;
        Wed, 13 Jun 2018 13:57:01 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5DDv1Tw005650;
        Wed, 13 Jun 2018 09:57:01 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5DDv0PQ005640;
        Wed, 13 Jun 2018 09:57:00 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 13 Jun 2018 09:57:00 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alan Stern <stern@rowland.harvard.edu>,
        Thomas Gleixner <tglx@linutronix.de>
cc:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
In-Reply-To: <Pine.LNX.4.44L0.1806121603460.1582-100000@iolanthe.rowland.org>
Message-ID: <alpine.LRH.2.02.1806130930550.15845@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806121603460.1582-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 13:57:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 13 Jun 2018 13:57:01 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2018, Alan Stern wrote:

> On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> 
> > On Tue, 12 Jun 2018, Alan Stern wrote:
> > 
> > > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > > 
> > > > In my opinion, it is much easier to fix this in the ehci driver (by not 
> > > > offloading isochronous completions), than to design a new 
> > > > real-time-capable ksoftirqd.
> > > 
> > > You probably never noticed this, but in fact we use _two_ bottom-half 
> > > handlers for URB completions: one scheduled with normal priority and 
> > > one scheduled with high priority (tasklet_hi_schedule()).  Isochronous 
> > > URB completions go to the high-priority handler.
> > > 
> > > Shouldn't a high-priority tasklet be up to the job of handling audio?
> > 
> > I noticed the function tasklet_hi_schedule. It has higher priority than 
> > other softirqs - but it gets offloaded to the ksoftirqd thread that has 
> > priority 0. So it can be preempted by anything - and it doesn't protect 
> > against skipping.
> > 
> > If we raise the priority of ksoftirqd, people will start complaining such 
> > as "my machine is unuseable when it receives too many network packets". 
> > So, you basically need two ksoftirqds, one for networking (with regular 
> > priority) and one for audio (with high priority).
> 
> I wonder if this is not a valid concern.  At the very least we could 
> ask the softirq maintainers what their opinion/recommendation is.

Who maintains the softirq code? IRQ subsystem is maintained by Thomas 
Gleixner. I added him to this email.

> > > > snd_complete_urb is doing nothing but submitting the same urb again. Is 
> > > > resubmitting the urb really causing so much latency that you can't do it 
> > > > in the interrupt handler?
> > > 
> > > Perhaps snd_complete_urb doesn't doing very much, but other drivers
> > > most definitely do.  In particular, the completion handler for the USB
> > > video class driver can be very time consuming.  Your proposed change
> > > would make things worse for people using USB video.
> > 
> > In that case we can avoid offloading just for snd_complete_urb. Would you 
> > agree to adding a flag such as URB_FAST_COMPLETION that is set just by the 
> > audio driver?
> 
> That's another possibility.

Here I'm sending a patch that adds the flag URB_FAST_COMPLETION.

BTW I found this piece of code in sound/usb/usx2y/usbusx2yaudio.c:
                        urb->transfer_buffer_length = subs->maxpacksize * nr_of_packs();
                        if ((err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
                                snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
                                err = -EPIPE;
                                goto cleanup;
                        } else
                                if (i == 0)
                                        usX2Y->wait_iso_frame = urb->start_frame;
                        urb->transfer_flags = 0;
It seems like a bug to modify transfer_flags after the urb is submitted.

Mikulas





From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] usb: don't offload isochronous usb transfers to ksoftirq

I have a single-core machine with usb2 soundcard. When I increase mplayer
priority (to real-time or high non-realtime priority), the sound is
stuttering. The reason for the stuttering is that mplayer at high priority
preempts the softirq thread, preventing URBs from being completed. It was
caused by the patch 428aac8a81058 that offloads URB completion to softirq.

This patch introduces a flag URB_FAST_COMPLETION. When this flag is used,
the usb subsystem will not offload an URB completion to a thread. This
flag is set for the audio drivers.

Fixes: c04ee4b1136e ("Revert "Revert "USB: EHCI: support running URB giveback in tasklet context""")
Cc: stable@vger.kernel.org

---
 drivers/usb/core/hcd.c       |    3 ++-
 drivers/usb/core/urb.c       |    4 ++--
 drivers/usb/host/ehci-q.c    |   14 +++++++++++++-
 include/linux/usb.h          |    1 +
 sound/usb/6fire/pcm.c        |    1 +
 sound/usb/caiaq/audio.c      |    1 +
 sound/usb/endpoint.c         |    4 ++--
 sound/usb/line6/capture.c    |    2 +-
 sound/usb/line6/playback.c   |    2 +-
 sound/usb/misc/ua101.c       |    2 +-
 sound/usb/usx2y/usb_stream.c |    1 +
 11 files changed, 26 insertions(+), 9 deletions(-)

Index: linux-4.17/include/linux/usb.h
===================================================================
--- linux-4.17.orig/include/linux/usb.h	2018-06-05 21:07:26.000000000 +0200
+++ linux-4.17/include/linux/usb.h	2018-06-12 22:39:01.000000000 +0200
@@ -1299,6 +1299,7 @@ extern int usb_disabled(void);
 #define URB_ISO_ASAP		0x0002	/* iso-only; use the first unexpired
 					 * slot in the schedule */
 #define URB_NO_TRANSFER_DMA_MAP	0x0004	/* urb->transfer_dma valid on submit */
+#define URB_FAST_COMPLETION	0x0008	/* Complete from hardirq, don't offload completion to softirq */
 #define URB_ZERO_PACKET		0x0040	/* Finish bulk OUT with short packet */
 #define URB_NO_INTERRUPT	0x0080	/* HINT: no non-error interrupt
 					 * needed */
Index: linux-4.17/drivers/usb/core/hcd.c
===================================================================
--- linux-4.17.orig/drivers/usb/core/hcd.c	2018-06-12 22:35:21.000000000 +0200
+++ linux-4.17/drivers/usb/core/hcd.c	2018-06-12 22:40:44.000000000 +0200
@@ -1831,7 +1831,8 @@ void usb_hcd_giveback_urb(struct usb_hcd
 	if (likely(!urb->unlinked))
 		urb->unlinked = status;
 
-	if (!hcd_giveback_urb_in_bh(hcd) && !is_root_hub(urb->dev)) {
+	if ((!hcd_giveback_urb_in_bh(hcd) || urb->transfer_flags & URB_FAST_COMPLETION) &&
+	    !is_root_hub(urb->dev)) {
 		__usb_hcd_giveback_urb(urb);
 		return;
 	}
Index: linux-4.17/drivers/usb/host/ehci-q.c
===================================================================
--- linux-4.17.orig/drivers/usb/host/ehci-q.c	2018-06-12 22:35:21.000000000 +0200
+++ linux-4.17/drivers/usb/host/ehci-q.c	2018-06-12 22:44:09.000000000 +0200
@@ -238,6 +238,8 @@ static int qtd_copy_status (
 
 static void
 ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
+__releases(ehci->lock)
+__acquires(ehci->lock)
 {
 	if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
 		/* ... update hc-wide periodic stats */
@@ -264,7 +266,17 @@ ehci_urb_done(struct ehci_hcd *ehci, str
 #endif
 
 	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
-	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
+	if (urb->transfer_flags & URB_FAST_COMPLETION) {
+		/*
+		 * USB audio experiences skipping of we offload completion
+		 * to ksoftirq.
+		 */
+		spin_unlock(&ehci->lock);
+		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
+		spin_lock(&ehci->lock);
+	} else {
+		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
+	}
 }
 
 static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
Index: linux-4.17/sound/usb/endpoint.c
===================================================================
--- linux-4.17.orig/sound/usb/endpoint.c	2018-06-12 20:45:25.000000000 +0200
+++ linux-4.17/sound/usb/endpoint.c	2018-06-13 13:46:44.000000000 +0200
@@ -789,7 +789,7 @@ static int data_ep_set_params(struct snd
 		if (!u->urb->transfer_buffer)
 			goto out_of_memory;
 		u->urb->pipe = ep->pipe;
-		u->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+		u->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP | URB_FAST_COMPLETION;
 		u->urb->interval = 1 << ep->datainterval;
 		u->urb->context = u;
 		u->urb->complete = snd_complete_urb;
@@ -827,7 +827,7 @@ static int sync_ep_set_params(struct snd
 		u->urb->transfer_dma = ep->sync_dma + i * 4;
 		u->urb->transfer_buffer_length = 4;
 		u->urb->pipe = ep->pipe;
-		u->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+		u->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP | URB_FAST_COMPLETION;
 		u->urb->number_of_packets = 1;
 		u->urb->interval = 1 << ep->syncinterval;
 		u->urb->context = u;
Index: linux-4.17/drivers/usb/core/urb.c
===================================================================
--- linux-4.17.orig/drivers/usb/core/urb.c	2018-06-05 21:06:59.000000000 +0200
+++ linux-4.17/drivers/usb/core/urb.c	2018-06-13 00:36:06.000000000 +0200
@@ -479,8 +479,8 @@ int usb_submit_urb(struct urb *urb, gfp_
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
 	/* Check against a simple/standard policy */
-	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |
-			URB_FREE_BUFFER);
+	allowed = URB_NO_TRANSFER_DMA_MAP | URB_FAST_COMPLETION | URB_NO_INTERRUPT |
+		URB_FREE_BUFFER | URB_DIR_MASK;
 	switch (xfertype) {
 	case USB_ENDPOINT_XFER_BULK:
 	case USB_ENDPOINT_XFER_INT:
Index: linux-4.17/sound/usb/6fire/pcm.c
===================================================================
--- linux-4.17.orig/sound/usb/6fire/pcm.c	2017-11-29 02:53:58.000000000 +0100
+++ linux-4.17/sound/usb/6fire/pcm.c	2018-06-13 13:58:37.000000000 +0200
@@ -574,6 +574,7 @@ static void usb6fire_pcm_init_urb(struct
 {
 	urb->chip = chip;
 	usb_init_urb(&urb->instance);
+	urb->instance.transfer_flags = URB_FAST_COMPLETION;
 	urb->instance.transfer_buffer = urb->buffer;
 	urb->instance.transfer_buffer_length =
 			PCM_N_PACKETS_PER_URB * PCM_MAX_PACKET_SIZE;
Index: linux-4.17/sound/usb/caiaq/audio.c
===================================================================
--- linux-4.17.orig/sound/usb/caiaq/audio.c	2017-11-29 02:53:58.000000000 +0100
+++ linux-4.17/sound/usb/caiaq/audio.c	2018-06-13 13:51:22.000000000 +0200
@@ -758,6 +758,7 @@ static struct urb **alloc_urbs(struct sn
 
 		urbs[i]->dev = usb_dev;
 		urbs[i]->pipe = pipe;
+		urbs[i]->transfer_flags = URB_FAST_COMPLETION;
 		urbs[i]->transfer_buffer_length = FRAMES_PER_URB
 						* BYTES_PER_FRAME;
 		urbs[i]->context = &cdev->data_cb_info[i];
Index: linux-4.17/sound/usb/usx2y/usb_stream.c
===================================================================
--- linux-4.17.orig/sound/usb/usx2y/usb_stream.c	2018-06-05 21:07:57.000000000 +0200
+++ linux-4.17/sound/usb/usx2y/usb_stream.c	2018-06-13 13:53:12.000000000 +0200
@@ -69,6 +69,7 @@ static int init_pipe_urbs(struct usb_str
 	     ++u, transfer += transfer_length) {
 		struct urb *urb = urbs[u];
 		struct usb_iso_packet_descriptor *desc;
+		urb->transfer_flags = URB_FAST_COMPLETION;
 		urb->transfer_buffer = transfer;
 		urb->dev = dev;
 		urb->pipe = pipe;
Index: linux-4.17/sound/usb/line6/capture.c
===================================================================
--- linux-4.17.orig/sound/usb/line6/capture.c	2018-06-05 21:07:57.000000000 +0200
+++ linux-4.17/sound/usb/line6/capture.c	2018-06-13 15:17:45.000000000 +0200
@@ -285,7 +285,7 @@ int line6_create_audio_in_urbs(struct sn
 		    usb_rcvisocpipe(line6->usbdev,
 				    line6->properties->ep_audio_r &
 				    USB_ENDPOINT_NUMBER_MASK);
-		urb->transfer_flags = URB_ISO_ASAP;
+		urb->transfer_flags = URB_ISO_ASAP | URB_FAST_COMPLETION;
 		urb->start_frame = -1;
 		urb->number_of_packets = LINE6_ISO_PACKETS;
 		urb->interval = LINE6_ISO_INTERVAL;
Index: linux-4.17/sound/usb/line6/playback.c
===================================================================
--- linux-4.17.orig/sound/usb/line6/playback.c	2018-06-05 21:07:57.000000000 +0200
+++ linux-4.17/sound/usb/line6/playback.c	2018-06-13 15:19:31.000000000 +0200
@@ -430,7 +430,7 @@ int line6_create_audio_out_urbs(struct s
 		    usb_sndisocpipe(line6->usbdev,
 				    line6->properties->ep_audio_w &
 				    USB_ENDPOINT_NUMBER_MASK);
-		urb->transfer_flags = URB_ISO_ASAP;
+		urb->transfer_flags = URB_ISO_ASAP | URB_FAST_COMPLETION;
 		urb->start_frame = -1;
 		urb->number_of_packets = LINE6_ISO_PACKETS;
 		urb->interval = LINE6_ISO_INTERVAL;
Index: linux-4.17/sound/usb/misc/ua101.c
===================================================================
--- linux-4.17.orig/sound/usb/misc/ua101.c	2017-11-29 02:53:58.000000000 +0100
+++ linux-4.17/sound/usb/misc/ua101.c	2018-06-13 15:20:32.000000000 +0200
@@ -1120,7 +1120,7 @@ static int alloc_stream_urbs(struct ua10
 			usb_init_urb(&urb->urb);
 			urb->urb.dev = ua->dev;
 			urb->urb.pipe = stream->usb_pipe;
-			urb->urb.transfer_flags = URB_NO_TRANSFER_DMA_MAP;
+			urb->urb.transfer_flags = URB_NO_TRANSFER_DMA_MAP | URB_FAST_COMPLETION;
 			urb->urb.transfer_buffer = addr;
 			urb->urb.transfer_dma = dma;
 			urb->urb.transfer_buffer_length = max_packet_size;
