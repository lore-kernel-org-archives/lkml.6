Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032891; cv=none;
        d=google.com; s=arc-20160816;
        b=xFdiXkE1k6+CVV5nYfZjaPJFPmr8PzpP/aKv6edHarZN3QfNsKvoGZADBSXvU97AJ7
         +HDlElmShmwgTjfSC32FCdGzHobmj1XQD9OeZX2jqGF76IWr+Q6oAmXR9qP4vSHLgQOs
         L22k7BbVte7D+RKkHWsNXYNNmw+0hzDD19pTthFMwRLYhL8YdrpBCfAxSW+LWqfvLRGD
         oHJoAQVEXfW6d7l/pTPjQqk1lBWtnza+PMqrkK+nvcKWs5z1E7lfsAL6pVxEcDG00o4G
         YeRPhCl3D7cq3xHwy8J0hVeLoXa9UCSM3l62PrfJ197RymZgHZ+AhEtWhV/hFQh8jegN
         gRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HeiwGNYYT4qTwYr9XbcMY7Kew3d9EpliLX6W7+Wr5Co=;
        b=qlWvnMsgs8gbB/65LO1Q7mtgnn042zJCprMeknrrd9MrXhkv1PPSrXffdm7iDyERpp
         v6k5ioOpPcPiERtXkDTAF4Avttgt4EQLpdJoGd9Z3alsBS7j7BgCVLzBPikM5jOgzA6b
         q1/2Fijr5jsCbZJy9TjDbbF3IG075Uwf1rl/r5GNtyiwPnb2xglz61a8+jSP6PO9QQVO
         e/816BdGZfSQeW5gHHXsQ77XlFH+9szZVvORvIEcqO9LquAj7gGmaWOSnq6yqt2m4CT6
         Sl0X6QrP6oZdAsUYstkXOv7HJgwNiYk5LuAKr14o2WAf+ndfqUW6LXgPPQ87nah7kyiW
         HvLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cK/KFTNT;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cK/KFTNT;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227MCxbqk1p7VcA2wzZtQ6zKDr9blQ5mfXLAOBjtAihUwWDwd8TsW09l+ZHomzC0dXHSI5kJZg==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 09/12] parport: Switch to use module_pci_driver() macro
Date: Wed,  7 Feb 2018 19:47:56 +0000
Message-Id: <1518032879-5844-9-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772856610888074?=
X-GMAIL-MSGID: =?utf-8?q?1591772856610888074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Eliminate some boilerplate code by using module_pci_driver() instead of
init/exit, moving the salient bits from init into probe.

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index c56bb06..08e218e 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -694,22 +694,8 @@ static struct pci_driver parport_serial_pci_driver = {
 		.pm     = &parport_serial_pm_ops,
 	},
 };
-
-
-static int __init parport_serial_init (void)
-{
-	return pci_register_driver (&parport_serial_pci_driver);
-}
-
-static void __exit parport_serial_exit (void)
-{
-	pci_unregister_driver (&parport_serial_pci_driver);
-	return;
-}
+module_pci_driver(parport_serial_pci_driver);
 
 MODULE_AUTHOR("Tim Waugh <twaugh@redhat.com>");
 MODULE_DESCRIPTION("Driver for common parallel+serial multi-I/O PCI cards");
 MODULE_LICENSE("GPL");
-
-module_init(parport_serial_init);
-module_exit(parport_serial_exit);
-- 
2.7.4
