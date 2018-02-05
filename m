Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242wksgi/zS8fNKPeQERqfbDCrQ64rPVbzNbt1eZ9wTauhNIlGiISnu5cw609fQN1L0S0UL
ARC-Seal: i=1; a=rsa-sha256; t=1517855202; cv=none;
        d=google.com; s=arc-20160816;
        b=aWgJoEktd02EOOZA0O+ZdrtQXcSdmbMVdg/G6rabW/rGLZKGBKic6V6x2jTbWLCuTS
         Hjm5Rh1472+7M6ax2pfr3hlPePo/2PvV8/rfOiUDA/w7zh7nSAw/pkHyVU1QyAl0T0XT
         5YwC2NbBOzRwRkN8U1wGe+78kt0beO+NQoYRDMSWacILUWHELecj7D5yTAxmmkCy9gCL
         UDx9xrSb8RNgHcseG0fHQhckn/uy8GwwMc2B0XuVjtMmrtXTr+9u8Gc0Eju0gkxc10ZY
         w0zwrg0cM69FAE+PSqTj6kPpzRtjgxnLg/UEnq03KPxkaHbOFLQsD6bgqGRZTd+OipkB
         J1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ri1i0ZLEh5U7S3k2vbItrgvgZ5NRVG94dIQ2Ao05/GE=;
        b=hveAjwvw+4pbVjYlgQV48N1zW87I/wDkh7bleG6PqYWOL8xDusNiFh7+As4mo8A62j
         MGSIM0wktf8OAnMgnDtSecypnHNANXKWkmAL6qYla/zqrT2RzwUW8t07WmFy0OHwFveA
         7C090kLfEylv27Q2aaOeaCEwdXivy8LMLfB36tOQV4tPPNWKgk3+48CMidPyd+Rh7pWy
         PUEYOJf6CejesmlpipYU6vMmEAMcnn1dc7bg5KuiWK3g7PGppjjn90In1nvRyw9k1kzz
         ohAQ87paliS0raBjYQX2UNjCjG8ZD96ROtUg696Wk4xDwu0ztofefpSxHiD3YIdK+e6Z
         R3Bg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 29/36] usbip: prevent bind loops on devices attached to vhci_hcd
Date: Mon,  5 Feb 2018 10:23:57 -0800
Message-Id: <20180205182352.968973260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586537459457408?=
X-GMAIL-MSGID: =?utf-8?q?1591586537459457408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
