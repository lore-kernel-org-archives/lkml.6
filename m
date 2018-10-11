Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2207FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C9F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMA6cN7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C9F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeJKXPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731168AbeJKXPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 951A52098A;
        Thu, 11 Oct 2018 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272885;
        bh=zx+KU5tgZa6aoM5/tTVyDlu75L++P47u4s8D0voHLpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMA6cN7mancNj+nKt5GMW79cVLPBf62+UwmWYq0x8pIpFWkKrZk6jVNikBXYvpPPC
         H1LDrWHKctFqTSk88gBTrevzEOxO7EuLhpJCBVwKOez3bCOdQ2f4WPLGDvAV7ruAhQ
         0DmMx1o8D9jFqg1H1lSW71aI4wncidPxEYTq6XrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.18 28/44] xhci: Add missing CAS workaround for Intel Sunrise Point xHCI
Date:   Thu, 11 Oct 2018 17:40:06 +0200
Message-Id: <20181011152453.662422281@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit ffe84e01bb1b38c7eb9c6b6da127a6c136d251df upstream.

The workaround for missing CAS bit is also needed for xHC on Intel
sunrisepoint PCH. For more details see:

Intel 100/c230 series PCH specification update Doc #332692-006 Errata #8

Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -185,6 +185,8 @@ static void xhci_pci_quirks(struct devic
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI))
 		xhci->quirks |= XHCI_MISSING_CAS;


