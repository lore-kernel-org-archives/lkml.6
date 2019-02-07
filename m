Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2063C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99452147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn4j45vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfBGADZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:03:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38247 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:03:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so3679895pgc.5;
        Wed, 06 Feb 2019 16:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6Y2SMTy/DLvibQn4rvUxUkItMt4BibJMOVwHTLlWdU=;
        b=Bn4j45vMnDeJ187Pc028HJG8OhN+ineByup/7oFOJzwXTK29kxU822HUPNS5A0NzBf
         98s+pbbGafgdmMfcfWQ/e49gsPCNWKAQZawO/BVDYtSVtGpsLza/e1UJGtImNiYVZH0B
         v0W7pD8R6IxVFQHlW5ViFFecmQS102F1HurvmVo2z2Spdhh+Ca0Xj9XzUaj+ne6j9uF/
         +hEpeUS7QRw1GFrlZhHK6/UCnl11fZic7oFpbchY9Ufrrye1fZHXBpp0lri8KDBVdA+H
         ZP+IjMibkya85ebNoVcfbGM0INBXCRw01H8v/VFsWpVbutFbzhCA3vGXHh8chzAxZd05
         2kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6Y2SMTy/DLvibQn4rvUxUkItMt4BibJMOVwHTLlWdU=;
        b=ZSzuudNG79tIiGyXSKS3ZcnWeU+SHNjNRrOtdVHvBcNZEWHob23xUB021V3yU03DNC
         pKTWVLMk3CRkiOMlxHm5vC5i2CuhOytPJOSI/MibCnI+1UgvwnRlNmc4mzoJofzHFlgA
         vi1dUauB9dTl9cFWix2zmy8ikCUuKFRMqHxkz4ne72X7mcGw/VPiHhmgD9x1oSFJ1y/r
         bMFu7i9dJqpnpLZMlQZAq2w+CigZwrn3/Sfav9c8YaAmpuPRnxc3fN5AZJEidOA+3xZs
         H61XPEkbxziIRJiSEMuKHtZ6P2FWg9dQlq+NjFyN3Zitvap0xIZAT95cS5HDHqtgw/mO
         Yx7w==
X-Gm-Message-State: AHQUAuaiF9CgZAKggosRIgj0gBbmUdiZOmJR81jzbdtSwuvUU5+4h6Ss
        dJetd9f+iMqNSCHdpHYV4DwozXb6
X-Google-Smtp-Source: AHgI3IbaC79tVu2cysKHDMF2+VL/07n1GVWjaK9l5UrvDjye5z1Wu1z71oRh9U3hGfVjJLDZE3m4ZA==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr12165266pgb.101.1549497802790;
        Wed, 06 Feb 2019 16:03:22 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p2sm11615974pgc.94.2019.02.06.16.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 16:03:21 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: Convert xhci_handshake() to use readl_poll_timeout()
Date:   Wed,  6 Feb 2019 16:03:08 -0800
Message-Id: <20190207000308.7051-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xhci_handshake() implements the algorithm already captured by
readl_poll_timeout(). Convert the former to use the latter to avoid
repetition.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/host/xhci.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..1b5306001340 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/log2.h>
 #include <linux/module.h>
@@ -52,7 +53,6 @@ static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 	return false;
 }
 
-/* TODO: copied from ehci-hcd.c - can this be refactored? */
 /*
  * xhci_handshake - spin reading hc until handshake completes or fails
  * @ptr: address of hc register to be read
@@ -69,18 +69,16 @@ static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
 int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
 {
 	u32	result;
+	int	ret;
 
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
+	ret = readl_poll_timeout(ptr, result,
+				 (result & mask) == done ||
+				 result == U32_MAX,
+				 1, usec);
+	if (result == U32_MAX)		/* card removed */
+		return -ENODEV;
+
+	return ret;
 }
 
 /*
-- 
2.20.1

