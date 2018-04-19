Return-Path: <ravisadineni@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524097146; cv=none;
        d=google.com; s=arc-20160816;
        b=X9s4CNRYDJTgtar/A0wbMt038779wdgSMdj2HMpQj6W2nPyjW4uQ4k9kWFTQCznXxf
         CyQvaIeBaEoBeJAvLs8lOFsKqiovPyJgetaqJjBasK9PdjgFKkXw5u2Rs9sX+1hQaPo6
         jwwj2ZRe7+BVy54O7x24sJ6Kx/O6bhmtC9c0SBNi08fzk12QtrqKuxlW0p73TZNGFWZd
         tD91OKokMD5taZLGnkVyHZAVW5mOx/F5C0ufZV6I9j1UtTndV6g+2+k2Rl4kNKbgPhOU
         bBwgWgWHMXqnkdU1BHW9MMo3daU6ThbrCZyFx/WDWIveOR0WpAz/Y6otkbvEa57ldafG
         42pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=KBPNMxaXO5BRdA+16kGJLSjfpSPzl0mJ7vCw/WhluSg=;
        b=GwnFDDA8Z93mWzHGjzZC8D/cpikLdhr6ZBTjn0O80ab8lKkiQJCROOLlODJHcJyeQ/
         9pCsSVdxaquw7Wp5cG9Gqx5eNHGoibiUaZVxf64MOa+O5sLG5LSV4sh19HoEbdIybNAC
         qZI8E+qsHCxGxcJk2jXmWp1yZvT09ImPsQx7zYfmAXwJgrPM7W5oaB9HcUJOI606ubz/
         6afHIOuV32PBBEdKcnmCdODEZwVdIPhp3iAxbcbTyu4WcI3qmwnkRxxQNzRtaAXoRPC3
         LdCyWrhl8NU+JE0ZYUzCujhbezTtLdN6bhp5ODYVNLPM1zehcQCWPEUdjTpKNOnabGWH
         mrWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=XWE6aDKc;
       spf=pass (google.com: domain of ravisadineni@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ravisadineni@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=XWE6aDKc;
       spf=pass (google.com: domain of ravisadineni@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ravisadineni@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49Y0yzxzwyVTA9N0AfiXHpSVT5aoYNoCZFKsJ4sNmXRXZN9AHrQsEU4qxh281sTs92gNjpxiQ==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	martin.blumenstingl@googlemail.com,
	ravisadineni@google.com,
	chunfeng.yun@mediatek.com,
	johan@kernel.org,
	arvind.yadav.cs@gmail.com,
	dtor@google.com,
	anton.bondarenko.sama@gmail.com,
	f.fainelli@gmail.com,
	keescook@chromium.org,
	mathias.nyman@linux.intel.com,
	felipe.balbi@linux.intel.com,
	ekorenevsky@gmail.com,
	peter.chen@nxp.com,
	joe@perches.com
Cc: tbroch@google.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rajatja@google.com,
	bleung@google.com,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] USB: Increment wakeup count on remote wakeup.
Date: Wed, 18 Apr 2018 17:18:50 -0700
Message-Id: <20180419001850.133110-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598131689368834523?=
X-GMAIL-MSGID: =?utf-8?q?1598131689368834523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On chromebooks we depend on wakeup count to identify the wakeup source.
But currently USB devices do not increment the wakeup count when they
trigger the remote wake. This patch addresses the same.

Resume condition is reported differently on USB 2.0 and USB 3.0 devices.

On USB 2.0 devices, a wake capable device, if wake enabled, drives
resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
The upstream facing port then sets C_PORT_SUSPEND bit and reports a
port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
has resumed before driving the resume signal from the host and
C_PORT_SUSPEND is set, then the device attached to the given port might
be the reason for the last system wakeup. Increment the wakeup count for
the same.

On USB 3.0 devices, a function may signal that it wants to exit from device
suspend by sending a Function Wake Device Notification to the host (USB3.0
spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
wakeup count.

Signed-off-by: ravisadineni@chromium.org
---
 drivers/usb/core/hcd.c |  1 +
 drivers/usb/core/hub.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 777036ae63674..79f95a878fb6e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2375,6 +2375,7 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
 {
 	unsigned long flags;
 
+	pm_wakeup_event(dev, 0);
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
 	if (hcd->rh_registered) {
 		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f6ea16e9f6bb9..6abc5be1bcbf5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -653,12 +653,17 @@ void usb_wakeup_notification(struct usb_device *hdev,
 		unsigned int portnum)
 {
 	struct usb_hub *hub;
+	struct usb_port *port_dev;
 
 	if (!hdev)
 		return;
 
 	hub = usb_hub_to_struct_hub(hdev);
 	if (hub) {
+		port_dev = hub->ports[portnum - 1];
+		if (port_dev && port_dev->child)
+			pm_wakeup_event(&port_dev->child->dev, 0);
+
 		set_bit(portnum, hub->wakeup_bits);
 		kick_hub_wq(hub);
 	}
@@ -3432,10 +3437,13 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 
 	usb_lock_port(port_dev);
 
-	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
-	if (status == 0 && !port_is_suspended(hub, portstatus))
+	/* Skip the initial Clear-Suspend step for a remote wakeup */
+	if (status == 0 && !port_is_suspended(hub, portstatus)) {
+		if (portchange & USB_PORT_STAT_C_SUSPEND)
+			pm_wakeup_event(&udev->dev, 0);
 		goto SuspendCleared;
+	}
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
 	if (hub_is_superspeed(hub->hdev))
-- 
2.13.5
