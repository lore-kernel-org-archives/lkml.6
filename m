Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227EdoqAFN/05WnUvmOfSO6+SnYmTY4CYnX3DjT2wz2Ymba859g21BcjGO/zgbk7QkH1eSjc
ARC-Seal: i=1; a=rsa-sha256; t=1517855203; cv=none;
        d=google.com; s=arc-20160816;
        b=PwWoGQ7gErFaNu1+dDc1j0I8mwTiDM5jSzLwru0+MEyKfN43ZjJte0SJ4H5wjtn0Ik
         whCpbryXoPhmi7JqEWv0S2sQlO6vUluHvOMKh2trfZyMSYhcFRw3CwKMO3YYWOPgamQv
         gfk04rLGr5l0NNDB2L7I7NVM48Oud+/BKduZ0ub8uAOCfKetbLs6EAys6iQ+TVb5IhuJ
         29vSno97ENrKS1oFi7zJHaQzJMYTOPFkeDmaK30xe4GWHGgZKdemU3U4tu5uV4Y/nXI9
         LW1yxfxCCV7JS3JJPPa1kMDEUuhsNcGGU/xvSc77fxh9FFv3fExAB/jiusg9lzKU36OX
         CLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BdSkzhPtyTfvrN+IHFbGmuPsNRZ/+g7NILK4rYmmwpI=;
        b=viQ2NeFDd/sR5ZkHnF6jXyPv26XVrwE9y+/4x5gFApH6vjkf1oMCIGSkZTgB0yiBM6
         Rkh08rFXPkc1iNt36MbMYvRI+F2VQvNBE/j5qvfy8/WTDh/3xT46qXuRkJtWq+vqZdfm
         zv56iyUVVuOtAiGtAuss6ALNSxfuoibCYzMK3w4x00Iu07WEbO3Rk018Eq9TXO70/rlJ
         Ox4gkWcsbXG+XpG/OqCe+m9oMaEsKy7huxrMQtSfqgv/8Dh+AeetN0D51C6oegfJ2MMj
         so3bxCA43TeyC/kruXd/E2mIGMHrO6cVFbIeZrF6Ed9Sx1WE/2HlYzxJNidMulmBta6P
         RC9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 30/36] usbip: list: dont list devices attached to vhci_hcd
Date: Mon,  5 Feb 2018 10:23:58 -0800
Message-Id: <20180205182353.011400224@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586537737168048?=
X-GMAIL-MSGID: =?utf-8?q?1591586537737168048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
