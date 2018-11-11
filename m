Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E94DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E520866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNJfIbBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084E520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbeKLJ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731883AbeKLIRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE21B2175B;
        Sun, 11 Nov 2018 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975267;
        bh=jnB/hu/SX8v56LNH2lEMbXwYxzsLGyeM1rIQ8X7KxDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNJfIbBzBCsrJ4cOHJFge2hxWkH1ZSaDA402irIGIuoY+Sg3Geouu8uli5oUAjZ0d
         ZpCp1aon2A3QRgLzhcwNX4qTLukn+IZgyp+kzHyTNP46PUrJzZEO9zR8ApA3d+zQFq
         g9o6b9ItA/1CWQgmYdZ1/CBLL6Q4taVSgOVW9DAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artur Petrosyan <arturp@synopsys.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 159/361] usb: dwc2: fix a race with external vbus supply
Date:   Sun, 11 Nov 2018 14:18:26 -0800
Message-Id: <20181111221642.798047180@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 41ee1ea21052583eaf5487dfa0d0c907c9667548 ]

There's a race with root hub resume, when using external vbus supply.
Root hub gets resumed, but runtime pm autosuspend runs as external vbus
supply isn't enabled. So, host never exit from power down properly.
Initialize vbus external supply before, rater that after hub resume.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Tested-by: Artur Petrosyan <arturp@synopsys.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4393,6 +4393,7 @@ static int _dwc2_hcd_start(struct usb_hc
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	struct usb_bus *bus = hcd_to_bus(hcd);
 	unsigned long flags;
+	int ret;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD START\n");
 
@@ -4408,6 +4409,13 @@ static int _dwc2_hcd_start(struct usb_hc
 
 	dwc2_hcd_reinit(hsotg);
 
+	/* enable external vbus supply before resuming root hub */
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+	ret = dwc2_vbus_supply_init(hsotg);
+	if (ret)
+		return ret;
+	spin_lock_irqsave(&hsotg->lock, flags);
+
 	/* Initialize and connect root hub if one is not already attached */
 	if (bus->root_hub) {
 		dev_dbg(hsotg->dev, "DWC OTG HCD Has Root Hub\n");
@@ -4417,7 +4425,7 @@ static int _dwc2_hcd_start(struct usb_hc
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	return dwc2_vbus_supply_init(hsotg);
+	return 0;
 }
 
 /*


