Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE91C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB672087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543077;
	bh=b7pxRANfTuSHHeZs2TXagvqzDHCv6dozbI6LKrVMaCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G2wy5VfCOtzpMrxsWSNfl/voHxlWFyYcHWNZ9/+oGBMYPDoXbHo4+PEv8kTYGjNR5
	 zIzj8/q3BhTVrVQmeJlz3dmXB0Mdmn1/9pfz5cZvkJQVsGGTwUucsSf+dyQwwuN1OT
	 QCu/+ZrzCTVOFGE4OAhLehKiz3GDx7wRZkc4tpCw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB672087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbeLKPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbeLKPoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56AE52082F;
        Tue, 11 Dec 2018 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543071;
        bh=b7pxRANfTuSHHeZs2TXagvqzDHCv6dozbI6LKrVMaCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Me9ngs6gT7fepWQ8Kn69wMHCFgkMfdlrjcQq4V55WBmpSq2cC20XKFXiCVMj+sAof
         81LEhs2jLLaW0niEVCJUbTwQ6o0iJl+jIPUbe1VmzCl50ww1oO6ToBYmFdfNgLyAwd
         8PzUKuc7tLNdW7ZWNt6cL/k/jLbAcjQnfQ/yYcuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3.18 49/54] xhci: Prevent U1/U2 link pm states if exit latency is too long
Date:   Tue, 11 Dec 2018 16:41:37 +0100
Message-Id: <20181211151548.818270301@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4377,6 +4377,14 @@ static u16 xhci_calculate_u1_timeout(str
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
@@ -4433,6 +4441,14 @@ static u16 xhci_calculate_u2_timeout(str
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


