Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1544148-1517551957-2-7410329531685522556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517551956; b=r5Nu3BkO9v/7wg+twdMgddkrC9l+H0dwJDubO4+el1E5HsW
    qXeNPHkYh+cc+zoGizXo7rUyv2hXMUO2qNd85+wTvfL0fboqzTuwogydDpWuLSL8
    8OIiZiy7AvYYrWZgqmS6Ga1Zz8N0YfYbCcL/hnhWFarT2VemihLbNbdqvHdlz/FD
    0luBhxYT8b6Fe0GHVF4JcWhngk8IP/RN7vxum/At4GUF3AhuvG5Qahbk79BbFJ5y
    xFvR64LSl7eimOQrntuztEbA+0vqr6nVnhtTka5XXO+MfntHxWBBZFYY9Ioh3Nwc
    vkUYeejXRJUym3zjzhEtJ2P4xzT+7GqyRhjW0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1517551956; bh=coEXR57/fOpemxJZsuTEpo6mcjnRljIYintP2vYNKd0=; b=O
    TnFPiV4mRVFv+iFxZJDjzy4NyaexWnsF97D7ZVe8noOzOAGXYXHb5XaMCujA8WLY
    2iMp68e+0RdI+5dQgjj8cT/NSluFUcBiJikE+Zvey2DtAm7dgaoRQ2julfG5edwh
    DMIGqYC0cFCIbRo2yeDRa7O7lynBpxMIoYAe+WCBuVzZ7eKZqC+Ar/r/2CrwCQ1N
    8OJ0vTFs0fJYmJsRmC126ljTOaVKdZP/savj+tqeUVXDeMibrUALw9LKCVCRRhyU
    scZ5AEi72/dSX8ZgCXnASzWDafYu8u90yCyqj8Do5tU6IMnlhWpl81uI1vYwgMYa
    WDZfho54jgBg6864320xQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=windriver.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=windriver.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=windriver.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=windriver.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeBBGMb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 01:12:31 -0500
