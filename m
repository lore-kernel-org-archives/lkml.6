Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A87C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CE820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BI2qful5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CE820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030690AbeFSTot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:44:49 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:39568 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967180AbeFSToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:44:44 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJiNBF013531;
        Tue, 19 Jun 2018 14:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437463;
        bh=vC/hVCEnsnqgO16+5+0pBTbwFdr+b44P2IzODUUMfes=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BI2qful5xuX5zCUeH7ySkqDEaO8IgVI771Ll2B2JAlweEl8Ji7tFJYnFZnnEwp1el
         CRrkLfDGLCSj9jrRpgvfzH1BxAwJ+jofIgwEKre4Z3BcUGtvhc4Fwbz8+ZGM/0XSId
         Yxz1ta5CtSd1AEu9xeCuXMmOqieY/3eYH9pG4QjA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiMFG010275;
        Tue, 19 Jun 2018 14:44:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:44:22 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:44:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiMj5000623;
        Tue, 19 Jun 2018 14:44:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] Documentation: dt: keystone: ti-sci: Add optional host-id parameter
Date:   Tue, 19 Jun 2018 14:44:20 -0500
Message-ID: <20180619194421.3432-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194421.3432-1-nm@ti.com>
References: <20180619194421.3432-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instrument's System Control Interface (TISCI) permits
the ability for OSs running in virtual machines to be able to
independently communicate with the firmware without the need going
through an hypervisor.

The "host-id" in effect is the hardware representation of the
host (example: VMs locked to a core) as identified to the System
Controller. Hypervisors can either fill in appropriate host-ids in dt
used for each VM instance OR may use prebuilt blobs where the host-ids
are pre-populated, as appropriate for the OS running in the VMs.

This is introduced as an optional parameter to maintain consistency
with legacy device tree blobs.

We call this with a vendor prefix to prevent any possible confusion
with SCSI ID (m68k) kernel option.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since RFC:
* Commit message update to elaborate usage in VM

RFC: https://patchwork.kernel.org/patch/10447753/

 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index 31f5f9a104cc..b56a02c10ae6 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -45,11 +45,15 @@ Optional Properties:
 	debug_messages - Map the Debug message region
 - reg:  register space corresponding to the debug_messages
 - ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
+- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
+	for identification of host processing entities such as virtual
+	machines
 
 Example (K2G):
 -------------
 	pmmc: pmmc {
 		compatible = "ti,k2g-sci";
+		ti,host-id = <2>;
 		mbox-names = "rx", "tx";
 		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
 			<&msgmgr &msgmgr_proxy_pmmc_tx>;
-- 
2.15.1

