Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Utbo/kI1pB8IJI0xgstkMDA9TTFlXsaNy1Iq1qDXUwtn3SP433mMh9Clp+m4fnH7PnD9P
ARC-Seal: i=1; a=rsa-sha256; t=1522168794; cv=none;
        d=google.com; s=arc-20160816;
        b=wNmgN3D1nA5Bbvo8ttaTciMn871Edhn3lIskrPZoWkVM1N14sHQxyrP5nVthXKhAlR
         f5+VlaoIF8PGYOxwuSKrFxr5/QPu9KJ3tH4U1mAK2WOA0w1i2JJKxF3M/jaetX9qu8TR
         MX9fC6xjdd+HagFJkY8f2qv+xq7T4B0TgjwQFeCX4AeZHxFZPSZenmtLh8PI1rkyHz8I
         LGPucvTLOYcIScEMTrI98rPM1+2hYu3HVYCW2zDLoMRAH/1zasSYCyVlLA799Bafh/oa
         eqBKO79R/8jMwLt3Qldpq0voapHFb5sKqQqJxhtlJ5Y2qrXC1wx7ZV47tiHk8d8KoDsc
         RNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sy0FWrZrzpHbhUZppSS0BwputcPHfZ99B+lTTnLKcJw=;
        b=dGAEHNnyi4RtkbNrhun3TnGkY7PAkHl1/xrkhSGIXh5CjRsNviADrL5hdZsM43OnRn
         WzBJhdLHHE0QNgkJ+54PiaUlHkw44bY/rcIW7c90LxTpwALwLK5XGCEBiGx4xJz8ghPu
         rO9W8ZoeLQf5RGY6iXYdF1Qd5JuyzRIwnlnElQLB0Kd0YY+Ae3Vanlr9ByWPUoRcwpgR
         c/+dy1LE5bdDKM4M3f9OQR142E7C8YSKW6So3mJizHhRXOouEir4h5B3zL0WTyXipMLN
         QHqrqmd/F+E7pHQJf7arQb+IpJ51T40inTlLbu4SaZqVOPm5vhCKau22H8DDc7xG08py
         8QIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ivan Levshin <ivan.levshin@microfocus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.15 033/105] Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
Date: Tue, 27 Mar 2018 18:27:13 +0200
Message-Id: <20180327162759.393172283@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109041135098917?=
X-GMAIL-MSGID: =?utf-8?q?1596109666043178567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f44cb4b19ed40b655c2d422c9021ab2c2625adb6 upstream.

The Atheros 1525/QCA6174 BT doesn't seem working properly on the
recent kernels, as it tries to load a wrong firmware
ar3k/AthrBT_0x00000200.dfu and it fails.

This seems to have been a problem for some time, and the known
workaround is to apply BTUSB_QCA_ROM quirk instead of BTUSB_ATH3012.

The device in question is:

T: Bus=01 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P: Vendor=0cf3 ProdID=3004 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E: Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
Reported-by: Ivan Levshin <ivan.levshin@microfocus.com>
Tested-by: Ivan Levshin <ivan.levshin@microfocus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -230,7 +230,6 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -263,6 +262,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
