Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68745C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DE820671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DE820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbeGSLig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:38:36 -0400
Received: from foss.arm.com ([217.140.101.70]:47452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbeGSLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C0811682;
        Thu, 19 Jul 2018 03:56:00 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A99983F246;
        Thu, 19 Jul 2018 03:55:57 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 08/10] coresight: dts: Document usage of graph bindings
Date:   Thu, 19 Jul 2018 11:55:12 +0100
Message-Id: <1531997715-6767-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we update the bindings, document the current graph bindings
and usage of additional properties.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/coresight.txt          | 30 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 5d1ad09..8e21512 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -54,9 +54,7 @@ its hardware characteristcs.
 	  clocks the core of that coresight component. The latter clock
 	  is optional.
 
-	* port or ports: The representation of the component's port
-	  layout using the generic DT graph presentation found in
-	  "bindings/graph.txt".
+	* port or ports: see "Graph bindings for Coresight" below.
 
 * Additional required properties for System Trace Macrocells (STM):
 	* reg: along with the physical base address and length of the register
@@ -73,7 +71,7 @@ its hardware characteristcs.
 	  AMBA markee):
 		- "arm,coresight-replicator"
 
-	* port or ports: same as above.
+	* port or ports: see "Graph bindings for Coresight" below.
 
 * Optional properties for ETM/PTMs:
 
@@ -96,6 +94,30 @@ its hardware characteristcs.
 	* interrupts : Exactly one SPI may be listed for reporting the address
 	  error
 
+Graph bindings for Coresight
+-------------------------------
+
+Coresight components are interconnected to create a data path for the flow of
+trace data generated from the "sources" to their collection points "sink".
+Each coresight component must describe the "input" and "output" connections.
+The connections must be described via generic DT graph bindings as described
+by the "bindings/graph.txt", where each "port" along with an "endpoint"
+component represents a hardware port and the connection.
+
+Since it is possible to have multiple connections for any coresight component
+with a specific direction of data flow, each connection must define the
+following properties to uniquely identify the connection details.
+
+ * Direction of the data flow w.r.t the component :
+   Each input port must have the following property defined at the "endpoint"
+   for the port.
+	"slave-mode"
+
+ * Hardware Port number at the component:
+     -  The hardware port number is assumed to be the address of the "port"
+         component.
+
+
 Example:
 
 1. Sinks
-- 
2.7.4

