Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A8820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeIFXyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:54:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:59190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbeIFXye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:54:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 12:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="68939787"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2018 12:17:38 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com,
        richard.gong@intel.com
Subject: [PATCHv9 1/8] dt-bindings, firmware: add Intel Stratix10 service layer binding
Date:   Thu,  6 Sep 2018 14:25:03 -0500
Message-Id: <1536261910-16426-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536261910-16426-1-git-send-email-richard.gong@linux.intel.com>
References: <1536261910-16426-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add a device tree binding for the Intel Stratix10 service layer driver

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: change to put service layer driver node under the firmware node
    change compatible to "intel, stratix10-svc"
v3: no change
v4: add Rob's Reviewed-by
v5: no change
v6: add Moritz's Acked-by
v7: no change
v8: no change
v9: no chnage
---
 .../bindings/firmware/intel,stratix10-svc.txt      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
new file mode 100644
index 0000000..1fa6606
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
@@ -0,0 +1,57 @@
+Intel Service Layer Driver for Stratix10 SoC
+============================================
+Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
+processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
+configured from HPS, there needs to be a way for HPS to notify SDM the
+location and size of the configuration data. Then SDM will get the
+configuration data from that location and perform the FPGA configuration.
+
+To meet the whole system security needs and support virtual machine requesting
+communication with SDM, only the secure world of software (EL3, Exception
+Layer 3) can interface with SDM. All software entities running on other
+exception layers must channel through the EL3 software whenever it needs
+service from SDM.
+
+Intel Stratix10 service layer driver, running at privileged exception level
+(EL1, Exception Layer 1), interfaces with the service providers and provides
+the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
+driver also manages secure monitor call (SMC) to communicate with secure monitor
+code running in EL3.
+
+Required properties:
+-------------------
+The svc node has the following mandatory properties, must be located under
+the firmware node.
+
+- compatible: "intel,stratix10-svc"
+- method: smc or hvc
+        smc - Secure Monitor Call
+        hvc - Hypervisor Call
+- memory-region:
+	phandle to the reserved memory node. See
+	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+	for details
+
+Example:
+-------
+
+	reserved-memory {
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+
+                service_reserved: svcbuffer@0 {
+                        compatible = "shared-dma-pool";
+                        reg = <0x0 0x0 0x0 0x1000000>;
+                        alignment = <0x1000>;
+                        no-map;
+                };
+        };
+
+	firmware {
+		svc {
+			compatible = "intel,stratix10-svc";
+			method = "smc";
+			memory-region = <&service_reserved>;
+		};
+	};
-- 
2.7.4

