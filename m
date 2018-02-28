Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225s5CCxDO1WiwDZ1rUewVRJsf0GLHaqkNv9MiOhhUBR7fVILCtJ68sbbqO26sI5wzNsj/vU
ARC-Seal: i=1; a=rsa-sha256; t=1519831343; cv=none;
        d=google.com; s=arc-20160816;
        b=VKR27kX/hpGfiAHQe4S6OJRMoE6KK14fE3hwP6xi9A7zTKo+/jl4rwRsPB8P5T25kE
         tyUUlwT9ephv53MIAGdZ94kNfJddA3lUpd7ZDHF7GVFBvzwpKdo+wNjY5EUjEFDjnFKV
         lp8rzs3NnJpnvGjdXRjtjIj9tX+3uRrPSEBNnSS3qsdAH0sYebkW9wKTbf4zlgvKBZja
         2+7WPtFzFI2RJqDhVlWWD+GOO5gBXddvb4SJtBUw5D2IK50JkdSK+hfLkJchFbQN3LET
         anPibaHvdZHZUELnsVbvIDwGFczQwuchMSoxbb55cK4qpcHN4xe8xb3jbFiV7g+hNDQn
         OMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=fOAohz/f5xKZPF34XFbic3fxaNfvYH/0yi/OocKbKGg=;
        b=RukcnHvAATBNnzWCQ9e6Mu6bbjXEBAWInLVvTcG8Oe841n/0HJvszJ02ET+ZsSLBME
         tLJUGUqEZB+mKgEleKLXgoahdFRe3tVq3TKA4/eULbUV4mum0PwJp69D36HXUpGDDp6u
         tM5uel0yEy3iuC79+BD6VNUbx5bqgtQtVM26YwhBpZffLt325gd1o0s7kx2QE3N7qDU6
         PQgxIs80yG0HqV4dPcucT6gGdSMf6tbO6pwNW14eZzePsiHCUxdsilnmhic6voWts79p
         PMIczs/VPBokOzxdx1A6pjVj0mfkvag5rR8a0Tov1nBdnOJ0JTz0nOfwx0nBYd2s1vpW
         Rftg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Hans de Goede" <hdegoede@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.250197924@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 026/254] uas: Always apply US_FL_NO_ATA_1X quirk to
 Seagate devices
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658670862317716?=
X-GMAIL-MSGID: =?utf-8?q?1593658670862317716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 7fee72d5e8f1e7b8d8212e28291b1a0243ecf2f1 upstream.

We've been adding this as a quirk on a per device basis hoping that
newer disk enclosures would do better, but that has not happened,
so simply apply this quirk to all Seagate devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/storage/uas-detect.h | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/storage/uas-detect.h
+++ b/drivers/usb/storage/uas-detect.h
@@ -111,6 +111,10 @@ static int uas_use_uas_driver(struct usb
 		}
 	}
 
+	/* All Seagate disk enclosures have broken ATA pass-through support */
+	if (le16_to_cpu(udev->descriptor.idVendor) == 0x0bc2)
+		flags |= US_FL_NO_ATA_1X;
+
 	usb_stor_adjust_quirks(udev, &flags);
 
 	if (flags & US_FL_IGNORE_UAS) {
