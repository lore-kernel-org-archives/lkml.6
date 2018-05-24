Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpE4xxjnTOpQh4jgE7uU/LXQypNJBgNRucgzMa3AscgWzFcbVkdlyXVxCNrffvS4irdhWBv
ARC-Seal: i=1; a=rsa-sha256; t=1527155644; cv=none;
        d=google.com; s=arc-20160816;
        b=BGajx73U40pp71j1YLpLoNj35aAptNNGoqUlQrDAorlLUPMY4uqE+E4Telk/mkiOXO
         1LB5UZUefdO/eBRwTTLDTOHEf46UE72w2KHtV3LVLJnBcGEcCmcfmLmBYxFL38UlU/t2
         0PcYx+a4GZgPLlOAeSA+/wtKJCHBBRz3/OMEQHdqi4Tbx5F9TaQB3Qb7yaTGg7xwejn3
         V5d1RkvzhQ9IbNgD2IYfzfUk0EAPLR2LiHdEeTOBD1U5JHzrOiZASJbGCzC9QpixNlFU
         ytCD5IelF6qZ9OyPxb0vLnpi3cL0L2aDCzBi0CvVzHnRvo8Ohooqj/JV5gUVco88r3u7
         3EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5lXFr2sKYGFTV3YL0JOv0gHAXUGicH9l+BDfwR0F0AM=;
        b=Sa4zLocr/I4lMEKvCA/knXSv6cl3FkpU/q6QgA2Jl0XH88Ai1i0R62hP1NbcCZBz90
         2IbiaEtEAf2Y+COIE2DbDNqRMQPCVIQz7xAQ9EgH/atV8ZdkpKllrmZRRJTOV0r5UMnk
         MTCBMbltOJHL5zB3Cy5R9I7NaPHeGXEEThYYbE3tdZaBRmpwju3xSJZUvZC/nu/meosG
         HY6m0YO3AC9tMSLAtwlrX5KJygQGr0o6VMIN6c3Muj31sB7O6ydw3rsFmgR5XghoIiKi
         6pxEuDME5QT3yj7chHO/1VdS+m76bj/EzX11S+wSPaItBA1eDX+3KKHTDo9iOxah6vx+
         bb7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RsJNhhwC;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RsJNhhwC;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fredrik Noring <noring@nocrew.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 064/165] USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM
Date: Thu, 24 May 2018 11:37:50 +0200
Message-Id: <20180524093624.613341312@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338479068807617?=
X-GMAIL-MSGID: =?utf-8?q?1601338757403147367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredrik Noring <noring@nocrew.org>

[ Upstream commit d6c931ea32dc08ac2665bb5f009f9c40ad1bbdb3 ]

Scatter-gather needs to be disabled when using dma_declare_coherent_memory
and HCD_LOCAL_MEM. Andrea Righi made the equivalent fix for EHCI drivers
in commit 4307a28eb01284 "USB: EHCI: fix NULL pointer dererence in HCDs
that use HCD_LOCAL_MEM".

The following NULL pointer WARN_ON_ONCE triggered with OHCI drivers:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at drivers/usb/core/hcd.c:1379 hcd_alloc_coherent+0x4c/0xc8
Modules linked in:
CPU: 0 PID: 49 Comm: usb-storage Not tainted 4.15.0+ #1014
Stack : 00000000 00000000 805a78d2 0000003a 81f5c2cc 8053d367 804d77fc 00000031
        805a3a08 00000563 81ee9400 805a0000 00000000 10058c00 81f61b10 805c0000
        00000000 00000000 805a0000 00d9038e 00000004 803ee818 00000006 312e3420
        805c0000 00000000 00000073 81f61958 00000000 00000000 802eb380 804fd538
        00000009 00000563 81ee9400 805a0000 00000002 80056148 00000000 805a0000
        ...
Call Trace:
[<578af360>] show_stack+0x74/0x104
[<2f3702c6>] __warn+0x118/0x120
[<ae93fc9e>] warn_slowpath_null+0x44/0x58
[<a891a517>] hcd_alloc_coherent+0x4c/0xc8
[<3578fa36>] usb_hcd_map_urb_for_dma+0x4d8/0x534
[<110bc94c>] usb_hcd_submit_urb+0x82c/0x834
[<02eb5baf>] usb_sg_wait+0x14c/0x1a0
[<ccd09e85>] usb_stor_bulk_transfer_sglist.part.1+0xac/0x124
[<87a5c34c>] usb_stor_bulk_srb+0x40/0x60
[<ff1792ac>] usb_stor_Bulk_transport+0x160/0x37c
[<b9e2709c>] usb_stor_invoke_transport+0x3c/0x500
[<004754f4>] usb_stor_control_thread+0x258/0x28c
[<22edf42e>] kthread+0x134/0x13c
[<a419ffd0>] ret_from_kernel_thread+0x14/0x1c
---[ end trace bcdb825805eefdcc ]---

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-hcd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -446,7 +446,8 @@ static int ohci_init (struct ohci_hcd *o
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
 
 	/* Accept arbitrarily long scatter-gather lists */
-	hcd->self.sg_tablesize = ~0;
+	if (!(hcd->driver->flags & HCD_LOCAL_MEM))
+		hcd->self.sg_tablesize = ~0;
 
 	if (distrust_firmware)
 		ohci->flags |= OHCI_QUIRK_HUB_POWER;
