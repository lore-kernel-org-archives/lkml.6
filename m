Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226q2VnQoJuUr9kxp16bH1VEuE8mE+1C38oEZ+BbKxaWkPNjvdzVaG5gCxfTc9xJ4U6EQ5U/
ARC-Seal: i=1; a=rsa-sha256; t=1517591765; cv=none;
        d=google.com; s=arc-20160816;
        b=04K2kkZToaRYnL99J79Av2KeeOPBGzxGUJ0ACpBe6KihIrKUcgM4zJp7Xqsioj9OE6
         kNroDfSiGXia1ngrZC+LLL+6CMY528dr+UGoOY9Gndz4qqUSi6CwkowgD+6MVHiv4yCh
         u8XmZ05x7jze+McTXO4iAbnQoSL+3hshiwTEm9PxAaW6AVff2iVyNyWhSZwsv72N551t
         XeQCHZmroV+1a3COm2s+p+Gk0ok3cvjb1wPlwMyxH5JRWtN1/dKsOAlcxMDoRw3pXoda
         zQqEGcN4O5bu003kgkFH7R+zdfNgtLr3u1eXPdmxhlwcucXsEL1Z7ktdpB5FAMqbMA1+
         Gs2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wHCZAKkFJuZyR7ZzwVXibUvZwga838kiskoA9qjWAR0=;
        b=e7Hnr95peZgZmjkIVX7MGoqz9zN11wJn7+veUEbec9NY2g7+FEMxcm/j6JstwUcyTY
         JR2rExb0w/yqgUDcn2JF8R1eKNkIFb3M5s2proLVoNRzTK6DIvq/bGVc6KYofmCieaqA
         3FvLRikB7hvnA7JFAa5peSFB2MGSxjzjUyjoPj5hkAoUWHDFs5EfLHFU1exXlTmQiHZv
         tzEns1nsU2Dn2g6N46SuySuj3BHQEwZZ7mulDUgAghbJRG3r+myf8bSJxXrHzM9IG2RQ
         2rn2iq8JmTfks/omSleBkbKIFezli1N3Fx94fpVX98jA/Zv2k9nziXqfqnckfoK590sb
         5kug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.15 36/55] usbip: prevent bind loops on devices attached to vhci_hcd
Date: Fri,  2 Feb 2018 17:58:54 +0100
Message-Id: <20180202140829.760810465@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309467728999985?=
X-GMAIL-MSGID: =?utf-8?q?1591310303572129510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
