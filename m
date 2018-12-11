Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD011C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A7C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544979;
	bh=VuAb4EsHxZTRqMSXU9MuX8WI9/JVXzR3d6xPcqZNVAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GvXowB7cMZV24cLh1C1Ik6eW5v+2/G6ZE66RCEw33a/rA4iji+8fWU+ySiu18mhTy
	 90kRE5nY8JEacoDlQxh9MbARxHX49un03c10IshhH+eKcBIzcMxO31/8X2/rJDVcbZ
	 hdlxL/+ELi8a844e8DmxHr15Uf+0z/xdFZO/SOrk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeLKQQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbeLKPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B9E20989;
        Tue, 11 Dec 2018 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543285;
        bh=VuAb4EsHxZTRqMSXU9MuX8WI9/JVXzR3d6xPcqZNVAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmxEJGM8M9dadJh7nvbt0m2lY89n4jE92bNj7vUXKAcIcJ2p2D2ybnTzKu0kwETUa
         Kv/6+iUtxlS1h8sFa52NSQOqZMOeQCpKX+KqlbqBcRh+1a4/m0ob2Hjs1IaPxSszbA
         lX5vXwFZm9T9RvkNgyIkxQ7jECnwuyxwV9DZSmds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.4 82/91] xhci: Prevent U1/U2 link pm states if exit latency is too long
Date:   Tue, 11 Dec 2018 16:41:41 +0100
Message-Id: <20181211151613.451348902@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4417,6 +4417,14 @@ static u16 xhci_calculate_u1_timeout(str
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
@@ -4473,6 +4481,14 @@ static u16 xhci_calculate_u2_timeout(str
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


