Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B86C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AEB2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AEB2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbeG0LhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:37:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbeG0LhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:37:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEC415AD;
        Fri, 27 Jul 2018 03:15:56 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 668353F575;
        Fri, 27 Jul 2018 03:15:54 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        coresight@lists.linaro.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com,
        john.horley@arm.com, al.grant@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 0/9] coresight: Update device tree bindings
Date:   Fri, 27 Jul 2018 11:15:28 +0100
Message-Id: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coresight uses DT graph bindings to describe the connections of the
components. However we have some undocumented usage of the bindings
to describe some of the properties of the connections.

The coresight driver needs to know the hardware ports invovled
in the connection and the direction of data flow to effectively
manage the trace sessions. So far we have relied on the "port"
address (as described by the generic graph bindings) to represent
the hardware port of the component for a connection.

The hardware uses separate numbering scheme for input and output
ports, which implies, we could have two different (input and output)
ports with the same port number. This could create problems in the
graph bindings where the label of the port wouldn't match the address.

e.g, with the existing bindings we get :

	port@0{				// Output port 0
		reg = <0>;
		...
	};

	port@1{
		reg = <0>;		// Input port 0
		endpoint {
			slave-mode;
			...
		};
	};

With the new enforcement in the DT rules, mismatches in label and address
are not allowed (as see in the case for port@1). So, we need a new mechanism
to describe the hardware port number reliably.

Also, we relied on an undocumented "slave-mode" property (see the above
example) to indicate if the port is an input port. Let us formalise and
switch to a new property to describe the direction of data flow.

There were three options considered for the hardware port number scheme:

 1) Use natural ordering in the DT to infer the hardware port number.
  i.e, Mandate that the all ports are listed in the DT and in the ascending
  order for each class (input and output respectively).
   Pros :
      - We don't need new properties and if the existing DTS list them in
        order (which most of them do), they work out of the box.
   Cons :
      - We must list all the ports even if the system cannot/shouldn't use
        it.
      - It is prone to human errors (if the order is not kept).

 2) Use an explicit property to list both the direction and the hw port
    number and direction. Define "coresight,hwid" as 2 member array of u32,
    where the members are port number and the direction respectively.
	e.g

	port@0{
		reg = <0>;
		endpoint {
			coresight,hwid = <0 1>;	// Port # 0, Output
		}
	};

	port@1{
		reg = <1>;
		endpoint {
			coresight,hwid = <0 0>;	// Port # 0, Input
		};
	};

	Pros:
	  - The bindings are formal but not so reader friendly and could
	    potentially lead to human errors.
	Cons:
	  - Backward compatiblity is lost.
 3) Use explicit properties (implemented in the series) for the hardware
    port id and direction. We define a new property "coresight,hwid" for
    each endpoint in coresight devices to specify the hardware port number
    explicitly. Also use a separate property "direction" to specify the
    direction of the data flow.

	e.g,

	port@0{
		reg = <0>;
		endpoint {
			direction = <1>;	// Output
			coresight,hwid = <0>;	// Port # 0
		}
	};

	port@1{
		reg = <1>;
		endpoint {
			direction = <0>;	// Input
			coresight,hwid = <0>;	// Port # 0
		};
	};

    Pros:
       - The bindings are formal and reader friendly, and less prone to errors.
    Cons:
       - Backward compatibility is lost.

After a round of discussions [1], the following option (4) is adopted :

 4) Group ports based on the directions under a dedicated node. This has been
    checked with the upstream DTC tool to resolve the "address mismatch" issue.

	e.g,

	out-ports {				// Output ports for this component

		port@0 {			// Outport 0
		  reg = 0;
		  endpoint { ... };
		};

		port@1 {			// Outport 1
		  reg = 1;
		  endpoint { ... };
		};

	};

	in-ports {				// Input ports for this component
		port@0 {			// Inport 0
		  reg = 0;
		  endpoint { ... };
		};

		port@1 {			// Inport 1
		  reg = 1;
		  endpoint { ... };
		};

	};


This series implements Option (4) listed above and falls back to the old
bindings if the new bindings are not available. This allows the systems
with old bindings work with the new driver. The driver now issues a warning
(once) when it encounters the old bindings. The series contains DT update
for Juno platform. The remaining in-kernel sources could be updated once
we are fine with the proposal.

It also cleans up the platform parsing code to reduce the memory usage by
reusing the platform description.

Applies on coresight/next

Changes since V2:
  - Clean of_coresight_parse_endpoint() to return 1 to indicate a connection
    record was updated.
  - Drop documentation for old bindings

Changes since V1:
  - Implement the proposal by Rob.
  - Drop the DTS updates for all platforms except Juno
  - Drop the incorrect fix in coresight_register. Instead document the code
    to prevent people trying to un-fix it again.
  - Add a patch to drop remote device references in DT graph parsing
  - Split of_node refcount fixing patch, fix a typo in the comment.
  - Add Reviewed-by tags from Mathieu.
  - Drop patches picked up for 4.18-rc series

Changes since RFC:
 - Fixed style issues
 - Fix an existing memory leak coresight_register (Found in code update)
 - Fix missing of_node_put() in the existing driver (Reported-by Mathieu)
 - Update the existing dts in kernel tree.

Suzuki K Poulose (9):
  coresight: Document error handling in coresight_register
  coresight: platform: Refactor graph endpoint parsing
  coresight: platform: Fix refcounting for graph nodes
  coresight: platform: Fix leaking device reference
  coresight: Fix remote endpoint parsing
  coresight: Add helper to check if the endpoint is input
  coresight: platform: Cleanup coresight connection handling
  coresight: Cleanup coresight DT bindings
  dts: juno: Update coresight bindings

 .../devicetree/bindings/arm/coresight.txt          |  95 +++++---
 arch/arm64/boot/dts/arm/juno-base.dtsi             | 161 ++++++------
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  52 ++--
 arch/arm64/boot/dts/arm/juno.dts                   |  13 +-
 drivers/hwtracing/coresight/coresight.c            |  35 +--
 drivers/hwtracing/coresight/of_coresight.c         | 269 ++++++++++++++-------
 include/linux/coresight.h                          |   9 +-
 7 files changed, 359 insertions(+), 275 deletions(-)

-- 
2.7.4

