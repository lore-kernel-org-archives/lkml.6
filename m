Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278cuC0hT14EIwF9N5K1yiKd6sODrJsTJzThOOrOImEO9/E314xlMOkU5SOdvHrzVgJ/EA7
ARC-Seal: i=1; a=rsa-sha256; t=1517590948; cv=none;
        d=google.com; s=arc-20160816;
        b=oSipMJ/eiPwWvRHtm/GHLm3ToUfo83oXEf7wmCuSAhmVGBfahRSliZ4Vh1uczKnu1g
         nT2jyIwvcovTgdH1ENUBhjIftqAn7o43buK6IgkJwEt7cl/jNRStDEVjGHD2i+xTTgcS
         BaK/B/07K+bgERix+D+lLfSUUVxuKWf7uF111u5UMkp3rxR4UmEQYHBe1/chwLw5fjcw
         RJVop0q0ISVdfZVVgGAXuIhtsfkxT1BQscntj7phFbfLVLZiPVCE9v2JZ9ELqYfTBW8n
         qYc+ErfSinDWjTjYtEcC+SVIZy1EnniQx78uE7A307wxWzida53rD0mdMwe1l70BKieX
         8bpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OnPlwiJKYgUtlPFUbh2KYIh0NmJYdfQv0AH4qa4nQsE=;
        b=PpiaCLGFZkc/QZH1z4Slf/HRc2kijWSd7tIHcKKfbliZqYCSqX3KNzEaL/7DPbtllR
         Z0rPvKo//oFABIiTWQfTm+3FRCsuBhVXW3AMzpx2ZEBKLYiP1KSO+aO6Xg+hzKejwaRV
         Gs1z42Zks3Teb0QrvGyzoMrfXWV/gaSbNO05NnOD3FTGn9H7EcCxkK10P2Luzu8gFw+N
         VN3EWDq9d+lYvGVzB4WpJwqguxoyW+1xVNL5SJfYttEQaiyeQWbAHy+jgKk7uJG1hmtF
         ei9xLLpzieXYvrB+rCW/rClFgZTJnMf9qUuQIRqsMvpq3sWY2AY0jAqwBBCf99Lsy45G
         +BSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 61/67] usbip: list: dont list devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:30 +0100
Message-Id: <20180202140821.982443896@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309446455834325?=
X-GMAIL-MSGID: =?utf-8?q?1591309446455834325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -180,6 +180,7 @@ static int list_devices(bool parsable)
 	const char *busid;
 	char product_name[128];
 	int ret = -1;
+	const char *devpath;
 
 	/* Create libudev context. */
 	udev = udev_new();
@@ -202,6 +203,14 @@ static int list_devices(bool parsable)
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
