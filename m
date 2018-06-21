Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA63C21C67
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA63C21C67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeFUTj4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:39:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:50567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeFUTjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:39:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 12:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="59887863"
Received: from maru.jf.intel.com ([10.54.51.80])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2018 12:39:54 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH linux-next v6 01/13] dt-bindings: Add a document of PECI subsystem
Date:   Thu, 21 Jun 2018 12:39:47 -0700
Message-Id: <20180621193947.20645-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a document of generic PECI bus, adapter and client
driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/peci/peci.txt         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci.txt

diff --git a/Documentation/devicetree/bindings/peci/peci.txt b/Documentation/devicetree/bindings/peci/peci.txt
new file mode 100644
index 000000000000..5583aa80b78a
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci.txt
@@ -0,0 +1,60 @@
+Generic device tree configuration for PECI buses
+================================================
+
+Required properties:
+- compatible     : Should be "simple-bus".
+- #address-cells : Should be present if the device has sub-nodes.
+- #size-cells    : Should be present if the device has sub-nodes.
+- ranges         : Should contain PECI controller registers ranges.
+
+Example:
+	peci: peci@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10000000 0x1000>;
+	};
+
+Generic device tree configuration for PECI adapters
+===================================================
+
+Required properties:
+- #address-cells : Should be <1>. Read more about client addresses below.
+- #size-cells    : Should be <0>. Read more about client addresses below.
+
+The cells properties above define that an address of CPU clients of a PECI bus
+are described by a single value.
+
+Example:
+	peci0: peci-bus@0 {
+		compatible = "vendor,soc-peci";
+		reg = <0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+Generic device tree configuration for PECI clients
+==================================================
+
+Required properties:
+- compatible : Should contain name of PECI client.
+- reg        : Should contain address of a client CPU. Address range of CPU
+	       clients starts from 0x30 based on PECI specification.
+
+Example:
+	peci-bus@0 {
+		compatible = "vendor,soc-peci";
+		reg = <0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		peci-client@30 {
+			compatible = "vendor,peci-client";
+			reg = <0x30>;
+		};
+
+		peci-client@31 {
+			compatible = "vendor,peci-client";
+			reg = <0x31>;
+		};
+	};
-- 
2.17.1

