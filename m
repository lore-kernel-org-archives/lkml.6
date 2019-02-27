Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE196C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894C2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QmNwv1T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfB0WTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:19:22 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54998 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfB0WTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:19:21 -0500
Received: by mail-it1-f194.google.com with SMTP id w18so11756067itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 14:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9H1l5Wdj1GWuKsEb4xNzSrNS9tB+LdMfzHBMpMzE48A=;
        b=QmNwv1T8AuLJaC/OXX05TWwgaBQeqHtWCR+72Tp5tU5Fdtxk+u1J88m+vW4O474Vjq
         nmCMCZK7dyF9TOSxDDBufD6GBiIBLdqkLLKp1sQ8CDlvEWdKxskozmoCjd/6OYwTTHn4
         PC0/SxcqNJD3yy5DoUgbLv+EbjNVy8IA9qLek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9H1l5Wdj1GWuKsEb4xNzSrNS9tB+LdMfzHBMpMzE48A=;
        b=UxC6qrSiqfshyB4SORmyBe+G3xR/HWVvpzVJgLIy5GQrYZJ4rboNI+r0hMSIrE+K4b
         YxysVGhtSM2yEBplfHYSJSJ4Qk75RVm02prSgLP3Fe/vQWxPl6XWQQgEEMTC5NYdS7vq
         SN+aVJkzOnB1freLIfktvMlzotgi/GW3DQWJbgejWhvbzebHUzl7c3/10pWe+CTpHw56
         R6uvRIpYy3pj54O+boN4d9L7iLgT3m4J9PSISPD1wNFqX4GnWh9RtaUheKDS8GHwgrXO
         ew1lX7Q7jgIzmSM7NOkrA/D9OMFmjaAYSCoGWatBZn2Jr9vjD7CyjkjhvbaSU1zxLDr5
         4l3w==
X-Gm-Message-State: APjAAAX1ZZ13jdse/9GqITzGw70qcEHGZu1k4oB4yCr+WeNu9mgEHno1
        tW6IyNrsSdiiDjDKrEj4hLKPCA==
X-Google-Smtp-Source: APXvYqzlBsBEVWWoISsS63dRohR/pC3fhAMWhce+XLOLVStAodHvLeqa7uG/A+22gWY9D0r7tbvabQ==
X-Received: by 2002:a24:9d94:: with SMTP id f142mr1065663itd.9.1551305960716;
        Wed, 27 Feb 2019 14:19:20 -0800 (PST)
Received: from djkurtz2.bld.corp.google.com ([2620:15c:183:0:1cfd:61a5:7215:5f9c])
        by smtp.gmail.com with ESMTPSA id j143sm1906263itj.16.2019.02.27.14.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 14:19:19 -0800 (PST)
From:   Daniel Kurtz <djkurtz@chromium.org>
Cc:     rrangel@chromium.org, Daniel Kurtz <djkurtz@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xhci: use iopoll for xhci_handshake
Date:   Wed, 27 Feb 2019 15:19:17 -0700
Message-Id: <20190227221917.62567-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases such as xhci_abort_cmd_ring(), xhci_handshake() is called with
a spin lock held (and local interrupts disabled) with a huge 5 second
timeout.  This can translates to 5 million calls to udelay(1).  By its
very nature, udelay() is not meant to be precise, it only guarantees to
delay a minimum of 1 microsecond. Therefore the actual delay of
xhci_handshake() can be significantly longer.  If the average udelay(1)
is greater than 2.2 us, the total time in xhci_handshake() - with
interrupts disabled can be > 11 seconds triggering the kernel's soft lockup
detector.

To avoid this, let's replace the open coded io polling loop with one from
iopoll.h that uses a loop timed with the more presumably reliable ktime
infrastructure.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/usb/host/xhci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608e..fde5ff84ba69b 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -69,18 +70,18 @@ static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
 {
 	u32	result;
+	int ret;
 
-	do {
-		result = readl(ptr);
-		if (result == ~(u32)0)		/* card removed */
-			return -ENODEV;
-		result &= mask;
-		if (result == done)
-			return 0;
-		udelay(1);
-		usec--;
-	} while (usec > 0);
-	return -ETIMEDOUT;
+	ret = readl_poll_timeout_atomic(ptr, result,
+			((result & mask) == done || (result == ~(u32)0)),
+			1, usec);
+	if (ret)
+		return ret;
+
+	if (result == ~(u32)0)		/* card removed */
+		return -ENODEV;
+
+	return 0;
 }
 
 /*
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

