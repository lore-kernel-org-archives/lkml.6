Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5571C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714BA2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714BA2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933699AbeGIUPb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:15:31 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:13038 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeGIUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:33 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 16:14:29 EDT
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="21909314"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:22 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8949"; a="231212349"
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 09 Jul 2018 13:08:21 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id AAC75150B; Mon,  9 Jul 2018 13:08:21 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 1/7] mhi_bus: core: initial checkin for modem host interface bus driver
Date:   Mon,  9 Jul 2018 13:08:08 -0700
Message-Id: <1531166894-30984-2-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial skeleton driver for mhi bus stack. MHI Host
Interface is a communication protocol to be used by the host to
control and communcate with modem over a high speed peripheral bus.
This module will allow host to communicate with external devices that
support MHI protocol.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 Documentation/00-INDEX                        |   2 +
 Documentation/devicetree/bindings/bus/mhi.txt | 258 ++++++++++++
 Documentation/mhi.txt                         | 235 +++++++++++
 drivers/bus/Kconfig                           |   8 +
 drivers/bus/Makefile                          |   1 +
 drivers/bus/mhi/Makefile                      |   6 +
 drivers/bus/mhi/core/Makefile                 |   1 +
 drivers/bus/mhi/core/mhi_init.c               | 538 ++++++++++++++++++++++++++
 drivers/bus/mhi/core/mhi_internal.h           | 238 ++++++++++++
 drivers/bus/mhi/core/mhi_main.c               | 122 ++++++
 include/linux/mhi.h                           | 341 ++++++++++++++++
 include/linux/mod_devicetable.h               |  12 +
 12 files changed, 1762 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/mhi.txt
 create mode 100644 Documentation/mhi.txt
 create mode 100644 drivers/bus/mhi/Makefile
 create mode 100644 drivers/bus/mhi/core/Makefile
 create mode 100644 drivers/bus/mhi/core/mhi_init.c
 create mode 100644 drivers/bus/mhi/core/mhi_internal.h
 create mode 100644 drivers/bus/mhi/core/mhi_main.c
 create mode 100644 include/linux/mhi.h

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 708dc4c..44e2c6b 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -270,6 +270,8 @@ memory-hotplug.txt
 	- Hotpluggable memory support, how to use and current status.
 men-chameleon-bus.txt
 	- info on MEN chameleon bus.
+mhi.txt
+	- Modem Host Interface
 mic/
 	- Intel Many Integrated Core (MIC) architecture device driver.
 mips/
