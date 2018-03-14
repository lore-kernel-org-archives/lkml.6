Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeCNJSR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:18:17 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:57518 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeCNJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:18:16 -0400
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
Date: Wed, 14 Mar 2018 10:11:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 13.03.2018 um 18:35 schrieb Jakob Unterwurzacher:
> The UCAN driver supports the microcontroller-based USB/CAN
> adapters from Theobroma Systems. There are two form-factors
> that run essentially the same firmware:
> 
> * Seal: standalone USB stick ( https://www.theobroma-systems.com/seal )
> 
> * Mule: integrated on the PCB of various System-on-Modules from
>    Theobroma Systems like the A31-µQ7 and the RK3399-Q7
>    ( https://www.theobroma-systems.com/rk3399-q7 )
> 
> The USB wire protocol has been designed to be as generic and
> hardware-indendent as possible in the hope of being useful for
> implementation on other microcontrollers.
> 
> Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>   Documentation/networking/can_ucan_protocol.rst |  315 +++++
>   Documentation/networking/index.rst             |    1 +
>   drivers/net/can/usb/Kconfig                    |   10 +
>   drivers/net/can/usb/Makefile                   |    1 +
>   drivers/net/can/usb/ucan.c                     | 1587 ++++++++++++++++++++++++
>   5 files changed, 1914 insertions(+)
>   create mode 100644 Documentation/networking/can_ucan_protocol.rst
>   create mode 100644 drivers/net/can/usb/ucan.c
> 
> diff --git a/Documentation/networking/can_ucan_protocol.rst b/Documentation/networking/can_ucan_protocol.rst
> new file mode 100644
> index 000000000000..d859b36200b4
> --- /dev/null
> +++ b/Documentation/networking/can_ucan_protocol.rst
> @@ -0,0 +1,315 @@
> +=================
> +The UCAN Protocol
> +=================
> +
> +UCAN is the protocol used by the microcontroller-based USB-CAN
> +adapter that is integrated on System-on-Modules from Theobroma Systems
> +and that is also available as a standalone USB stick.
> +
> +The UCAN protocol has been designed to be hardware-independent.
> +It is modeled closely after how Linux represents CAN devices
> +internally. All multi-byte integers are encoded as Little Endian.
> +
> +All structures mentioned in this document are defined in
> +``drivers/net/can/usb/ucan.c``.
> +
> +USB Endpoints
> +=============
> +
> +UCAN devices use three USB endpoints:
> +
> +CONTROL endpoint
> +  The driver sends device management commands on this endpoint
> +
> +IN endpoint
> +  The device sends CAN data frames and CAN error frames
> +
> +OUT endpoint
> +  The driver sends CAN data frames on the out endpoint
> +
> +
> +CONTROL Messages
> +================
> +
> +UCAN devices are configured using vendor requests on the control pipe.
> +
> +To support multiple CAN interfaces in a single USB device all
> +configuration commands target the corresponding interface in the USB
> +descriptor.
> +
> +The driver uses ``ucan_ctrl_command_in/out`` and
> +``ucan_device_request_in`` to deliver commands to the device.
> +
> +Setup Packet
> +------------
> +
> +=================  =====================================================
> +``bmRequestType``  Direction | Vendor | (Interface or Device)
> +``bRequest``       Command Number
> +``wValue``         Subcommand Number (16 Bit) or 0 if not used
> +``wIndex``         USB Interface Index (0 for device commands)
> +``wLength``        * Host to Device - Number of bytes to transmit
> +                   * Device to Host - Maximum Number of bytes to
> +                     receive. If the device send less. Commom ZLP
> +                     semantics are used.
> +=================  =====================================================
> +
> +Error Handling
> +--------------
> +
> +The device indicates failed control commands by stalling the
> +pipe.
> +
> +Device Commands
> +---------------
> +
> +UCAN_DEVICE_GET_FW_STRING
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +*Dev2Host; optional*
> +
> +Request the device firmware string.
> +
> +
> +Interface Commands
> +------------------
> +
> +UCAN_COMMAND_START
> +~~~~~~~~~~~~~~~~~~
> +
> +*Host2Dev; mandatory*
> +
> +Bring the CAN interface up.
> +
> +Payload Format
> +  ``ucan_ctl_payload_t.cmd_start``
> +
> +====  ============================
> +mode  or mask of ``UCAN_MODE_*``
> +====  ============================
> +
> +UCAN_COMMAND_STOP
> +~~~~~~~~~~~~~~~~~~
> +
> +*Host2Dev; mandatory*
> +
> +Stop the CAN interface
> +
> +Payload Format
> +  *empty*
> +
> +UCAN_COMMAND_RESET
> +~~~~~~~~~~~~~~~~~~
> +
> +*Host2Dev; mandatory*
> +
> +Reset the CAN controller (including error counters)
> +
> +Payload Format
> +  *empty*
> +
> +UCAN_COMMAND_GET
> +~~~~~~~~~~~~~~~~
> +
> +*Host2Dev; mandatory*
> +
> +Get Information from the Device
> +
> +Subcommands
> +^^^^^^^^^^^
> +
> +UCAN_COMMAND_GET_INFO
> +  Request the device information structure ``ucan_ctl_payload_t.device_info``.
> +
> +  See the ``device_info`` field for details, and
> +  ``uapi/linux/can/netlink.h`` for an explanation of the
> +  ``can_bittiming fields``.
> +
> +  Payload Format
> +    ``ucan_ctl_payload_t.device_info``
> +
> +UCAN_COMMAND_GET_PROTOCOL_VERSION
> +
> +  Request the device protocol version
> +  ``ucan_ctl_payload_t.protocol_version``. The current protocol version is 3.
> +
> +  Payload Format
> +    ``ucan_ctl_payload_t.protocol_version``
> +
> +.. note:: Devices that do not implement this command use the old
> +          protocol version 1
> +
> +UCAN_COMMAND_SET_BITTIMING
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +*Host2Dev; mandatory*
> +
> +Setup bittiming by sending the the structure
> +``ucan_ctl_payload_t.cmd_set_bittiming`` (see ``struct bittiming`` for
> +details)
> +
> +Payload Format
> +  ``ucan_ctl_payload_t.cmd_set_bittiming``.
> +
> +UCAN_SLEEP/WAKE
> +~~~~~~~~~~~~~~~
> +
> +*Host2Dev; optional*
> +
> +Configure sleep and wake modes. Not yet supported by the driver.
> +
> +UCAN_FILTER
> +~~~~~~~~~~~
> +
> +*Host2Dev; optional*
> +
> +Setup hardware CAN filters. Not yet supported by the driver.
> +
> +Allowed interface commands
> +--------------------------
> +
> +==================  ===================  ==================
> +Legal Device State  Command              New Device State
> +==================  ===================  ==================
> +stopped             SET_BITTIMING        stopped
> +stopped             START                started
> +started             STOP or RESET        stopped
> +stopped             STOP or RESET        stopped
> +started             RESTART              started
> +any                 GET                  *no change*
> +==================  ===================  ==================
> +
> +IN Message Format
> +=================
> +
> +A data packet on the USB IN endpoint contains one or more
> +``ucan_message_in`` values. If multiple messages are batched in a USB
> +data packet, the ``len`` field can be used to jump to the next
> +``ucan_message_in`` value (take care to sanity-check the ``len`` value
> +against the actual data size).
> +
> +.. _can_ucan_in_message_len:
> +
> +``len`` field
> +-------------
> +
> +Each ``ucan_message_in`` must be aligned to a 4-byte boundary (relative
> +to the start of the start of the data buffer). That means that there
> +may be padding bytes between multiple ``ucan_message_in`` values:
> +
> +.. code::
> +
> +    +----------------------------+ < 0
> +    |                            |
> +    |   struct ucan_message_in   |
> +    |                            |
> +    +----------------------------+ < len
> +              [padding]
> +    +----------------------------+ < round_up(len, 4)
> +    |                            |
> +    |   struct ucan_message_in   |
> +    |                            |
> +    +----------------------------+
> +                [...]
> +
> +``type`` field
> +--------------
> +
> +The ``type`` field specifies the type of the message.
> +
> +UCAN_IN_RX
> +~~~~~~~~~~
> +
> +``subtype``
> +  zero
> +
> +Data received from the CAN bus (ID + payload).
> +
> +UCAN_IN_TX_COMPLETE
> +~~~~~~~~~~~~~~~~~~~
> +
> +``subtype``
> +  zero
> +
> +The CAN device has sent a message to the CAN bus. It answers with a
> +set of echo-ids from previous UCAN_OUT_TX messages
> +
> +Flow Control
> +------------
> +
> +When receiving CAN messages there is no flow control on the USB
> +buffer. The driver has to handle inbound message quickly enough to
> +avoid drops. I case the device buffer overflow the condition is
> +reported by sending corresponding error frames (see
> +:ref:`can_ucan_error_handling`)
> +
> +
> +OUT Message Format
> +==================
> +
> +A data packet on the USB OUT endpoint contains one or more ``struct
> +ucan_message_out`` values. If multiple messages are batched into one
> +data packet, the device uses the ``len`` field to jump to the next
> +ucan_message_out value. Each ucan_message_out must be aligned to 4
> +bytes (relative to the start of the data buffer). The mechanism is
> +same as described in :ref:`can_ucan_in_message_len`.
> +
> +.. code::
> +
> +    +----------------------------+ < 0
> +    |                            |
> +    |   struct ucan_message_out  |
> +    |                            |
> +    +----------------------------+ < len
> +              [padding]
> +    +----------------------------+ < round_up(len, 4)
> +    |                            |
> +    |   struct ucan_message_out  |
> +    |                            |
> +    +----------------------------+
> +                [...]
> +
> +``type`` field
> +--------------
> +
> +In protocol version 3 only ``UCAN_OUT_TX`` is defined, others are used
> +only by legacy devices (protocol version 1).
> +
> +UCAN_OUT_TX
> +~~~~~~~~~~~
> +``subtype``
> +  echo id to be replied within a CAN_IN_TX_COMPLETE message
> +
> +Transmit a CAN frame. (parameters: ``id``, ``data``)
> +
> +Flow Control
> +------------
> +
> +When the device outbound buffers are full it starts sending *NAKs* on
> +the *OUT* pipe until more buffers are available. The driver stops the
> +queue when a certain threshold of out packets are incomplete.
> +
> +.. _can_ucan_error_handling:
> +
> +CAN Error Handling
> +==================
> +
> +If error reporting is turned on the device encodes errors into CAN
> +error frames (see ``uapi/linux/can/error.h``) and sends it using the
> +IN endpoint. The driver updates its error statistics and forwards
> +it.
> +
> +Although UCAN devices can suppress error frames completely, in Linux
> +the driver is always interested. Hence, the device is always started with
> +the ``UCAN_MODE_BERR_REPORT`` set. Filtering those messages for the
> +user space is done by the driver.
> +
> +Example Conversation
> +====================
> +
> +#) Device is connected to USB
> +#) Host sends command ``UCAN_COMMAND_RESET``, subcmd 0
> +#) Host sends command ``UCAN_COMMAND_GET``, subcmd ``UCAN_COMMAND_GET_INFO``
> +#) Device sends ``UCAN_IN_DEVICE_INFO``
> +#) Host sends command ``UCAN_OUT_SET_BITTIMING``
> +#) Host sends command ``UCAN_COMMAND_START``, subcmd 0, mode ``UCAN_MODE_BERR_REPORT``
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 90966c2692d8..18903968cebf 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -8,6 +8,7 @@ Contents:
>   
>      batman-adv
>      can
> +   can_ucan_protocol
>      kapi
>      z8530book
>      msg_zerocopy
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index c36f4bdcbf4f..490cdce1f1da 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -89,4 +89,14 @@ config CAN_MCBA_USB
>   	  This driver supports the CAN BUS Analyzer interface
>   	  from Microchip (http://www.microchip.com/development-tools/).
>   
> +config CAN_UCAN
> +	tristate "Theobroma Systems UCAN interface"
> +	---help---
> +	  This driver supports the Theobroma Systems
> +	  UCAN USB-CAN interface.
> +
> +	  UCAN is an microcontroller-based USB-CAN interface that
> +	  is integrated on System-on-Modules made by Theobroma Systems
> +	  (https://www.theobroma-systems.com/som-products).
> +
>   endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index 49ac7b99ba32..4176e8358232 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
>   obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>   obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
>   obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
> +obj-$(CONFIG_CAN_UCAN) += ucan.o
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> new file mode 100644
> index 000000000000..61348e8c4747
> --- /dev/null
> +++ b/drivers/net/can/usb/ucan.c
> @@ -0,0 +1,1587 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Driver for Theobroma Systems UCAN devices Protocol Version 3
> + *
> + * Copyright (C) 2018 Theobroma Systems Design und Consulting GmbH
> + *
> + *
> + * General Description:
> + *
> + * The USB Device uses three Endpoints:
> + *
> + *   CONTROL Endpoint: Is used the setup the device (start, stop,
> + *   info, configure).
> + *
> + *   IN Endpoint: The device sends CAN Frame Messages and Device
> + *   Information using the IN endpoint.
> + *
> + *   OUT Endpoint: The driver sends configuration requests, and CAN
> + *   Frames on the out endpoint.
> + *
> + * Error Handling:
> + *
> + *   If error reporting is turned on the device encodes error into CAN
> + *   error frames (see uapi/linux/can/error.h) and sends it using the
> + *   IN Endpoint. The driver updates statistics and forward it.
> + */
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/signal.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +
> +#define UCAN_MAX_RX_URBS 8
> +/* the CAN controller needs a while to enable/disable the bus */
> +#define UCAN_USB_CTL_PIPE_TIMEOUT 1000
> +/* this driver currently supports protocol version 3 only */
> +#define UCAN_PROTOCOL_VERSION_MIN 3
> +#define UCAN_PROTOCOL_VERSION_MAX 3
> +
> +/* UCAN Message Definitions --------------------------------------------
> + *
> + *  ucan_message_out_t and ucan_message_in_t define the messages
> + *  transmitted on the OUT and IN endpoint.
> + *
> + *  Multibyte fields are transmitted with little endianness
> + *
> + *  INTR Endpoint: a single uint32_t storing the current space in the fifo
> + *
> + *  OUT Endpoint: single message of type ucan_message_out_t is
> + *    transmitted on the out endpoint
> + *
> + *  IN Endpoint: multiple messages ucan_message_in_t concateted in
> + *    the following way:
> + *
> + *	m[n].len <=> the length if message n(including the header in bytes)
> + *	m[n] is is aligned to a 4 byte boundary, hence
> + *	  offset(m[0])	 := 0;
> + *	  offset(m[n+1]) := offset(m[n]) + (m[n].len + 3) & 3
> + *
> + *	this implies that
> + *	  offset(m[n]) % 4 <=> 0
> + */
> +
> +/* Device Global Commands */
> +enum {
> +	UCAN_DEVICE_GET_FW_STRING = 0,
> +};
> +
> +/* UCAN Commands */
> +enum {
> +	/* start the can transceiver - val defines the operation mode */
> +	UCAN_COMMAND_START    = 0,
> +	/* cancel pending transmissions and stop the can transceiver */
> +	UCAN_COMMAND_STOP     = 1,
> +	/* send can transceiver into low-power sleep mode */
> +	UCAN_COMMAND_SLEEP    = 2,
> +	/* wake up can transceiver from low-power sleep mode */
> +	UCAN_COMMAND_WAKEUP   = 3,
> +	/* reset the can transceiver */
> +	UCAN_COMMAND_RESET    = 4,
> +	/* get piece of info from the can transceiver - subcmd defines what
> +	 * piece
> +	 */
> +	UCAN_COMMAND_GET      = 5,
> +	/* clear or disable hardware filter - subcmd defines which of the two */
> +	UCAN_COMMAND_FILTER   = 6,
> +	/* Setup bittiming */
> +	UCAN_COMMAND_SET_BITTIMING = 7,
> +	/* recover from bus-off state */
> +	UCAN_COMMAND_RESTART  = 8,
> +};
> +
> +/* UCAN_COMMAND_START and UCAN_COMMAND_GET_INFO operation modes (bitmap).
> + * Undefined bits must be set to 0.
> + */
> +enum {
> +	UCAN_MODE_LOOPBACK    = (1 << 0),
> +	UCAN_MODE_SILENT      = (1 << 1),
> +	UCAN_MODE_3_SAMPLES   = (1 << 2),
> +	UCAN_MODE_ONE_SHOT    = (1 << 3),
> +	UCAN_MODE_BERR_REPORT = (1 << 4),
> +};
> +
> +/* UCAN_COMMAND_GET subcommands */
> +enum {
> +	UCAN_COMMAND_GET_INFO             = 0,
> +	UCAN_COMMAND_GET_PROTOCOL_VERSION = 1,
> +};
> +
> +/* UCAN_COMMAND_FILTER subcommands */
> +enum {
> +	UCAN_FILTER_CLEAR     = 0,
> +	UCAN_FILTER_DISABLE   = 1,
> +	UCAN_FILTER_ENABLE    = 2,
> +};
> +
> +/* OUT endpoint message types */
> +enum {
> +	UCAN_OUT_TX = 2, /* transmit a CAN frame */
> +};
> +
> +/* IN endpoint message types */
> +enum {
> +	UCAN_IN_TX_COMPLETE = 1,  /* CAN frame transmission completed */
> +	UCAN_IN_RX          = 2,  /* CAN frame received */
> +};
> +
> +struct ucan_ctl_cmd_start {
> +	u16 mode;            /* oring any of UCAN_MODE_* */
> +} __packed;
> +
> +struct ucan_ctl_cmd_set_bittiming {
> +	u32 tq;		     /* Time quanta (TQ) in nanoseconds */
> +	u16 brp;	     /* TQ Prescaler */
> +	u16 sample_point;    /* Samplepoint on tenth percent */
> +	u8 prop_seg;	     /* Propagation segment in TQs */
> +	u8 phase_seg1;	     /* Phase buffer segment 1 in TQs */
> +	u8 phase_seg2;	     /* Phase buffer segment 2 in TQs */
> +	u8 sjw;		     /* Synchronisation jump width in TQs */
> +} __packed;
> +
> +struct ucan_ctl_cmd_device_info {
> +	u32 freq;   /* Clock Frequency for tq generation */
> +	u8 tx_fifo; /* Size of the transmission fifo */
> +	u8 sjw_max;   /* can_bittiming fields... */
> +	u8 tseg1_min;
> +	u8 tseg1_max;
> +	u8 tseg2_min;
> +	u8 tseg2_max;
> +	u16 brp_inc;
> +	u32 brp_min;
> +	u32 brp_max; /* ...can_bittiming fields */
> +	u16 ctrlmodes; /* supported control modes */
> +	u16 hwfilter;  /* Number of HW filter banks */
> +	u16 rxmboxes;  /* Number of receive Mailboxes */
> +} __packed;
> +
> +struct ucan_ctl_cmd_get_protocol_version {
> +	u32 version;
> +} __packed;
> +
> +union ucan_ctl_payload {
> +	/***************************************************
> +	 * Setup Bittiming
> +	 * bmRequest == UCAN_COMMAND_START
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_start cmd_start;
> +	/***************************************************
> +	 * Setup Bittiming
> +	 * bmRequest == UCAN_COMMAND_SET_BITTIMING
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_set_bittiming cmd_set_bittiming;
> +	/***************************************************
> +	 * Get Device Information
> +	 * bmRequest == UCAN_COMMAND_GET; wValue = UCAN_COMMAND_GET_INFO
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_device_info cmd_get_device_info;
> +	/***************************************************
> +	 * Get Protocol Version
> +	 * bmRequest == UCAN_COMMAND_GET;
> +	 * wValue = UCAN_COMMAND_GET_PROTOCOL_VERSION
> +	 ***************************************************/
> +	struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
> +
> +	u8 raw[128];
> +} __packed;
> +
> +enum {
> +	UCAN_TX_COMPLETE_SUCCESS = (1 << 0),
> +};
> +
> +/* Transmission Complete within ucan_message_in */
> +struct ucan_tx_complete_entry_t {
> +	u8 echo_id;
> +	u8 flags;
> +}  __packed __aligned(0x2);
> +
> +/* CAN Data message format within ucan_message_in/out */
> +struct ucan_can_msg {
> +	/* note DLC is computed by
> +	 *    msg.len - sizeof (msg.len)
> +	 *	       - sizeof (msg.type)
> +	 *	       - sizeof (msg.can_msg.id)
> +	 */
> +	u32 id;
> +
> +	union {
> +		u8 data[CAN_MAX_DLEN];  /* Data of CAN frames */
> +		u8 dlc;                 /* RTR dlc */
> +	};
> +} __packed;
> +
> +/* OUT Endpoint, outbound messages */
> +struct ucan_message_out {
> +	u16 len;  /* Length of the content include header */
> +	u8  type; /* UCAN_OUT_TX and friends */
> +	u8  subtype; /* command sub type */
> +	union {
> +		/***************************************************
> +		 * Transmit CAN frame
> +		 * (type == UCAN_TX) && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
> +		 * subtype stores the echo id
> +		 ***************************************************/
> +		struct ucan_can_msg can_msg;
> +	} msg;
> +} __packed __aligned(0x4);
> +
> +/* IN Endpoint, inbound messages */
> +struct ucan_message_in {
> +	u16 len;     /* Length of the content include header */
> +	u8  type;    /* UCAN_IN_RX and friends */
> +	u8  subtype; /* command sub type */
> +
> +	union {
> +		/***************************************************
> +		 * CAN Frame received
> +		 * (type == UCAN_IN_RX)
> +		 * && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
> +		 ***************************************************/
> +		struct ucan_can_msg can_msg;
> +
> +		/***************************************************
> +		 * CAN transmission complete
> +		 * (type == UCAN_IN_TX_COMPLETE)
> +		 ***************************************************/
> +		struct ucan_tx_complete_entry_t can_tx_complete_msg[0];
> +
> +	} __aligned(0x4) msg;
> +} __packed;
> +
> +/* Macros to calculate message lengths */
> +#define UCAN_OUT_HDR_SIZE offsetof(struct ucan_message_out, msg)
> +
> +#define UCAN_IN_HDR_SIZE offsetof(struct ucan_message_in, msg)
> +#define UCAN_IN_LEN(member) (UCAN_OUT_HDR_SIZE + sizeof(member))
> +
> +struct ucan_priv;
> +
> +/* Context Information for transmission URBs */
> +struct ucan_urb_context {
> +	struct ucan_priv *up;
> +	u32 echo_index;
> +	u8 dlc;
> +	atomic_t allocated;
> +};
> +
> +/* Information reported by the USB device */
> +struct ucan_device_info {
> +	struct can_bittiming_const bittiming_const;
> +	u8 tx_fifo;
> +};
> +
> +/* Driver private data */
> +struct ucan_priv {
> +	struct can_priv can; /* must be the first member */
> +
> +	u8 intf_index;
> +	struct usb_device *udev;
> +	struct usb_interface *intf;
> +	struct net_device *netdev;
> +
> +	struct usb_endpoint_descriptor *out_ep;
> +	struct usb_endpoint_descriptor *in_ep;
> +
> +	struct usb_anchor rx_urbs;
> +	struct usb_anchor tx_urbs;
> +
> +	union ucan_ctl_payload *ctl_msg_buffer;
> +	struct ucan_device_info device_info;
> +
> +	atomic_t available_tx_urbs;
> +	struct ucan_urb_context *tx_contexts;
> +};
> +
> +static u8 ucan_compute_dlc(u16 len, struct ucan_can_msg *msg)
> +{
> +	u16 res = 0;
> +
> +	if (msg->id & CAN_RTR_FLAG)
> +		res = msg->dlc;
> +	else
> +		res = len - (UCAN_IN_HDR_SIZE + sizeof(msg->id));
> +
> +	if (res > CAN_MAX_DLEN)
> +		return -1;
> +
> +	return res;
> +}
> +
> +static void ucan_release_contexts(struct ucan_priv *up)
> +{
> +	if (!up->tx_contexts)
> +		return;
> +
> +	atomic_set(&up->available_tx_urbs, 0);
> +
> +	kfree(up->tx_contexts);
> +	up->tx_contexts = NULL;
> +}
> +
> +static int ucan_allocate_contexts(struct ucan_priv *up)
> +{
> +	int i;
> +
> +	/* release contexts if any */
> +	ucan_release_contexts(up);
> +
> +	up->tx_contexts = kmalloc_array(up->device_info.tx_fifo,
> +					sizeof(*up->tx_contexts),
> +					GFP_KERNEL);
> +	if (!up->tx_contexts) {
> +		dev_err(&up->udev->dev, "Not enough memory to allocate tx contexts\n");
> +		return -ENOMEM;
> +	}
> +
> +	memset(up->tx_contexts, 0,
> +	       sizeof(*up->tx_contexts) * up->device_info.tx_fifo);
> +	for (i = 0; i < up->device_info.tx_fifo; i++) {
> +		atomic_set(&up->tx_contexts[i].allocated, 0);
> +		up->tx_contexts[i].up = up;
> +		up->tx_contexts[i].echo_index = i;
> +	}
> +
> +	atomic_set(&up->available_tx_urbs, up->device_info.tx_fifo);
> +
> +	return 0;
> +}
> +
> +static struct ucan_urb_context *ucan_allocate_context(struct ucan_priv *up)
> +{
> +	int i, allocated, avail;
> +
> +	if (!up->tx_contexts)
> +		return NULL;
> +
> +	for (i = 0; i < up->device_info.tx_fifo; i++) {
> +		allocated = atomic_cmpxchg(&up->tx_contexts[i].allocated, 0, 1);
> +		if (allocated == 0) {
> +			avail = atomic_sub_return(1, &up->available_tx_urbs);
> +			if (avail == 0)
> +				netif_stop_queue(up->netdev);
> +			return &up->tx_contexts[i];
> +		}
> +	}
> +	return NULL;
> +}
> +
> +static void ucan_release_context(struct ucan_priv *up,
> +				 struct ucan_urb_context *ctx)
> +{
> +	WARN_ON_ONCE(!up->tx_contexts);
> +	if (!up->tx_contexts)
> +		return;
> +
> +	if (atomic_cmpxchg(&ctx->allocated, 1, 0) == 0) {
> +		dev_warn(&up->udev->dev,
> +			 "context %p (#%ld) was not allocated\n",
> +			 ctx, ctx - up->tx_contexts);
> +	} else {
> +		atomic_inc(&up->available_tx_urbs);
> +		netif_wake_queue(up->netdev);
> +	}
> +}
> +
> +static int ucan_ctrl_command_out(struct ucan_priv *up,
> +				 u8 cmd,
> +				 u16 subcmd,
> +				 size_t datalen)
> +{
> +	if (datalen > sizeof(union ucan_ctl_payload))
> +		return -ENOMEM;
> +
> +	return usb_control_msg(up->udev,
> +			usb_sndctrlpipe(up->udev, 0),
> +			cmd,
> +			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
> +			cpu_to_le16(subcmd),
> +			up->intf_index,
> +			up->ctl_msg_buffer,
> +			datalen,
> +			UCAN_USB_CTL_PIPE_TIMEOUT);
> +}
> +
> +static int ucan_device_request_in(struct ucan_priv *up,
> +				  u8 cmd,
> +				  u16 subcmd,
> +				  size_t datalen)
> +{
> +	if (datalen > sizeof(union ucan_ctl_payload))
> +		return -ENOMEM;
> +
> +	return usb_control_msg(up->udev,
> +			usb_rcvctrlpipe(up->udev, 0),
> +			cmd,
> +			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +			cpu_to_le16(subcmd),
> +			0,
> +			up->ctl_msg_buffer,
> +			datalen,
> +			UCAN_USB_CTL_PIPE_TIMEOUT);
> +}
> +
> +/* Parse the device information structure reported by the device and
> + * setup private variables accordingly
> + */
> +static void ucan_parse_device_info(struct ucan_priv *up,
> +				   struct ucan_ctl_cmd_device_info
> +					*ctl_cmd_device_info)
> +{
> +	struct can_bittiming_const *bittiming =
> +		&up->device_info.bittiming_const;
> +	u16 ctrlmodes;
> +
> +	/* store the data */
> +	up->can.clock.freq = le32_to_cpu(ctl_cmd_device_info->freq);
> +	up->device_info.tx_fifo = ctl_cmd_device_info->tx_fifo;
> +	strcpy(bittiming->name, "ucan");
> +	bittiming->tseg1_min = ctl_cmd_device_info->tseg1_min;
> +	bittiming->tseg1_max = ctl_cmd_device_info->tseg1_max;
> +	bittiming->tseg2_min = ctl_cmd_device_info->tseg2_min;
> +	bittiming->tseg2_max = ctl_cmd_device_info->tseg2_max;
> +	bittiming->sjw_max = ctl_cmd_device_info->sjw_max;
> +	bittiming->brp_min = le32_to_cpu(ctl_cmd_device_info->brp_min);
> +	bittiming->brp_max = le32_to_cpu(ctl_cmd_device_info->brp_max);
> +	bittiming->brp_inc = le16_to_cpu(ctl_cmd_device_info->brp_inc);
> +
> +	ctrlmodes = le16_to_cpu(ctl_cmd_device_info->ctrlmodes);
> +
> +	up->can.ctrlmode_supported = 0;
> +
> +	if (ctrlmodes & UCAN_MODE_LOOPBACK)
> +		up->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
> +	if (ctrlmodes & UCAN_MODE_SILENT)
> +		up->can.ctrlmode_supported |= CAN_CTRLMODE_LISTENONLY;
> +	if (ctrlmodes & UCAN_MODE_3_SAMPLES)
> +		up->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
> +	if (ctrlmodes & UCAN_MODE_ONE_SHOT)
> +		up->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
> +	if (ctrlmodes & UCAN_MODE_BERR_REPORT)
> +		up->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
> +}
> +
> +/* Handle a CAN error frame that we have received from the device */
> +static void ucan_handle_error_frame(struct ucan_priv *up,
> +				    struct ucan_message_in *m,
> +				    u32 canid)
> +{
> +	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
> +	struct net_device_stats *net_stats = &up->netdev->stats;
> +	struct can_device_stats *can_stats = &up->can.can_stats;
> +
> +	if (canid & CAN_ERR_LOSTARB)
> +		can_stats->arbitration_lost++;
> +
> +	if (canid & CAN_ERR_BUSERROR)
> +		can_stats->bus_error++;
> +
> +	if (canid & CAN_ERR_ACK)
> +		net_stats->tx_errors++;
> +
> +	if (canid & CAN_ERR_BUSOFF)
> +		new_state = CAN_STATE_BUS_OFF;
> +
> +	/* controller problems, details in data[1] */
> +	if (canid & CAN_ERR_CRTL) {
> +		u8 d1 = m->msg.can_msg.data[1];
> +
> +		if (d1 & (CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE))
> +			new_state = max(new_state, (enum can_state)
> +					CAN_STATE_ERROR_PASSIVE);
> +
> +		if (d1 & (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING))
> +			new_state = max(new_state, (enum can_state)
> +					CAN_STATE_ERROR_WARNING);
> +
> +		if (d1 & CAN_ERR_CRTL_RX_OVERFLOW)
> +			net_stats->rx_over_errors++;
> +	}
> +
> +	/* protocol error, details in data[2] */
> +	if (canid & CAN_ERR_PROT) {
> +		u8 d2 = m->msg.can_msg.data[2];
> +
> +		if (d2 & CAN_ERR_PROT_TX)
> +			net_stats->tx_errors++;
> +		else
> +			net_stats->rx_errors++;
> +	}
> +
> +	/* we switched into a better state */
> +	if (up->can.state >= new_state) {
> +		up->can.state = new_state;
> +		return;
> +	}
> +
> +	/* we switched into a worse state */
> +	up->can.state = new_state;
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		can_stats->bus_off++;
> +		can_bus_off(up->netdev);
> +		netdev_info(up->netdev,
> +			    "link has gone into BUS-OFF state\n");
> +		break;
> +	case CAN_STATE_ERROR_PASSIVE:
> +		can_stats->error_passive++;
> +		break;
> +	case CAN_STATE_ERROR_WARNING:
> +		can_stats->error_warning++;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +/* Callback on reception of a can frame via the IN endpoint
> + *
> + * This function allocates an skb and transferres it to the Linux
> + * network stack
> + */
> +static void ucan_rx_can_msg(struct ucan_priv *up, struct ucan_message_in *m)
> +{
> +	int len;
> +	u32 canid;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	struct net_device_stats *stats = &up->netdev->stats;
> +
> +	/* get the contents of the length field */
> +	len = le16_to_cpu(m->len);
> +
> +	/* check sanity */
> +	if (len < UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id)) {
> +		dev_warn(&up->udev->dev, "invalid input message len\n");
> +		return;
> +	}
> +
> +	/* handle error frames */
> +	canid = le32_to_cpu(m->msg.can_msg.id);
> +	if (canid & CAN_ERR_FLAG) {
> +		ucan_handle_error_frame(up, m, canid);
> +		/* drop frame if berr-reporting is off */
> +		if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
> +			return;
> +	}

You still do not generate error messages for state changes, IIUC.

Wolfgang.
