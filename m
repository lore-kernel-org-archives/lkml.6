Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeFEVoq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:44:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34394 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFEVoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:44:44 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org, frowand.list@gmail.com,
        mark.rutland@arm.com, sudeep.holla@arm.com, arm@kernel.org,
        linux-kernel@vger.kernel.org, matt.sealey@arm.com, john.horley@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, mike.leach@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 00/20] coresight: Update device tree bindings
Date: Tue,  5 Jun 2018 22:43:11 +0100
Message-Id: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
	  - The bindings are formal but not so reader friendly and could potentially
	    lead to human errors.
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


This series implements Option (3) listed above and falls back to the old
bindings if the new bindings are not available. This allows the systems
with old bindings work with the new driver. The driver now issues a warning
(once) when it encounters the old bindings.

It also cleans up the platform parsing code to reduce the memory usage by
reusing the platform description.

I am not sure what is the best route to push these DTS changes. Thoughts ?

Changes since RFC [0] :
 - Fixed style issues
 - Fix an existing memory leak coresight_register (Found in code update)
 - Fix missing of_node_put() in the existing driver (Reported-by Mathieu)
 - Update the existing dts in kernel tree.
 - Rename new helper functions for consistency


Suzuki K Poulose (20):
  coresight: Fix memory leak in coresight_register
  coresight: of: Fix refcounting for graph nodes
  coresight: Fix remote endpoint parsing
  coresight: Cleanup platform description data
  coresight: platform: Cleanup coresight connection handling
  coresight: Handle errors in finding input/output ports
  coresight: dts: Document usage of graph bindings
  coresight: dts: Cleanup device tree graph bindings
  coresight: dts: Define new bindings for direction of data flow
  dts: juno: Update coresight bindings for hw port
  dts: hisilicon: Update coresight bindings for hw ports
  dts: spreadtrum: Update coresight bindings for hw ports
  dts: qcom: Update coresight bindings for hw ports
  dts: arm: hisilicon: Update coresight bindings for hardware port
  dts: arm: imx7{d,s}: Update coresight binding for hardware ports
  dts: arm: omap: Update coresight bindings for hardware ports
  dts: arm: qcom: Update coresight bindings for hardware ports
  dts: sama5d2: Update coresight bindings for hardware ports
  dts: ste-dbx5x0: Update coresight bindings for hardware port
  dts: tc2: Update coresight bindings for hardware ports

 .../devicetree/bindings/arm/coresight.txt          |  76 +++++--
 arch/arm/boot/dts/hip04.dtsi                       | 195 +++++++++++++-----
 arch/arm/boot/dts/imx7d.dtsi                       |   5 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  41 ++--
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   5 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   5 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  37 +++-
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  60 ++++--
 arch/arm/boot/dts/sama5d2.dtsi                     |   5 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |  31 ++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  48 +++--
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  82 +++++---
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |  26 ++-
 arch/arm64/boot/dts/arm/juno.dts                   |   5 +-
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi |  89 ++++++---
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  55 ++++--
 arch/arm64/boot/dts/sprd/sc9836.dtsi               |  40 ++--
 arch/arm64/boot/dts/sprd/sc9860.dtsi               | 101 +++++++---
 drivers/hwtracing/coresight/coresight.c            |  30 +--
 drivers/hwtracing/coresight/of_coresight.c         | 219 +++++++++++++--------
 include/linux/coresight.h                          |  11 +-
 21 files changed, 818 insertions(+), 348 deletions(-)

-- 
2.7.4