Received: from mail5.windriver.com ([192.103.53.11]:48514 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeBBGMa (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 2 Feb 2018 01:12:30 -0500
From: Haiqing Bai <Haiqing.Bai@windriver.com>
To: <stern@rowland.harvard.edu>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Shigeru.Yoshida@windriver.com>,
        <haiqing.bai@windriver.com>
Subject: [V2][PATCH] ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watchdog_func()
Date: Fri, 2 Feb 2018 13:51:39 +0800
Message-ID: <1517550699-7879-1-git-send-email-Haiqing.Bai@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shigeru Yoshida <shigeru.yoshida@windriver.com>

Running io_watchdog_func() while ohci_urb_enqueue() is running can
cause a race condition where ohci->prev_frame_no is corrupted and the
watchdog can mis-detect following error:

  ohci-platform 664a0800.usb: frame counter not updating; disabled
  ohci-platform 664a0800.usb: HC died; cleaning up

Specifically, following scenario causes a race condition:

  1. ohci_urb_enqueue() calls spin_lock_irqsave(&ohci->lock, flags)
     and enters the critical section
  2. ohci_urb_enqueue() calls timer_pending(&ohci->io_watchdog) and it
     returns false
  3. ohci_urb_enqueue() sets ohci->prev_frame_no to a frame number
     read by ohci_frame_no(ohci)
  4. ohci_urb_enqueue() schedules io_watchdog_func() with mod_timer()
  5. ohci_urb_enqueue() calls spin_unlock_irqrestore(&ohci->lock,
     flags) and exits the critical section
  6. Later, ohci_urb_enqueue() is called
  7. ohci_urb_enqueue() calls spin_lock_irqsave(&ohci->lock, flags)
     and enters the critical section
  8. The timer scheduled on step 4 expires and io_watchdog_func() runs
  9. io_watchdog_func() calls spin_lock_irqsave(&ohci->lock, flags)
     and waits on it because ohci_urb_enqueue() is already in the
     critical section on step 7
 10. ohci_urb_enqueue() calls timer_pending(&ohci->io_watchdog) and it
     returns false
 11. ohci_urb_enqueue() sets ohci->prev_frame_no to new frame number
     read by ohci_frame_no(ohci) because the frame number proceeded
     between step 3 and 6
 12. ohci_urb_enqueue() schedules io_watchdog_func() with mod_timer()
 13. ohci_urb_enqueue() calls spin_unlock_irqrestore(&ohci->lock,
     flags) and exits the critical section, then wake up
     io_watchdog_func() which is waiting on step 9
 14. io_watchdog_func() enters the critical section
 15. io_watchdog_func() calls ohci_frame_no(ohci) and set frame_no
     variable to the frame number
 16. io_watchdog_func() compares frame_no and ohci->prev_frame_no

On step 16, because this calling of io_watchdog_func() is scheduled on
step 4, the frame number set in ohci->prev_frame_no is expected to the
number set on step 3.  However, ohci->prev_frame_no is overwritten on
step 11.  Because step 16 is executed soon after step 11, the frame
number might not proceed, so ohci->prev_frame_no must equals to
frame_no.

To address above scenario, this patch introduces a special sentinel
value IO_WATCHDOG_OFF and set this value to ohci->prev_frame_no when
the watchdog is not pending or running.  When ohci_urb_enqueue()
schedules the watchdog (step 4 and 12 above), it compares
ohci->prev_frame_no to IO_WATCHDOG_OFF so that ohci->prev_frame_no is
not overwritten while io_watchdog_func() is running.

Signed-off-by: Shigeru Yoshida <Shigeru.Yoshida@windriver.com>
Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
---
v2: Instead of adding an extra flag variable, defining IO_WATCHDOG_OFF
    as a special sentinel value for prev_frame_no.

 drivers/usb/host/ohci-hcd.c | 10 +++++++---
 drivers/usb/host/ohci-hub.c |  4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index ee96763..84f88fa 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -74,6 +74,7 @@
 
 #define	STATECHANGE_DELAY	msecs_to_jiffies(300)
 #define	IO_WATCHDOG_DELAY	msecs_to_jiffies(275)
+#define	IO_WATCHDOG_OFF		0xffffff00
 
 #include "ohci.h"
 #include "pci-quirks.h"
@@ -231,7 +232,7 @@ static int ohci_urb_enqueue (
 		}
 
 		/* Start up the I/O watchdog timer, if it's not running */
-		if (!timer_pending(&ohci->io_watchdog) &&
+		if (ohci->prev_frame_no == IO_WATCHDOG_OFF &&
 				list_empty(&ohci->eds_in_use) &&
 				!(ohci->flags & OHCI_QUIRK_QEMU)) {
 			ohci->prev_frame_no = ohci_frame_no(ohci);
@@ -501,6 +502,7 @@ static int ohci_init (struct ohci_hcd *ohci)
 		return 0;
 
 	timer_setup(&ohci->io_watchdog, io_watchdog_func, 0);
+	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
 			sizeof(*ohci->hcca), &ohci->hcca_dma, GFP_KERNEL);
@@ -730,7 +732,7 @@ static void io_watchdog_func(struct timer_list *t)
 	u32		head;
 	struct ed	*ed;
 	struct td	*td, *td_start, *td_next;
-	unsigned	frame_no;
+	unsigned	frame_no, prev_frame_no = IO_WATCHDOG_OFF;
 	unsigned long	flags;
 
 	spin_lock_irqsave(&ohci->lock, flags);
@@ -835,7 +837,7 @@ static void io_watchdog_func(struct timer_list *t)
 			}
 		}
 		if (!list_empty(&ohci->eds_in_use)) {
-			ohci->prev_frame_no = frame_no;
+			prev_frame_no = frame_no;
 			ohci->prev_wdh_cnt = ohci->wdh_cnt;
 			ohci->prev_donehead = ohci_readl(ohci,
 					&ohci->regs->donehead);
@@ -845,6 +847,7 @@ static void io_watchdog_func(struct timer_list *t)
 	}
 
  done:
+	ohci->prev_frame_no = prev_frame_no;
 	spin_unlock_irqrestore(&ohci->lock, flags);
 }
 
@@ -973,6 +976,7 @@ static void ohci_stop (struct usb_hcd *hcd)
 	if (quirk_nec(ohci))
 		flush_work(&ohci->nec_work);
 	del_timer_sync(&ohci->io_watchdog);
+	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
 	ohci_usb_reset(ohci);
diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
index fb7aaa3..634f3c7 100644
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -311,8 +311,10 @@ static int ohci_bus_suspend (struct usb_hcd *hcd)
 		rc = ohci_rh_suspend (ohci, 0);
 	spin_unlock_irq (&ohci->lock);
 
-	if (rc == 0)
+	if (rc == 0) {
 		del_timer_sync(&ohci->io_watchdog);
+		ohci->prev_frame_no = IO_WATCHDOG_OFF;
+	}
 	return rc;
 }
 
-- 
1.9.1

