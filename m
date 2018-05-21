Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrym33RjECFWAYY/k1oX1HvYdXuDSON6inY4baq/Aij1taPzqkfrMnCr7pdQE0Lm74GrrW8
ARC-Seal: i=1; a=rsa-sha256; t=1526937741; cv=none;
        d=google.com; s=arc-20160816;
        b=y8M/qxzH3p+wpuqeUxJXYB0WWFZhZOq/WjoOLCTlZtbaWcLDunbZVzZ0uKzJ7C4ZgV
         TWbTmP/ysWs22Y78vvyrY5VQWJ3MaU21jPe+HfbaKYxwmmutSwCXi3IPv/I7w1OLPb6A
         8M3Kh8ik5tk+WRgZLOMm0PifF+j2ZAZW0r6jf2eABWmis9TGDplAMP7i6nlrn7yyBeCU
         C81FWrquhUkYcdv7UB2Z69pBMY5QFvtu9pqjuXVUU/T/Q5MufQpDhqa+olP7KfOBSmQh
         qISPkTWJY0SgiPgLwKYxjUllnKFfmcIowa96O1Qz/3Rua5J/JOGJwYlZEb5maTXTB925
         xhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xQ9xbXIIIjAEpnZ3Rgr7ZdSOIkLJBWfnFsGFPPSncnE=;
        b=pSqER5YbDzpbcoHCbCXBmsUq3u4YpRe/+gBrt3qdYLL79xZg0f5uKipqk/K0ccN010
         7R8d4/1h74PYs6Z9zzcR/oDCUA5u5GtfzTuBQPsr8y+to+AnSRLD3iumAEW70aYx4OoJ
         gkiWjgYTU6MmbCAUmbYS3Qyavj2W6boXGE2+zSkXhsrzVpSZBLM4Fr4Soye+CAGWTXs3
         0ouNJTFrr3ZTroseyyKYnhS7pqoNACOGzI+xEmrvwN7pWaQXIDyprijHsX2XSQblIvu8
         Yj/XklHhDA597hFxl9Mc3dEwyUhMZctRZAnDffhgoo5l2QdLUnw+fpxUPrddaMsFPwmH
         YW5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=AZ0iFYlu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=AZ0iFYlu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jordan Glover <Golden_Miller83@protonmail.ch>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.16 001/110] xhci: Fix USB3 NULL pointer dereference at logical disconnect.
Date: Mon, 21 May 2018 23:10:58 +0200
Message-Id: <20180521210503.936834693@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110268692847716?=
X-GMAIL-MSGID: =?utf-8?q?1601110268692847716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 2278446e2b7cd33ad894b32e7eb63afc7db6c86e upstream.

Hub driver will try to disable a USB3 device twice at logical disconnect,
racing with xhci_free_dev() callback from the first port disable.

This can be triggered with "udisksctl power-off --block-device <disk>"
or by writing "1" to the "remove" sysfs file for a USB3 device
in 4.17-rc4.

USB3 devices don't have a similar disabled link state as USB2 devices,
and use a U3 suspended link state instead. In this state the port
is still enabled and connected.

hub_port_connect() first disconnects the device, then later it notices
that device is still enabled (due to U3 states) it will try to disable
the port again (set to U3).

The xhci_free_dev() called during device disable is async, so checking
for existing xhci->devs[i] when setting link state to U3 the second time
was successful, even if device was being freed.

The regression was caused by, and whole thing revealed by,
Commit 44a182b9d177 ("xhci: Fix use-after-free in xhci_free_virt_device")
which sets xhci->devs[i]->udev to NULL before xhci_virt_dev() returned.
and causes a NULL pointer dereference the second time we try to set U3.

Fix this by checking xhci->devs[i]->udev exists before setting link state.

The original patch went to stable so this fix needs to be applied there as
well.

Fixes: 44a182b9d177 ("xhci: Fix use-after-free in xhci_free_virt_device")
Cc: <stable@vger.kernel.org>
Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Tested-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -354,7 +354,7 @@ int xhci_find_slot_id_by_port(struct usb
 
 	slot_id = 0;
 	for (i = 0; i < MAX_HC_SLOTS; i++) {
-		if (!xhci->devs[i])
+		if (!xhci->devs[i] || !xhci->devs[i]->udev)
 			continue;
 		speed = xhci->devs[i]->udev->speed;
 		if (((speed >= USB_SPEED_SUPER) == (hcd->speed >= HCD_USB3))
