Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+lPsINYFBrcE8vux6undUi4mlq9uRCz1cdyYNiAof2Sy6YsLq49eAZkTcWOBQGUCrBOpOW
ARC-Seal: i=1; a=rsa-sha256; t=1522168706; cv=none;
        d=google.com; s=arc-20160816;
        b=tteG72Z7U8TwIB88HR14cq0oH7HD5GOw7qGfUffo69DRTsf/Yka9cRHWIfn3KnKJg8
         /q8nSViWLTfjgDvHsrzqHYsZlJXgFnXgWmUPoBbr1GYnfNrKVsSuancfslDD46gFoMBH
         tO8BL+rOEK/3k0zFHIG5nJgCFv9gw72JfCk2J7LwNqXbpamLAtlLa/yhg3og6r5dZEsH
         a2PFj/1neH6BeF8mVz3WfGqaIkDYhzt0xwLrtZsXmHNNZuKIW99LvC9vnDjBqiDYgAiI
         G3c+I+zqczGlMcLa2YLOWsutGy94h5vYGIl39G22YxibYqkXtMbi/LEiU0aLinCqPpN1
         +Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fVsFuqWD5X9IkQLAnj2qB1EdqNoeixuI/UCeqws43Sc=;
        b=cru2jlRXa0Uiy9jT1Mr5nto57kZCEfGX4q7Z0psy40pQIui/xnm1BBPKUN/vI3qrkb
         z+31oGxTzs5uWEmLAcmUvl8fvxyC1nGeRwi8ACnySGLCHcCNGPz2SD6Y+6BP4/995Sbl
         iqrnKUImXKrfwkPS32j+56m8Ii3xuwuJNq03b58ww1NVP2N5h7lrs5P4S3TAS+rHrnMs
         +Z4Cvbu88bQ4f7J+dKFygk0+BSGgKq6Bni6803YbYviSo8WC7UdgA1RhOgNrOm1Lterq
         +J4ZsRRyYipCvAw9fteXaz1ML2uW2KPFFX+JrkfB1ucQPpjDewnydhW4gnfMAxDS+Ewz
         6t6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guoqing Zhang <guoqing.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 097/101] usb: xhci: Fix potential memory leak in xhci_disable_slot()
Date: Tue, 27 Mar 2018 18:28:09 +0200
Message-Id: <20180327162755.950452777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109573888457412?=
X-GMAIL-MSGID: =?utf-8?q?1596109573888457412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Baolu <baolu.lu@linux.intel.com>

commit cd3f1790b006d91786728c20a01da21ee277aff1 upstream.

xhci_disable_slot() allows the invoker to pass a command pointer
as paramenter. Otherwise, it will allocate one. This will cause
memory leak when a command structure was allocated inside of this
function while queuing command trb fails. Another problem comes up
when the invoker passed a command pointer, but xhci_disable_slot()
frees it when it detects a dead host.

This patch fixes these two problems by removing the command parameter
from xhci_disable_slot().

Fixes: f9e609b82479 ("usb: xhci: Add helper function xhci_disable_slot().")
Cc: Guoqing Zhang <guoqing.zhang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |    2 +-
 drivers/usb/host/xhci.c     |   30 +++++++++---------------------
 drivers/usb/host/xhci.h     |    3 +--
 3 files changed, 11 insertions(+), 24 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -637,7 +637,7 @@ static int xhci_enter_test_mode(struct x
 		if (!xhci->devs[i])
 			continue;
 
-		retval = xhci_disable_slot(xhci, NULL, i);
+		retval = xhci_disable_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
 				 i, retval);
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3523,11 +3523,6 @@ static void xhci_free_dev(struct usb_hcd
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
 	int i, ret;
-	struct xhci_command *command;
-
-	command = xhci_alloc_command(xhci, false, false, GFP_KERNEL);
-	if (!command)
-		return;
 
 #ifndef CONFIG_USB_DEFAULT_PERSIST
 	/*
@@ -3543,10 +3538,8 @@ static void xhci_free_dev(struct usb_hcd
 	/* If the host is halted due to driver unload, we still need to free the
 	 * device.
 	 */
-	if (ret <= 0 && ret != -ENODEV) {
-		kfree(command);
+	if (ret <= 0 && ret != -ENODEV)
 		return;
-	}
 
 	virt_dev = xhci->devs[udev->slot_id];
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->out_ctx);
@@ -3558,22 +3551,21 @@ static void xhci_free_dev(struct usb_hcd
 		del_timer_sync(&virt_dev->eps[i].stop_cmd_timer);
 	}
 
-	xhci_disable_slot(xhci, command, udev->slot_id);
+	xhci_disable_slot(xhci, udev->slot_id);
 	/*
 	 * Event command completion handler will free any data structures
 	 * associated with the slot.  XXX Can free sleep?
 	 */
 }
 
-int xhci_disable_slot(struct xhci_hcd *xhci, struct xhci_command *command,
-			u32 slot_id)
+int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 {
+	struct xhci_command *command;
 	unsigned long flags;
 	u32 state;
 	int ret = 0;
 
-	if (!command)
-		command = xhci_alloc_command(xhci, false, false, GFP_KERNEL);
+	command = xhci_alloc_command(xhci, false, false, GFP_KERNEL);
 	if (!command)
 		return -ENOMEM;
 
@@ -3591,7 +3583,7 @@ int xhci_disable_slot(struct xhci_hcd *x
 				slot_id);
 	if (ret) {
 		spin_unlock_irqrestore(&xhci->lock, flags);
-		xhci_dbg(xhci, "FIXME: allocate a command ring segment\n");
+		kfree(command);
 		return ret;
 	}
 	xhci_ring_cmd_db(xhci);
@@ -3666,6 +3658,8 @@ int xhci_alloc_dev(struct usb_hcd *hcd,
 		return 0;
 	}
 
+	xhci_free_command(xhci, command);
+
 	if ((xhci->quirks & XHCI_EP_LIMIT_QUIRK)) {
 		spin_lock_irqsave(&xhci->lock, flags);
 		ret = xhci_reserve_host_control_ep_resources(xhci);
@@ -3701,18 +3695,12 @@ int xhci_alloc_dev(struct usb_hcd *hcd,
 		pm_runtime_get_noresume(hcd->self.controller);
 #endif
 
-
-	xhci_free_command(xhci, command);
 	/* Is this a LS or FS device under a HS hub? */
 	/* Hub or peripherial? */
 	return 1;
 
 disable_slot:
-	/* Disable slot, if we can do it without mem alloc */
-	kfree(command->completion);
-	command->completion = NULL;
-	command->status = 0;
-	return xhci_disable_slot(xhci, command, udev->slot_id);
+	return xhci_disable_slot(xhci, udev->slot_id);
 }
 
 /*
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -2014,8 +2014,7 @@ int xhci_run(struct usb_hcd *hcd);
 int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks);
 void xhci_init_driver(struct hc_driver *drv,
 		      const struct xhci_driver_overrides *over);
-int xhci_disable_slot(struct xhci_hcd *xhci,
-			struct xhci_command *command, u32 slot_id);
+int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
