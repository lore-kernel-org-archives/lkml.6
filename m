Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225BWL2ULnNPpJtJRMJJ5k/kM26h7SzGdxOCWV98fGovowIOgmbuSJbQHscpdgtan6Rlz7HP
ARC-Seal: i=1; a=rsa-sha256; t=1518709031; cv=none;
        d=google.com; s=arc-20160816;
        b=mwe1bn+XAKq5CyrqcNwE7VCw2eVP4pzlb5EhZ6p4y3Dn0zPs14dM4XGM1LnY6/OVhj
         A+oZlpNfX6HxoJdUx5nmcruE4faVhbPd6r25ltlr2vBf2d8sspCcBaGU5//I6GR8G2Dj
         9pfWZuflStAIv6GVXg+BfM8GMjeloIUcE9XeeRcp6ICpcSub0VdKsVK+jNrG+zmvCeid
         9owctc5/axDDNnKacX/qe31VYpHAjd80rJfruWTP5abwQwSBadEwlmguS5dBZFUh/Id4
         rmrxLzFt0rvY8oTxslkxvWAo4G9UuqCP5HXnu0fPwrxp4CoIikDlq87SA1162PWxhutC
         4RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rC+AZXzDSW5X84KXdzrzxXkxln0tRijlF9CxlQpkJPA=;
        b=iCF4q3viUTw6U/afZZhsKe30XYPtoHKRotwokgnrYSjR3et8yQGa8grCr2skZPZMhe
         T9mbHRPjEL8Q1auUSQ9XoUXSf8FNCbQKnUbDMr6DBERmxr7upWcXnhzGxOB7qzKaya0G
         n8uv8XQYPVkXPTLVapK+CDFBVfXkfnjseOodQVCzGox+oxI6g1V3svf6++wxUGFWBvQU
         CCt08ajrnpk0QeFwl+DpEM4KUmifi/KxEdo0D0HIele59B0xeVfY8Kz8o5Zb0ewMJnih
         rXq/cdLYZ+Ipp3hYXUndk9iURgcNdNUvW3SASlucTjZMDXSvqYGhkoK03cX2ToKDRpnO
         QhCA==
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
Subject: [PATCH 4.14 159/195] Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
Date: Thu, 15 Feb 2018 16:17:30 +0100
Message-Id: <20180215151713.896685414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481105470680951?=
X-GMAIL-MSGID: =?utf-8?q?1592481841747192878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3099,12 +3099,6 @@ static int btusb_probe(struct usb_interf
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
