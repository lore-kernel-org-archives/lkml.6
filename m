Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeCMR4c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:56:32 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:41022 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752535AbeCMR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:56:18 -0400
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To: jakob.unterwurzacher@theobroma-systems.com
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Tue, 13 Mar 2018 18:35:20 +0100
Message-Id: <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UCAN driver supports the microcontroller-based USB/CAN
adapters from Theobroma Systems. There are two form-factors
that run essentially the same firmware:

* Seal: standalone USB stick ( https://www.theobroma-systems.com/seal )

* Mule: integrated on the PCB of various System-on-Modules from
  Theobroma Systems like the A31-µQ7 and the RK3399-Q7
  ( https://www.theobroma-systems.com/rk3399-q7 )

The USB wire protocol has been designed to be as generic and
hardware-indendent as possible in the hope of being useful for
implementation on other microcontrollers.

Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
---
 Documentation/networking/can_ucan_protocol.rst |  315 +++++
 Documentation/networking/index.rst             |    1 +
 drivers/net/can/usb/Kconfig                    |   10 +
 drivers/net/can/usb/Makefile                   |    1 +
 drivers/net/can/usb/ucan.c                     | 1587 ++++++++++++++++++++++++
 5 files changed, 1914 insertions(+)
 create mode 100644 Documentation/networking/can_ucan_protocol.rst
 create mode 100644 drivers/net/can/usb/ucan.c

diff --git a/Documentation/networking/can_ucan_protocol.rst b/Documentation/networking/can_ucan_protocol.rst
new file mode 100644
index 000000000000..d859b36200b4
--- /dev/null
+++ b/Documentation/networking/can_ucan_protocol.rst
@@ -0,0 +1,315 @@
+=================
+The UCAN Protocol
+=================
+
+UCAN is the protocol used by the microcontroller-based USB-CAN
+adapter that is integrated on System-on-Modules from Theobroma Systems
+and that is also available as a standalone USB stick.
+
+The UCAN protocol has been designed to be hardware-independent.
+It is modeled closely after how Linux represents CAN devices
+internally. All multi-byte integers are encoded as Little Endian.
+
+All structures mentioned in this document are defined in
+``drivers/net/can/usb/ucan.c``.
+
+USB Endpoints
+=============
+
+UCAN devices use three USB endpoints:
+
+CONTROL endpoint
+  The driver sends device management commands on this endpoint
+
+IN endpoint
+  The device sends CAN data frames and CAN error frames
+
+OUT endpoint
+  The driver sends CAN data frames on the out endpoint
+
+
+CONTROL Messages
+================
+
+UCAN devices are configured using vendor requests on the control pipe.
+
+To support multiple CAN interfaces in a single USB device all
+configuration commands target the corresponding interface in the USB
+descriptor.
+
+The driver uses ``ucan_ctrl_command_in/out`` and
+``ucan_device_request_in`` to deliver commands to the device.
+
+Setup Packet
+------------
+
+=================  =====================================================
+``bmRequestType``  Direction | Vendor | (Interface or Device)
+``bRequest``       Command Number
+``wValue``         Subcommand Number (16 Bit) or 0 if not used
+``wIndex``         USB Interface Index (0 for device commands)
+``wLength``        * Host to Device - Number of bytes to transmit
+                   * Device to Host - Maximum Number of bytes to
+                     receive. If the device send less. Commom ZLP
+                     semantics are used.
+=================  =====================================================
+
+Error Handling
+--------------
+
+The device indicates failed control commands by stalling the
+pipe.
+
+Device Commands
+---------------
+
+UCAN_DEVICE_GET_FW_STRING
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+*Dev2Host; optional*
+
+Request the device firmware string.
+
+
+Interface Commands
+------------------
+
+UCAN_COMMAND_START
+~~~~~~~~~~~~~~~~~~
+
+*Host2Dev; mandatory*
+
+Bring the CAN interface up.
+
+Payload Format
+  ``ucan_ctl_payload_t.cmd_start``
+
+====  ============================
+mode  or mask of ``UCAN_MODE_*``
+====  ============================
+
+UCAN_COMMAND_STOP
+~~~~~~~~~~~~~~~~~~
+
+*Host2Dev; mandatory*
+
+Stop the CAN interface
+
+Payload Format
+  *empty*
+
+UCAN_COMMAND_RESET
+~~~~~~~~~~~~~~~~~~
+
+*Host2Dev; mandatory*
+
+Reset the CAN controller (including error counters)
+
+Payload Format
+  *empty*
+
+UCAN_COMMAND_GET
+~~~~~~~~~~~~~~~~
+
+*Host2Dev; mandatory*
+
+Get Information from the Device
+
+Subcommands
+^^^^^^^^^^^
+
+UCAN_COMMAND_GET_INFO
+  Request the device information structure ``ucan_ctl_payload_t.device_info``.
+
+  See the ``device_info`` field for details, and
+  ``uapi/linux/can/netlink.h`` for an explanation of the
+  ``can_bittiming fields``.
+
+  Payload Format
+    ``ucan_ctl_payload_t.device_info``
+
+UCAN_COMMAND_GET_PROTOCOL_VERSION
+
+  Request the device protocol version
+  ``ucan_ctl_payload_t.protocol_version``. The current protocol version is 3.
+
+  Payload Format
+    ``ucan_ctl_payload_t.protocol_version``
+
+.. note:: Devices that do not implement this command use the old
+          protocol version 1
+
+UCAN_COMMAND_SET_BITTIMING
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+*Host2Dev; mandatory*
+
+Setup bittiming by sending the the structure
+``ucan_ctl_payload_t.cmd_set_bittiming`` (see ``struct bittiming`` for
+details)
+
+Payload Format
+  ``ucan_ctl_payload_t.cmd_set_bittiming``.
+
+UCAN_SLEEP/WAKE
+~~~~~~~~~~~~~~~
+
+*Host2Dev; optional*
+
+Configure sleep and wake modes. Not yet supported by the driver.
+
+UCAN_FILTER
+~~~~~~~~~~~
+
+*Host2Dev; optional*
+
+Setup hardware CAN filters. Not yet supported by the driver.
+
+Allowed interface commands
+--------------------------
+
+==================  ===================  ==================
+Legal Device State  Command              New Device State
+==================  ===================  ==================
+stopped             SET_BITTIMING        stopped
+stopped             START                started
+started             STOP or RESET        stopped
+stopped             STOP or RESET        stopped
+started             RESTART              started
+any                 GET                  *no change*
+==================  ===================  ==================
+
+IN Message Format
+=================
+
+A data packet on the USB IN endpoint contains one or more
+``ucan_message_in`` values. If multiple messages are batched in a USB
+data packet, the ``len`` field can be used to jump to the next
+``ucan_message_in`` value (take care to sanity-check the ``len`` value
+against the actual data size).
+
+.. _can_ucan_in_message_len:
+
+``len`` field
+-------------
+
+Each ``ucan_message_in`` must be aligned to a 4-byte boundary (relative
+to the start of the start of the data buffer). That means that there
+may be padding bytes between multiple ``ucan_message_in`` values:
+
+.. code::
+
+    +----------------------------+ < 0
+    |                            |
+    |   struct ucan_message_in   |
+    |                            |
+    +----------------------------+ < len
+              [padding]
+    +----------------------------+ < round_up(len, 4)
+    |                            |
+    |   struct ucan_message_in   |
+    |                            |
+    +----------------------------+
+                [...]
+
+``type`` field
+--------------
+
+The ``type`` field specifies the type of the message.
+
+UCAN_IN_RX
+~~~~~~~~~~
+
+``subtype``
+  zero
+
+Data received from the CAN bus (ID + payload).
+
+UCAN_IN_TX_COMPLETE
+~~~~~~~~~~~~~~~~~~~
+
+``subtype``
+  zero
+
+The CAN device has sent a message to the CAN bus. It answers with a
+set of echo-ids from previous UCAN_OUT_TX messages
+
+Flow Control
+------------
+
+When receiving CAN messages there is no flow control on the USB
+buffer. The driver has to handle inbound message quickly enough to
+avoid drops. I case the device buffer overflow the condition is
+reported by sending corresponding error frames (see
+:ref:`can_ucan_error_handling`)
+
+
+OUT Message Format
+==================
+
+A data packet on the USB OUT endpoint contains one or more ``struct
+ucan_message_out`` values. If multiple messages are batched into one
+data packet, the device uses the ``len`` field to jump to the next
+ucan_message_out value. Each ucan_message_out must be aligned to 4
+bytes (relative to the start of the data buffer). The mechanism is
+same as described in :ref:`can_ucan_in_message_len`.
+
+.. code::
+
+    +----------------------------+ < 0
+    |                            |
+    |   struct ucan_message_out  |
+    |                            |
+    +----------------------------+ < len
+              [padding]
+    +----------------------------+ < round_up(len, 4)
+    |                            |
+    |   struct ucan_message_out  |
+    |                            |
+    +----------------------------+
+                [...]
+
+``type`` field
+--------------
+
+In protocol version 3 only ``UCAN_OUT_TX`` is defined, others are used
+only by legacy devices (protocol version 1).
+
+UCAN_OUT_TX
+~~~~~~~~~~~
+``subtype``
+  echo id to be replied within a CAN_IN_TX_COMPLETE message
+
+Transmit a CAN frame. (parameters: ``id``, ``data``)
+
+Flow Control
+------------
+
+When the device outbound buffers are full it starts sending *NAKs* on
+the *OUT* pipe until more buffers are available. The driver stops the
+queue when a certain threshold of out packets are incomplete.
+
+.. _can_ucan_error_handling:
+
+CAN Error Handling
+==================
+
+If error reporting is turned on the device encodes errors into CAN
+error frames (see ``uapi/linux/can/error.h``) and sends it using the
+IN endpoint. The driver updates its error statistics and forwards
+it.
+
+Although UCAN devices can suppress error frames completely, in Linux
+the driver is always interested. Hence, the device is always started with
+the ``UCAN_MODE_BERR_REPORT`` set. Filtering those messages for the
+user space is done by the driver.
+
+Example Conversation
+====================
+
+#) Device is connected to USB
+#) Host sends command ``UCAN_COMMAND_RESET``, subcmd 0
+#) Host sends command ``UCAN_COMMAND_GET``, subcmd ``UCAN_COMMAND_GET_INFO``
+#) Device sends ``UCAN_IN_DEVICE_INFO``
+#) Host sends command ``UCAN_OUT_SET_BITTIMING``
+#) Host sends command ``UCAN_COMMAND_START``, subcmd 0, mode ``UCAN_MODE_BERR_REPORT``
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 90966c2692d8..18903968cebf 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -8,6 +8,7 @@ Contents:
 
    batman-adv
    can
+   can_ucan_protocol
    kapi
    z8530book
    msg_zerocopy
diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index c36f4bdcbf4f..490cdce1f1da 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -89,4 +89,14 @@ config CAN_MCBA_USB
 	  This driver supports the CAN BUS Analyzer interface
 	  from Microchip (http://www.microchip.com/development-tools/).
 
+config CAN_UCAN
+	tristate "Theobroma Systems UCAN interface"
+	---help---
+	  This driver supports the Theobroma Systems
+	  UCAN USB-CAN interface.
+
+	  UCAN is an microcontroller-based USB-CAN interface that
+	  is integrated on System-on-Modules made by Theobroma Systems
+	  (https://www.theobroma-systems.com/som-products).
+
 endmenu
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index 49ac7b99ba32..4176e8358232 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
 obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
 obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
+obj-$(CONFIG_CAN_UCAN) += ucan.o
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
new file mode 100644
index 000000000000..61348e8c4747
--- /dev/null
+++ b/drivers/net/can/usb/ucan.c
@@ -0,0 +1,1587 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Driver for Theobroma Systems UCAN devices Protocol Version 3
+ *
+ * Copyright (C) 2018 Theobroma Systems Design und Consulting GmbH
+ *
+ *
+ * General Description:
+ *
+ * The USB Device uses three Endpoints:
+ *
+ *   CONTROL Endpoint: Is used the setup the device (start, stop,
+ *   info, configure).
+ *
+ *   IN Endpoint: The device sends CAN Frame Messages and Device
+ *   Information using the IN endpoint.
+ *
+ *   OUT Endpoint: The driver sends configuration requests, and CAN
+ *   Frames on the out endpoint.
+ *
+ * Error Handling:
+ *
+ *   If error reporting is turned on the device encodes error into CAN
+ *   error frames (see uapi/linux/can/error.h) and sends it using the
+ *   IN Endpoint. The driver updates statistics and forward it.
+ */
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/signal.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+#define UCAN_MAX_RX_URBS 8
+/* the CAN controller needs a while to enable/disable the bus */
+#define UCAN_USB_CTL_PIPE_TIMEOUT 1000
+/* this driver currently supports protocol version 3 only */
+#define UCAN_PROTOCOL_VERSION_MIN 3
+#define UCAN_PROTOCOL_VERSION_MAX 3
+
+/* UCAN Message Definitions --------------------------------------------
+ *
+ *  ucan_message_out_t and ucan_message_in_t define the messages
+ *  transmitted on the OUT and IN endpoint.
+ *
+ *  Multibyte fields are transmitted with little endianness
+ *
+ *  INTR Endpoint: a single uint32_t storing the current space in the fifo
+ *
+ *  OUT Endpoint: single message of type ucan_message_out_t is
+ *    transmitted on the out endpoint
+ *
+ *  IN Endpoint: multiple messages ucan_message_in_t concateted in
+ *    the following way:
+ *
+ *	m[n].len <=> the length if message n(including the header in bytes)
+ *	m[n] is is aligned to a 4 byte boundary, hence
+ *	  offset(m[0])	 := 0;
+ *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
+ *
+ *	this implies that
+ *	  offset(m[n]) % 4 <=> 0
+ */
+
+/* Device Global Commands */
+enum {
+	UCAN_DEVICE_GET_FW_STRING = 0,
+};
+
+/* UCAN Commands */
+enum {
+	/* start the can transceiver - val defines the operation mode */
+	UCAN_COMMAND_START    = 0,
+	/* cancel pending transmissions and stop the can transceiver */
+	UCAN_COMMAND_STOP     = 1,
+	/* send can transceiver into low-power sleep mode */
+	UCAN_COMMAND_SLEEP    = 2,
+	/* wake up can transceiver from low-power sleep mode */
+	UCAN_COMMAND_WAKEUP   = 3,
+	/* reset the can transceiver */
+	UCAN_COMMAND_RESET    = 4,
+	/* get piece of info from the can transceiver - subcmd defines what
+	 * piece
+	 */
+	UCAN_COMMAND_GET      = 5,
+	/* clear or disable hardware filter - subcmd defines which of the two */
+	UCAN_COMMAND_FILTER   = 6,
+	/* Setup bittiming */
+	UCAN_COMMAND_SET_BITTIMING = 7,
+	/* recover from bus-off state */
+	UCAN_COMMAND_RESTART  = 8,
+};
+
+/* UCAN_COMMAND_START and UCAN_COMMAND_GET_INFO operation modes (bitmap).
+ * Undefined bits must be set to 0.
+ */
+enum {
+	UCAN_MODE_LOOPBACK    = (1 << 0),
+	UCAN_MODE_SILENT      = (1 << 1),
+	UCAN_MODE_3_SAMPLES   = (1 << 2),
+	UCAN_MODE_ONE_SHOT    = (1 << 3),
+	UCAN_MODE_BERR_REPORT = (1 << 4),
+};
+
+/* UCAN_COMMAND_GET subcommands */
+enum {
+	UCAN_COMMAND_GET_INFO             = 0,
+	UCAN_COMMAND_GET_PROTOCOL_VERSION = 1,
+};
+
+/* UCAN_COMMAND_FILTER subcommands */
+enum {
+	UCAN_FILTER_CLEAR     = 0,
+	UCAN_FILTER_DISABLE   = 1,
+	UCAN_FILTER_ENABLE    = 2,
+};
+
+/* OUT endpoint message types */
+enum {
+	UCAN_OUT_TX = 2, /* transmit a CAN frame */
+};
+
+/* IN endpoint message types */
+enum {
+	UCAN_IN_TX_COMPLETE = 1,  /* CAN frame transmission completed */
+	UCAN_IN_RX          = 2,  /* CAN frame received */
+};
+
+struct ucan_ctl_cmd_start {
+	u16 mode;            /* oring any of UCAN_MODE_* */
+} __packed;
+
+struct ucan_ctl_cmd_set_bittiming {
+	u32 tq;		     /* Time quanta (TQ) in nanoseconds */
+	u16 brp;	     /* TQ Prescaler */
+	u16 sample_point;    /* Samplepoint on tenth percent */
+	u8 prop_seg;	     /* Propagation segment in TQs */
+	u8 phase_seg1;	     /* Phase buffer segment 1 in TQs */
+	u8 phase_seg2;	     /* Phase buffer segment 2 in TQs */
+	u8 sjw;		     /* Synchronisation jump width in TQs */
+} __packed;
+
+struct ucan_ctl_cmd_device_info {
+	u32 freq;   /* Clock Frequency for tq generation */
+	u8 tx_fifo; /* Size of the transmission fifo */
+	u8 sjw_max;   /* can_bittiming fields... */
+	u8 tseg1_min;
+	u8 tseg1_max;
+	u8 tseg2_min;
+	u8 tseg2_max;
+	u16 brp_inc;
+	u32 brp_min;
+	u32 brp_max; /* ...can_bittiming fields */
+	u16 ctrlmodes; /* supported control modes */
+	u16 hwfilter;  /* Number of HW filter banks */
+	u16 rxmboxes;  /* Number of receive Mailboxes */
+} __packed;
+
+struct ucan_ctl_cmd_get_protocol_version {
+	u32 version;
+} __packed;
+
+union ucan_ctl_payload {
+	/***************************************************
+	 * Setup Bittiming
+	 * bmRequest == UCAN_COMMAND_START
+	 ***************************************************/
+	struct ucan_ctl_cmd_start cmd_start;
+	/***************************************************
+	 * Setup Bittiming
+	 * bmRequest == UCAN_COMMAND_SET_BITTIMING
+	 ***************************************************/
+	struct ucan_ctl_cmd_set_bittiming cmd_set_bittiming;
+	/***************************************************
+	 * Get Device Information
+	 * bmRequest == UCAN_COMMAND_GET; wValue = UCAN_COMMAND_GET_INFO
+	 ***************************************************/
+	struct ucan_ctl_cmd_device_info cmd_get_device_info;
+	/***************************************************
+	 * Get Protocol Version
+	 * bmRequest == UCAN_COMMAND_GET;
+	 * wValue = UCAN_COMMAND_GET_PROTOCOL_VERSION
+	 ***************************************************/
+	struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
+
+	u8 raw[128];
+} __packed;
+
+enum {
+	UCAN_TX_COMPLETE_SUCCESS = (1 << 0),
+};
+
+/* Transmission Complete within ucan_message_in */
+struct ucan_tx_complete_entry_t {
+	u8 echo_id;
+	u8 flags;
+}  __packed __aligned(0x2);
+
+/* CAN Data message format within ucan_message_in/out */
+struct ucan_can_msg {
+	/* note DLC is computed by
+	 *    msg.len - sizeof (msg.len)
+	 *	       - sizeof (msg.type)
+	 *	       - sizeof (msg.can_msg.id)
+	 */
+	u32 id;
+
+	union {
+		u8 data[CAN_MAX_DLEN];  /* Data of CAN frames */
+		u8 dlc;                 /* RTR dlc */
+	};
+} __packed;
+
+/* OUT Endpoint, outbound messages */
+struct ucan_message_out {
+	u16 len;  /* Length of the content include header */
+	u8  type; /* UCAN_OUT_TX and friends */
+	u8  subtype; /* command sub type */
+	union {
+		/***************************************************
+		 * Transmit CAN frame
+		 * (type == UCAN_TX) && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
+		 * subtype stores the echo id
+		 ***************************************************/
+		struct ucan_can_msg can_msg;
+	} msg;
+} __packed __aligned(0x4);
+
+/* IN Endpoint, inbound messages */
+struct ucan_message_in {
+	u16 len;     /* Length of the content include header */
+	u8  type;    /* UCAN_IN_RX and friends */
+	u8  subtype; /* command sub type */
+
+	union {
+		/***************************************************
+		 * CAN Frame received
+		 * (type == UCAN_IN_RX)
+		 * && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
+		 ***************************************************/
+		struct ucan_can_msg can_msg;
+
+		/***************************************************
+		 * CAN transmission complete
+		 * (type == UCAN_IN_TX_COMPLETE)
+		 ***************************************************/
+		struct ucan_tx_complete_entry_t can_tx_complete_msg[0];
+
+	} __aligned(0x4) msg;
+} __packed;
+
+/* Macros to calculate message lengths */
+#define UCAN_OUT_HDR_SIZE offsetof(struct ucan_message_out, msg)
+
+#define UCAN_IN_HDR_SIZE offsetof(struct ucan_message_in, msg)
+#define UCAN_IN_LEN(member) (UCAN_OUT_HDR_SIZE + sizeof(member))
+
+struct ucan_priv;
+
+/* Context Information for transmission URBs */
+struct ucan_urb_context {
+	struct ucan_priv *up;
+	u32 echo_index;
+	u8 dlc;
+	atomic_t allocated;
+};
+
+/* Information reported by the USB device */
+struct ucan_device_info {
+	struct can_bittiming_const bittiming_const;
+	u8 tx_fifo;
+};
+
+/* Driver private data */
+struct ucan_priv {
+	struct can_priv can; /* must be the first member */
+
+	u8 intf_index;
+	struct usb_device *udev;
+	struct usb_interface *intf;
+	struct net_device *netdev;
+
+	struct usb_endpoint_descriptor *out_ep;
+	struct usb_endpoint_descriptor *in_ep;
+
+	struct usb_anchor rx_urbs;
+	struct usb_anchor tx_urbs;
+
+	union ucan_ctl_payload *ctl_msg_buffer;
+	struct ucan_device_info device_info;
+
+	atomic_t available_tx_urbs;
+	struct ucan_urb_context *tx_contexts;
+};
+
+static u8 ucan_compute_dlc(u16 len, struct ucan_can_msg *msg)
+{
+	u16 res = 0;
+
+	if (msg->id & CAN_RTR_FLAG)
+		res = msg->dlc;
+	else
+		res = len - (UCAN_IN_HDR_SIZE + sizeof(msg->id));
+
+	if (res > CAN_MAX_DLEN)
+		return -1;
+
+	return res;
+}
+
+static void ucan_release_contexts(struct ucan_priv *up)
+{
+	if (!up->tx_contexts)
+		return;
+
+	atomic_set(&up->available_tx_urbs, 0);
+
+	kfree(up->tx_contexts);
+	up->tx_contexts = NULL;
+}
+
+static int ucan_allocate_contexts(struct ucan_priv *up)
+{
+	int i;
+
+	/* release contexts if any */
+	ucan_release_contexts(up);
+
+	up->tx_contexts = kmalloc_array(up->device_info.tx_fifo,
+					sizeof(*up->tx_contexts),
+					GFP_KERNEL);
+	if (!up->tx_contexts) {
+		dev_err(&up->udev->dev, "Not enough memory to allocate tx contexts\n");
+		return -ENOMEM;
+	}
+
+	memset(up->tx_contexts, 0,
+	       sizeof(*up->tx_contexts) * up->device_info.tx_fifo);
+	for (i = 0; i < up->device_info.tx_fifo; i++) {
+		atomic_set(&up->tx_contexts[i].allocated, 0);
+		up->tx_contexts[i].up = up;
+		up->tx_contexts[i].echo_index = i;
+	}
+
+	atomic_set(&up->available_tx_urbs, up->device_info.tx_fifo);
+
+	return 0;
+}
+
+static struct ucan_urb_context *ucan_allocate_context(struct ucan_priv *up)
+{
+	int i, allocated, avail;
+
+	if (!up->tx_contexts)
+		return NULL;
+
+	for (i = 0; i < up->device_info.tx_fifo; i++) {
+		allocated = atomic_cmpxchg(&up->tx_contexts[i].allocated, 0, 1);
+		if (allocated == 0) {
+			avail = atomic_sub_return(1, &up->available_tx_urbs);
+			if (avail == 0)
+				netif_stop_queue(up->netdev);
+			return &up->tx_contexts[i];
+		}
+	}
+	return NULL;
+}
+
+static void ucan_release_context(struct ucan_priv *up,
+				 struct ucan_urb_context *ctx)
+{
+	WARN_ON_ONCE(!up->tx_contexts);
+	if (!up->tx_contexts)
+		return;
+
+	if (atomic_cmpxchg(&ctx->allocated, 1, 0) == 0) {
+		dev_warn(&up->udev->dev,
+			 "context %p (#%ld) was not allocated\n",
+			 ctx, ctx - up->tx_contexts);
+	} else {
+		atomic_inc(&up->available_tx_urbs);
+		netif_wake_queue(up->netdev);
+	}
+}
+
+static int ucan_ctrl_command_out(struct ucan_priv *up,
+				 u8 cmd,
+				 u16 subcmd,
+				 size_t datalen)
+{
+	if (datalen > sizeof(union ucan_ctl_payload))
+		return -ENOMEM;
+
+	return usb_control_msg(up->udev,
+			usb_sndctrlpipe(up->udev, 0),
+			cmd,
+			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			cpu_to_le16(subcmd),
+			up->intf_index,
+			up->ctl_msg_buffer,
+			datalen,
+			UCAN_USB_CTL_PIPE_TIMEOUT);
+}
+
+static int ucan_device_request_in(struct ucan_priv *up,
+				  u8 cmd,
+				  u16 subcmd,
+				  size_t datalen)
+{
+	if (datalen > sizeof(union ucan_ctl_payload))
+		return -ENOMEM;
+
+	return usb_control_msg(up->udev,
+			usb_rcvctrlpipe(up->udev, 0),
+			cmd,
+			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			cpu_to_le16(subcmd),
+			0,
+			up->ctl_msg_buffer,
+			datalen,
+			UCAN_USB_CTL_PIPE_TIMEOUT);
+}
+
+/* Parse the device information structure reported by the device and
+ * setup private variables accordingly
+ */
+static void ucan_parse_device_info(struct ucan_priv *up,
+				   struct ucan_ctl_cmd_device_info
+					*ctl_cmd_device_info)
+{
+	struct can_bittiming_const *bittiming =
+		&up->device_info.bittiming_const;
+	u16 ctrlmodes;
+
+	/* store the data */
+	up->can.clock.freq = le32_to_cpu(ctl_cmd_device_info->freq);
+	up->device_info.tx_fifo = ctl_cmd_device_info->tx_fifo;
+	strcpy(bittiming->name, "ucan");
+	bittiming->tseg1_min = ctl_cmd_device_info->tseg1_min;
+	bittiming->tseg1_max = ctl_cmd_device_info->tseg1_max;
+	bittiming->tseg2_min = ctl_cmd_device_info->tseg2_min;
+	bittiming->tseg2_max = ctl_cmd_device_info->tseg2_max;
+	bittiming->sjw_max = ctl_cmd_device_info->sjw_max;
+	bittiming->brp_min = le32_to_cpu(ctl_cmd_device_info->brp_min);
+	bittiming->brp_max = le32_to_cpu(ctl_cmd_device_info->brp_max);
+	bittiming->brp_inc = le16_to_cpu(ctl_cmd_device_info->brp_inc);
+
+	ctrlmodes = le16_to_cpu(ctl_cmd_device_info->ctrlmodes);
+
+	up->can.ctrlmode_supported = 0;
+
+	if (ctrlmodes & UCAN_MODE_LOOPBACK)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
+	if (ctrlmodes & UCAN_MODE_SILENT)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
+	if (ctrlmodes & UCAN_MODE_3_SAMPLES)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+	if (ctrlmodes & UCAN_MODE_ONE_SHOT)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
+	if (ctrlmodes & UCAN_MODE_BERR_REPORT)
+		up->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
+}
+
+/* Handle a CAN error frame that we have received from the device */
+static void ucan_handle_error_frame(struct ucan_priv *up,
+				    struct ucan_message_in *m,
+				    u32 canid)
+{
+	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
+	struct net_device_stats *net_stats = &up->netdev->stats;
+	struct can_device_stats *can_stats = &up->can.can_stats;
+
+	if (canid & CAN_ERR_LOSTARB)
+		can_stats->arbitration_lost++;
+
+	if (canid & CAN_ERR_BUSERROR)
+		can_stats->bus_error++;
+
+	if (canid & CAN_ERR_ACK)
+		net_stats->tx_errors++;
+
+	if (canid & CAN_ERR_BUSOFF)
+		new_state = CAN_STATE_BUS_OFF;
+
+	/* controller problems, details in data[1] */
+	if (canid & CAN_ERR_CRTL) {
+		u8 d1 = m->msg.can_msg.data[1];
+
+		if (d1 & (CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE))
+			new_state = max(new_state, (enum can_state)
+					CAN_STATE_ERROR_PASSIVE);
+
+		if (d1 & (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING))
+			new_state = max(new_state, (enum can_state)
+					CAN_STATE_ERROR_WARNING);
+
+		if (d1 & CAN_ERR_CRTL_RX_OVERFLOW)
+			net_stats->rx_over_errors++;
+	}
+
+	/* protocol error, details in data[2] */
+	if (canid & CAN_ERR_PROT) {
+		u8 d2 = m->msg.can_msg.data[2];
+
+		if (d2 & CAN_ERR_PROT_TX)
+			net_stats->tx_errors++;
+		else
+			net_stats->rx_errors++;
+	}
+
+	/* we switched into a better state */
+	if (up->can.state >= new_state) {
+		up->can.state = new_state;
+		return;
+	}
+
+	/* we switched into a worse state */
+	up->can.state = new_state;
+	switch (new_state) {
+	case CAN_STATE_BUS_OFF:
+		can_stats->bus_off++;
+		can_bus_off(up->netdev);
+		netdev_info(up->netdev,
+			    "link has gone into BUS-OFF state\n");
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		can_stats->error_passive++;
+		break;
+	case CAN_STATE_ERROR_WARNING:
+		can_stats->error_warning++;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Callback on reception of a can frame via the IN endpoint
+ *
+ * This function allocates an skb and transferres it to the Linux
+ * network stack
+ */
+static void ucan_rx_can_msg(struct ucan_priv *up, struct ucan_message_in *m)
+{
+	int len;
+	u32 canid;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	struct net_device_stats *stats = &up->netdev->stats;
+
+	/* get the contents of the length field */
+	len = le16_to_cpu(m->len);
+
+	/* check sanity */
+	if (len < UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id)) {
+		dev_warn(&up->udev->dev, "invalid input message len\n");
+		return;
+	}
+
+	/* handle error frames */
+	canid = le32_to_cpu(m->msg.can_msg.id);
+	if (canid & CAN_ERR_FLAG) {
+		ucan_handle_error_frame(up, m, canid);
+		/* drop frame if berr-reporting is off */
+		if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+			return;
+	}
+
+	/* allocate skb */
+	skb = alloc_can_skb(up->netdev, &cf);
+	if (!skb)
+		return;
+
+	/* fill the can frame */
+	cf->can_id = le32_to_cpu(m->msg.can_msg.id);
+
+	/* compute DLC taking RTR_FLAG into account */
+	cf->can_dlc = ucan_compute_dlc(len, &m->msg.can_msg);
+
+	if (cf->can_dlc > CAN_MAX_DLEN) {
+		dev_warn(&up->udev->dev,
+			 "dropping CAN frame due to DLC field\n");
+		goto err_freeskb;
+	}
+
+	if (cf->can_id & CAN_EFF_FLAG)
+		cf->can_id &=
+		    (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_ERR_FLAG);
+	else
+		cf->can_id &= (CAN_SFF_MASK | CAN_RTR_FLAG | CAN_ERR_FLAG);
+
+	if ((cf->can_id & CAN_RTR_FLAG) != CAN_RTR_FLAG)
+		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
+
+	/* don't count error frames as real packets */
+	if (!(canid & CAN_ERR_FLAG)) {
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+	}
+
+	/* pass it to Linux */
+	netif_rx(skb);
+
+	return;
+err_freeskb:
+	kfree_skb(skb);
+}
+
+/* callback indicating completed transmission */
+static void ucan_tx_complete_msg(struct ucan_priv *up,
+				 struct ucan_message_in *m)
+{
+	u16 count, i;
+	u8 echo_id;
+	u16 len = le16_to_cpu(m->len);
+
+	struct ucan_urb_context *context;
+
+	if (len < UCAN_IN_HDR_SIZE || (len % 2 != 0)) {
+		dev_dbg(&up->udev->dev, "%s Invalid tx complete length\n",
+			__func__);
+	}
+
+	count = (len - UCAN_IN_HDR_SIZE) / 2;
+	for (i = 0; i < count; i++) {
+		/* we did not submit such echo ids */
+		echo_id = m->msg.can_tx_complete_msg[i].echo_id;
+		if (echo_id >= up->device_info.tx_fifo) {
+			up->netdev->stats.tx_errors++;
+			dev_err(&up->udev->dev,
+				"device answered with invalid echo_id\n");
+			continue;
+		}
+
+		context = &up->tx_contexts[echo_id];
+		if (atomic_read(&context->allocated) == 0) {
+			dev_err(&up->udev->dev,
+				"device answered with unallocated echo id %d\n",
+				echo_id);
+			continue;
+		}
+
+		if (m->msg.can_tx_complete_msg[i].flags &
+		    UCAN_TX_COMPLETE_SUCCESS) {
+			/* update statistics */
+			up->netdev->stats.tx_packets++;
+			up->netdev->stats.tx_bytes += context->dlc;
+			can_get_echo_skb(up->netdev, context->echo_index);
+		} else {
+			up->netdev->stats.tx_dropped++;
+			can_free_echo_skb(up->netdev, context->echo_index);
+		}
+
+		/* Release context and restart queue if necessary */
+		ucan_release_context(up, context);
+	}
+}
+
+/* callback on reception of a USB message */
+static void ucan_read_bulk_callback(struct urb *urb)
+{
+	int ret;
+	int pos;
+	struct ucan_priv *up = urb->context;
+	struct net_device *netdev = up->netdev;
+	struct ucan_message_in *m;
+
+	/* the device is not up and the driver should not receive any
+	 * data on the bulk in pipe
+	 */
+	WARN_ON(!up->tx_contexts);
+	if (!up->tx_contexts) {
+		usb_free_coherent(up->udev,
+				  up->in_ep->wMaxPacketSize,
+				  urb->transfer_buffer,
+				  urb->transfer_dma);
+		return;
+	}
+
+	/* check URB status */
+	switch (urb->status) {
+	case 0:
+		break;
+	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
+	case -ESHUTDOWN:
+	case -ETIME:
+		/* urb is not resubmitted -> free dma data */
+		usb_free_coherent(up->udev,
+				  up->in_ep->wMaxPacketSize,
+				  urb->transfer_buffer,
+				  urb->transfer_dma);
+		dev_dbg(&up->udev->dev, "%s ENOENT|ESHUTDOWN|ETIME\n",
+			__func__);
+		return;
+	default:
+		goto resubmit;
+	}
+
+	/* sanity check */
+	if (!netif_device_present(netdev))
+		return;
+
+	/* iterate over input */
+	pos = 0;
+	while (pos < urb->actual_length) {
+		int len;
+
+		/* check sanity (length of header) */
+		if ((urb->actual_length - pos) < UCAN_IN_HDR_SIZE) {
+			dev_warn(&up->udev->dev,
+				 "invalid input message %d; too short (no header)\n",
+				 urb->actual_length);
+			goto resubmit;
+		}
+
+		/* setup the message address */
+		m = (struct ucan_message_in *)
+			((u8 *)urb->transfer_buffer + pos);
+		len = le16_to_cpu(m->len);
+
+		/* check sanity (length of content) */
+		if (urb->actual_length - pos < len) {
+			dev_warn(&up->udev->dev, "invalid input message al:%d pos:%d len:%d; too short (no data)\n",
+				 urb->actual_length, pos, len);
+			print_hex_dump(KERN_WARNING,
+				       "raw data: ",
+				       DUMP_PREFIX_ADDRESS,
+				       16,
+				       1,
+				       urb->transfer_buffer,
+				       urb->actual_length,
+				       true);
+
+			goto resubmit;
+		}
+
+		switch (le16_to_cpu(m->type)) {
+		case UCAN_IN_RX:
+			ucan_rx_can_msg(up, m);
+			break;
+		case UCAN_IN_TX_COMPLETE:
+			ucan_tx_complete_msg(up, m);
+			break;
+		default:
+			dev_warn(&up->udev->dev,
+				 "invalid input message type\n");
+			break;
+		}
+
+		/* proceed to next message */
+		pos += len;
+		/* align to 4 byte boundary */
+		pos = round_up(pos, 4);
+	}
+
+resubmit:
+	/* resubmit urb when done */
+	usb_fill_bulk_urb(urb, up->udev,
+			  usb_rcvbulkpipe(up->udev,
+					  up->in_ep->bEndpointAddress &
+						USB_ENDPOINT_NUMBER_MASK),
+			  urb->transfer_buffer,
+			  up->in_ep->wMaxPacketSize,
+			  ucan_read_bulk_callback,
+			  up);
+
+	usb_anchor_urb(urb, &up->rx_urbs);
+	ret = usb_submit_urb(urb, GFP_KERNEL);
+
+	if (ret < 0) {
+		dev_err(&up->udev->dev,
+			"failed resubmitting read bulk urb: %d\n", ret);
+
+		usb_unanchor_urb(urb);
+		usb_free_coherent(up->udev, up->in_ep->wMaxPacketSize,
+				  urb->transfer_buffer,
+				  urb->transfer_dma);
+
+		if (ret == -ENODEV)
+			netif_device_detach(netdev);
+	}
+}
+
+/* callback after transmission of a USB message */
+static void ucan_write_bulk_callback(struct urb *urb)
+{
+	struct ucan_urb_context *context = urb->context;
+	struct ucan_priv *up;
+
+	/* get the urb context */
+	WARN_ON_ONCE(!context);
+	if (!context)
+		return;
+
+	/* free up our allocated buffer */
+	usb_free_coherent(urb->dev,
+			  sizeof(struct ucan_message_out),
+			  urb->transfer_buffer,
+			  urb->transfer_dma);
+
+	up = context->up;
+	WARN_ON_ONCE(!up);
+	if (!up)
+		return;
+
+	/* sanity check */
+	if (!netif_device_present(up->netdev))
+		return;
+
+	/* transmission failed (USB - the device will not send a TX complete) */
+	if (urb->status) {
+		dev_warn_once(&up->udev->dev,
+			      "failed to transmit USB message to device: %d\n",
+			      urb->status);
+
+		/* update counters an cleanup */
+		can_free_echo_skb(up->netdev, context->echo_index);
+
+		up->netdev->stats.tx_dropped++;
+
+		/* release context and restart the queue if necessary */
+		ucan_release_context(up, context);
+	}
+}
+
+static void ucan_cleanup_rx_urbs(struct ucan_priv *up, struct urb **urbs)
+{
+	int i;
+
+	for (i = 0; i < UCAN_MAX_RX_URBS; i++) {
+		if (urbs[i]) {
+			usb_unanchor_urb(urbs[i]);
+			usb_free_coherent(up->udev, up->in_ep->wMaxPacketSize,
+					  urbs[i]->transfer_buffer,
+					  urbs[i]->transfer_dma);
+			usb_free_urb(urbs[i]);
+		}
+	}
+
+	memset(urbs, 0, sizeof(*urbs) * UCAN_MAX_RX_URBS);
+}
+
+static int ucan_prepare_and_anchor_rx_urbs(struct ucan_priv *up,
+					   struct urb **urbs)
+{
+	int i;
+
+	memset(urbs, 0, sizeof(*urbs) * UCAN_MAX_RX_URBS);
+
+	for (i = 0; i < UCAN_MAX_RX_URBS; i++) {
+		void *buf;
+
+		urbs[i] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urbs[i])
+			goto err;
+
+		buf = usb_alloc_coherent(up->udev, up->in_ep->wMaxPacketSize,
+					 GFP_KERNEL, &urbs[i]->transfer_dma);
+		if (!buf) {
+			/* cleanup this urb */
+			usb_free_urb(urbs[i]);
+			urbs[i] = NULL;
+			goto err;
+		}
+
+		usb_fill_bulk_urb(urbs[i], up->udev,
+				  usb_rcvbulkpipe(up->udev,
+						  up->in_ep->bEndpointAddress &
+						  USB_ENDPOINT_NUMBER_MASK),
+				  buf,
+				  up->in_ep->wMaxPacketSize,
+				  ucan_read_bulk_callback,
+				  up);
+
+		urbs[i]->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+		usb_anchor_urb(urbs[i], &up->rx_urbs);
+	}
+	return 0;
+
+err:
+	/* cleanup other unsubmitted urbs */
+	ucan_cleanup_rx_urbs(up, urbs);
+	return -ENOMEM;
+}
+
+/* Submits rx urbs with the semantic: Either submit all, or cleanup
+ * everything. I case of errors submitted urbs are killed and all urbs in
+ * the array are freed. I case of no errors every entry in the urb
+ * array is set to NULL.
+ */
+static int ucan_submit_rx_urbs(struct ucan_priv *up, struct urb **urbs)
+{
+	int i, ret;
+
+	/* Iterate over all urbs to submit. On success remove the urb
+	 * from the list.
+	 */
+	for (i = 0; i < UCAN_MAX_RX_URBS; i++) {
+		ret = usb_submit_urb(urbs[i], GFP_KERNEL);
+		if (ret) {
+			dev_err(&up->udev->dev,
+				"Could not submit urb; code: %d\n", ret);
+			goto err;
+		}
+
+		/* Anchor URB and drop reference, USB core will take
+		 * care of freeing it
+		 */
+		usb_free_urb(urbs[i]);
+		urbs[i] = NULL;
+	}
+	return 0;
+
+err:
+	/* Cleanup unsubmitted urbs */
+	ucan_cleanup_rx_urbs(up, urbs);
+
+	/* Kill urbs that are already submitted */
+	usb_kill_anchored_urbs(&up->rx_urbs);
+
+	return ret;
+}
+
+/* Open the network device */
+static int ucan_open(struct net_device *netdev)
+{
+	int ret, ret_cleanup;
+	u16 ctrlmode;
+	struct urb *urbs[UCAN_MAX_RX_URBS];
+	struct ucan_priv *up = netdev_priv(netdev);
+
+	ret = ucan_allocate_contexts(up);
+	if (ret)
+		goto err;
+
+	/* Allocate and prepare IN URBS - allocated and anchored
+	 * urbs are stored in urbs[] for clean
+	 */
+	ret = ucan_prepare_and_anchor_rx_urbs(up, urbs);
+	if (ret)
+		goto err_contexts;
+
+	/* Check the control mode */
+	ctrlmode = 0;
+	if (up->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		ctrlmode |= UCAN_MODE_LOOPBACK;
+	if (up->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		ctrlmode |= UCAN_MODE_SILENT;
+	if (up->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		ctrlmode |= UCAN_MODE_3_SAMPLES;
+	if (up->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		ctrlmode |= UCAN_MODE_ONE_SHOT;
+
+	/* Enable this in any case - filtering is down within the
+	 * receive path
+	 */
+	ctrlmode |= UCAN_MODE_BERR_REPORT;
+	up->ctl_msg_buffer->cmd_start.mode =  cpu_to_le16(ctrlmode);
+
+	/* Driver is ready to receive data - start the USB device */
+	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_START, 0, 2);
+	if (ret < 0) {
+		dev_err(&up->udev->dev,
+			"Could not start UCAN device, code: %d\n",
+			ret);
+		goto err_reset;
+	}
+
+	/* Call CAN layer open */
+	ret = open_candev(netdev);
+	if (ret)
+		goto err_stop;
+
+	/* Driver is ready to receive data. Submit RX URBS */
+	ret = ucan_submit_rx_urbs(up, urbs);
+	if (ret)
+		goto err_stop;
+
+	up->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	/* Start the network queue */
+	netif_start_queue(netdev);
+
+	return 0;
+
+err_stop:
+	/* The device have started already stop it */
+	ret_cleanup = ucan_ctrl_command_out(up, UCAN_COMMAND_STOP, 0, 0);
+	if (ret_cleanup < 0)
+		dev_err(&up->udev->dev,
+			"Could not stop UCAN device, code: %d\n",
+			ret_cleanup);
+
+err_reset:
+	/* The device might have received data, reset it for
+	 * consistent state
+	 */
+	ret_cleanup = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
+	if (ret_cleanup < 0)
+		dev_err(&up->udev->dev,
+			"Could not reset UCAN device, code: %d\n",
+			ret_cleanup);
+
+	/* clean up unsubmitted urbs */
+	ucan_cleanup_rx_urbs(up, urbs);
+
+err_contexts:
+	ucan_release_contexts(up);
+
+err:
+	return ret;
+}
+
+static struct urb *ucan_prepare_tx_urb(struct ucan_priv *up,
+				       struct ucan_urb_context *context,
+				       struct can_frame *cf)
+{
+	int mlen;
+	struct urb *urb;
+	struct ucan_message_out *m;
+
+	/* create a URB, and a buffer for it, and copy the data to the URB */
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		netdev_err(up->netdev, "No memory left for URBs\n");
+		return NULL;
+	}
+
+	m = usb_alloc_coherent(up->udev,
+			       sizeof(struct ucan_message_out),
+			       GFP_ATOMIC,
+			       &urb->transfer_dma);
+	if (!m) {
+		netdev_err(up->netdev, "No memory left for USB buffer\n");
+		usb_free_urb(urb);
+		return NULL;
+	}
+
+	/* build the USB message */
+	m->type = UCAN_OUT_TX;
+	m->msg.can_msg.id = cpu_to_le32(cf->can_id);
+
+	if (cf->can_id & CAN_RTR_FLAG) {
+		mlen = UCAN_OUT_HDR_SIZE +
+			offsetof(struct ucan_can_msg, dlc) +
+			sizeof(m->msg.can_msg.dlc);
+		m->msg.can_msg.dlc = cf->can_dlc;
+	} else {
+		mlen = UCAN_OUT_HDR_SIZE +
+			sizeof(m->msg.can_msg.id) + cf->can_dlc;
+		memcpy(m->msg.can_msg.data, cf->data, cf->can_dlc);
+	}
+	m->len = cpu_to_le16(mlen);
+
+	context->dlc = cf->can_dlc;
+
+	m->subtype = context->echo_index;
+
+	/* build the urb */
+	usb_fill_bulk_urb(urb, up->udev,
+			  usb_sndbulkpipe(up->udev,
+					  up->out_ep->bEndpointAddress &
+					  USB_ENDPOINT_NUMBER_MASK),
+			  m, mlen, ucan_write_bulk_callback, context);
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	return urb;
+}
+
+static void ucan_clean_up_tx_urb(struct ucan_priv *up, struct urb *urb)
+{
+	usb_free_coherent(up->udev, sizeof(struct ucan_message_out),
+			  urb->transfer_buffer, urb->transfer_dma);
+	usb_free_urb(urb);
+}
+
+/* callback when Linux needs to send a can frame */
+static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
+				   struct net_device *netdev)
+{
+	int ret;
+	struct urb *urb;
+	struct ucan_urb_context *context;
+	struct ucan_priv *up = netdev_priv(netdev);
+	struct can_frame *cf = (struct can_frame *)skb->data;
+
+	/* check skb */
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* allocate a context and slow down tx path, if fifo state is low */
+	context = ucan_allocate_context(up);
+
+	WARN_ON_ONCE(!context);
+	if (!context)
+		return NETDEV_TX_BUSY;
+
+	/* prepare urb for transmission */
+	urb = ucan_prepare_tx_urb(up, context, cf);
+	if (!urb)
+		goto drop;
+
+	/* put the skb on can loopback stack */
+	can_put_echo_skb(skb, up->netdev, context->echo_index);
+
+	/* transmit it */
+	usb_anchor_urb(urb, &up->tx_urbs);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+
+	/* cleanup urb */
+	if (ret) {
+		/* on error, clean up */
+		usb_unanchor_urb(urb);
+		ucan_clean_up_tx_urb(up, urb);
+		ucan_release_context(up, context);
+
+		/* remove the skb from the echo stack - this also
+		 * frees the skb
+		 */
+		can_free_echo_skb(up->netdev, context->echo_index);
+
+		if (ret == -ENODEV) {
+			netif_device_detach(up->netdev);
+		} else {
+			netdev_warn(up->netdev, "failed tx_urb %d\n", ret);
+			up->netdev->stats.tx_dropped++;
+		}
+		return NETDEV_TX_OK;
+	}
+
+	netif_trans_update(netdev);
+
+	/* release ref, as we do not need the urb anymore */
+	usb_free_urb(urb);
+
+	return NETDEV_TX_OK;
+
+drop:
+	ucan_release_context(up, context);
+	dev_kfree_skb(skb);
+	up->netdev->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
+/* Device goes down
+ *
+ * Clean up used resources
+ */
+static int ucan_close(struct net_device *netdev)
+{
+	int ret;
+	struct ucan_priv *up = netdev_priv(netdev);
+
+	up->can.state = CAN_STATE_STOPPED;
+
+	/* stop sending data */
+	usb_kill_anchored_urbs(&up->tx_urbs);
+
+	/* stop receiving data */
+	usb_kill_anchored_urbs(&up->rx_urbs);
+
+	/* stop and reset can device */
+	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_STOP, 0, 0);
+	if (ret < 0)
+		dev_err(&up->udev->dev,
+			"Could not stop UCAN device, code: %d\n", ret);
+
+	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
+	if (ret < 0)
+		dev_err(&up->udev->dev,
+			"Could not reset UCAN device, code: %d\n", ret);
+
+	netif_stop_queue(netdev);
+
+	ucan_release_contexts(up);
+
+	close_candev(up->netdev);
+	return 0;
+}
+
+/* CAN driver callbacks */
+static const struct net_device_ops ucan_netdev_ops = {
+	.ndo_open = ucan_open,
+	.ndo_stop = ucan_close,
+	.ndo_start_xmit = ucan_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+/* Request to set bittiming
+ *
+ * This function generates an USB set bittiming message and transmits
+ * it to the device
+ */
+static int ucan_set_bittiming(struct net_device *netdev)
+{
+	int ret;
+	struct ucan_priv *up = netdev_priv(netdev);
+	struct ucan_ctl_cmd_set_bittiming *cmd_set_bittiming;
+
+	cmd_set_bittiming = &up->ctl_msg_buffer->cmd_set_bittiming;
+	cmd_set_bittiming->tq = cpu_to_le32(up->can.bittiming.tq);
+	cmd_set_bittiming->brp = cpu_to_le16(up->can.bittiming.brp);
+	cmd_set_bittiming->sample_point =
+	    cpu_to_le32(up->can.bittiming.sample_point);
+	cmd_set_bittiming->prop_seg = up->can.bittiming.prop_seg;
+	cmd_set_bittiming->phase_seg1 = up->can.bittiming.phase_seg1;
+	cmd_set_bittiming->phase_seg2 = up->can.bittiming.phase_seg2;
+	cmd_set_bittiming->sjw = up->can.bittiming.sjw;
+
+	dev_dbg(&up->udev->dev,
+		"Setup bittiming\n"
+		"  bitrate: %d\n"
+		"  sample-point: %d\n"
+		"  tq: %d\n"
+		"  prop_seg: %d\n"
+		"  phase_seg1 %d\n"
+		"  phase_seg2 %d\n"
+		"  sjw %d\n"
+		"  brp %d\n",
+		up->can.bittiming.bitrate, up->can.bittiming.sample_point,
+		up->can.bittiming.tq, up->can.bittiming.prop_seg,
+		up->can.bittiming.phase_seg1, up->can.bittiming.phase_seg2,
+		up->can.bittiming.sjw, up->can.bittiming.brp);
+
+	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_SET_BITTIMING,
+				    0,
+				    sizeof(*cmd_set_bittiming));
+	return (ret < 0) ? ret : 0;
+}
+
+/* Restart the device to get it out of BUS-OFF state.
+ * Called when the user runs "ip link set can1 type can restart".
+ */
+static int ucan_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	int ret;
+	struct ucan_priv *up = netdev_priv(netdev);
+
+	switch (mode) {
+	case CAN_MODE_START:
+		dev_dbg(&up->udev->dev, "Restarting device");
+		ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESTART, 0, 0);
+
+		/* check if queue can be restarted */
+		if (atomic_read(&up->available_tx_urbs) > 0)
+			netif_wake_queue(up->netdev);
+
+		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/* Probe the device, reset it and gather general device information */
+static int ucan_probe(struct usb_interface *intf,
+		      const struct usb_device_id *id)
+{
+	int ret;
+	int i;
+	u32 protocol_version;
+	struct usb_device *udev;
+	struct net_device *netdev;
+	struct usb_host_interface *iface_desc;
+	struct ucan_priv *up;
+	struct usb_endpoint_descriptor *ep;
+	struct usb_endpoint_descriptor *out_ep;
+	struct usb_endpoint_descriptor *in_ep;
+	union ucan_ctl_payload *ctl_msg_buffer;
+	char firmware_str[sizeof(union ucan_ctl_payload) + 1];
+
+	udev = interface_to_usbdev(intf);
+
+	/**************************************
+	 * Stage 1 - Interface Parsing
+	 **************************************
+	 *
+	 * Identifie the device USB interface descriptor and its
+	 * endpoints. Probing is aborted on errors.
+	 */
+
+	/* check if the interface is sane */
+	ret = -ENODEV;
+	iface_desc = intf->cur_altsetting;
+	if (!iface_desc)
+		goto err;
+
+	/* interface sanity check */
+	if (iface_desc->desc.bNumEndpoints != 2) {
+		dev_err(&udev->dev,
+			"Incompatible (possibly old) interface. It must have 2 endpoints but has %d\n",
+			iface_desc->desc.bNumEndpoints);
+		goto err;
+	}
+
+	dev_info(&udev->dev, "Found UCAN device on interface #%d\n",
+		 iface_desc->desc.iInterface);
+
+	/* check interface endpoints */
+	in_ep = NULL;
+	out_ep = NULL;
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		ep = &iface_desc->endpoint[i].desc;
+
+		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
+		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+		     USB_ENDPOINT_XFER_BULK)) {
+			/* In Endpoint */
+			in_ep = ep;
+		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
+			    0) &&
+			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+			    USB_ENDPOINT_XFER_BULK)) {
+			/* Out Endpoint */
+			out_ep = ep;
+		}
+	}
+
+	/* check if interface is sane */
+	if (!in_ep || !out_ep) {
+		dev_err(&udev->dev, "invalid endpoint configuration\n");
+		goto err;
+	}
+	if (in_ep->wMaxPacketSize < sizeof(struct ucan_message_in)) {
+		dev_err(&udev->dev, "invalid in_ep MaxPacketSize\n");
+		goto err;
+	}
+	if (out_ep->wMaxPacketSize < sizeof(struct ucan_message_out)) {
+		dev_err(&udev->dev, "invalid out_ep MaxPacketSize\n");
+		goto err;
+	}
+
+	/**************************************
+	 * Stage 2 - Device Identification
+	 **************************************
+	 *
+	 * The device interface seems to be a ucan device. Do further
+	 * compatibility checks. On error probing is aborted, on
+	 * success this stage leaves the ctl_msg_buffer with the
+	 * reported contents of a GET_INFO command (supported
+	 * bittimings, tx_fifo depth). This information is used in
+	 * Stage 3 for the final driver initialisation.
+	 */
+
+	/* Prepare Memory for control transferes */
+	ctl_msg_buffer =
+		devm_kzalloc(&udev->dev, sizeof(union ucan_ctl_payload),
+			     GFP_KERNEL);
+	if (!ctl_msg_buffer)
+		goto err;
+
+	/* get protocol version
+	 *
+	 * note: ucan_ctrl_command_* wrappers connot be used yet
+	 * because `up` is initialised in Stage 3
+	 */
+	ret = usb_control_msg(udev,
+			      usb_rcvctrlpipe(udev, 0),
+			      UCAN_COMMAND_GET,
+			      USB_DIR_IN | USB_TYPE_VENDOR |
+				USB_RECIP_INTERFACE,
+			      cpu_to_le16(UCAN_COMMAND_GET_PROTOCOL_VERSION),
+			      iface_desc->desc.bInterfaceNumber,
+			      ctl_msg_buffer,
+			      sizeof(union ucan_ctl_payload),
+			      UCAN_USB_CTL_PIPE_TIMEOUT);
+
+	/* older firmware version do not support this command - those
+	 * are not supported by this drive
+	 */
+	if (ret != 4) {
+		dev_err(&udev->dev,
+			"Could not read protocol version, ret=%d. The firmware on this device is too old, please update!\n",
+			ret);
+		if (ret >= 0)
+			ret = -EINVAL;
+		goto err;
+	}
+
+	/* this driver currently supports protocol version 3 only */
+	protocol_version =
+		le32_to_cpu(ctl_msg_buffer->cmd_get_protocol_version.version);
+	if (protocol_version < UCAN_PROTOCOL_VERSION_MIN ||
+	    protocol_version > UCAN_PROTOCOL_VERSION_MAX) {
+		dev_err(&udev->dev, "Device protocol version %d is not supported",
+			protocol_version);
+		ret = -EINVAL;
+		goto err;
+	}
+	dev_info(&udev->dev, "Device protocol version %d ok", protocol_version);
+
+	/* request the device information and store it in ctl_msg_buffer
+	 *
+	 * note: ucan_ctrl_command_* wrappers connot be used yet
+	 * because `up` is initialised in Stage 3
+	 */
+	ret = usb_control_msg(udev,
+			      usb_rcvctrlpipe(udev, 0),
+			      UCAN_COMMAND_GET,
+			      USB_DIR_IN | USB_TYPE_VENDOR |
+				USB_RECIP_INTERFACE,
+			      cpu_to_le16(UCAN_COMMAND_GET_INFO),
+			      iface_desc->desc.bInterfaceNumber,
+			      ctl_msg_buffer,
+			      sizeof(ctl_msg_buffer->cmd_get_device_info),
+			      UCAN_USB_CTL_PIPE_TIMEOUT);
+
+	if (ret < 0) {
+		dev_err(&udev->dev, "Failed to retrieve device info\n");
+		goto err;
+	}
+	if (ret < sizeof(ctl_msg_buffer->cmd_get_device_info)) {
+		dev_err(&udev->dev, "Device reported invalid device info\n");
+		ret = -EINVAL;
+		goto err;
+	}
+	if (ctl_msg_buffer->cmd_get_device_info.tx_fifo == 0) {
+		dev_err(&udev->dev, "Device reported invalid tx-fifo size\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/**************************************
+	 * Stage 3 - Driver Initialisation
+	 **************************************
+	 *
+	 * Register device to Linux, prepare private structures and
+	 * reset the device.
+	 */
+
+	/* allocate driver resources */
+	netdev = alloc_candev(sizeof(struct ucan_priv),
+			      ctl_msg_buffer->cmd_get_device_info.tx_fifo);
+	if (!netdev) {
+		dev_err(&udev->dev, "Cannot allocate candev\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	up = netdev_priv(netdev);
+
+	/* initialze data */
+	up->udev = udev;
+	up->intf = intf;
+	up->netdev = netdev;
+	up->intf_index = iface_desc->desc.bInterfaceNumber;
+	up->in_ep = in_ep;
+	up->out_ep = out_ep;
+	up->ctl_msg_buffer = ctl_msg_buffer;
+	up->tx_contexts = NULL;
+	atomic_set(&up->available_tx_urbs, 0);
+
+	up->can.state = CAN_STATE_STOPPED;
+	up->can.bittiming_const = &up->device_info.bittiming_const;
+	up->can.do_set_bittiming = ucan_set_bittiming;
+	up->can.do_set_mode = &ucan_set_mode;
+	netdev->netdev_ops = &ucan_netdev_ops;
+
+	usb_set_intfdata(intf, up);
+	SET_NETDEV_DEV(netdev, &intf->dev);
+
+	/* parse device information
+	 * the data retrieved in Stage 2 is still available in
+	 * up->ctl_msg_buffer
+	 */
+	ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
+
+	/* just print some device information - if available */
+	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
+				     sizeof(union ucan_ctl_payload));
+	if (ret > 0) {
+		/* copy string while ensuring zero terminiation */
+		strncpy(firmware_str, up->ctl_msg_buffer->raw,
+			sizeof(union ucan_ctl_payload));
+		firmware_str[sizeof(union ucan_ctl_payload)] = '\0';
+	} else {
+		strcpy(firmware_str, "unknown firmware");
+	}
+
+	/* device is compatible, reset it */
+	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
+	if (ret < 0)
+		goto err_free_candev;
+
+	init_usb_anchor(&up->rx_urbs);
+	init_usb_anchor(&up->tx_urbs);
+
+	up->can.state = CAN_STATE_STOPPED;
+
+	/* register the device */
+	ret = register_candev(netdev);
+	if (ret)
+		goto err_free_candev;
+
+	/* initialisation complete, log device info */
+	dev_info(&up->udev->dev,
+		 "Device reports:\n"
+		 "  Clock frequency [Hz]     : %d\n"
+		 "  TX FIFO length           : %d\n"
+		 "  Time segment 1 [min-max] : %d-%d\n"
+		 "  Time segment 2 [min-max] : %d-%d\n"
+		 "  SWJ [max]                : %d\n"
+		 "  Prescaler [min-max,step] : %d-%d,%d\n"
+		 "  Supported modes          : %s%s%s%s%s = 0x%x\n"
+		 "  Firmware                 : %s",
+		 up->can.clock.freq, up->device_info.tx_fifo,
+		 up->can.bittiming_const->tseg1_min,
+		 up->can.bittiming_const->tseg1_max,
+		 up->can.bittiming_const->tseg2_min,
+		 up->can.bittiming_const->tseg2_max,
+		 up->can.bittiming_const->sjw_max,
+		 up->can.bittiming_const->brp_min,
+		 up->can.bittiming_const->brp_max,
+		 up->can.bittiming_const->brp_inc,
+		 (up->can.ctrlmode_supported & CAN_CTRLMODE_LOOPBACK) ?
+			"LOOPBACK" : "",
+		 (up->can.ctrlmode_supported & CAN_CTRLMODE_LISTENONLY) ?
+			" | LISTENONLY" : "",
+		 (up->can.ctrlmode_supported & CAN_CTRLMODE_3_SAMPLES) ?
+			" | 3_SAMPLES" : "",
+		 (up->can.ctrlmode_supported & CAN_CTRLMODE_ONE_SHOT) ?
+			" | ONE_SHOT" : "",
+		 (up->can.ctrlmode_supported & CAN_CTRLMODE_BERR_REPORTING) ?
+			" | BERR_REPORTING" : "",
+		 up->can.ctrlmode_supported,
+		 firmware_str);
+
+	dev_info(&udev->dev, "Registered UCAN device at %s\n",
+		 netdev->name);
+
+	/* success */
+	return 0;
+
+err_free_candev:
+	free_candev(netdev);
+err:
+	return ret;
+}
+
+/* disconnect the device */
+static void ucan_disconnect(struct usb_interface *intf)
+{
+	struct usb_device *udev;
+	struct ucan_priv *up = usb_get_intfdata(intf);
+
+	udev = interface_to_usbdev(intf);
+
+	usb_set_intfdata(intf, NULL);
+
+	if (up) {
+		unregister_netdev(up->netdev);
+		free_candev(up->netdev);
+	}
+}
+
+static struct usb_device_id ucan_table[] = {
+	/* Mule (soldered onto compute modules) */
+	{USB_DEVICE_INTERFACE_NUMBER(0x2294, 0x425a, 0)},
+	/* Seal (standalone USB stick) */
+	{USB_DEVICE_INTERFACE_NUMBER(0x2294, 0x425b, 0)},
+	{} /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, ucan_table);
+/* driver callbacks */
+static struct usb_driver ucan_driver = {
+	.name = "ucan",
+	.probe = ucan_probe,
+	.disconnect = ucan_disconnect,
+	.id_table = ucan_table,
+};
+
+module_usb_driver(ucan_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Martin Elshuber, Theobroma Systems Design und Consulting GmbH <martin.elshuber@theobroma-systems.com>");
+MODULE_DESCRIPTION("Driver for Theobroma Systems UCAN devices");
-- 
2.11.0
