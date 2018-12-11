Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A322146F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543398;
	bh=Ctr5J1sXdyalYOwTqhmbZVqlbVn0SmHoLOHbaI5a730=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fb9XMLeYUBFgXmXCgjAVkYQSBVnBjNZtlec/wkR2lwUCe6O41WB1/F1rhh90xf2JZ
	 DBsHhWYD4x05f85mygeM409sRXCwTY1P/Je05KNqh77BZSFVsXBXcE8q5vLCaYmIRq
	 AZQA+U3M9gVYzQtdDFpGJ4eJl5TULHYtGUKCaKs8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A322146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeLKPt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeLKPty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2757E2146D;
        Tue, 11 Dec 2018 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543393;
        bh=Ctr5J1sXdyalYOwTqhmbZVqlbVn0SmHoLOHbaI5a730=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jkOl4qm4NGHQgknNMY6aIewZ9GzXlz6IpGyigdPhcrQokyig4Pa3Yji8keAqB0cz
         zI/HM2rRUjm1ApRSiqWWcHktA5CEzY4sIdOnMtCly0L+BdDyJbf0QNQ+CqAAfz2XHB
         GbgQ3QBQnVsZg4r+oNbmDIPqseI0mcpJH8JybWyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.9 34/51] xhci: Prevent U1/U2 link pm states if exit latency is too long
Date:   Tue, 11 Dec 2018 16:41:42 +0100
Message-Id: <20181211151616.878431889@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 0472bf06c6fd33c1a18aaead4c8f91e5a03d8d7b upstream.

Don't allow USB3 U1 or U2 if the latency to wake up from the U-state
reaches the service interval for a periodic endpoint.

This is according to xhci 1.1 specification section 4.23.5.2 extra note:

"Software shall ensure that a device is prevented from entering a U-state
 where its worst case exit latency approaches the ESIT."

Allowing too long exit latencies for periodic endpoint confuses xHC
internal scheduling, and new devices may fail to enumerate with a
"Not enough bandwidth for new device state" error from the host.

Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4398,6 +4398,14 @@ static u16 xhci_calculate_u1_timeout(str
 {
 	unsigned long long timeout_ns;
 
+	/* Prevent U1 if service interval is shorter than U1 exit latency */
+	if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc)) {
+		if (xhci_service_interval_to_ns(desc) <= udev->u1_params.mel) {
+			dev_dbg(&udev->dev, "Disable U1, ESIT shorter than exit latency\n");
+			return USB3_LPM_DISABLED;
+		}
+	}
+
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		timeout_ns = xhci_calculate_intel_u1_timeout(udev, desc);
 	else
@@ -4454,6 +4462,14 @@ static u16 xhci_calculate_u2_timeout(str
 {
 	unsigned long long timeout_ns;
 
+	/* Prevent U2 if service interval is shorter than U2 exit latency */
+	if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc)) {
+		if (xhci_service_interval_to_ns(desc) <= udev->u2_params.mel) {
+			dev_dbg(&udev->dev, "Disable U2, ESIT shorter than exit latency\n");
+			return USB3_LPM_DISABLED;
+		}
+	}
+
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		timeout_ns = xhci_calculate_intel_u2_timeout(udev, desc);
 	else


