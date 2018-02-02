Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227s6K+eSBy/EzKwTrImHax0cwo8EfoyIFp2N7O01opQeWE11X8nTkkoNSNoNBvvyZm4+F6m
ARC-Seal: i=1; a=rsa-sha256; t=1517591674; cv=none;
        d=google.com; s=arc-20160816;
        b=qyb43D5qHy18i8pRFWtwjFWcsLeSrqjr7LzG//6RXgU5qACcEIS/8//ERI0CcWC1NN
         Hly0DJoNqDx2d8mUdzIPeFqmSejYtT1KeNozzItbCJhoCAK2IpmPSqB3K1YrsUhSSHfY
         jDiuLOKpXP2Z/mkW8PdwQp0knJEoDWhhPiwyqRP5fMXXugBEYagqjE6NokpWdfHOdXW3
         LwhtnhG0f1TBc63XxncBJkb8fx4wc4tVcAD+lXVp+x/Ciu+17maTkSdnvhXyxFhWIYVK
         S26ikkJzEbVX6gHiHnkqPQR+x0WscoSnNH1n0rfhhMRGGtJ1y6xjBc6o93V2ccdNLKLu
         zKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AeSHPvftPOgNaAzWArL9NNilRrZn6FiA1tfR3w0R3fs=;
        b=kb1ciaALxXKOTaeZ8X3tWQzGks9ii25gdQZQ9yXJ6RGTcyekJHwg1+f9ljU5rtScSD
         uCRtYNGn5XiRtsL6jUcww/dgz+QbWgQZ7ekL8m3P30f0vMGGFT1GBLPIAoA6GDl2ki+S
         DVMgsU3WdjM762aLR/pyxuETHMtfYqo5uWWxLJ/X9fJ5yjQqVEG3WwEomb+k4sNofkD/
         iHaMnrOpIpMkGJBwOpqJp1OgaSYiZmgsFG2sseU4Ck7f70t5DPrswhINubj3YRbCm7Ws
         4r1UALArR76OLDYITe5WBa7LNXbOYANyeu8JC4lkGBCvokaWuVU3X2Yu1ANDwjRKE2Mw
         FjsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 138/156] usbip: prevent bind loops on devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:39 +0100
Message-Id: <20180202140846.622444985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309467728999985?=
X-GMAIL-MSGID: =?utf-8?q?1591310207702789780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit ef54cf0c600fb8f5737fb001a9e357edda1a1de8 upstream.

usbip host binds to devices attached to vhci_hcd on the same server
when user does attach over localhost or specifies the server as the
remote.

usbip attach -r localhost -b busid
or
usbip attach -r servername (or server IP)

Unbind followed by bind works, however device is left in a bad state with
accesses via the attached busid result in errors and system hangs during
shutdown.

Fix it to check and bail out if the device is already attached to vhci_hcd.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/usb/usbip/src/usbip_bind.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/tools/usb/usbip/src/usbip_bind.c
+++ b/tools/usb/usbip/src/usbip_bind.c
@@ -144,6 +144,7 @@ static int bind_device(char *busid)
 	int rc;
 	struct udev *udev;
 	struct udev_device *dev;
+	const char *devpath;
 
 	/* Check whether the device with this bus ID exists. */
 	udev = udev_new();
@@ -152,8 +153,16 @@ static int bind_device(char *busid)
 		err("device with the specified bus ID does not exist");
 		return -1;
 	}
+	devpath = udev_device_get_devpath(dev);
 	udev_unref(udev);
 
+	/* If the device is already attached to vhci_hcd - bail out */
+	if (strstr(devpath, USBIP_VHCI_DRV_NAME)) {
+		err("bind loop detected: device: %s is attached to %s\n",
+		    devpath, USBIP_VHCI_DRV_NAME);
+		return -1;
+	}
+
 	rc = unbind_other(busid);
 	if (rc == UNBIND_ST_FAILED) {
 		err("could not unbind driver from device on busid %s", busid);
