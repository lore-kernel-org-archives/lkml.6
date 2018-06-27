Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549EFC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048EB25C47
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDBBLSMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048EB25C47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934989AbeF0QEq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:04:46 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33170 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934936AbeF0QEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:04:44 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so2785054otj.0;
        Wed, 27 Jun 2018 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6PySoBRfifAzBxXuBXgnTzPB/lqOymPdQg6Upzm4f4s=;
        b=bDBBLSMYLm5YpdS/njYu5rpiK1ATSQ+uAlniLs+P0dzVeTQsUiuJpVGRgdUkzs1A2a
         ZSfjaBfpXXsMyk/c7VElrFsxYfXaT7OP08ghBXRSkw+ql9KrdhkDYpkzZC8jZ0GXOPPg
         qZ+UYtYeLHEENfevMGr9yFlnxvbEzld+hCmeY126dDw7sLj+EqcG0EKu3JLKk5gxvlZY
         bcDXe9v2i+C0XPxZmjbpvUz5we6cSyHe2bFLteBXUWg+mKzJkkl8M+SaCNTCfaK1DGHi
         dv1fuZtn+huyoqxS8XCZJ/o55gFVTBSkcsIq9He5b6+BbxDNbEVFxdbmiXEFugSYn/ci
         B1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6PySoBRfifAzBxXuBXgnTzPB/lqOymPdQg6Upzm4f4s=;
        b=r0nOp4d+RdPz7rHPH4YALtGM7tTiWtjJsv6NBeOmfACG8ACbTx0RSQZyYHgftUt5cu
         jB8N26OOoiOHCwfe1aJR6l1FEGa6dXHqVLIT+yJZZWPchPnwFIbSZ+yvyZ4yWwmmn3pE
         kQMmkh20fCCWDREXL9QIV/kQv/zWcQEzhH6kncHRjXGMJmr+cozWvOL8QEJ28NWhgxqC
         NvU1C5eToH7WC2VFYPgBUm7tULXmoA7j0lRqPJ71xHpmKWfu6j8v354p3zQce7HDz2GK
         Qpmu32GMjE03xApMnIf9mZsU/y4lyuOz8h+0A+Q1IpJ6GPnOcv0G+JlkQ+THpdFLSpS4
         71Lw==
X-Gm-Message-State: APt69E3iPIqsMS+yxfFR0iT7MZlZ40RYzOTPe+7YEh/3L3atNsdl1627
        RfnbXVtSd0BSYmUfCjlUO70=
X-Google-Smtp-Source: AAOMgpeUrfZlclSdoIw2KXHlWQXgiGIbDIms0fGxsQW1r0VTq4z0YbJZUCsXM2W1/Nv2NdGhCp9e7w==
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr3969775otj.361.1530115483488;
        Wed, 27 Jun 2018 09:04:43 -0700 (PDT)
Received: from guyc-Aspire-ZS600.asus ([173.216.132.44])
        by smtp.googlemail.com with ESMTPSA id u10-v6sm577866otu.0.2018.06.27.09.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 09:04:42 -0700 (PDT)
From:   Guy Chronister <guylovesbritt@gmail.com>
Cc:     guychronister@outlook.com,
        Guy Chronister <guylovesbritt@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed typo on USB device ID number.
Date:   Wed, 27 Jun 2018 11:04:27 -0500
Message-Id: <1530115467-3771-1-git-send-email-guylovesbritt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6372edf..6ec766b 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -196,7 +196,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-	    pdev->device == 0x0014) {
+	    pdev->device == 0x0015) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_ZERO_64B_REGS;
 	}
-- 
2.7.4

