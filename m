Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvmVsGar6S+uz2H2FQcPMb1L/hTom3WaSUyYPUr8kocvuAaPEA/y2Wvxu/Y6rTYvlRsblWp
ARC-Seal: i=1; a=rsa-sha256; t=1519836617; cv=none;
        d=google.com; s=arc-20160816;
        b=nzPrcFANHo7rFJ4t67mkK/uQhIBmmB0Mejz8ZkwN6jsyznzJMcFOOljZfZvUAK86VV
         bkfWFikYp58fJlmZl9k1esKAXtynpT0ST9ynP/litzO2uuWGeVSkJ5YQd6Tq0wQaGpzo
         Ute/3Iz7WrqSgvvIgzFOf2RVrH30IrMs02ZdOePpISg6TTXvoBICT7OqKW5yDDAAyTZn
         FXRswEmq5CMUGlhBI+OF6Pp+UxRX2810Z1qjdZOPD0wh/7X283kdxUupNnRpoV11kSf5
         gBKaQWKAMZmbN1EhPGRP8wVgV7QCZB5+c9uWEUk9op4kLYAaK/sX2VD8MIuevtIW44c6
         PpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Rzl8XOTLxziCCVH6dqz9viwfGHuuBsw8Sz/h6GAsGGY=;
        b=E5U++9W1SzWN3pBtn/e5LTNWLtUIlaoCQMtFIOfDlW/wmJdTBSOCDGgLqMYurxyZYQ
         CLFTD801tMHx0LWpNSNKxrqeDA9ANDOV947ZlCMCDBmPPNcZk/voDbIu7NqurJwbONLO
         KcNpc17CIr0btcwZcIwWdVBYM3c6tqsRYMk74RIrq17DPpancPOC2ZyqI3P6HnoAg7DU
         kgfvw4K0kpHzJThuI3ATAStQsDX+oL5Snw93VNG/NLckvR/AOic8ZdUWMfjxS4Rh2x6x
         sF4qVyRtSqBda+waw6qS7be9onQvATZoajtOZ+eYxzjp9P+PBYFZK+FJE7iemi7io6Yc
         d2Aw==
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
 "Icenowy Zheng" <icenowy@aosc.io>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Hans de Goede" <hdegoede@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.649355122@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 194/254] uas: ignore UAS for Norelsys NS1068(X) chips
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593664201560968987?=
X-GMAIL-MSGID: =?utf-8?q?1593664201560968987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>

commit 928afc85270753657b5543e052cc270c279a3fe9 upstream.

The UAS mode of Norelsys NS1068(X) is reported to fail to work on
several platforms with the following error message:

xhci-hcd xhci-hcd.0.auto: ERROR Transfer event for unknown stream ring slot 1 ep 8
xhci-hcd xhci-hcd.0.auto: @00000000bf04a400 00000000 00000000 1b000000 01098001

And when trying to mount a partition on the disk the disk will
disconnect from the USB controller, then after re-connecting the device
will be offlined and not working at all.

Falling back to USB mass storage can solve this problem, so ignore UAS
function of this chip.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -145,6 +145,13 @@ UNUSUAL_DEV(0x2109, 0x0711, 0x0000, 0x99
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_ATA_1X),
 
+/* Reported-by: Icenowy Zheng <icenowy@aosc.io> */
+UNUSUAL_DEV(0x2537, 0x1068, 0x0000, 0x9999,
+		"Norelsys",
+		"NS1068X",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* Reported-by: Takeo Nakayama <javhera@gmx.com> */
 UNUSUAL_DEV(0x357d, 0x7788, 0x0000, 0x9999,
 		"JMicron",
