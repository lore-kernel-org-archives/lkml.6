Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224lyd27i+V1n/NT0Sa8203vKPpqq/ju8+KL8bFeat/+PZ/QuECJpq9fnpIvpZemJc16/uQK
ARC-Seal: i=1; a=rsa-sha256; t=1517590968; cv=none;
        d=google.com; s=arc-20160816;
        b=bd0XOLEIC87940ZqX2K/2IWqKxD1KwkIvXym1ic0ufqAgDPj/TFhZ5ZM40knjqaY4i
         LPZ8Ig4XldCML41jKVfO+XSzDW2i1ozCR+cCEGXpve2J4MTZTPAB9qQYJKygx5B5Hy13
         RkKWNgt4POUneb8Tce+wjx6mbh2fYcxcxJHP8IuculizC3sqF1bnOJ6l8OhICKZDKUM6
         f/o5v4+eOBWB64QSv9hOb4HunNscABKnEq6Rz+n4rT25zv4VfWx1vpM0uN3d8xy+hQP1
         91aY8yycraXyqdk0L3OtfxhI0KayD8nnZeeIM07lAzvgVXRUFXnW50Jw0c/4DmFAyfT0
         /j1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UbjQjweQo/kwKB6eas6QWmSzBPq+wM1QPVxr6eK7ZkQ=;
        b=HqSGlCRnyfECsdCruK/6VnxgwZ8KomPUl81dd/ybVJ+ccGAx0GNn2AOV+lEVNaSpec
         OI37LqEVi8ddTc8MfxPSWljNXhD3rInbO3Qcx0i3bNFyxRVN/F8a/REHivjwF8lA9a3m
         tobV7gdpLZgY5/SOKFhWodK3Ew90faYkV0dxcB+c7UumTiFeUJHgiTtnIARU4EnNoKt2
         YBBaYwbWXGgV4Cf1J8TVXwP5gtOqvAVwczPdaucHbp1qZ89cmAgJXV/QgQjewVdulE7j
         RVdlDdfRfnpTSiHOKohngncIVRZZcrIK2hDXk4yNaKlvEfIrVRqf+3sp00FBAzu8ryKA
         AF4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 60/67] usbip: prevent bind loops on devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:29 +0100
Message-Id: <20180202140821.868570518@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309467728999985?=
X-GMAIL-MSGID: =?utf-8?q?1591309467728999985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
