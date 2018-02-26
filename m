Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224CeG5oDVoXwohpPcdHAyzgPls2zTSr+DX0O+dseeuiabkyeVasp2IfGN8mqN+wSPBWfwgg
ARC-Seal: i=1; a=rsa-sha256; t=1519676956; cv=none;
        d=google.com; s=arc-20160816;
        b=uupOlrKefysdPg/qSag4prManw6y3FuY46aSQgo7VeWBni1zsqFvA9DCZBw10rqb07
         ZX7hGHskwElaPPxoMuN8zRJsztUFrkT02axF5Ya1//0qjYWc6gvZHs8Wzu2Ea+8HEPhP
         rf5VkP9jt0640PxrDrdpS3ge5rUG3LF/3/EYOCqp1p3HsJB0qX5XTktCqBowURC0Fmeq
         LKWfvXYSz7oNeYezKdmEnynrfjyevMQDRTWi4WTS3xAprW5Up9raVaTHE3HSxSpbbuzZ
         kYCZL0ntdN9WYAIu5xt4xjJcjfEA3qERTg8P3tK+4KAp80xs3hjMyoKqTv5gu1Z4g3UA
         vUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y74UJuX1bAk5VIo1/2wAno8TEuft8jSKdHF3IfAMIes=;
        b=uGHkFOCb704UJfiWqIwdzcRv+e3swQmRlbRUsU03IfyJPTETWVKIirR3KvzfC+kxv3
         CAEGkRYxJSVOynxd0IueYl1C/OuDmtgunpl3PoAIW4R34uup1fFSim6vjBs4nN7x1BtN
         0s4MtEp2Rg/z1b+ezflot+Ru5u3fau3SuaAWPrPIgBmXZWJ6tEeWrnix+hrW7bzihPXg
         IbkXt8zF3S2LN4nz22cOphRnLVEavg9a2MhY63HZpcTnxyiuac2LnWp6zcuxEUnq6EMP
         dfLxC4fvEVHWWLiHF1sHnlYt3VmkCLOjcsM4oWxejx8gbehbIFyMUtMCBwb/BSnz9QCy
         ehzg==
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
Subject: [PATCH 4.15 37/64] ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and io_watchdog_func()
Date: Mon, 26 Feb 2018 21:22:14 +0100
Message-Id: <20180226202155.043753482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496287558138852?=
X-GMAIL-MSGID: =?utf-8?q?1593496784658298947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -74,6 +74,7 @@ static const char	hcd_name [] = "ohci_hc
 
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
@@ -501,6 +502,7 @@ static int ohci_init (struct ohci_hcd *o
 		return 0;
 
 	timer_setup(&ohci->io_watchdog, io_watchdog_func, 0);
+	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
 			sizeof(*ohci->hcca), &ohci->hcca_dma, GFP_KERNEL);
@@ -730,7 +732,7 @@ static void io_watchdog_func(struct time
 	u32		head;
 	struct ed	*ed;
 	struct td	*td, *td_start, *td_next;
-	unsigned	frame_no;
+	unsigned	frame_no, prev_frame_no = IO_WATCHDOG_OFF;
 	unsigned long	flags;
 
 	spin_lock_irqsave(&ohci->lock, flags);
@@ -835,7 +837,7 @@ static void io_watchdog_func(struct time
 			}
 		}
 		if (!list_empty(&ohci->eds_in_use)) {
-			ohci->prev_frame_no = frame_no;
+			prev_frame_no = frame_no;
 			ohci->prev_wdh_cnt = ohci->wdh_cnt;
 			ohci->prev_donehead = ohci_readl(ohci,
 					&ohci->regs->donehead);
@@ -845,6 +847,7 @@ static void io_watchdog_func(struct time
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
@@ -311,8 +311,10 @@ static int ohci_bus_suspend (struct usb_
 		rc = ohci_rh_suspend (ohci, 0);
 	spin_unlock_irq (&ohci->lock);
 
-	if (rc == 0)
+	if (rc == 0) {
 		del_timer_sync(&ohci->io_watchdog);
+		ohci->prev_frame_no = IO_WATCHDOG_OFF;
+	}
 	return rc;
 }
 