diff --git a/Documentation/devicetree/bindings/bus/mhi.txt b/Documentation/devicetree/bindings/bus/mhi.txt
new file mode 100644
index 0000000..19deb84
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/mhi.txt
@@ -0,0 +1,258 @@
+MHI Host Interface
+
+MHI used by the host to control and communicate with modem over
+high speed peripheral bus.
+
+==============
+Node Structure
+==============
+
+Main node properties:
+
+- mhi,max-channels
+  Usage: required
+  Value type: <u32>
+  Definition: Maximum number of channels supported by this controller
+
+- mhi,timeout
+  Usage: optional
+  Value type: <u32>
+  Definition: Maximum timeout in ms wait for state and cmd completion
+
+- mhi,use-bb
+  Usage: optional
+  Value type: <bool>
+  Definition: Set true, if PCIe controller does not have full access to host
+	DDR, and we're using a dedicated memory pool like cma, or
+	carveout pool. Pool must support atomic allocation.
+
+- mhi,buffer-len
+  Usage: optional
+  Value type: <bool>
+  Definition: MHI automatically pre-allocate buffers for some channel.
+	Set the length of buffer size to allocate. If not default
+	size MHI_MAX_MTU will be used.
+
+============================
+mhi channel node properties:
+============================
+
+- reg
+  Usage: required
+  Value type: <u32>
+  Definition: physical channel number
+
+- label
+  Usage: required
+  Value type: <string>
+  Definition: given name for the channel
+
+- mhi,num-elements
+  Usage: optional
+  Value type: <u32>
+  Definition: Number of elements transfer ring support
+
+- mhi,event-ring
+  Usage: required
+  Value type: <u32>
+  Definition: Event ring index associated with this channel
+
+- mhi,chan-dir
+  Usage: required
+  Value type: <u32>
+  Definition: Channel direction as defined by enum dma_data_direction
+	0 = Bidirectional data transfer
+	1 = UL data transfer
+	2 = DL data transfer
+	3 = No direction, not a regular data transfer channel
+
+- mhi,ee
+  Usage: required
+  Value type: <u32>
+  Definition: Channel execution enviornment as defined by enum MHI_EE
+	1 = Bootloader stage
+	2 = AMSS mode
+
+- mhi,pollcfg
+  Usage: optional
+  Value type: <u32>
+  Definition: MHI poll configuration, valid only when burst mode is enabled
+	0 = Use default (device specific) polling configuration
+	For UL channels, value specifies the timer to poll MHI context in
+	milliseconds.
+	For DL channels, the threshold to poll the MHI context in multiple of
+	eight ring element.
+
+- mhi,data-type
+  Usage: required
+  Value type: <u32>
+  Definition: Data transfer type accepted as defined by enum MHI_XFER_TYPE
+	0 = accept cpu address for buffer
+	1 = accept skb
+	2 = accept scatterlist
+	3 = offload channel, does not accept any transfer type
+
+- mhi,doorbell-mode
+  Usage: required
+  Value type: <u32>
+  Definition: Channel doorbell mode configuration as defined by enum
+	MHI_BRSTMODE
+	2 = burst mode disabled
+	3 = burst mode enabled
+
+- mhi,lpm-notify
+  Usage: optional
+  Value type: <bool>
+  Definition: This channel master require low power mode enter and exit
+  notifications from mhi bus master.
+
+- mhi,offload-chan
+  Usage: optional
+  Value type: <bool>
+  Definition: Client managed channel, MHI host only involved in setting up
+	the data path, not involved in active data path.
+
+- mhi,db-mode-switch
+  Usage: optional
+  Value type: <bool>
+  Definition: Must switch to doorbell mode whenever MHI M0 state transition
+	happens.
+
+- mhi,auto-queue
+  Usage: optional
+  Value type: <bool>
+  Definition: MHI bus driver will pre-allocate buffers for this channel and
+	queue to hardware. If set, client not allowed to queue buffers. Valid
+	only for downlink direction.
+
+- mhi,auto-start
+  Usage: optional
+  Value type: <bool>
+  Definition: MHI host driver to automatically start channels once mhi device
+	driver probe is complete. This should be only set true if initial
+	handshake iniaitead by external modem.
+
+==========================
+mhi event node properties:
+==========================
+
+- mhi,num-elements
+  Usage: required
+  Value type: <u32>
+  Definition: Number of elements event ring support
+
+- mhi,intmod
+  Usage: required
+  Value type: <u32>
+  Definition: interrupt moderation time in ms
+
+- mhi,msi
+  Usage: required
+  Value type: <u32>
+  Definition: MSI associated with this event ring
+
+- mhi,chan
+  Usage: optional
+  Value type: <u32>
+  Definition: Dedicated channel number, if it's a dedicated event ring
+
+- mhi,priority
+  Usage: required
+  Value type: <u32>
+  Definition: Event ring priority, set to 1 for now
+
+- mhi,brstmode
+  Usage: required
+  Value type: <u32>
+  Definition: Event doorbell mode configuration as defined by
+	enum MHI_BRSTMODE
+		2 = burst mode disabled
+		3 = burst mode enabled
+
+- mhi,data-type
+  Usage: optional
+  Value type: <u32>
+  Definition: Type of data this event ring will process as defined
+	by enum mhi_er_data_type
+		0 = process data packets (default)
+		1 = process mhi control packets
+
+- mhi,hw-ev
+  Usage: optional
+  Value type: <bool>
+  Definition: Event ring associated with hardware channels
+
+- mhi,client-manage
+  Usage: optional
+  Value type: <bool>
+  Definition: Client manages the event ring (use by napi_poll)
+
+- mhi,offload
+  Usage: optional
+  Value type: <bool>
+  Definition: Event ring associated with offload channel
+
+
+Children node properties:
+
+MHI drivers that require DT can add driver specific information as a child node.
+
+- mhi,chan
+  Usage: Required
+  Value type: <string>
+  Definition: Channel name
+
+========
+Example:
+========
+mhi_controller {
+	mhi,max-channels = <105>;
+
+	mhi_chan@0 {
+		reg = <0>;
+		label = "LOOPBACK";
+		mhi,num-elements = <64>;
+		mhi,event-ring = <2>;
+		mhi,chan-dir = <1>;
+		mhi,data-type = <0>;
+		mhi,doorbell-mode = <2>;
+		mhi,ee = <2>;
+	};
+
+	mhi_chan@1 {
+		reg = <1>;
+		label = "LOOPBACK";
+		mhi,num-elements = <64>;
+		mhi,event-ring = <2>;
+		mhi,chan-dir = <2>;
+		mhi,data-type = <0>;
+		mhi,doorbell-mode = <2>;
+		mhi,ee = <2>;
+	};
+
+	mhi_event@0 {
+		mhi,num-elements = <32>;
+		mhi,intmod = <1>;
+		mhi,msi = <1>;
+		mhi,chan = <0>;
+		mhi,priority = <1>;
+		mhi,bstmode = <2>;
+		mhi,data-type = <1>;
+	};
+
+	mhi_event@1 {
+		mhi,num-elements = <256>;
+		mhi,intmod = <1>;
+		mhi,msi = <2>;
+		mhi,chan = <0>;
+		mhi,priority = <1>;
+		mhi,bstmode = <2>;
+	};
+
+	mhi,timeout = <500>;
+
+	children_node {
+		mhi,chan = "LOOPBACK"
+		<driver specific properties>
+	};
+};
diff --git a/Documentation/mhi.txt b/Documentation/mhi.txt
new file mode 100644
index 0000000..1c501f1
--- /dev/null
+++ b/Documentation/mhi.txt
@@ -0,0 +1,235 @@
+Overview of Linux kernel MHI support
+====================================
+
+Modem-Host Interface (MHI)
+=========================
+MHI used by the host to control and communicate with modem over high speed
+peripheral bus. Even though MHI can be easily adapt to any peripheral buses,
+primarily used with PCIe based devices. The host has one or more PCIe root
+ports connected to modem device. The host has limited access to device memory
+space, including register configuration and control the device operation.
+Data transfers are invoked from the device.
+
+All data structures used by MHI are in the host system memory. Using PCIe
+interface, the device accesses those data structures. MHI data structures and
+data buffers in the host system memory regions are mapped for device.
+
+Memory spaces
+-------------
+PCIe Configurations : Used for enumeration and resource management, such as
+interrupt and base addresses.  This is done by mhi control driver.
+
+MMIO
+----
+MHI MMIO : Memory mapped IO consists of set of registers in the device hardware,
+which are mapped to the host memory space through PCIe base address register
+(BAR)
+
+MHI control registers : Access to MHI configurations registers
+(struct mhi_controller.regs).
+
+MHI BHI register: Boot host interface registers (struct mhi_controller.bhi) used
+for firmware download before MHI initialization.
+
+Channel db array : Doorbell registers (struct mhi_chan.tre_ring.db_addr) used by
+host to notify device there is new work to do.
+
+Event db array : Associated with event context array
+(struct mhi_event.ring.db_addr), host uses to notify device free events are
+available.
+
+Data structures
+---------------
+Host memory : Directly accessed by the host to manage the MHI data structures
+and buffers. The device accesses the host memory over the PCIe interface.
+
+Channel context array : All channel configurations are organized in channel
+context data array.
+
+struct __packed mhi_chan_ctxt;
+struct mhi_ctxt.chan_ctxt;
+
+Transfer rings : Used by host to schedule work items for a channel and organized
+as a circular queue of transfer descriptors (TD).
+
+struct __packed mhi_tre;
+struct mhi_chan.tre_ring;
+
+Event context array : All event configurations are organized in event context
+data array.
+
+struct mhi_ctxt.er_ctxt;
+struct __packed mhi_event_ctxt;
+
+Event rings: Used by device to send completion and state transition messages to
+host
+
+struct mhi_event.ring;
+struct __packed mhi_tre;
+
+Command context array: All command configurations are organized in command
+context data array.
+
+struct __packed mhi_cmd_ctxt;
+struct mhi_ctxt.cmd_ctxt;
+
+Command rings: Used by host to send MHI commands to device
+
+struct __packed mhi_tre;
+struct mhi_cmd.ring;
+
+Transfer rings
+--------------
+MHI channels are logical, unidirectional data pipes between host and device.
+Each channel associated with a single transfer ring.  The data direction can be
+either inbound (device to host) or outbound (host to device).  Transfer
+descriptors are managed by using transfer rings, which are defined for each
+channel between device and host and resides in the host memory.
+
+Transfer ring Pointer:	  	Transfer Ring Array
+[Read Pointer (RP)] ----------->[Ring Element] } TD
+[Write Pointer (WP)]-		[Ring Element]
+                     -		[Ring Element]
+		      --------->[Ring Element]
+				[Ring Element]
+
+1. Host allocate memory for transfer ring
+2. Host sets base, read pointer, write pointer in corresponding channel context
+3. Ring is considered empty when RP == WP
+4. Ring is considered full when WP + 1 == RP
+4. RP indicates the next element to be serviced by device
+4. When host new buffer to send, host update the Ring element with buffer
+   information
+5. Host increment the WP to next element
+6. Ring the associated channel DB.
+
+Event rings
+-----------
+Events from the device to host are organized in event rings and defined in event
+descriptors.  Event rings are array of EDs that resides in the host memory.
+
+Transfer ring Pointer:	  	Event Ring Array
+[Read Pointer (RP)] ----------->[Ring Element] } ED
+[Write Pointer (WP)]-		[Ring Element]
+                     -		[Ring Element]
+		      --------->[Ring Element]
+				[Ring Element]
+
+1. Host allocate memory for event ring
+2. Host sets base, read pointer, write pointer in corresponding channel context
+3. Both host and device has local copy of RP, WP
+3. Ring is considered empty (no events to service) when WP + 1 == RP
+4. Ring is full of events when RP == WP
+4. RP - 1 = last event device programmed
+4. When there is a new event device need to send, device update ED pointed by RP
+5. Device increment RP to next element
+6. Device trigger and interrupt
+
+Example Operation for data transfer:
+
+1. Host prepare TD with buffer information
+2. Host increment Chan[id].ctxt.WP
+3. Host ring channel DB register
+4. Device wakes up process the TD
+5. Device generate a completion event for that TD by updating ED
+6. Device increment Event[id].ctxt.RP
+7. Device trigger MSI to wake host
+8. Host wakes up and check event ring for completion event
+9. Host update the Event[i].ctxt.WP to indicate processed of completion event.
+
+MHI States
+----------
+
+enum MHI_STATE {
+MHI_STATE_RESET : MHI is in reset state, POR state. Host is not allowed to
+		  access device MMIO register space.
+MHI_STATE_READY : Device is ready for initialization. Host can start MHI
+		  initialization by programming MMIO
+MHI_STATE_M0 : MHI is in fully active state, data transfer is active
+MHI_STATE_M1 : Device in a suspended state
+MHI_STATE_M2 : MHI in low power mode, device may enter lower power mode.
+MHI_STATE_M3 : Both host and device in suspended state.  PCIe link is not
+	       accessible to device.
+
+MHI Initialization
+------------------
+
+1. After system boots, the device is enumerated over PCIe interface
+2. Host allocate MHI context for event, channel and command arrays
+3. Initialize context array, and prepare interrupts
+3. Host waits until device enter READY state
+4. Program MHI MMIO registers and set device into MHI_M0 state
+5. Wait for device to enter M0 state
+
+Linux Software Architecture
+===========================
+
+MHI Controller
+--------------
+MHI controller is also the MHI bus master. In charge of managing the physical
+link between host and device.  Not involved in actual data transfer.  At least
+for PCIe based buses, for other type of bus, we can expand to add support.
+
+Roles:
+1. Turn on PCIe bus and configure the link
+2. Configure MSI, SMMU, and IOMEM
+3. Allocate struct mhi_controller and register with MHI bus framework
+2. Initiate power on and shutdown sequence
+3. Initiate suspend and resume
+
+Usage
+-----
+
+1. Allocate control data structure by calling mhi_alloc_controller()
+2. Initialize mhi_controller with all the known information such as:
+   - Device Topology
+   - IOMMU window
+   - IOMEM mapping
+   - Device to use for memory allocation, and of_node with DT configuration
+   - Configure asynchronous callback functions
+3. Register MHI controller with MHI bus framework by calling
+   of_register_mhi_controller()
+
+After successfully registering controller can initiate any of these power modes:
+
+1. Power up sequence
+   - mhi_prepare_for_power_up()
+   - mhi_async_power_up()
+   - mhi_sync_power_up()
+2. Power down sequence
+   - mhi_power_down()
+   - mhi_unprepare_after_power_down()
+3. Initiate suspend
+   - mhi_pm_suspend()
+4. Initiate resume
+   - mhi_pm_resume()
+
+MHI Devices
+-----------
+Logical device that bind to maximum of two physical MHI channels. Once MHI is in
+powered on state, each supported channel by controller will be allocated as a
+mhi_device.
+
+Each supported device would be enumerated under
+/sys/bus/mhi/devices/
+
+struct mhi_device;
+
+MHI Driver
+----------
+Each MHI driver can bind to one or more MHI devices. MHI host driver will bind
+mhi_device to mhi_driver.
+
+All registered drivers are visible under
+/sys/bus/mhi/drivers/
+
+struct mhi_driver;
+
+Usage
+-----
+
+1. Register driver using mhi_driver_register
+2. Before sending data, prepare device for transfer by calling
+   mhi_prepare_for_transfer
+3. Initiate data transfer by calling mhi_queue_transfer
+4. After finish, call mhi_unprepare_from_transfer to end data transfer
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60..080d3c2 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -171,6 +171,14 @@ config DA8XX_MSTPRI
 	  configuration. Allows to adjust the priorities of all master
 	  peripherals.
 
+config MHI_BUS
+	tristate "Modem Host Interface"
+	help
+	  MHI Host Interface is a communication protocol to be used by the host
+	  to control and communcate with modem over a high speed peripheral bus.
+	  Enabling this module will allow host to communicate with external
+	  devices that support MHI protocol.
+
 source "drivers/bus/fsl-mc/Kconfig"
 
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index b8f036c..8fc0b3b 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
+obj-$(CONFIG_MHI_BUS) += mhi/
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
new file mode 100644
index 0000000..f8f14f7
--- /dev/null
+++ b/drivers/bus/mhi/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the MHI stack
+#
+
+# core layer
+obj-y += core/
diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
new file mode 100644
index 0000000..a015809
--- /dev/null
+++ b/drivers/bus/mhi/core/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MHI_BUS) +=mhi_init.o mhi_main.o
diff --git a/drivers/bus/mhi/core/mhi_init.c b/drivers/bus/mhi/core/mhi_init.c
new file mode 100644
index 0000000..b8c30f8
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_init.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+static int of_parse_ev_cfg(struct mhi_controller *mhi_cntrl,
+			   struct device_node *of_node)
+{
+	int i, ret, num = 0;
+	struct mhi_event *mhi_event;
+	struct device_node *child;
+
+	for_each_available_child_of_node(of_node, child) {
+		if (!strcmp(child->name, "mhi_event"))
+			num++;
+	}
+
+	if (!num)
+		return -EINVAL;
+
+	mhi_cntrl->total_ev_rings = num;
+	mhi_cntrl->mhi_event = kcalloc(num, sizeof(*mhi_cntrl->mhi_event),
+				       GFP_KERNEL);
+	if (!mhi_cntrl->mhi_event)
+		return -ENOMEM;
+
+	/* populate ev ring */
+	mhi_event = mhi_cntrl->mhi_event;
+	i = 0;
+	for_each_available_child_of_node(of_node, child) {
+		if (strcmp(child->name, "mhi_event"))
+			continue;
+
+		mhi_event->er_index = i++;
+		ret = of_property_read_u32(child, "mhi,num-elements",
+					   (u32 *)&mhi_event->ring.elements);
+		if (ret)
+			goto error_ev_cfg;
+
+		ret = of_property_read_u32(child, "mhi,intmod",
+					   &mhi_event->intmod);
+		if (ret)
+			goto error_ev_cfg;
+
+		ret = of_property_read_u32(child, "mhi,msi",
+					   &mhi_event->msi);
+		if (ret)
+			goto error_ev_cfg;
+
+		ret = of_property_read_u32(child, "mhi,chan",
+					   &mhi_event->chan);
+		if (!ret) {
+			if (mhi_event->chan >= mhi_cntrl->max_chan)
+				goto error_ev_cfg;
+			/* this event ring has a dedicated channel */
+			mhi_event->mhi_chan =
+				&mhi_cntrl->mhi_chan[mhi_event->chan];
+		}
+
+		ret = of_property_read_u32(child, "mhi,priority",
+					   &mhi_event->priority);
+		if (ret)
+			goto error_ev_cfg;
+
+		ret = of_property_read_u32(child, "mhi,brstmode",
+					   &mhi_event->db_cfg.brstmode);
+		if (ret || MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
+			goto error_ev_cfg;
+
+		mhi_event->db_cfg.process_db =
+			(mhi_event->db_cfg.brstmode == MHI_BRSTMODE_ENABLE) ?
+			mhi_db_brstmode : mhi_db_brstmode_disable;
+
+		ret = of_property_read_u32(child, "mhi,data-type",
+					   &mhi_event->data_type);
+		if (ret)
+			mhi_event->data_type = MHI_ER_DATA_ELEMENT_TYPE;
+
+		if (mhi_event->data_type > MHI_ER_DATA_TYPE_MAX)
+			goto error_ev_cfg;
+
+		switch (mhi_event->data_type) {
+		case MHI_ER_DATA_ELEMENT_TYPE:
+			mhi_event->process_event = mhi_process_data_event_ring;
+			break;
+		case MHI_ER_CTRL_ELEMENT_TYPE:
+			mhi_event->process_event = mhi_process_ctrl_ev_ring;
+			break;
+		}
+
+		mhi_event->hw_ring = of_property_read_bool(child, "mhi,hw-ev");
+		if (mhi_event->hw_ring)
+			mhi_cntrl->hw_ev_rings++;
+		else
+			mhi_cntrl->sw_ev_rings++;
+		mhi_event->cl_manage = of_property_read_bool(child,
+							"mhi,client-manage");
+		mhi_event->offload_ev = of_property_read_bool(child,
+							      "mhi,offload");
+		mhi_event++;
+	}
+
+	/* we need msi for each event ring + additional one for BHI */
+	mhi_cntrl->msi_required = mhi_cntrl->total_ev_rings + 1;
+
+	return 0;
+
+error_ev_cfg:
+
+	kfree(mhi_cntrl->mhi_event);
+	return -EINVAL;
+}
+static int of_parse_ch_cfg(struct mhi_controller *mhi_cntrl,
+			   struct device_node *of_node)
+{
+	int ret;
+	struct device_node *child;
+	u32 chan;
+
+	ret = of_property_read_u32(of_node, "mhi,max-channels",
+				   &mhi_cntrl->max_chan);
+	if (ret)
+		return ret;
+
+	mhi_cntrl->mhi_chan = kcalloc(mhi_cntrl->max_chan,
+				      sizeof(*mhi_cntrl->mhi_chan), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_chan)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mhi_cntrl->lpm_chans);
+
+	/* populate channel configurations */
+	for_each_available_child_of_node(of_node, child) {
+		struct mhi_chan *mhi_chan;
+
+		if (strcmp(child->name, "mhi_chan"))
+			continue;
+
+		ret = of_property_read_u32(child, "reg", &chan);
+		if (ret || chan >= mhi_cntrl->max_chan)
+			goto error_chan_cfg;
+
+		mhi_chan = &mhi_cntrl->mhi_chan[chan];
+
+		ret = of_property_read_string(child, "label",
+					      &mhi_chan->name);
+		if (ret)
+			goto error_chan_cfg;
+
+		mhi_chan->chan = chan;
+
+		ret = of_property_read_u32(child, "mhi,num-elements",
+					   (u32 *)&mhi_chan->buf_ring.elements);
+		if (!ret && !mhi_chan->buf_ring.elements)
+			goto error_chan_cfg;
+
+		mhi_chan->tre_ring.elements = mhi_chan->buf_ring.elements;
+
+		ret = of_property_read_u32(child, "mhi,event-ring",
+					   &mhi_chan->er_index);
+		if (ret)
+			goto error_chan_cfg;
+
+		ret = of_property_read_u32(child, "mhi,chan-dir",
+					   &mhi_chan->dir);
+		if (ret)
+			goto error_chan_cfg;
+
+		ret = of_property_read_u32(child, "mhi,ee", &mhi_chan->ee);
+		if (ret || mhi_chan->ee >= MHI_EE_MAX_SUPPORTED)
+			goto error_chan_cfg;
+
+		of_property_read_u32(child, "mhi,pollcfg",
+				     &mhi_chan->db_cfg.pollcfg);
+
+		ret = of_property_read_u32(child, "mhi,data-type",
+					   &mhi_chan->xfer_type);
+		if (ret)
+			goto error_chan_cfg;
+
+		switch (mhi_chan->xfer_type) {
+		case MHI_XFER_BUFFER:
+			mhi_chan->gen_tre = mhi_gen_tre;
+			mhi_chan->queue_xfer = mhi_queue_buf;
+			break;
+		case MHI_XFER_SKB:
+			mhi_chan->queue_xfer = mhi_queue_skb;
+			break;
+		case MHI_XFER_SCLIST:
+			mhi_chan->gen_tre = mhi_gen_tre;
+			mhi_chan->queue_xfer = mhi_queue_sclist;
+			break;
+		case MHI_XFER_NOP:
+			mhi_chan->queue_xfer = mhi_queue_nop;
+			break;
+		default:
+			goto error_chan_cfg;
+		}
+
+		mhi_chan->lpm_notify = of_property_read_bool(child,
+							     "mhi,lpm-notify");
+		mhi_chan->offload_ch = of_property_read_bool(child,
+							"mhi,offload-chan");
+		mhi_chan->db_cfg.reset_req = of_property_read_bool(child,
+							"mhi,db-mode-switch");
+		mhi_chan->pre_alloc = of_property_read_bool(child,
+							    "mhi,auto-queue");
+		mhi_chan->auto_start = of_property_read_bool(child,
+							     "mhi,auto-start");
+
+		if (mhi_chan->pre_alloc &&
+		    (mhi_chan->dir != DMA_FROM_DEVICE ||
+		     mhi_chan->xfer_type != MHI_XFER_BUFFER))
+			goto error_chan_cfg;
+
+		/* bi-dir and dirctionless channels must be a offload chan */
+		if ((mhi_chan->dir == DMA_BIDIRECTIONAL ||
+		     mhi_chan->dir == DMA_NONE) && !mhi_chan->offload_ch)
+			goto error_chan_cfg;
+
+		/* if mhi host allocate the buffers then client cannot queue */
+		if (mhi_chan->pre_alloc)
+			mhi_chan->queue_xfer = mhi_queue_nop;
+
+		if (!mhi_chan->offload_ch) {
+			ret = of_property_read_u32(child, "mhi,doorbell-mode",
+						   &mhi_chan->db_cfg.brstmode);
+			if (ret ||
+			    MHI_INVALID_BRSTMODE(mhi_chan->db_cfg.brstmode))
+				goto error_chan_cfg;
+
+			mhi_chan->db_cfg.process_db =
+				(mhi_chan->db_cfg.brstmode ==
+				 MHI_BRSTMODE_ENABLE) ?
+				mhi_db_brstmode : mhi_db_brstmode_disable;
+		}
+
+		mhi_chan->configured = true;
+
+		if (mhi_chan->lpm_notify)
+			list_add_tail(&mhi_chan->node, &mhi_cntrl->lpm_chans);
+	}
+
+	return 0;
+
+error_chan_cfg:
+	kfree(mhi_cntrl->mhi_chan);
+
+	return -EINVAL;
+}
+
+static int of_parse_dt(struct mhi_controller *mhi_cntrl,
+		       struct device_node *of_node)
+{
+	int ret;
+
+	/* parse MHI channel configuration */
+	ret = of_parse_ch_cfg(mhi_cntrl, of_node);
+	if (ret)
+		return ret;
+
+	/* parse MHI event configuration */
+	ret = of_parse_ev_cfg(mhi_cntrl, of_node);
+	if (ret)
+		goto error_ev_cfg;
+
+	ret = of_property_read_u32(of_node, "mhi,timeout",
+				   &mhi_cntrl->timeout_ms);
+	if (ret)
+		mhi_cntrl->timeout_ms = MHI_TIMEOUT_MS;
+
+	mhi_cntrl->bounce_buf = of_property_read_bool(of_node, "mhi,use-bb");
+	ret = of_property_read_u32(of_node, "mhi,buffer-len",
+				   (u32 *)&mhi_cntrl->buffer_len);
+	if (ret)
+		mhi_cntrl->buffer_len = MHI_MAX_MTU;
+
+	return 0;
+
+error_ev_cfg:
+	kfree(mhi_cntrl->mhi_chan);
+
+	return ret;
+}
+
+int of_register_mhi_controller(struct mhi_controller *mhi_cntrl)
+{
+	int ret;
+	int i;
+	struct mhi_event *mhi_event;
+	struct mhi_chan *mhi_chan;
+	struct mhi_cmd *mhi_cmd;
+	struct mhi_device *mhi_dev;
+
+	if (!mhi_cntrl->of_node)
+		return -EINVAL;
+
+	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put)
+		return -EINVAL;
+
+	if (!mhi_cntrl->status_cb || !mhi_cntrl->link_status)
+		return -EINVAL;
+
+	ret = of_parse_dt(mhi_cntrl, mhi_cntrl->of_node);
+	if (ret)
+		return -EINVAL;
+
+	mhi_cntrl->mhi_cmd = kcalloc(NR_OF_CMD_RINGS,
+				     sizeof(*mhi_cntrl->mhi_cmd), GFP_KERNEL);
+	if (!mhi_cntrl->mhi_cmd) {
+		ret = -ENOMEM;
+		goto error_alloc_cmd;
+	}
+
+	INIT_LIST_HEAD(&mhi_cntrl->transition_list);
+	mutex_init(&mhi_cntrl->pm_mutex);
+	rwlock_init(&mhi_cntrl->pm_lock);
+	spin_lock_init(&mhi_cntrl->transition_lock);
+	spin_lock_init(&mhi_cntrl->wlock);
+	init_waitqueue_head(&mhi_cntrl->state_event);
+
+	mhi_cmd = mhi_cntrl->mhi_cmd;
+	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++)
+		spin_lock_init(&mhi_cmd->lock);
+
+	mhi_event = mhi_cntrl->mhi_event;
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		mhi_event->mhi_cntrl = mhi_cntrl;
+		spin_lock_init(&mhi_event->lock);
+		if (mhi_event->data_type == MHI_ER_CTRL_ELEMENT_TYPE)
+			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
+				     (ulong)mhi_event);
+		else
+			tasklet_init(&mhi_event->task, mhi_ev_task,
+				     (ulong)mhi_event);
+	}
+
+	mhi_chan = mhi_cntrl->mhi_chan;
+	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
+		mutex_init(&mhi_chan->mutex);
+		init_completion(&mhi_chan->completion);
+		rwlock_init(&mhi_chan->lock);
+	}
+
+	if (mhi_cntrl->bounce_buf) {
+		mhi_cntrl->map_single = mhi_map_single_use_bb;
+		mhi_cntrl->unmap_single = mhi_unmap_single_use_bb;
+	} else {
+		mhi_cntrl->map_single = mhi_map_single_no_bb;
+		mhi_cntrl->unmap_single = mhi_unmap_single_no_bb;
+	}
+
+	/* register controller with mhi_bus */
+	mhi_dev = mhi_alloc_device(mhi_cntrl);
+	if (!mhi_dev) {
+		ret = -ENOMEM;
+		goto error_alloc_dev;
+	}
+
+	mhi_dev->dev_type = MHI_CONTROLLER_TYPE;
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	dev_set_name(&mhi_dev->dev, "%04x_%02u.%02u.%02u", mhi_dev->dev_id,
+		     mhi_dev->domain, mhi_dev->bus, mhi_dev->slot);
+	ret = device_add(&mhi_dev->dev);
+	if (ret)
+		goto error_add_dev;
+
+	mhi_cntrl->mhi_dev = mhi_dev;
+
+	mhi_cntrl->parent = debugfs_lookup(mhi_bus_type.name, NULL);
+
+	return 0;
+
+error_add_dev:
+	mhi_dealloc_device(mhi_cntrl, mhi_dev);
+
+error_alloc_dev:
+	kfree(mhi_cntrl->mhi_cmd);
+
+error_alloc_cmd:
+	kfree(mhi_cntrl->mhi_chan);
+	kfree(mhi_cntrl->mhi_event);
+
+	return ret;
+};
+EXPORT_SYMBOL(of_register_mhi_controller);
+
+void mhi_unregister_mhi_controller(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
+
+	kfree(mhi_cntrl->mhi_cmd);
+	kfree(mhi_cntrl->mhi_event);
+	kfree(mhi_cntrl->mhi_chan);
+
+	device_del(&mhi_dev->dev);
+	put_device(&mhi_dev->dev);
+}
+
+/* set ptr to control private data */
+static inline void mhi_controller_set_devdata(struct mhi_controller *mhi_cntrl,
+					 void *priv)
+{
+	mhi_cntrl->priv_data = priv;
+}
+
+
+/* allocate mhi controller to register */
+struct mhi_controller *mhi_alloc_controller(size_t size)
+{
+	struct mhi_controller *mhi_cntrl;
+
+	mhi_cntrl = kzalloc(size + sizeof(*mhi_cntrl), GFP_KERNEL);
+
+	if (mhi_cntrl && size)
+		mhi_controller_set_devdata(mhi_cntrl, mhi_cntrl + 1);
+
+	return mhi_cntrl;
+}
+EXPORT_SYMBOL(mhi_alloc_controller);
+
+/* match dev to drv */
+static int mhi_match(struct device *dev, struct device_driver *drv)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_driver *mhi_drv = to_mhi_driver(drv);
+	const struct mhi_device_id *id;
+
+	/* if controller type there is no client driver associated with it */
+	if (mhi_dev->dev_type == MHI_CONTROLLER_TYPE)
+		return 0;
+
+	for (id = mhi_drv->id_table; id->chan[0]; id++)
+		if (!strcmp(mhi_dev->chan_name, id->chan)) {
+			mhi_dev->id = id;
+			return 1;
+		}
+
+	return 0;
+};
+
+static void mhi_release_device(struct device *dev)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+
+	kfree(mhi_dev);
+}
+
+struct bus_type mhi_bus_type = {
+	.name = "mhi",
+	.dev_name = "mhi",
+	.match = mhi_match,
+};
+
+static int mhi_driver_probe(struct device *dev)
+{
+	return -EINVAL;
+}
+
+static int mhi_driver_remove(struct device *dev)
+{
+	return 0;
+}
+
+int mhi_driver_register(struct mhi_driver *mhi_drv)
+{
+	struct device_driver *driver = &mhi_drv->driver;
+
+	if (!mhi_drv->probe || !mhi_drv->remove)
+		return -EINVAL;
+
+	driver->bus = &mhi_bus_type;
+	driver->probe = mhi_driver_probe;
+	driver->remove = mhi_driver_remove;
+
+	return driver_register(driver);
+}
+EXPORT_SYMBOL(mhi_driver_register);
+
+void mhi_driver_unregister(struct mhi_driver *mhi_drv)
+{
+	driver_unregister(&mhi_drv->driver);
+}
+EXPORT_SYMBOL(mhi_driver_unregister);
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
+{
+	struct mhi_device *mhi_dev = kzalloc(sizeof(*mhi_dev), GFP_KERNEL);
+	struct device *dev;
+
+	if (!mhi_dev)
+		return NULL;
+
+	dev = &mhi_dev->dev;
+	device_initialize(dev);
+	dev->bus = &mhi_bus_type;
+	dev->release = mhi_release_device;
+	dev->parent = mhi_cntrl->dev;
+	mhi_dev->mhi_cntrl = mhi_cntrl;
+	mhi_dev->dev_id = mhi_cntrl->dev_id;
+	mhi_dev->domain = mhi_cntrl->domain;
+	mhi_dev->bus = mhi_cntrl->bus;
+	mhi_dev->slot = mhi_cntrl->slot;
+	mhi_dev->mtu = MHI_MAX_MTU;
+	atomic_set(&mhi_dev->dev_wake, 0);
+
+	return mhi_dev;
+}
+
+static int __init mhi_init(void)
+{
+	/* parent directory */
+	debugfs_create_dir(mhi_bus_type.name, NULL);
+
+	return bus_register(&mhi_bus_type);
+}
+postcore_initcall(mhi_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("MHI_CORE");
+MODULE_DESCRIPTION("MHI Host Interface");
diff --git a/drivers/bus/mhi/core/mhi_internal.h b/drivers/bus/mhi/core/mhi_internal.h
new file mode 100644
index 0000000..90c40de
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_internal.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#ifndef _MHI_INT_H
+#define _MHI_INT_H
+
+extern struct bus_type mhi_bus_type;
+
+/* MHI transfer completion events */
+enum MHI_EV_CCS {
+	MHI_EV_CC_INVALID = 0x0,
+	MHI_EV_CC_SUCCESS = 0x1,
+	MHI_EV_CC_EOT = 0x2,
+	MHI_EV_CC_OVERFLOW = 0x3,
+	MHI_EV_CC_EOB = 0x4,
+	MHI_EV_CC_OOB = 0x5,
+	MHI_EV_CC_DB_MODE = 0x6,
+	MHI_EV_CC_UNDEFINED_ERR = 0x10,
+	MHI_EV_CC_BAD_TRE = 0x11,
+};
+
+enum MHI_CH_STATE {
+	MHI_CH_STATE_DISABLED = 0x0,
+	MHI_CH_STATE_ENABLED = 0x1,
+	MHI_CH_STATE_RUNNING = 0x2,
+	MHI_CH_STATE_SUSPENDED = 0x3,
+	MHI_CH_STATE_STOP = 0x4,
+	MHI_CH_STATE_ERROR = 0x5,
+};
+
+enum MHI_BRSTMODE {
+	MHI_BRSTMODE_DISABLE = 0x2,
+	MHI_BRSTMODE_ENABLE = 0x3,
+};
+
+#define MHI_INVALID_BRSTMODE(mode) (mode != MHI_BRSTMODE_DISABLE && \
+				    mode != MHI_BRSTMODE_ENABLE)
+
+enum MHI_EE {
+	MHI_EE_PBL = 0x0,
+	MHI_EE_SBL = 0x1,
+	MHI_EE_AMSS = 0x2,
+	MHI_EE_BHIE = 0x3,
+	MHI_EE_RDDM = 0x4,
+	MHI_EE_PTHRU = 0x5,
+	MHI_EE_EDL = 0x6,
+	MHI_EE_MAX_SUPPORTED = MHI_EE_EDL,
+	MHI_EE_DISABLE_TRANSITION, /* local EE, not related to mhi spec */
+	MHI_EE_MAX,
+};
+
+/* accepted buffer type for the channel */
+enum MHI_XFER_TYPE {
+	MHI_XFER_BUFFER,
+	MHI_XFER_SKB,
+	MHI_XFER_SCLIST,
+	MHI_XFER_NOP, /* CPU offload channel, host does not accept transfer */
+};
+
+#define NR_OF_CMD_RINGS (1)
+#define CMD_EL_PER_RING (128)
+#define PRIMARY_CMD_RING (0)
+#define MHI_MAX_MTU (0xffff)
+
+enum MHI_ER_TYPE {
+	MHI_ER_TYPE_INVALID = 0x0,
+	MHI_ER_TYPE_VALID = 0x1,
+};
+
+enum mhi_er_data_type {
+	MHI_ER_DATA_ELEMENT_TYPE,
+	MHI_ER_CTRL_ELEMENT_TYPE,
+	MHI_ER_DATA_TYPE_MAX = MHI_ER_CTRL_ELEMENT_TYPE,
+};
+
+struct db_cfg {
+	bool reset_req;
+	bool db_mode;
+	u32 pollcfg;
+	enum MHI_BRSTMODE brstmode;
+	dma_addr_t db_val;
+	void (*process_db)(struct mhi_controller *mhi_cntrl,
+			   struct db_cfg *db_cfg, void __iomem *io_addr,
+			   dma_addr_t db_val);
+};
+
+struct mhi_ring {
+	dma_addr_t dma_handle;
+	dma_addr_t iommu_base;
+	u64 *ctxt_wp; /* point to ctxt wp */
+	void *pre_aligned;
+	void *base;
+	void *rp;
+	void *wp;
+	size_t el_size;
+	size_t len;
+	size_t elements;
+	size_t alloc_size;
+	void __iomem *db_addr;
+};
+
+struct mhi_cmd {
+	struct mhi_ring ring;
+	spinlock_t lock;
+};
+
+struct mhi_buf_info {
+	dma_addr_t p_addr;
+	void *v_addr;
+	void *bb_addr;
+	void *wp;
+	size_t len;
+	void *cb_buf;
+	enum dma_data_direction dir;
+};
+
+struct mhi_event {
+	u32 er_index;
+	u32 intmod;
+	u32 msi;
+	int chan; /* this event ring is dedicated to a channel */
+	u32 priority;
+	enum mhi_er_data_type data_type;
+	struct mhi_ring ring;
+	struct db_cfg db_cfg;
+	bool hw_ring;
+	bool cl_manage;
+	bool offload_ev; /* managed by a device driver */
+	spinlock_t lock;
+	struct mhi_chan *mhi_chan; /* dedicated to channel */
+	struct tasklet_struct task;
+	int (*process_event)(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event,
+			     u32 event_quota);
+	struct mhi_controller *mhi_cntrl;
+};
+
+struct mhi_chan {
+	u32 chan;
+	const char *name;
+	/*
+	 * important, when consuming increment tre_ring first, when releasing
+	 * decrement buf_ring first. If tre_ring has space, buf_ring
+	 * guranteed to have space so we do not need to check both rings.
+	 */
+	struct mhi_ring buf_ring;
+	struct mhi_ring tre_ring;
+	u32 er_index;
+	u32 intmod;
+	enum dma_data_direction dir;
+	struct db_cfg db_cfg;
+	enum MHI_EE ee;
+	enum MHI_XFER_TYPE xfer_type;
+	enum MHI_CH_STATE ch_state;
+	enum MHI_EV_CCS ccs;
+	bool lpm_notify;
+	bool configured;
+	bool offload_ch;
+	bool pre_alloc;
+	bool auto_start;
+	/* functions that generate the transfer ring elements */
+	int (*gen_tre)(struct mhi_controller *mhi_cntrl,
+		       struct mhi_chan *mhi_chan, void *buf, void *cb,
+		       size_t len, enum MHI_FLAGS flags);
+	int (*queue_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+			  void *buf, size_t len, enum MHI_FLAGS mflags);
+	/* xfer call back */
+	struct mhi_device *mhi_dev;
+	void (*xfer_cb)(struct mhi_device *mhi_dev, struct mhi_result *result);
+	struct mutex mutex;
+	struct completion completion;
+	rwlock_t lock;
+	struct list_head node;
+};
+
+/* default MHI timeout */
+#define MHI_TIMEOUT_MS (1000)
+
+/* power management apis */
+void mhi_pm_st_worker(struct work_struct *work);
+void mhi_fw_load_worker(struct work_struct *work);
+void mhi_pm_sys_err_worker(struct work_struct *work);
+
+/* queue transfer buffer */
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
+		void *buf, void *cb, size_t buf_len, enum MHI_FLAGS flags);
+int mhi_queue_buf(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+int mhi_queue_skb(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+int mhi_queue_sclist(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+int mhi_queue_nop(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		  void *buf, size_t len, enum MHI_FLAGS mflags);
+
+/* register access methods */
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl, struct db_cfg *db_cfg,
+		     void __iomem *db_addr, dma_addr_t wp);
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_mode, void __iomem *db_addr,
+			     dma_addr_t wp);
+
+struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
+static inline void mhi_dealloc_device(struct mhi_controller *mhi_cntrl,
+				      struct mhi_device *mhi_dev)
+{
+	kfree(mhi_dev);
+}
+int mhi_destroy_device(struct device *dev, void *data);
+void mhi_create_devices(struct mhi_controller *mhi_cntrl);
+
+int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
+			 struct mhi_buf_info *buf_info);
+int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf_info);
+void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info);
+void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
+			     struct mhi_buf_info *buf_info);
+void mhi_ctrl_ev_task(unsigned long data);
+int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
+				struct mhi_event *mhi_event, u32 event_quota);
+int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event, u32 event_quota);
+
+/* initialization methods */
+int mhi_dtr_init(void);
+
+/* isr handlers */
+irqreturn_t mhi_msi_handlr(int irq_number, void *dev);
+irqreturn_t mhi_intvec_threaded_handlr(int irq_number, void *dev);
+irqreturn_t mhi_intvec_handlr(int irq_number, void *dev);
+void mhi_ev_task(unsigned long data);
+
+#endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/core/mhi_main.c b/drivers/bus/mhi/core/mhi_main.c
new file mode 100644
index 0000000..4df4cd0
--- /dev/null
+++ b/drivers/bus/mhi/core/mhi_main.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/mhi.h>
+#include "mhi_internal.h"
+
+void mhi_db_brstmode(struct mhi_controller *mhi_cntrl,
+		     struct db_cfg *db_cfg,
+		     void __iomem *db_addr,
+		     dma_addr_t wp)
+{
+}
+
+void mhi_db_brstmode_disable(struct mhi_controller *mhi_cntrl,
+			     struct db_cfg *db_cfg,
+			     void __iomem *db_addr,
+			     dma_addr_t wp)
+{
+}
+
+int mhi_map_single_no_bb(struct mhi_controller *mhi_cntrl,
+			 struct mhi_buf_info *buf_info)
+{
+	return -ENOMEM;
+}
+
+int mhi_map_single_use_bb(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf_info)
+{
+	return -ENOMEM;
+}
+
+void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info)
+{
+}
+
+void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
+			    struct mhi_buf_info *buf_info)
+{
+}
+
+int mhi_queue_sclist(struct mhi_device *mhi_dev,
+		     struct mhi_chan *mhi_chan,
+		     void *buf,
+		     size_t len,
+		     enum MHI_FLAGS mflags)
+{
+	return -EINVAL;
+}
+
+int mhi_queue_nop(struct mhi_device *mhi_dev,
+		  struct mhi_chan *mhi_chan,
+		  void *buf,
+		  size_t len,
+		  enum MHI_FLAGS mflags)
+{
+	return -EINVAL;
+}
+
+int mhi_queue_skb(struct mhi_device *mhi_dev,
+		  struct mhi_chan *mhi_chan,
+		  void *buf,
+		  size_t len,
+		  enum MHI_FLAGS mflags)
+{
+	return -EINVAL;
+}
+
+int mhi_gen_tre(struct mhi_controller *mhi_cntrl,
+		struct mhi_chan *mhi_chan,
+		void *buf,
+		void *cb,
+		size_t buf_len,
+		enum MHI_FLAGS flags)
+{
+	return -EINVAL;
+}
+
+int mhi_queue_buf(struct mhi_device *mhi_dev,
+		  struct mhi_chan *mhi_chan,
+		  void *buf,
+		  size_t len,
+		  enum MHI_FLAGS mflags)
+{
+	return -EINVAL;
+}
+
+int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
+			     struct mhi_event *mhi_event,
+			     u32 event_quota)
+{
+	return -EIO;
+}
+
+int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
+				struct mhi_event *mhi_event,
+				u32 event_quota)
+{
+	return -EIO;
+}
+
+void mhi_ev_task(unsigned long data)
+{
+}
+
+void mhi_ctrl_ev_task(unsigned long data)
+{
+}
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
new file mode 100644
index 0000000..c80685e9
--- /dev/null
+++ b/include/linux/mhi.h
@@ -0,0 +1,341 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ */
+#ifndef _MHI_H_
+#define _MHI_H_
+
+struct mhi_chan;
+struct mhi_event;
+struct mhi_ctxt;
+struct mhi_cmd;
+struct mhi_buf_info;
+
+/**
+ * enum MHI_CB - MHI callback
+ * @MHI_CB_IDLE: MHI entered idle state
+ * @MHI_CB_PENDING_DATA: New data available for client to process
+ * @MHI_CB_LPM_ENTER: MHI host entered low power mode
+ * @MHI_CB_LPM_EXIT: MHI host about to exit low power mode
+ * @MHI_CB_EE_RDDM: MHI device entered RDDM execution enviornment
+ */
+enum MHI_CB {
+	MHI_CB_IDLE,
+	MHI_CB_PENDING_DATA,
+	MHI_CB_LPM_ENTER,
+	MHI_CB_LPM_EXIT,
+	MHI_CB_EE_RDDM,
+};
+
+/**
+ * enum MHI_FLAGS - Transfer flags
+ * @MHI_EOB: End of buffer for bulk transfer
+ * @MHI_EOT: End of transfer
+ * @MHI_CHAIN: Linked transfer
+ */
+enum MHI_FLAGS {
+	MHI_EOB,
+	MHI_EOT,
+	MHI_CHAIN,
+};
+
+/**
+ * enum mhi_device_type - Device types
+ * @MHI_XFER_TYPE: Handles data transfer
+ * @MHI_TIMESYNC_TYPE: Use for timesync feature
+ * @MHI_CONTROLLER_TYPE: Control device
+ */
+enum mhi_device_type {
+	MHI_XFER_TYPE,
+	MHI_TIMESYNC_TYPE,
+	MHI_CONTROLLER_TYPE,
+};
+
+/**
+ * struct mhi_controller - Master controller structure for external modem
+ * @dev: Device associated with this controller
+ * @of_node: DT that has MHI configuration information
+ * @regs: Points to base of MHI MMIO register space
+ * @dev_id: PCIe device id of the external device
+ * @domain: PCIe domain the device connected to
+ * @bus: PCIe bus the device assigned to
+ * @slot: PCIe slot for the modem
+ * @iova_start: IOMMU starting address for data
+ * @iova_stop: IOMMU stop address for data
+ * @fw_image: Firmware image name for normal booting
+ * @edl_image: Firmware image name for emergency download mode
+ * @fbc_download: MHI host needs to do complete image transfer
+ * @rddm_size: RAM dump size that host should allocate for debugging purpose
+ * @sbl_size: SBL image size
+ * @seg_len: BHIe vector size
+ * @fbc_image: Points to firmware image buffer
+ * @rddm_image: Points to RAM dump buffer
+ * @max_chan: Maximum number of channels controller support
+ * @mhi_chan: Points to channel configuration table
+ * @lpm_chans: List of channels that require LPM notifications
+ * @total_ev_rings: Total # of event rings allocated
+ * @hw_ev_rings: Number of hardware event rings
+ * @sw_ev_rings: Number of software event rings
+ * @msi_required: Number of msi required to operate
+ * @msi_allocated: Number of msi allocated by bus master
+ * @irq: base irq # to request
+ * @mhi_event: MHI event ring configurations table
+ * @mhi_cmd: MHI command ring configurations table
+ * @mhi_ctxt: MHI device context, shared memory between host and device
+ * @timeout_ms: Timeout in ms for state transitions
+ * @pm_state: Power management state
+ * @ee: MHI device execution environment
+ * @dev_state: MHI STATE
+ * @status_cb: CB function to notify various power states to but master
+ * @link_status: Query link status in case of abnormal value read from device
+ * @runtime_get: Async runtime resume function
+ * @runtimet_put: Release votes
+ * @time_get: Return host time in us
+ * @lpm_disable: Request controller to disable link level low power modes
+ * @lpm_enable: Controller may enable link level low power modes again
+ * @priv_data: Points to bus master's private data
+ */
+struct mhi_controller {
+	struct list_head node;
+	struct mhi_device *mhi_dev;
+
+	/* device node for iommu ops */
+	struct device *dev;
+	struct device_node *of_node;
+
+	/* mmio base */
+	void __iomem *regs;
+
+	/* device topology */
+	u32 dev_id;
+	u32 domain;
+	u32 bus;
+	u32 slot;
+
+	/* addressing window */
+	dma_addr_t iova_start;
+	dma_addr_t iova_stop;
+
+	/* fw images */
+	const char *fw_image;
+	const char *edl_image;
+
+	/* mhi host manages downloading entire fbc images */
+	bool fbc_download;
+	size_t rddm_size;
+	size_t sbl_size;
+	size_t seg_len;
+	u32 session_id;
+	u32 sequence_id;
+
+	/* physical channel config data */
+	u32 max_chan;
+	struct mhi_chan *mhi_chan;
+	struct list_head lpm_chans; /* these chan require lpm notification */
+
+	/* physical event config data */
+	u32 total_ev_rings;
+	u32 hw_ev_rings;
+	u32 sw_ev_rings;
+	u32 msi_required;
+	u32 msi_allocated;
+	int *irq; /* interrupt table */
+	struct mhi_event *mhi_event;
+
+	/* cmd rings */
+	struct mhi_cmd *mhi_cmd;
+
+	/* mhi context (shared with device) */
+	struct mhi_ctxt *mhi_ctxt;
+
+	u32 timeout_ms;
+
+	/* caller should grab pm_mutex for suspend/resume operations */
+	struct mutex pm_mutex;
+	bool pre_init;
+	rwlock_t pm_lock;
+	u32 pm_state;
+	u32 ee;
+	u32 dev_state;
+	bool wake_set;
+	atomic_t dev_wake;
+	atomic_t alloc_size;
+	struct list_head transition_list;
+	spinlock_t transition_lock;
+	spinlock_t wlock;
+
+	/* debug counters */
+	u32 M0, M2, M3;
+
+	/* worker for different state transitions */
+	struct work_struct st_worker;
+	struct work_struct fw_worker;
+	struct work_struct syserr_worker;
+	wait_queue_head_t state_event;
+
+	/* shadow functions */
+	void (*status_cb)(struct mhi_controller *mhi_cntrl, void *priv,
+			  enum MHI_CB cb);
+	int (*link_status)(struct mhi_controller *mhi_cntrl, void *priv);
+	void (*wake_get)(struct mhi_controller *mhi_cntrl, bool override);
+	void (*wake_put)(struct mhi_controller *mhi_cntrl, bool override);
+	int (*runtime_get)(struct mhi_controller *mhi_cntrl, void *priv);
+	void (*runtime_put)(struct mhi_controller *mhi_cntrl, void *priv);
+	void (*lpm_disable)(struct mhi_controller *mhi_cntrl, void *priv);
+	void (*lpm_enable)(struct mhi_controller *mhi_cntrl, void *priv);
+	int (*map_single)(struct mhi_controller *mhi_cntrl,
+			  struct mhi_buf_info *buf);
+	void (*unmap_single)(struct mhi_controller *mhi_cntrl,
+			     struct mhi_buf_info *buf);
+
+	/* channel to control DTR messaging */
+	struct mhi_device *dtr_dev;
+
+	/* bounce buffer settings */
+	bool bounce_buf;
+	size_t buffer_len;
+
+	/* controller specific data */
+	void *priv_data;
+	void *log_buf;
+	struct dentry *dentry;
+	struct dentry *parent;
+};
+
+/**
+ * struct mhi_device - mhi device structure associated bind to channel
+ * @dev: Device associated with the channels
+ * @mtu: Maximum # of bytes controller support
+ * @ul_chan_id: MHI channel id for UL transfer
+ * @dl_chan_id: MHI channel id for DL transfer
+ * @tiocm: Device current terminal settings
+ * @priv: Driver private data
+ */
+struct mhi_device {
+	struct device dev;
+	u32 dev_id;
+	u32 domain;
+	u32 bus;
+	u32 slot;
+	size_t mtu;
+	int ul_chan_id;
+	int dl_chan_id;
+	int ul_event_id;
+	int dl_event_id;
+	u32 tiocm;
+	const struct mhi_device_id *id;
+	const char *chan_name;
+	struct mhi_controller *mhi_cntrl;
+	struct mhi_chan *ul_chan;
+	struct mhi_chan *dl_chan;
+	atomic_t dev_wake;
+	enum mhi_device_type dev_type;
+	void *priv_data;
+	int (*ul_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		       void *buf, size_t len, enum MHI_FLAGS flags);
+	int (*dl_xfer)(struct mhi_device *mhi_dev, struct mhi_chan *mhi_chan,
+		       void *buf, size_t len, enum MHI_FLAGS flags);
+	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB cb);
+};
+
+/**
+ * struct mhi_result - Completed buffer information
+ * @buf_addr: Address of data buffer
+ * @dir: Channel direction
+ * @bytes_xfer: # of bytes transferred
+ * @transaction_status: Status of last trasnferred
+ */
+struct mhi_result {
+	void *buf_addr;
+	enum dma_data_direction dir;
+	size_t bytes_xferd;
+	int transaction_status;
+};
+
+/**
+ * struct mhi_driver - mhi driver information
+ * @id_table: NULL terminated channel ID names
+ * @ul_xfer_cb: UL data transfer callback
+ * @dl_xfer_cb: DL data transfer callback
+ * @status_cb: Asynchronous status callback
+ */
+struct mhi_driver {
+	const struct mhi_device_id *id_table;
+	int (*probe)(struct mhi_device *mhi_dev,
+		     const struct mhi_device_id *id);
+	void (*remove)(struct mhi_device *mhi_dev);
+	void (*ul_xfer_cb)(struct mhi_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*dl_xfer_cb)(struct mhi_device *mhi_dev,
+			   struct mhi_result *result);
+	void (*status_cb)(struct mhi_device *mhi_dev, enum MHI_CB mhi_cb);
+	struct device_driver driver;
+};
+
+#define to_mhi_driver(drv) container_of(drv, struct mhi_driver, driver)
+#define to_mhi_device(dev) container_of(dev, struct mhi_device, dev)
+
+static inline void mhi_device_set_devdata(struct mhi_device *mhi_dev,
+					  void *priv)
+{
+	mhi_dev->priv_data = priv;
+}
+
+static inline void *mhi_device_get_devdata(struct mhi_device *mhi_dev)
+{
+	return mhi_dev->priv_data;
+}
+
+static inline void *mhi_controller_get_devdata(struct mhi_controller *mhi_cntrl)
+{
+	return mhi_cntrl->priv_data;
+}
+
+static inline void mhi_free_controller(struct mhi_controller *mhi_cntrl)
+{
+	kfree(mhi_cntrl);
+}
+
+/**
+ * mhi_driver_register - Register driver with MHI framework
+ * @mhi_drv: mhi_driver structure
+ */
+int mhi_driver_register(struct mhi_driver *mhi_drv);
+
+/**
+ * mhi_driver_unregister - Unregister a driver for mhi_devices
+ * @mhi_drv: mhi_driver structure
+ */
+void mhi_driver_unregister(struct mhi_driver *mhi_drv);
+
+/**
+ * mhi_alloc_controller - Allocate mhi_controller structure
+ * Allocate controller structure and additional data for controller
+ * private data. You may get the private data pointer by calling
+ * mhi_controller_get_devdata
+ * @size: # of additional bytes to allocate
+ */
+struct mhi_controller *mhi_alloc_controller(size_t size);
+
+/**
+ * of_register_mhi_controller - Register MHI controller
+ * Registers MHI controller with MHI bus framework. DT must be supported
+ * @mhi_cntrl: MHI controller to register
+ */
+int of_register_mhi_controller(struct mhi_controller *mhi_cntrl);
+
+void mhi_unregister_mhi_controller(struct mhi_controller *mhi_cntrl);
+
+/**
+ * mhi_bdf_to_controller - Look up a registered controller
+ * Search for controller based on device identification
+ * @domain: RC domain of the device
+ * @bus: Bus device connected to
+ * @slot: Slot device assigned to
+ * @dev_id: Device Identification
+ */
+struct mhi_controller *mhi_bdf_to_controller(u32 domain, u32 bus, u32 slot,
+					     u32 dev_id);
+
+#endif /* _MHI_H_ */
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 7d361be..453ec01 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -734,4 +734,16 @@ struct tb_service_id {
 #define TBSVC_MATCH_PROTOCOL_VERSION	0x0004
 #define TBSVC_MATCH_PROTOCOL_REVISION	0x0008
 
+#define MHI_NAME_SIZE 32
+
+/**
+ * struct mhi_device_id - MHI device identification
+ * @chan: MHI channel name
+ * @driver_data: driver data;
+ */
+struct mhi_device_id {
+	const char chan[MHI_NAME_SIZE];
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

