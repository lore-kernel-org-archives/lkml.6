Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EO6HtjFG0KcaICnsZUAUOclMweXBahRQTikusCZpc66n2PiIgyFxH3uMp+d5YGpd9LF9r
ARC-Seal: i=1; a=rsa-sha256; t=1524405990; cv=none;
        d=google.com; s=arc-20160816;
        b=pQZ5TCrP4KWIhzzXrFCNhtRjzXS2/dc7l2oPr6+leHccsnDR1318U+9WjZ8QendlG0
         XV8TcAoQ37/n8l4+yRYyla/9hb/b1ff0uhibSZeZLWkTZRIuigtbL6y6vKzzDVpB6s3s
         SMxBnJh95JD86lNWcN9PHlncdMiSWfuWsccOlpdTsd271xRKM5osS7qiDprT5ZIoZCre
         vlsXKSVjnwWdwOrUysZ892UOTE+kokAs4XwLF6b/QdCtze87D+lx6hj0i9423sFYxDUA
         xumuMUt2H0qiy5BRDLLTws8Jv/8rEADXQZB6O06977Heh7cX9GAb0XupkSOHbplsdp8o
         0Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sLy+KfP0dNoHunrnlPSKMFAzPgspgTMfR+EH+W7gvCo=;
        b=iLR073Hd7KrxiL4wDI+f9v94zhibJMQWVwRw18cnVnxCgrnfAmmj51C+T8KDvEFZb9
         rU9qThJv9qcE8ueKn8aqJL7appQzBRxUHJrlQg/tqtbG8SifX5QISt0YD9+1Sgy87sYZ
         32Kp82tTUWwPDphx2O+QRu7/8zkez5Atq+sQGzKivtpFOBRJAKeD3Q45JDXo/HpW3iC3
         NnRb4MXeIdBcULVtOp0kOZU9EeZaYlaCm0jHE/HxZNbLoM8nHDpQ6UPSiTD82gCysDRF
         0k/7MVadjnyj2m76pluNQ7kv7fC0ki58D5oI+T7E4VhpHTvi5E5SN0KK8NmJXXbYH/nk
         kXgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 4.14 038/164] USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw
Date: Sun, 22 Apr 2018 15:51:45 +0200
Message-Id: <20180422135136.964518200@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454888478547425?=
X-GMAIL-MSGID: =?utf-8?q?1598455535843170597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

commit 64627388b50158fd24d6ad88132525b95a5ef573 upstream.

USB3 hubs don't support global suspend.

USB3 specification 10.10, Enhanced SuperSpeed hubs only support selective
suspend and resume, they do not support global suspend/resume where the
hub downstream facing ports states are not affected.

When system enters hibernation it first enters freeze process where only
the root hub enters suspend, usb_port_suspend() is not called for other
devices, and suspend status flags are not set for them. Other devices are
expected to suspend globally. Some external USB3 hubs will suspend the
downstream facing port at global suspend. These devices won't be resumed
at thaw as the suspend status flag is not set.

A USB3 removable hard disk connected through a USB3 hub that won't resume
at thaw will fail to synchronize SCSI cache, return “cmd cmplt err -71”
error, and needs a 60 seconds timeout which causing system hang for 60s
before the USB host reset the port for the USB3 removable hard disk to
recover.

Fix this by always calling usb_port_suspend() during freeze for USB3
devices.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/generic.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -210,8 +210,13 @@ static int generic_suspend(struct usb_de
 	if (!udev->parent)
 		rc = hcd_bus_suspend(udev, msg);
 
-	/* Non-root devices don't need to do anything for FREEZE or PRETHAW */
-	else if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+	/*
+	 * Non-root USB2 devices don't need to do anything for FREEZE
+	 * or PRETHAW. USB3 devices don't support global suspend and
+	 * needs to be selectively suspended.
+	 */
+	else if ((msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_PRETHAW)
+		 && (udev->speed < USB_SPEED_SUPER))
 		rc = 0;
 	else
 		rc = usb_port_suspend(udev, msg);
