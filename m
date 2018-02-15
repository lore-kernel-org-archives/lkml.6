Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225upm9cjm9GH5tf8YIayAa1KzeYVPhiidPYV9069WVLq4NyFjBOpm+LV6hSNWiOcSfFbGIR
ARC-Seal: i=1; a=rsa-sha256; t=1518708508; cv=none;
        d=google.com; s=arc-20160816;
        b=sOI/x4S8x+gp7+/oZJyBG8oSQW/+OTh6Xyi9BhwNw+DbdiUcHb0hxGVQ4ZZHjOQoap
         9peQlhkRDHAZYiFL059rVsC5R4vEPnAGUiscFQ/MfUqK7r1ywBuHN6hrWZ4PME7g7UQu
         5YJ1y3yKO7xPKjBit+dCgpl9mrpWeEo0Liq6kV+T61P6akoC2ZgUYePhsgXzLWmPAuMG
         55i5GbtMdqY/J4c01vBaiX6UEQUdSWtC6auqYTZzAumBVXKBcBfy3ek7hBZVLP/ojZO6
         H8g2gvO4rKbxyMznFiUDE3hdw9KA3TL4Pw+igtshhvd/SHlH4GaZbUC/DaYOXVXgRqJj
         Ivmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lYJWPcW0GKyDIkhZ/8AUm8wDQOQCgAPzgpfZE5DTpAk=;
        b=W3a4JxRR9S8ZdBTjSWiBE3Z4+F96fhuEz/FOb9o+a3pNI214jJFGR/ONipJ7z/k7GO
         XTWsfgF6lioeXlkSW/3vzXUU2pumNiGhBU7RHBQb5HUPQyXYWRv8ODspPI5JutMbMQ1Z
         qbS8rqjvVGfcgcjugX72a3pDe+z165LoyTqNzqDve4/iWzbGQ5l0XZi6BF580YEqHgx8
         ho990YdBVG4bXz+90SaXYWA3EtiFGeIf2tgtT3fws6H1VIxywggwl7mZzfhO77d7WbkJ
         DDjD62u7iS21YTjNzG9yoyNmGP4zLzk8VDWOddjRbR13PFeDGzSAOCTMU32rXfb+R9rA
         lNpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leif Liddy <leif.linux@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Daniel Drake <drake@endlessm.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 68/88] Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
Date: Thu, 15 Feb 2018 16:17:35 +0100
Message-Id: <20180215151231.958666430@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481105470680951?=
X-GMAIL-MSGID: =?utf-8?q?1592481292737691735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 7d06d5895c159f64c46560dc258e553ad8670fe0 upstream.

This reverts commit fd865802c66bc451dc515ed89360f84376ce1a56.

This commit causes a regression on some QCA ROME chips. The USB device
reset happens in btusb_open(), hence firmware loading gets interrupted.

Furthermore, this commit stops working after commit
("a0085f2510e8976614ad8f766b209448b385492f Bluetooth: btusb: driver to
enable the usb-wakeup feature"). Reset-resume quirk only gets enabled in
btusb_suspend() when it's not a wakeup source.

If we really want to reset the USB device, we need to do it before
btusb_open(). Let's handle it in drivers/usb/core/quirks.c.

Cc: Leif Liddy <leif.linux@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2925,12 +2925,6 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
-
-		/* QCA Rome devices lose their updated firmware over suspend,
-		 * but the USB hub doesn't notice any status change.
-		 * Explicitly request a device reset on resume.
-		 */
-		set_bit(BTUSB_RESET_RESUME, &data->flags);
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
