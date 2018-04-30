Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+Qgr4XCoKN2hezdz3J702EfAd59ke3s7iKK+aIy+K0TOjLYy8TunrKj9hPIeEcvMAyUzM
ARC-Seal: i=1; a=rsa-sha256; t=1525116422; cv=none;
        d=google.com; s=arc-20160816;
        b=kEksUMB7uFacbot3s65Vm22y/jzAn7WUx8NTo/Y5XjI+xyLVq3M5j1L6mDDxXz4Jan
         v3yXT5wRyU4JZpECi/JDqRlz3gQlLRPGR+Iu15xwPb8rps8ezSB/Cudk+6HrE4R8n8cN
         GCRI1BY8S1yMFgCrwgsqOE+UrDcfNs0dSZvyFdbNG65W5vinmlj2JVwm7cYxkxDR0Vs+
         y/FvVV7QeY2AHWMJuqzHXrQWgH3GIwgMVeBrW9ohiiaOjg5ZyuDXcpvGjGg2JAhAz2E0
         gnxj+Ul8+eNOd+N7ZHqryQ3Tui+XPjnhfCn0Gn4Z7gmggp40Mkih5DjjWu7rwMSNPa87
         k2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=OMsYUaYq/h2rJYHTz4Flno/cAEdJh87ldDVo5rC/Dd0=;
        b=SvN/IouoY/NgRYoyVWqZgkEDV0X7DCwEcElKR+m7mOEC9Y2uwlcoIcHiUQkaFwKsEn
         CrcNA3ahp0YfH6COi+32JnH/GiZ6bFc131/QCkpNjN2wNkW4DQs3ieVaeEbeKtKht5i0
         X6VTjUqNdNfI34JN1WP5IVcxpm4nIjWEdFaABq0ExhljOUeR7XeMfU7fg/ZPjUwmaC6w
         3v1k+pZioyThNEWdflKKMXb7J/+qMOCPqUhQ+pJOg5kjwaaUbms/QD52ccOIhKw1wlZQ
         kzAMLkASOkRBprT7XLSvQ0UCdsf+j8uGqugRjBHpo0hf+SsM24tjLOvtb/TwCbzvGzNy
         yaYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CBC22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.14 20/91] USB: Increment wakeup count on remote wakeup.
Date: Mon, 30 Apr 2018 12:24:02 -0700
Message-Id: <20180430184005.266250935@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200292434828035?=
X-GMAIL-MSGID: =?utf-8?q?1599200477633665780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Chandra Sadineni <ravisadineni@chromium.org>

commit 83a62c51ba7b3c0bf45150c4eac7aefc6c785e94 upstream.

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

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hcd.c |    1 +
 drivers/usb/core/hub.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2376,6 +2376,7 @@ void usb_hcd_resume_root_hub (struct usb
 
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
 	if (hcd->rh_registered) {
+		pm_wakeup_event(&hcd->self.root_hub->dev, 0);
 		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
 		queue_work(pm_wq, &hcd->wakeup_work);
 	}
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -650,12 +650,17 @@ void usb_wakeup_notification(struct usb_
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
@@ -3415,8 +3420,11 @@ int usb_port_resume(struct usb_device *u
 
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
-	if (status == 0 && !port_is_suspended(hub, portstatus))
+	if (status == 0 && !port_is_suspended(hub, portstatus)) {
+		if (portchange & USB_PORT_STAT_C_SUSPEND)
+			pm_wakeup_event(&udev->dev, 0);
 		goto SuspendCleared;
+	}
 
 	/* see 7.1.7.7; affects power usage, but not budgeting */
 	if (hub_is_superspeed(hub->hdev))
