Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ypo8eFNHW6w0RdUb57t7wP1h4dqcd+pB59DhNMrssESKxOWo6X94+9gJ+gR8EXbo+cH7o
ARC-Seal: i=1; a=rsa-sha256; t=1522168704; cv=none;
        d=google.com; s=arc-20160816;
        b=hg4J06sX/iZ4FfXPxduWVeg5L+fFVXuXKMpRkkh9xJYV+2l31bZjF66HOthaEydpR2
         v2niaHaRZZ+OsYBTJwYCpUCzzSG8C/ZO9+e8SNaN1Itrw2wGXJ149CtgYUBMRnORtNF/
         IbjeQocqoQfbDV0ZBPT9BlE9UqL1sJWrDsYsNqpTO965wOdFv1rmWo09L0iwBD17xHWh
         vQ6fpR4m9ssgpPZk1eJBM/6H+SXA0TQ6vrjfgK6LLmy6JM1XaEK/A0P03X6etU9nwJkn
         I7qJj+yr7YJP8ldGB2yk+8mxyJdvxYI60vwpwgYFfbatSWumx8pucO66cMFga+cFcba7
         V93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vhcnMehMDfhujCHlcHdPElIr+yHMu8m3hViMxzz8if0=;
        b=bszKNX4QrWjE9SdsbjOgHG6uTyXHHOAWTf3DxMYqKRYLOCKjjjLLv6M7nZzJJYCRjq
         RVtM+C8/JPTbAZNk3DZGeYTG0UV4QHsr9lTJNXcw3VJf5f5YQmMaWlyyZJHb9x922NGI
         5kJBR4Vs3aubf+JxNlx3Iv4sWxs12ytHG4nNDSZaDKKtmLSQmUUQ2aVgqGfn3xdYudMn
         9BwNON+7A02ENmuPZNJlciyutkKTAHPK2fQVLIemljEWQywQIbChSykLqY7nkFC5ECWM
         AmP+hhNbXOuV3zMvQVIFX43DKH8/U1T44ljDrSEbbD9QKymPRAipxSZDq7ihhlhswU1Q
         Eleg==
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
Subject: [PATCH 4.14 096/101] usb: xhci: Disable slot even when virt-dev is null
Date: Tue, 27 Mar 2018 18:28:08 +0200
Message-Id: <20180327162755.907512389@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109571131306203?=
X-GMAIL-MSGID: =?utf-8?q?1596109571131306203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Baolu <baolu.lu@linux.intel.com>

commit b64149ca016c25f30b39ac5a8f37cfb9017e19bb upstream.

xhci_disable_slot() is a helper for disabling a slot when a device
goes away or recovers from error situations. Currently, it checks
the corespoding virt-dev pointer and returns directly (w/o issuing
disable slot command) if it's null.

This is unnecessary and will cause problems in case where virt-dev
allocation fails and xhci_disable_slot() is called to roll back the
hardware state. Refer to the implementation of xhci_alloc_dev().

This patch removes lines to check virt-dev in xhci_disable_slot().

Fixes: f9e609b82479 ("usb: xhci: Add helper function xhci_disable_slot().")
Cc: Guoqing Zhang <guoqing.zhang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |    3 +++
 drivers/usb/host/xhci.c     |    4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -634,6 +634,9 @@ static int xhci_enter_test_mode(struct x
 	xhci_dbg(xhci, "Disable all slots\n");
 	spin_unlock_irqrestore(&xhci->lock, *flags);
 	for (i = 1; i <= HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
+		if (!xhci->devs[i])
+			continue;
+
 		retval = xhci_disable_slot(xhci, NULL, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3571,11 +3571,7 @@ int xhci_disable_slot(struct xhci_hcd *x
 	unsigned long flags;
 	u32 state;
 	int ret = 0;
-	struct xhci_virt_device *virt_dev;
 
-	virt_dev = xhci->devs[slot_id];
-	if (!virt_dev)
-		return -EINVAL;
 	if (!command)
 		command = xhci_alloc_command(xhci, false, false, GFP_KERNEL);
 	if (!command)
