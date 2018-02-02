Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227nJvvV7ZaU/x3BZ/PYW9iTUlB1z7ObsKfKXHsahCdDc33Dq1r0/6I5PfBz1MpMIbiJip+p
ARC-Seal: i=1; a=rsa-sha256; t=1517591677; cv=none;
        d=google.com; s=arc-20160816;
        b=PsjhPqDCjLF5pgj/+j1S6IBC9NDN15KNV5P1iWJpxuxvYgxe0sjX3RDV8Nqb9to27I
         hrDOUzuhlWdGqz1w6Ivhr5UKt6le7W/eZuUbB49graZ928Jmy1NSVQ4aHYapUljLqd28
         kTBPncD0x7OJnmRtiGcUyBOST14voX3ul301EtqcT421cjqzdRBpXsOC+gJZgI6rw+2u
         WjGtstc9jxM//h1Hkq5QACXVkS5L3qgNmE/UteB5SRriv88xdDR8cikfBfyjFmCB2fQC
         nokNFFB3LDbwzSgmUKf/B+kWmQIOVFAx9au/cMZG0ZXbouFFoKHhJhRqWiPOJIP7/ldX
         PtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GT8eCIALRKGr6d3MmI+PQIKTKbdrtv7pfd8HM/oTMB0=;
        b=m7jGS+eeMkIMgmIvL3StAOal8g3BM03CU7Odkulw0qzvFJ/Ai69Qdaw8rGXr4ZOq9S
         vBJaJYzDbUomK1W3o0LUJn9QHpbydnPqpKWl1dKM8DKEhRXoul2okzjBWpfsREbsmk7I
         xk6qHr/iNiLdOQG6r6YIgfAp5WtzWlxFDPbAwfRDeiDX1Bf6hrj26DsdhGtfp698pl4D
         hz+L11FIRZKWgdu1gizG37qrUT3PWN8y5OHiqhE5j5h1gMPvhGkjsMYHYlquOTJ0n0QV
         tMd+ZHXr0w7XtUCgxmXzFnZAkbckKOF/wG7iO6vboGn4rI9Ex9C1N9UrM2j+pwNLlPmt
         h7Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 139/156] usbip: list: dont list devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:40 +0100
Message-Id: <20180202140846.663815139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309446455834325?=
X-GMAIL-MSGID: =?utf-8?q?1591310210421302259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit ef824501f50846589f02173d73ce3fe6021a9d2a upstream.

usbip host lists devices attached to vhci_hcd on the same server
when user does attach over localhost or specifies the server as the
remote.

usbip attach -r localhost -b busid
or
usbip attach -r servername (or server IP)

Fix it to check and not list devices that are attached to vhci_hcd.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/usb/usbip/src/usbip_list.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -187,6 +187,7 @@ static int list_devices(bool parsable)
 	const char *busid;
 	char product_name[128];
 	int ret = -1;
+	const char *devpath;
 
 	/* Create libudev context. */
 	udev = udev_new();
@@ -209,6 +210,14 @@ static int list_devices(bool parsable)
 		path = udev_list_entry_get_name(dev_list_entry);
 		dev = udev_device_new_from_syspath(udev, path);
 
+		/* Ignore devices attached to vhci_hcd */
+		devpath = udev_device_get_devpath(dev);
+		if (strstr(devpath, USBIP_VHCI_DRV_NAME)) {
+			dbg("Skip the device %s already attached to %s\n",
+			    devpath, USBIP_VHCI_DRV_NAME);
+			continue;
+		}
+
 		/* Get device information. */
 		idVendor = udev_device_get_sysattr_value(dev, "idVendor");
 		idProduct = udev_device_get_sysattr_value(dev, "idProduct");
