Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D812ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299442089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkx9NYFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299442089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbeKIHrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbeKIHre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:47:34 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF06B2089F;
        Thu,  8 Nov 2018 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715002;
        bh=MP5RU+d3o657icRpQfHtmx2bGT30DwZU6IBG9yZeJ4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkx9NYFkmGhZwBKwa1KOTW1nYKK7DOTSPqQqQmgiSCYAc3dUWdzJC06+BQhQRwZhj
         afkDxN8lha6IV61KnIDGzPVEwr1Q25d4F/owcP9wKFqRlN5I0uSeThyiFOKEJEQTjd
         NNtFnnbTDqIYLdb4eDrgBFdTZiXSCy5CZ/YwOB4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.18 21/34] usb: xhci: pci: Enable Intel USB role mux on Apollo Lake platforms
Date:   Thu,  8 Nov 2018 13:52:50 -0800
Message-Id: <20181108215140.236926535@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit c02588a352defaf985fc1816eb6232663159e1b8 upstream.

Intel Apollo Lake has the same internal USB role mux as
Intel Cherry Trail.

Cc: <stable@vger.kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -179,10 +179,12 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_PME_STUCK_QUIRK;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
-		 pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI) {
+	    pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI)
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI))
 		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
-	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||


