Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224EUHmwv+uh+uJYqS8O2ZoxkTJFjbLzltyFAFpQrVYmR3yqIusytvQr6RulB2o21w83sxSV
ARC-Seal: i=1; a=rsa-sha256; t=1517591184; cv=none;
        d=google.com; s=arc-20160816;
        b=hGFW4A38MVhb73PAlUGPSpTX6I5Ryveeug1IVHG06JLTEGkr5R6jfyZRDYpXNWNWwP
         3NDsuRgt7VVNoT/hk51WlBdel180SbS1YsrCz581QnrQFybLZN1hXw4bG7zh1aDzEVM+
         v+e6+LLADXLxnH1Kgw2lAOHFIZZ1TmHM0eTRi9c1m4OnX9y+VMMJU+LtBtx8iBWWxAOl
         PN2Iiz2gUBc/jeBcEbUmDHN8ioF9R4sadMNQSleJ0j0N8JiiHXR0j4amDtB+Q24xbkOU
         OiBfv65FrndeRqBxGtUZnSfHrDpYvnInDdYCfui/tYEFoSOj1PFzMlUTZ33+u0GEQ79N
         DK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SF6WPRhc/FVuPrGFV/PcE/xF/Xpw+ehAg+7NtbIMS8M=;
        b=DSgPIzMimJitBDIbOXOjs8YLfAoovS0r9feIFp600dl41BZvc0MyZ+1rLGKQt3nkeW
         eBABRBuTjM013B7rD/t+Zp1v6AJLv1jvy/rOBZnoRtJ4IxxjEl8wnAhj697ikoHn7Wzc
         LpQB8jEID7NnQn/WnuiGCkCVKA208vxFjHwwTsV9iC9rs95GZPclsARvSjrkDcaM+v72
         AcnNguhFnSqOpAW9cmIV2rH3VUU0NrQOnJMFK/fnlYYbmDSvxOuMjT8p/X3syKGL8Kau
         0NWzZ//sZWBgmwtCRAxP82H6XCcEM+bndEu9oP3wZTICARXV2Lv6lSmLjlMqB7rriVm6
         AKMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 79/86] usbip: list: dont list devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:39 +0100
Message-Id: <20180202140829.942628549@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309446455834325?=
X-GMAIL-MSGID: =?utf-8?q?1591309694735230134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
