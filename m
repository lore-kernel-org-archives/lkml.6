Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDHLqg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 07:46:36 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:37082 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeDHLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 07:46:35 -0400
Subject: Re: [PATCH v4 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180403143514.24200-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180403143514.24200-2-jakob.unterwurzacher@theobroma-systems.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Message-ID: <b887637b-6e15-ac2a-1dac-385167595beb@grandegger.com>
Date: Sun, 8 Apr 2018 13:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403143514.24200-2-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jacob,

just a few minor issues and a question about bus-off handling...

Am 03.04.2018 um 16:35 schrieb Jakob Unterwurzacher:
> The UCAN driver supports the microcontroller-based USB/CAN
> adapters from Theobroma Systems. There are two form-factors
> that run essentially the same firmware:
> 
> * Seal: standalone USB stick ( https://www.theobroma-systems.com/seal )
> 
> * Mule: integrated on the PCB of various System-on-Modules from
>   Theobroma Systems like the A31-µQ7 and the RK3399-Q7
>   ( https://www.theobroma-systems.com/rk3399-q7 )
> 
> The USB wire protocol has been designed to be as generic and
> hardware-indendent as possible in the hope of being useful for
> implementation on other microcontrollers.
> 
> Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>  Documentation/networking/can_ucan_protocol.rst |  315 +++++
>  Documentation/networking/index.rst             |    1 +
>  drivers/net/can/usb/Kconfig                    |   10 +
>  drivers/net/can/usb/Makefile                   |    1 +
>  drivers/net/can/usb/ucan.c                     | 1596 ++++++++++++++++++++++++
>  5 files changed, 1923 insertions(+)
>  create mode 100644 Documentation/networking/can_ucan_protocol.rst
>  create mode 100644 drivers/net/can/usb/ucan.c
> 
[..snip..]

> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index c36f4bdcbf4f..490cdce1f1da 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -89,4 +89,14 @@ config CAN_MCBA_USB
>  	  This driver supports the CAN BUS Analyzer interface
>  	  from Microchip (http://www.microchip.com/development-tools/).
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
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index 49ac7b99ba32..4176e8358232 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>  obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
>  obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
> +obj-$(CONFIG_CAN_UCAN) += ucan.o
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> new file mode 100644
> index 000000000000..bb2d62dcbd7b
> --- /dev/null
> +++ b/drivers/net/can/usb/ucan.c
> @@ -0,0 +1,1596 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Driver for Theobroma Systems UCAN devices, Protocol Version 3
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

[...snip...]

> +static struct ucan_urb_context *ucan_alloc_context(struct ucan_priv *up)
> +{
> +	int i;
> +	unsigned long flags;
> +	struct ucan_urb_context *ret = NULL;
> +
> +	if (WARN_ON_ONCE(!up->context_array))
> +		return NULL;
> +
> +	/* execute context operation atomically */
> +	spin_lock_irqsave(&up->context_lock, flags);
> +
> +	for (i = 0; i < up->device_info.tx_fifo; i++) {
> +		if (!up->context_array[i].allocated) {
> +			/* update context */
> +			ret = &up->context_array[i];
> +			up->context_array[i].allocated = true;
> +
> +			/* stop queue if necessary */
> +			up->available_tx_urbs--;
> +			if (!up->available_tx_urbs)
> +				netif_stop_queue(up->netdev);
> +
> +			goto done_restore;

break instead of goto!?

> +		}
> +	}
> +
> +done_restore:
> +	spin_unlock_irqrestore(&up->context_lock, flags);
> +	return ret;
> +}
> +
> +static bool ucan_release_context(struct ucan_priv *up,
> +				 struct ucan_urb_context *ctx)
> +{
> +	unsigned long flags;
> +	bool ret = false;
> +
> +	if (WARN_ON_ONCE(!up->context_array))
> +		return false;
> +
> +	/* execute context operation atomically */
> +	spin_lock_irqsave(&up->context_lock, flags);
> +
> +	/* context was not allocated, maybe the device sent garbage */
> +	if (!ctx->allocated)
> +		goto done_restore;

        if (ctx->allocated) {

> +	ctx->allocated = false;
> +
> +	/* check if the queue needs to be woken */
> +	if (!up->available_tx_urbs)
> +		netif_wake_queue(up->netdev);
> +	up->available_tx_urbs++;
> +

        }
> +done_restore:

No need for a label.

> +	spin_unlock_irqrestore(&up->context_lock, flags);
> +	return ret;

Hm, what is "ret" good for? The value is always "false".

Maybe it's better to print an error message here and make
this function void.

> +}

[...snip...]

> +/* Handle a CAN error frame that we have received from the device.
> + * Returns true if the can state has changed.
> + */
> +static bool ucan_handle_error_frame(struct ucan_priv *up,
> +				    struct ucan_message_in *m,
> +				    canid_t canid)
> +{
> +	enum can_state new_state = up->can.state;
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
> +		if (d1 & CAN_ERR_CRTL_RX_OVERFLOW)
> +			net_stats->rx_over_errors++;
> +
> +		/* controller state bits: if multiple are set the worst wins */
> +		if (d1 & CAN_ERR_CRTL_ACTIVE)
> +			new_state = CAN_STATE_ERROR_ACTIVE;
> +
> +		if (d1 & (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING))
> +			new_state = CAN_STATE_ERROR_WARNING;
> +
> +		if (d1 & (CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE))
> +			new_state = CAN_STATE_ERROR_PASSIVE;
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
> +	/* no state change - we are done */
> +	if (up->can.state == new_state)
> +		return false;
> +
> +	/* we switched into a better state */
> +	if (up->can.state > new_state) {
> +		up->can.state = new_state;
> +		return true;
> +	}
> +
> +	/* we switched into a worse state */
> +	up->can.state = new_state;
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		can_stats->bus_off++;
> +		can_bus_off(up->netdev);

How does the CAN controller firmware handle bus-off? Does it recover
automatically? "can_bus_off()" will restart the CAN controller after
"restart-ms" or manually via netlink "restart" command by calling
"ucan_set_mode(CAN_START_MODE)":

  # ip link set canX type can restart-ms 100
  # ip link set canX type can restart

See also:

  https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev.c#L597

> +		netdev_info(up->netdev, "link has gone into BUS-OFF state\n");

"can_bus_off()" already prints a message.

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
> +	return true;
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
> +	canid_t canid;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	struct net_device_stats *stats = &up->netdev->stats;
> +
> +	/* get the contents of the length field */
> +	len = le16_to_cpu(m->len);
> +
> +	/* check sanity */
> +	if (len < UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id)) {
> +		netdev_warn(up->netdev, "invalid input message len: %d\n", len);
> +		return;
> +	}
> +
> +	/* handle error frames */
> +	canid = le32_to_cpu(m->msg.can_msg.id);
> +	if (canid & CAN_ERR_FLAG) {
> +		bool busstate_changed = ucan_handle_error_frame(up, m, canid);
> +
> +		/* if berr-reporting is off only state changes get through */
> +		if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> +		    !busstate_changed)
> +			return;
> +	} else {
> +		canid_t canid_mask;
> +		/* compute the mask for canid */
> +		canid_mask = CAN_RTR_FLAG;
> +		if (canid & CAN_EFF_FLAG)
> +			canid_mask |= CAN_EFF_MASK | CAN_EFF_FLAG;
> +		else
> +			canid_mask |= CAN_SFF_MASK;
> +
> +		if (canid & ~canid_mask)
> +			netdev_warn(up->netdev,
> +				    "masking unexpected set bits in canid (canid %x, mask %x)",

Line too long... there are a few more lines exceeding 80 chars.

> +				    canid, canid_mask);
> +
> +		canid &= canid_mask;
> +	}
> +
> +	/* allocate skb */
> +	skb = alloc_can_skb(up->netdev, &cf);
> +	if (!skb)
> +		return;
> +
> +	/* fill the can frame */
> +	cf->can_id = canid;
> +
> +	/* compute DLC taking RTR_FLAG into account */
> +	cf->can_dlc = ucan_get_can_dlc(&m->msg.can_msg, len);
> +
> +	/* copy the payload of non RTR frames */
> +	if (!(cf->can_id & CAN_RTR_FLAG) || (cf->can_id & CAN_ERR_FLAG))
> +		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);
> +
> +	/* don't count error frames as real packets */
> +	stats->rx_packets++;
> +	stats->rx_bytes += cf->can_dlc;
> +
> +	/* pass it to Linux */
> +	netif_rx(skb);
> +}

[...snip...]

You may also want to replace

	it (ret)
		goto err;

with

	return ret;

in "ucan_open()" and  "ucan_probe()".

You can then add my:

  Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Thanks for your contribution!

Wolfgang.
