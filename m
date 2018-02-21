Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227hFLvxEoLdVxUGQYUt2piMlhHVyrWSLX70fliwlGYjeHrAeIMQ5S2cuQMDba9iZWwDL93N
ARC-Seal: i=1; a=rsa-sha256; t=1519218287; cv=none;
        d=google.com; s=arc-20160816;
        b=J3frhHV59a7ayAo+9vyWiKSAnX9fwcjHKt2VLuIQBw+iu+s5+0NKDqvXDkhp2E8dBE
         kscp3vYSLNKpiKsUtrnRY5fKqUrxJG6bw7q/wdr469ytRWKcHyG7Jn518HuzHWdPpg2i
         BMadsbfwVWuYBSEG4FXz4OHLeqGVWcfEnoCGguRPuLIEoUhePXtkjbBLCyP7DlOZEwl2
         3dT4vm8LsS3w7PIYtR0ojzJ4P2+zO2wILVPWjqGq1+uNMCgY62wyOpdGY+SbbXnmzWQC
         SdFHA3z1j7wVfcAnu2eL13lF+N2JwNkTgq1FRIS0/2J4soAoBgV2KtdVH46lyixqipXo
         JVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PS9+wcZdPucFewta+94a/B/1aq6fnfeEs+8LmoRXr2o=;
        b=AFbJRoRvi49iNW8xY+AZMa4/U8o4zRE3+dbmPxRT5nynrW5F9nJHTaIQHdUSVQlqwB
         nmQMdC1ZJER/eNj/PQrZlO/fwNKzDIC44KWHFD7wsUmV52Os2aTkHW/rbmN/nhNcjtyo
         rFq/xhNobt+AHge4uqm9lpP3xgGqkJMfeAAbKIci6Xwo5UWWy7ERh0nsjsGnC/F/D7WX
         4d0qrIz/p3LSbeP1ihklRv71DAhwGwk3RxQGX0MAWSRLZbzM/QyZrwFCY93M71nxK8UH
         eF7WNv3ds4LU5z608v5p5Tr8MrWggsh0tZA+w45kUuZ6KRV8CYWAFzksYYgCbrDnEMn7
         NYhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 154/167] Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
Date: Wed, 21 Feb 2018 13:49:25 +0100
Message-Id: <20180221124533.283031693@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015835567100549?=
X-GMAIL-MSGID: =?utf-8?q?1593015835567100549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 05e89fb576f580ac95e7a5d00bdb34830b09671a upstream.

It is no longer possible to build BT_HCIUART into the kernel
when SERIAL_DEV_BUS is a loadable module, even if none of the
SERIAL_DEV_BUS based implementations are selected:

drivers/bluetooth/hci_ldisc.o: In function `hci_uart_set_flow_control':
hci_ldisc.c:(.text+0xb40): undefined reference to `serdev_device_set_flow_control'
hci_ldisc.c:(.text+0xb5c): undefined reference to `serdev_device_set_tiocm'

This adds a dependency to avoid the broken configuration.

Fixes: 7841d554809b ("Bluetooth: hci_uart_set_flow_control: Fix NULL deref when using serdev")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -66,6 +66,7 @@ config BT_HCIBTSDIO
 
 config BT_HCIUART
 	tristate "HCI UART driver"
+	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
 	depends on TTY
 	help
 	  Bluetooth HCI UART driver.
@@ -80,7 +81,6 @@ config BT_HCIUART
 config BT_HCIUART_SERDEV
 	bool
 	depends on SERIAL_DEV_BUS && BT_HCIUART
-	depends on SERIAL_DEV_BUS=y || SERIAL_DEV_BUS=BT_HCIUART
 	default y
 
 config BT_HCIUART_H4
