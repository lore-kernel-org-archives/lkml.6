Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ROrYDZSYiIZM5EuEFxfTNC8RtUroT0tkMkCOktqYCzazXF3G4iF0Vyn1KDu10UjbOqp9A
ARC-Seal: i=1; a=rsa-sha256; t=1524406702; cv=none;
        d=google.com; s=arc-20160816;
        b=IjbfHsFtbpSGGmRd0jEFg8sYKNzZkNLWkjrcNxq4AuV7vWqCWCayyMjAwvyJtMUlXD
         ywz90FumVgfLcJFKkZK6WLbjXAoB7hEAcHM9nrpVTq17ZcLgzORVZnm8h4nH8CEAhDbr
         r/nUgZmsg4idra0NVHbLuDgRcukGz1deaX33ozzmsQcilGKH0M9OfK0v8dbXdE3UUYUj
         vhBHQy17k4pFDrVMHQGHcmmaQLTUXKQQ3H+fRs89pl7VIW18AProBwDVI8A4tJGsODJn
         jmn1u5g6+Lbu+SkWMdlEc/9yXkkMNmyOm6Cf864kqqPyCJB2/mFK+7DUEzqIgDROnM1k
         QrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XI2d6gfeNJC2soMADy37wjVO5Zx4FnoRGbutKpPwhw0=;
        b=NvXsGHZse6g66B9UpaSeM7duXQMiVtAwg7GtHhQW3uoto1SoB28QIUyW337Gby6LgF
         RqSNmytdqvQ4c2EMKhCg3NG92E4A28oO0iLFJvjA3T8OqtWaUo7Seoz5Hw+X4iqK7A1B
         8x+XKRXbnPIUBycdIM93YQZ97wbKRSOlsy/KNRaQKX91hjfWgIu5Dh3s1T2/XHNB2PHt
         G+Zg3/US1OPxQNINgL+VSXZAuBhBD0mm90G1Stxq0/N34JhbUfcq78tGUxvGb1pbWw73
         +rsPgWPi7FQvf8HH1ad/Xw0qbCZcUcYPrHfitoloBNZYZlfGmrs6/+A13ehKmhlBVFDk
         YG/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH 4.4 37/97] USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw
Date: Sun, 22 Apr 2018 15:53:15 +0200
Message-Id: <20180422135307.421111179@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454888478547425?=
X-GMAIL-MSGID: =?utf-8?q?1598456282754006451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -208,8 +208,13 @@ static int generic_suspend(struct usb_de
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
