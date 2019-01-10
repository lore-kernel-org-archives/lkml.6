Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E522177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vZDNXzRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAJPEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:04:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51832 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:04:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0AF4bOm108823;
        Thu, 10 Jan 2019 09:04:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547132677;
        bh=YArC5gKWV2hIL05o4TVGQAvf2LVQ1PnZV+WNmMXBlBU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vZDNXzRe9IaEtbl8eRtzWG8gKwnV9X35qDbtbbHd7AcPuDQWauEmcGO02BnZrC+/e
         QKLJ9KXe/v7qssqnMJXqqyTKxkihcoNCnzcx2bWonRjJ82dFxoEGWirTkTklGEOZY6
         AGWznPKKjzlJcpB2jK+RC2US0SkCoVrfl943Oe6g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0AF4a3C051649
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 09:04:37 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 09:04:36 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 09:04:36 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0AF4VPg006681;
        Thu, 10 Jan 2019 09:04:34 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <vigneshr@ti.com>, <robh+dt@kernel.org>, <nsekhar@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/3] usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
Date:   Thu, 10 Jan 2019 17:04:28 +0200
Message-ID: <1547132670-5908-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547132670-5908-1-git-send-email-rogerq@ti.com>
References: <1547132670-5908-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On v3.10a in dual-role mode, if port is in device mode
and gadget driver isn't loaded, the OTG event interrupts don't
come through.

It seems that if the core is configured to be OTG2.0 only,
then we can't leave the DCFG.DEVSPD at Super-speed (default)
if we expect OTG to work properly. It must be set to High-speed.

Fix this issue by configuring DCFG.DEVSPD to the supported
maximum speed at gadget init. Device tree still needs to provide
correct supported maximum speed for this to work.

This issue wasn't present on v2.40a but is seen on v3.10a.
It doesn't cause any side effects on v2.40a.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 07bd31b..a9cf4dd4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3337,6 +3337,8 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	dwc3_gadget_set_speed(&dwc->gadget, dwc->maximum_speed);
+
 	return 0;
 
 err4:
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

