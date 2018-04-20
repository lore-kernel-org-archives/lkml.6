Return-Path: <stern+5ad477ca@rowland.harvard.edu>
X-Google-Smtp-Source: AIpwx4/LrIZ7OFPod3Dx75LaGRtZJDUonzHHQiO0QeWimnz9SSAn6wfoCIEFC08XMczrfwy3EQGx
ARC-Seal: i=1; a=rsa-sha256; t=1524245382; cv=none;
        d=google.com; s=arc-20160816;
        b=SdCnDC7xdLWew7Fl94qVcix8ghKXDncTELiso3tXyzrd+XPIFxjzM7cqpW8p4iyRm+
         QjK5yo0oQlo5milmrR+XaaQEG95hk7ApT0+pRP94LGcOtsZFSOUnkxp5vrEJYQT1almC
         PKHdwuj2hNIA/J5I1WUwxSkqE9gBIbVjZySTbUetGzLWlzaD8HP5bopFXa0ftAmdWv5z
         YU0iEFQesVdmRi8Tf4AZD9KNpeN4STfvQkrQZKqaU6wIlJlQbqtLR0NH3iSMcDacQeto
         cuv7YfZfOMJi0C4iAZxhp3LqAmVzvyZJ0rLGK2LpAAnO+ndy+0KpGehXt/oCDpwlYfxs
         pUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ZbDz8ntVFQGfDTlEgxiyYCjzpPLD94bhlgYL1KspdNQ=;
        b=rbAOD5g30TYC4BGJoikOAdxtCHoERB7N1qKLmImFWGdp1aPi60RAPgLlxJv8S/ahdA
         tdb/uJvcPZ0XlFDjKSgXTlEFvyT+F2E/M+p3YHbQh9nBr9WwujKQe9PL3t5XKCe1fehW
         xkSH2FxpQlUWQdJmThr2WJYQkKLgU5nGy/MNQsbY060cImjH4ZVSDGe5LKouX0yKpYXf
         YViyD3B80QIzjfCKVIHPAWzXRQGe8XuUj0T3Q3Hx1jbYpZWYCkgWdSIiGOT9Q+47zyN4
         FtgM5s8t72rcKPZqUoma62QShFzNBod06ZVNgNk0zuzZE2Dna6C5Ii90aQIBPb0MWEcp
         QFgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5ad477ca@rowland.harvard.edu) smtp.mailfrom=stern+5ad477ca@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5ad477ca@rowland.harvard.edu) smtp.mailfrom=stern+5ad477ca@rowland.harvard.edu
Date: Fri, 20 Apr 2018 13:29:41 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
cc: gregkh@linuxfoundation.org,  <martin.blumenstingl@googlemail.com>,
     <ravisadineni@google.com>,  <chunfeng.yun@mediatek.com>,
     <johan@kernel.org>,  <arvind.yadav.cs@gmail.com>,  <dtor@google.com>,
     <anton.bondarenko.sama@gmail.com>,  <f.fainelli@gmail.com>,
     <keescook@chromium.org>,  <mathias.nyman@linux.intel.com>,
     <felipe.balbi@linux.intel.com>,  <ekorenevsky@gmail.com>,
     <peter.chen@nxp.com>,  <joe@perches.com>,  <tbroch@google.com>,
     <linux-usb@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
     <rajatja@google.com>,  <bleung@google.com>
Subject: Re: [PATCH V3] USB: Increment wakeup count on remote wakeup.
In-Reply-To: <20180420170527.143240-1-ravisadineni@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1804201325430.1407-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598131689368834523?=
X-GMAIL-MSGID: =?utf-8?q?1598287125911899667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018, Ravi Chandra Sadineni wrote:

> On chromebooks we depend on wakeup count to identify the wakeup source.
> But currently USB devices do not increment the wakeup count when they
> trigger the remote wake. This patch addresses the same.
> 
> Resume condition is reported differently on USB 2.0 and USB 3.0 devices.
> 
> On USB 2.0 devices, a wake capable device, if wake enabled, drives
> resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
> The upstream facing port then sets C_PORT_SUSPEND bit and reports a
> port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
> has resumed before driving the resume signal from the host and
> C_PORT_SUSPEND is set, then the device attached to the given port might
> be the reason for the last system wakeup. Increment the wakeup count for
> the same.
> 
> On USB 3.0 devices, a function may signal that it wants to exit from device
> suspend by sending a Function Wake Device Notification to the host (USB3.0
> spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
> wakeup count.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---

At this point you're supposed to list the differences between this 
patch and the preceding versions.

>  drivers/usb/core/hcd.c |  2 ++
>  drivers/usb/core/hub.c | 10 +++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 777036ae63674..b8024ae4fdcaa 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2375,6 +2375,8 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
>  {
>  	unsigned long flags;
>  
> +	if (hcd->rh_registered)
> +		pm_wakeup_event(&hcd->self.root_hub->dev, 0);
>  	spin_lock_irqsave (&hcd_root_hub_lock, flags);
>  	if (hcd->rh_registered) {
>  		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);

This isn't good enough.  hcd->rh_registered can change at any time;  
it is protected by the hcd_root_hub_lock spinlock.  That's why I said
your code should be moved inside the existing "if" statement.

Alan Stern

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index f6ea16e9f6bb9..aa9968d90a48c 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -653,12 +653,17 @@ void usb_wakeup_notification(struct usb_device *hdev,
>  		unsigned int portnum)
>  {
>  	struct usb_hub *hub;
> +	struct usb_port *port_dev;
>  
>  	if (!hdev)
>  		return;
>  
>  	hub = usb_hub_to_struct_hub(hdev);
>  	if (hub) {
> +		port_dev = hub->ports[portnum - 1];
> +		if (port_dev && port_dev->child)
> +			pm_wakeup_event(&port_dev->child->dev, 0);
> +
>  		set_bit(portnum, hub->wakeup_bits);
>  		kick_hub_wq(hub);
>  	}
> @@ -3434,8 +3439,11 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  
>  	/* Skip the initial Clear-Suspend step for a remote wakeup */
>  	status = hub_port_status(hub, port1, &portstatus, &portchange);
> -	if (status == 0 && !port_is_suspended(hub, portstatus))
> +	if (status == 0 && !port_is_suspended(hub, portstatus)) {
> +		if (portchange & USB_PORT_STAT_C_SUSPEND)
> +			pm_wakeup_event(&udev->dev, 0);
>  		goto SuspendCleared;
> +	}
>  
>  	/* see 7.1.7.7; affects power usage, but not budgeting */
>  	if (hub_is_superspeed(hub->hdev))
> 
