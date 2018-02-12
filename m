Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x225ngrNm2snu5CzLN5f/2fP/t2q8XuOJQ7W8I9GAu7wrkmcFpvmD7jF3JIDyTu5UlNNKr1rf
ARC-Seal: i=1; a=rsa-sha256; t=1518461145; cv=none;
        d=google.com; s=arc-20160816;
        b=Jd2QHaaEzAgrrIKted5VqLUb31hyTag4miz++ZCsQNmX5snsroldbJ/hBlGixQEgki
         kJDk7/DOS8Rrewa1JZv/uvIGqUh6kmS/tvg/TGAGSskSNQ0yPFV5pG61GRXnhgqec/p8
         NPLWXOuZ+NU9bEJ/zsGOlVwNT++TvYV5D0DNnkXNb1EPl974+vL+9/FCEtM7+XxNbNah
         Oe+jynvU871b/K4VswxML/fRW+3Z0EV7fzWA+CVaFirqwiRiLOaNppP1RCISTzl7FFNo
         huEMKV1j8THoWB6lf7+dclH/nre0ZqsQFAim5avLK+u0m53SSePaHoMe1wFU7ALGJ2pY
         UtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=iZDiToIH9Y2S2yJlposRe/FLeOXW3XNTrNYPD4PRUOM=;
        b=mrYWGr4tOsmMO85mIXKRlqRXzW4iTfYcudG0xa6BfLOGIzLyDu3+zFB/EZuuOPHxKR
         +a5//HH7//Hp04o1mLWKWiC1pFkQupHFuQqOYRr+KFfHLz8rfLWBwvgns0hX1BzrU1bC
         1O5vtsvXjfLmIk9hAefaV9O8ZAILnkzxmc5ndQqZZfVtSTxZG0ZXjqX5EuhCLcvTi3PN
         Nd7Ya4n+cWu+B0E2uDL5T3uAijjw8ut4yza+3cH4jdRscYuRSOVmHjqi41obQ1HYHHw2
         0wQSxG+Q7waMCssrjO6eRDWp6e0hyX3tVjghIFL418Ys2c9Uik0aeQ9MUdQ1DZNCH5bW
         IyOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 02/20] dt-bindings: arm: add support for ARM System Control and Management Interface(SCMI) protocol
Date: Mon, 12 Feb 2018 18:45:06 +0000
Message-Id: <1518461124-17371-3-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221914564056706?=
X-GMAIL-MSGID: =?utf-8?q?1592221914564056706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds devicetree binding for System Control and Management
Interface (SCMI) Message Protocol used between the Application Cores(AP)
and the System Control Processor(SCP). The MHU peripheral provides a
mechanism for inter-processor communication between SCP's M3 processor
and AP.

SCP offers control and management of the core/cluster power states,
various power domain DVFS including the core/cluster, certain system
clocks configuration, thermal sensors and many others.

SCMI protocol is developed as better replacement to the existing SCPI
which is not flexible and easily extensible.

Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 179 +++++++++++++++++++++
 MAINTAINERS                                        |   4 +-
 2 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
