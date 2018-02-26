Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvl4bKIJhec4uJpT2pXxG7lhiJzl1RNljQ1Uvy1Ora8JA4svmUFQvcIcnbZC3FrcM+cKhG3
ARC-Seal: i=1; a=rsa-sha256; t=1519676482; cv=none;
        d=google.com; s=arc-20160816;
        b=rUZNFpmeRUXbTR5oBqzaAK7LcnuvardKASdSzfaGw7xlpgh+YihjhCa61h5zvXw0ai
         /dqcQCrJgun1IQzqE9kauUkr1hXRjwW/8FuccadcsQI3h9gxMsP6XNqHhK7Uc2fTDIYD
         PYhMdWqueiSuFtGiJR4pA66g2/UTDKJRkS4Ts/qhehkOj2hrz1+Y6ZmJp551nkxTaUUq
         NqcjdncQUxhR5c7arJTE5vG7xMCf9qXN4PIqA+ZQWwdP2FZMFfu67gvtp1eGp6kzEeRd
         BzobYGLYAs79ew+D7olFeejfrZCPymcKB4woNNKFS0w7liIJl/e38II23spYs9Un62aA
         jj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0Abgpd44jp3rZByabvsOMQNuYxrdrd/bAh5lSrQSLCU=;
        b=Lc2zawWIXxC12w0cjnghDJArUfuukTjNdz3byWHsOjh6ft84QbahTMFE4nLfzt8m8J
         bcacColF4G6lesndlJ3g/OD/pP19PF5vS8mTHOdMVi2USFPk6IINTS4zgW97+8QTrrah
         OlpizPgVhP5y1XKBNvzBl281MpE0JaHytkN7sWbtflp0X73s/lP0ojhl373wGeybBZGI
         moqtZeycC6Sc5Eg7wvChWO+ZKd2cenM+bgPjV43A9egEBXuV906NmLovMPYQwvuERyeF
         +hRC02Dc1Yek87zXKmDw7igdjss6t5fuCv43WG96thEeKh/LNklXwX8HhUQm8RU4Ea8r
         RD3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shigeru Yoshida <Shigeru.Yoshida@windriver.com>,
	Haiqing Bai <Haiqing.Bai@windriver.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 13/39] ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watchdog_func()
Date: Mon, 26 Feb 2018 21:20:34 +0100
Message-Id: <20180226201644.257868973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496287558138852?=
X-GMAIL-MSGID: =?utf-8?q?1593496287558138852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <shigeru.yoshida@windriver.com>

commit b2685bdacdaab065c172b97b55ab46c6be77a037 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ohci-hcd.c |   10 +++++++---
 drivers/usb/host/ohci-hub.c |    4 +++-
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -73,6 +73,7 @@ static const char	hcd_name [] = "ohci_hc
 
 #define	STATECHANGE_DELAY	msecs_to_jiffies(300)
 #define	IO_WATCHDOG_DELAY	msecs_to_jiffies(275)
+#define	IO_WATCHDOG_OFF		0xffffff00
 
 #include "ohci.h"
 #include "pci-quirks.h"
@@ -230,7 +231,7 @@ static int ohci_urb_enqueue (
 		}
 
 		/* Start up the I/O watchdog timer, if it's not running */
-		if (!timer_pending(&ohci->io_watchdog) &&
+		if (ohci->prev_frame_no == IO_WATCHDOG_OFF &&
 				list_empty(&ohci->eds_in_use) &&
 				!(ohci->flags & OHCI_QUIRK_QEMU)) {
 			ohci->prev_frame_no = ohci_frame_no(ohci);
@@ -501,6 +502,7 @@ static int ohci_init (struct ohci_hcd *o
 
 	setup_timer(&ohci->io_watchdog, io_watchdog_func,
 			(unsigned long) ohci);
+	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
 			sizeof(*ohci->hcca), &ohci->hcca_dma, GFP_KERNEL);
@@ -730,7 +732,7 @@ static void io_watchdog_func(unsigned lo
 	u32		head;
 	struct ed	*ed;
 	struct td	*td, *td_start, *td_next;
-	unsigned	frame_no;
+	unsigned	frame_no, prev_frame_no = IO_WATCHDOG_OFF;
 	unsigned long	flags;
 
 	spin_lock_irqsave(&ohci->lock, flags);
@@ -835,7 +837,7 @@ static void io_watchdog_func(unsigned lo
 			}
 		}
 		if (!list_empty(&ohci->eds_in_use)) {
-			ohci->prev_frame_no = frame_no;
+			prev_frame_no = frame_no;
 			ohci->prev_wdh_cnt = ohci->wdh_cnt;
 			ohci->prev_donehead = ohci_readl(ohci,
 					&ohci->regs->donehead);
@@ -845,6 +847,7 @@ static void io_watchdog_func(unsigned lo
 	}
 
  done:
+	ohci->prev_frame_no = prev_frame_no;
 	spin_unlock_irqrestore(&ohci->lock, flags);
 }
 
@@ -973,6 +976,7 @@ static void ohci_stop (struct usb_hcd *h
 	if (quirk_nec(ohci))
 		flush_work(&ohci->nec_work);
 	del_timer_sync(&ohci->io_watchdog);
+	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
 	ohci_usb_reset(ohci);
--- a/drivers/usb/host/ohci-hub.c
+++ b/drivers/usb/host/ohci-hub.c
@@ -310,8 +310,10 @@ static int ohci_bus_suspend (struct usb_
 		rc = ohci_rh_suspend (ohci, 0);
 	spin_unlock_irq (&ohci->lock);
 
-	if (rc == 0)
+	if (rc == 0) {
 		del_timer_sync(&ohci->io_watchdog);
+		ohci->prev_frame_no = IO_WATCHDOG_OFF;
+	}
 	return rc;
 }
 
