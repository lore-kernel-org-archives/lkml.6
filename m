Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC78FF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B0920893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 11:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgwdbJXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B0920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeG2NMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:12:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50397 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeG2NMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:12:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so10042595wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=10GUvqmS6JiyaCq216Pe5Yi+A0WnreATf2CdAiR54Rw=;
        b=vgwdbJXuvMD6ncbs24RZ5CvtrAPxrwcBn1O23gy3CAzHwWRTMSe6kuNXzbL6wqVHT9
         Rlmf+51kd314eJhwePW7Lu4MZfoWo1ZdfK5jVfwg+EUjTZzaNWuhH9Qz8vrbzHfOsGwT
         UikVerCQHc2NgIJ+B5P7CFwlfiAdGPn3IuVUtaSapAEFjopw+OkgCpX3t/qiQiafaU2E
         AHA2IP3SPqC1WBBa63UE69rjWoWhx/sakfTMBjD9C35mA0KGW0OMYQErkn23yqNNgfkX
         D75BNQjXeUj/OI2yCTTs/5ALSo4ocv2GuBY5Bw6vFdUykrdF3Lm/hGofIKBqtRridjMP
         W/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=10GUvqmS6JiyaCq216Pe5Yi+A0WnreATf2CdAiR54Rw=;
        b=cJshG79yDxiSE1PWTARe/dN4Lcf3c7qhGquo9j8ebTHEK9FbuMyMocO8DwzdOXeVdn
         shz1l1RN9amNkeFtKo7dzX816HIYfJxStFIoo9N2cWev5km7X6C8UWLCl0vKIDPXpG7v
         9m6s5WmyNeDm+MCtdTftTXqY8rz45XAgWVuFNZKSlxUgEZ7cSnVvnvh2TxGytkOsYXuM
         RlfAGAQHA0ePnoMqH2ixIVVY5MUNCes9iwFXhm0KkJtBBN+7fsLzju1tY/T685/UqSue
         B2ykhhnVWbMPCXQCMD8umQ8DfXnbCRrM7TADuoqg5876DdpaV15ULngzwmJ5MfYOO8dM
         4ing==
X-Gm-Message-State: AOUpUlHdSvsoDf1ryuZpR0ddZQSXrGe1jmKKsmsYvdog8VrWaxr1UlrD
        AnscmqK34/MQIpUpf7mCQchsYLGy
X-Google-Smtp-Source: AAOMgpdz3hij4pRATkzQwebiBPkfyUJSD6Fj7nYDYtQ5d+qPIEED5nLhZlFrKcvR0qcGSXruW+7Y2g==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr11569251wmz.79.1532864526166;
        Sun, 29 Jul 2018 04:42:06 -0700 (PDT)
Received: from we.local (ppp-2-87-92-87.home.otenet.gr. [2.87.92.87])
        by smtp.gmail.com with ESMTPSA id k3-v6sm10070305wme.44.2018.07.29.04.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 04:42:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 690FA6408D2;
        Sun, 29 Jul 2018 14:42:04 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6rNDzNrfH_IU; Sun, 29 Jul 2018 14:42:03 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id E6D8E6408D3; Sun, 29 Jul 2018 14:42:03 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] Staging: octeon-usb: Breaks down cvmx_usb_poll_channel().
Date:   Sun, 29 Jul 2018 14:41:53 +0300
Message-Id: <81f71a7c1997e53ec97f2b90ae562ff361a46f42.1532864059.git.tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1532864059.git.tsotsos@gmail.com>
References: <cover.1532864059.git.tsotsos@gmail.com>
In-Reply-To: <cover.1532864059.git.tsotsos@gmail.com>
References: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com> <cover.1532864059.git.tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make this function more clear a new function created that controls
channels halt on no DMA mode.

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 81 +++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index 8a7bdf1a9fe6..3f44ac260eff 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -2593,7 +2593,51 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
 		cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);
 	}
 }
+/**
+ * Handles channels halt in non DMA mode
+ * @hcchar_chena:
+ * @hcint_xfercompl:
+ * @usb:             USB device
+ * @channel:         Channel to poll
+ *
+ * In non DMA mode the channels don't halt themselves. We need
+ * to manually disable channels that are left running
+ *
+ * Returns: -1 on halt
+ */
+static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
+			     struct octeon_hcd *usb, int channel)
+{
+	struct usb_hcd *hcd = octeon_to_hcd(usb);
+	struct device *dev = hcd->self.controller;
 
+	if (hcchar_chena) {
+		union cvmx_usbcx_hcintmskx hcintmsk;
+		union cvmx_usbcx_hccharx usbc_hcchar;
+		/* Disable all interrupts except CHHLTD */
+		hcintmsk.u32 = 0;
+		hcintmsk.s.chhltdmsk = 1;
+		cvmx_usb_write_csr32(usb,
+				     CVMX_USBCX_HCINTMSKX(channel, usb->index),
+				     hcintmsk.u32);
+		usbc_hcchar.s.chdis = 1;
+		cvmx_usb_write_csr32(usb,
+				     CVMX_USBCX_HCCHARX(channel, usb->index),
+				     usbc_hcchar.u32);
+		return -1;
+	} else if (hcint_xfercompl) {
+		/*
+		 * Successful IN/OUT with transfer complete.
+		 * Channel halt isn't needed.
+		 */
+	} else {
+		dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
+			usb->index, channel);
+		return -1;
+	}
+
+	return 0;
+}
 /**
  * Poll a channel for status
  *
@@ -2604,8 +2648,6 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
  */
 static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 {
-	struct usb_hcd *hcd = octeon_to_hcd(usb);
-	struct device *dev = hcd->self.controller;
 	union cvmx_usbcx_hcintx usbc_hcint;
 	union cvmx_usbcx_hctsizx usbc_hctsiz;
 	union cvmx_usbcx_hccharx usbc_hcchar;
@@ -2637,34 +2679,17 @@ static int cvmx_usb_poll_channel(struct octeon_hcd *usb, int channel)
 			return 0;
 		}
 
-		/*
-		 * In non DMA mode the channels don't halt themselves. We need
-		 * to manually disable channels that are left running
-		 */
+		/* In case of non DMA mode handle halt */
 		if (!usbc_hcint.s.chhltd) {
-			if (usbc_hcchar.s.chena) {
-				union cvmx_usbcx_hcintmskx hcintmsk;
-				/* Disable all interrupts except CHHLTD */
-				hcintmsk.u32 = 0;
-				hcintmsk.s.chhltdmsk = 1;
-				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCINTMSKX(channel, usb->index),
-						     hcintmsk.u32);
-				usbc_hcchar.s.chdis = 1;
-				cvmx_usb_write_csr32(usb,
-						     CVMX_USBCX_HCCHARX(channel, usb->index),
-						     usbc_hcchar.u32);
-				return 0;
-			} else if (usbc_hcint.s.xfercompl) {
-				/*
-				 * Successful IN/OUT with transfer complete.
-				 * Channel halt isn't needed.
-				 */
-			} else {
-				dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
-					usb->index, channel);
+			int dma_halt_status = 0;
+			u32 xfercompl = usbc_hcint.s.xfercompl;
+
+			dma_halt_status = cvmx_usb_dma_halt(usbc_hcchar.s.chena,
+							    xfercompl,
+							    usb, channel);
+
+			if (dma_halt_status < 0)
 				return 0;
-			}
 		}
 	} else {
 		/*
-- 
2.16.4