new file mode 100644
index 000000000000..5f3719ab7075
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -0,0 +1,179 @@
+System Control and Management Interface (SCMI) Message Protocol
+----------------------------------------------------------
+
+The SCMI is intended to allow agents such as OSPM to manage various functions
+that are provided by the hardware platform it is running on, including power
+and performance functions.
+
+This binding is intended to define the interface the firmware implementing
+the SCMI as described in ARM document number ARM DUI 0922B ("ARM System Control
+and Management Interface Platform Design Document")[0] provide for OSPM in
+the device tree.
+
+Required properties:
+
+The scmi node with the following properties shall be under the /firmware/ node.
+
+- compatible : shall be "arm,scmi"
+- mboxes: List of phandle and mailbox channel specifiers. It should contain
+	  exactly one or two mailboxes, one for transmitting messages("tx")
+	  and another optional for receiving the notifications("rx") if
+	  supported.
+- shmem : List of phandle pointing to the shared memory(SHM) area as per
+	  generic mailbox client binding.
+- #address-cells : should be '1' if the device has sub-nodes, maps to
+	  protocol identifier for a given sub-node.
+- #size-cells : should be '0' as 'reg' property doesn't have any size
+	  associated with it.
+
+Optional properties:
+
+- mbox-names: shall be "tx" or "rx" depending on mboxes entries.
+
+See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
+about the generic mailbox controller and client driver bindings.
+
+The mailbox is the only permitted method of calling the SCMI firmware.
+Mailbox doorbell is used as a mechanism to alert the presence of a
+messages and/or notification.
+
+Each protocol supported shall have a sub-node with corresponding compatible
+as described in the following sections. If the platform supports dedicated
+communication channel for a particular protocol, the 3 properties namely:
+mboxes, mbox-names and shmem shall be present in the sub-node corresponding
+to that protocol.
+
+Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
+------------------------------------------------------------
+
+This binding uses the common clock binding[1].
+
+Required properties:
+- #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.
+
+Power domain bindings for the power domains based on SCMI Message Protocol
+------------------------------------------------------------
+
+This binding for the SCMI power domain providers uses the generic power
+domain binding[2].
+
+Required properties:
+ - #power-domain-cells : Should be 1. Contains the device or the power
+			 domain ID value used by SCMI commands.
+
+Sensor bindings for the sensors based on SCMI Message Protocol
+--------------------------------------------------------------
+SCMI provides an API to access the various sensors on the SoC.
+
+Required properties:
+- #thermal-sensor-cells: should be set to 1. This property follows the
+			 thermal device tree bindings[3].
+
+			 Valid cell values are raw identifiers (Sensor ID)
+			 as used by the firmware. Refer to  platform details
+			 for your implementation for the IDs to use.
+
+SRAM and Shared Memory for SCMI
+-------------------------------
+
+A small area of SRAM is reserved for SCMI communication between application
+processors and SCP.
+
+The properties should follow the generic mmio-sram description found in [4]
+
+Each sub-node represents the reserved area for SCMI.
+
+Required sub-node properties:
+- reg : The base offset and size of the reserved area with the SRAM
+- compatible : should be "arm,scmi-shmem" for Non-secure SRAM based
+	       shared memory
+
+[0] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/power/power_domain.txt
+[3] Documentation/devicetree/bindings/thermal/thermal.txt
+[4] Documentation/devicetree/bindings/sram/sram.txt
+
+Example:
+
+sram@50000000 {
+	compatible = "mmio-sram";
+	reg = <0x0 0x50000000 0x0 0x10000>;
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x0 0x50000000 0x10000>;
+
+	cpu_scp_lpri: scp-shmem@0 {
+		compatible = "arm,scmi-shmem";
+		reg = <0x0 0x200>;
+	};
+
+	cpu_scp_hpri: scp-shmem@200 {
+		compatible = "arm,scmi-shmem";
+		reg = <0x200 0x200>;
+	};
+};
+
+mailbox@40000000 {
+	....
+	#mbox-cells = <1>;
+	reg = <0x0 0x40000000 0x0 0x10000>;
+};
+
+firmware {
+
+	...
+
+	scmi {
+		compatible = "arm,scmi";
+		mboxes = <&mailbox 0 &mailbox 1>;
+		mbox-names = "tx", "rx";
+		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		scmi_devpd: protocol@11 {
+			reg = <0x11>;
+			#power-domain-cells = <1>;
+		};
+
+		scmi_dvfs: protocol@13 {
+			reg = <0x13>;
+			#clock-cells = <1>;
+		};
+
+		scmi_clk: protocol@14 {
+			reg = <0x14>;
+			#clock-cells = <1>;
+		};
+
+		scmi_sensors0: protocol@15 {
+			reg = <0x15>;
+			#thermal-sensor-cells = <1>;
+		};
+	};
+};
+
+cpu@0 {
+	...
+	reg = <0 0>;
+	clocks = <&scmi_dvfs 0>;
+};
+
+hdlcd@7ff60000 {
+	...
+	reg = <0 0x7ff60000 0 0x1000>;
+	clocks = <&scmi_clk 4>;
+	power-domains = <&scmi_devpd 1>;
+};
+
+thermal-zones {
+	soc_thermal {
+		polling-delay-passive = <100>;
+		polling-delay = <1000>;
+					/* sensor ID */
+		thermal-sensors = <&scmi_sensors0 3>;
+		...
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..5c8c55ba22a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13379,11 +13379,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
 S:	Supported
 F:	drivers/mfd/syscon.c
 
-SYSTEM CONTROL & POWER INTERFACE (SCPI) Message Protocol drivers
+SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message Protocol drivers
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/arm/arm,scpi.txt
+F:	Documentation/devicetree/bindings/arm/arm,sc[mp]i.txt
 F:	drivers/clk/clk-scpi.c
 F:	drivers/cpufreq/scpi-cpufreq.c
 F:	drivers/firmware/arm_scpi.c
-- 
2.7.4
