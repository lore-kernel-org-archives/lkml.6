Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/e0Q2OX1erVqD56MUcrV2xPfZeryZLZ6eyiien/r7XV6VY1O+Louvs0S5YED4q79YF4xG/
ARC-Seal: i=1; a=rsa-sha256; t=1522168273; cv=none;
        d=google.com; s=arc-20160816;
        b=A01fpERMxYoOPsQ7NfY6ipsXjD3N6RSg0U8ZRlBtD3Tr9W19nzoB/7F52AIR5vlxES
         DPH8Y62/cg+TnCAFVXACSstNUiofEU3AKWeDELn6X2sZJSBm+DXIQ/tw9y2tE6Qtnu2k
         2PMwiEYUR0aeoDl3CR4lUnx7WhEpZ1ErxfEbZA+xr2X5ofuY+iy01DTqbn+A6zaIjvuJ
         KT09o0QdyHU/GSegXUdsX0m+hP3AmdqJQErA5KOm3R9pq4QEyH40pwfHcVSugJfo+RCs
         +4D6nrtv3pGiU098l3D6VsB+O4a1dNX4h0w3pqhnDy9eM10GpGtCgdVatzjQIEJAcSTb
         8GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OpVW57Z4QhISHS3baQGitZwdCCCaW4T6QnFnTqcmbDg=;
        b=wEvXKptEirNVB3MbO4Z9EUogmlVqtbUKl7fVk2JmgzaXoc7blBgCvP7YhOOYxq5bZA
         JIcHCLVmT9gVRXeXZ17trWzFrTw5hCRpc1ltrcm7uVWQZijt1waSb/UFqqBGugDlT1cl
         sNReoi/P1awJd6MKHQ1tSVjWmmE5xdUWFSZlSOv1Bq5uwF/ERv4pNlDa0WWcTzSNknOb
         1rhv26xygByCEviOVQ6B9XA5BW49OQjBgsd5I8g4HE4UkZCso2j7EYM2D/Bk1DDjjVQf
         EdxuOi0j789UlJRfUPp5+haRq79c5BmV3U7945Hs5lJrqcnJllP7Kl6N3iqxqYeuE1K5
         8iQQ==
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
Subject: [PATCH 4.9 13/67] Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
Date: Tue, 27 Mar 2018 18:27:05 +0200
Message-Id: <20180327162727.430669120@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109041135098917?=
X-GMAIL-MSGID: =?utf-8?q?1596109119871278857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -217,7 +217,6 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -250,6 +249,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
