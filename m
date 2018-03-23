Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCWInC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:43:02 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:37668 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeCWIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:42:59 -0400
Subject: Re: [PATCH v3 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180322135338.60923-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180322135338.60923-2-jakob.unterwurzacher@theobroma-systems.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <f25294e2-6b27-34c8-b03e-75a0ab84373b@grandegger.com>
Date: Fri, 23 Mar 2018 09:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322135338.60923-2-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 22.03.2018 um 14:53 schrieb Jakob Unterwurzacher:
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
>  drivers/net/can/usb/ucan.c                     | 1628 ++++++++++++++++++++++++
>  5 files changed, 1955 insertions(+)
>  create mode 100644 Documentation/networking/can_ucan_protocol.rst
>  create mode 100644 drivers/net/can/usb/ucan.c

> 

[...snip...]

> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> new file mode 100644
> index 000000000000..5a98ef5d95da
> --- /dev/null
> +++ b/drivers/net/can/usb/ucan.c

[...snip...]

> +static void ucan_rx_can_msg(struct ucan_priv *up, struct ucan_message_in *m)
> +{
> +	int len;
> +	canid_t canid, canid_mask;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	struct net_device_stats *stats = &up->netdev->stats;
> +
> +	/* get the contents of the length field */
> +	len = le16_to_cpu(m->len);
> +
> +	/* check sanity */
> +	if (len < UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id)) {
> +		dev_warn(&up->udev->dev,
> +			 "%s: invalid input message len: %d\n", __func__, len);
> +		return;
> +	}
> +
> +	/* handle error frames */
> +	canid = le32_to_cpu(m->msg.can_msg.id);
> +	if (canid & CAN_ERR_FLAG) {
> +		bool busstate_changed = ucan_handle_error_frame(up, m, canid);
> +		/* if berr-reporting is off only state changes get through */
> +		if (!(up->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
> +		    !busstate_changed)
> +			return;
> +	}
> +
> +	/* allocate skb */
> +	skb = alloc_can_skb(up->netdev, &cf);
> +	if (!skb)
> +		return;
> +
> +	/* compute the mask for canid */
> +	canid_mask = CAN_RTR_FLAG | CAN_ERR_FLAG;
> +	if (canid & CAN_EFF_FLAG)
> +		canid_mask |= CAN_EFF_MASK | CAN_EFF_FLAG;
> +	else
> +		canid_mask |= CAN_SFF_MASK;

You do not want that for error frames... or have I missed something?

> +	/* fill the can frame */
> +	cf->can_id = canid & canid_mask;
> +
> +	/* compute DLC taking RTR_FLAG into account */
> +	cf->can_dlc = ucan_get_can_dlc(&m->msg.can_msg, len);
> +
> +	/* copy the payload of non RTR frames */
> +	if (!(cf->can_id & CAN_RTR_FLAG))
> +		memcpy(cf->data, m->msg.can_msg.data, cf->can_dlc);

Ditto.

> +	/* don't count error frames as real packets */
> +	stats->rx_packets++;
> +	stats->rx_bytes += cf->can_dlc;
> +
> +	/* pass it to Linux */
> +	netif_rx(skb);
> +}
> +
> +/* callback indicating completed transmission */
> +static void ucan_tx_complete_msg(struct ucan_priv *up,
> +				 struct ucan_message_in *m)
> +{
> +	u16 count, i;
> +	u8 echo_index, dlc;
> +	u16 len = le16_to_cpu(m->len);
> +
> +	struct ucan_urb_context *context;
> +
> +	if (len < UCAN_IN_HDR_SIZE || (len % 2 != 0)) {
> +		dev_err(&up->udev->dev,
> +			"%s: invalid tx complete length\n",
> +			__func__);
> +		return;
> +	}
> +
> +	count = (len - UCAN_IN_HDR_SIZE) / 2;
> +	for (i = 0; i < count; i++) {
> +		/* we did not submit such echo ids */
> +		echo_index = m->msg.can_tx_complete_msg[i].echo_index;
> +		if (echo_index >= up->device_info.tx_fifo) {
> +			up->netdev->stats.tx_errors++;
> +			dev_err(&up->udev->dev,
> +				"%s: device answered with invalid echo_index\n",
> +				__func__);
> +			continue;
> +		}
> +
> +		/* gather information from the context */
> +		context = &up->context_array[echo_index];
> +		dlc = READ_ONCE(context->dlc);
> +
> +		/* Release context and restart queue if necessary.
> +		 * Also check if the context was allocated
> +		 */
> +		if (ucan_release_context(up, context))
> +			continue;
> +
> +		if (m->msg.can_tx_complete_msg[i].flags &
> +		    UCAN_TX_COMPLETE_SUCCESS) {
> +			/* update statistics */
> +			up->netdev->stats.tx_packets++;
> +			up->netdev->stats.tx_bytes += dlc;
> +			can_get_echo_skb(up->netdev, echo_index);
> +		} else {
> +			up->netdev->stats.tx_dropped++;
> +			can_free_echo_skb(up->netdev, echo_index);
> +		}
> +	}
> +}
> +
> +/* callback on reception of a USB message */
> +static void ucan_read_bulk_callback(struct urb *urb)
> +{
> +	int ret;
> +	int pos;
> +	struct ucan_priv *up = urb->context;
> +	struct net_device *netdev = up->netdev;
> +	struct ucan_message_in *m;
> +
> +	/* the device is not up and the driver should not receive any
> +	 * data on the bulk in pipe
> +	 */
> +	if (WARN_ON(!up->context_array)) {
> +		usb_free_coherent(up->udev,
> +				  up->in_ep->wMaxPacketSize,
> +				  urb->transfer_buffer,
> +				  urb->transfer_dma);
> +		return;
> +	}
> +
> +	/* check URB status */
> +	switch (urb->status) {
> +	case 0:
> +		break;
> +	case -ENOENT:
> +	case -EPIPE:
> +	case -EPROTO:
> +	case -ESHUTDOWN:
> +	case -ETIME:
> +		/* urb is not resubmitted -> free dma data */
> +		usb_free_coherent(up->udev,
> +				  up->in_ep->wMaxPacketSize,
> +				  urb->transfer_buffer,
> +				  urb->transfer_dma);
> +		dev_dbg(&up->udev->dev,
> +			"%s: ENOENT|EPIPE|EPROTO|ESHUTDOWN|ETIME\n",

Some space would make that message more readable, I think!

> +			__func__);
> +		return;
> +	default:
> +		goto resubmit;
> +	}
> +
> +	/* sanity check */
> +	if (!netif_device_present(netdev))
> +		return;
> +
> +	/* iterate over input */
> +	pos = 0;
> +	while (pos < urb->actual_length) {
> +		int len;
> +
> +		/* check sanity (length of header) */
> +		if ((urb->actual_length - pos) < UCAN_IN_HDR_SIZE) {
> +			dev_warn(&up->udev->dev,
> +				 "%s: invalid input message %d; too short (no header)\n",
> +				 __func__,
> +				 urb->actual_length);
> +			goto resubmit;
> +		}
> +
> +		/* setup the message address */
> +		m = (struct ucan_message_in *)
> +			((u8 *)urb->transfer_buffer + pos);
> +		len = le16_to_cpu(m->len);
> +
> +		/* check sanity (length of content) */
> +		if (urb->actual_length - pos < len) {
> +			dev_warn(&up->udev->dev,
> +				 "%s: invalid input message al:%d pos:%d len:%d; too short (no data)\n",
> +				 __func__,
> +				 urb->actual_length, pos, len);
> +			print_hex_dump(KERN_WARNING,
> +				       "raw data: ",
> +				       DUMP_PREFIX_ADDRESS,
> +				       16,
> +				       1,
> +				       urb->transfer_buffer,
> +				       urb->actual_length,
> +				       true);
> +
> +			goto resubmit;
> +		}
> +
> +		switch (le16_to_cpu(m->type)) {
> +		case UCAN_IN_RX:
> +			ucan_rx_can_msg(up, m);
> +			break;
> +		case UCAN_IN_TX_COMPLETE:
> +			ucan_tx_complete_msg(up, m);
> +			break;
> +		default:
> +			dev_warn(&up->udev->dev,
> +				 "%s: invalid input message type\n",
> +				 __func__);
> +			break;
> +		}
> +
> +		/* proceed to next message */
> +		pos += len;
> +		/* align to 4 byte boundary */
> +		pos = round_up(pos, 4);
> +	}
> +
> +resubmit:
> +	/* resubmit urb when done */
> +	usb_fill_bulk_urb(urb, up->udev,
> +			  usb_rcvbulkpipe(up->udev,
> +					  up->in_ep->bEndpointAddress &
> +						USB_ENDPOINT_NUMBER_MASK),
> +			  urb->transfer_buffer,
> +			  up->in_ep->wMaxPacketSize,
> +			  ucan_read_bulk_callback,
> +			  up);
> +
> +	usb_anchor_urb(urb, &up->rx_urbs);
> +	ret = usb_submit_urb(urb, GFP_KERNEL);
> +
> +	if (ret < 0) {
> +		dev_err(&up->udev->dev,
> +			"%s: failed resubmitting read bulk urb: %d\n",
> +			__func__,
> +			ret);
> +
> +		usb_unanchor_urb(urb);
> +		usb_free_coherent(up->udev, up->in_ep->wMaxPacketSize,
> +				  urb->transfer_buffer,
> +				  urb->transfer_dma);
> +
> +		if (ret == -ENODEV)
> +			netif_device_detach(netdev);
> +	}
> +}

> +static int ucan_set_bittiming(struct net_device *netdev)
> +{
> +	int ret;
> +	struct ucan_priv *up = netdev_priv(netdev);
> +	struct ucan_ctl_cmd_set_bittiming *cmd_set_bittiming;
> +
> +	cmd_set_bittiming = &up->ctl_msg_buffer->cmd_set_bittiming;
> +	cmd_set_bittiming->tq = cpu_to_le32(up->can.bittiming.tq);
> +	cmd_set_bittiming->brp = cpu_to_le16(up->can.bittiming.brp);
> +	cmd_set_bittiming->sample_point =
> +	    cpu_to_le32(up->can.bittiming.sample_point);
> +	cmd_set_bittiming->prop_seg = up->can.bittiming.prop_seg;
> +	cmd_set_bittiming->phase_seg1 = up->can.bittiming.phase_seg1;
> +	cmd_set_bittiming->phase_seg2 = up->can.bittiming.phase_seg2;
> +	cmd_set_bittiming->sjw = up->can.bittiming.sjw;
> +
> +	dev_dbg(&up->udev->dev,
> +		"Setup bittiming\n"
> +		"  bitrate: %d\n"
> +		"  sample-point: %d\n"
> +		"  tq: %d\n"
> +		"  prop_seg: %d\n"
> +		"  phase_seg1 %d\n"
> +		"  phase_seg2 %d\n"
> +		"  sjw %d\n"
> +		"  brp %d\n",
> +		up->can.bittiming.bitrate, up->can.bittiming.sample_point,
> +		up->can.bittiming.tq, up->can.bittiming.prop_seg,
> +		up->can.bittiming.phase_seg1, up->can.bittiming.phase_seg2,
> +		up->can.bittiming.sjw, up->can.bittiming.brp);

Do we need that! Is it useful for the end user? The information is also
available via "ip -d -s link show canX".

> +
> +	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_SET_BITTIMING, 0,
> +				    sizeof(*cmd_set_bittiming));
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +/* Restart the device to get it out of BUS-OFF state.
> + * Called when the user runs "ip link set can1 type can restart".
> + */
> +static int ucan_set_mode(struct net_device *netdev, enum can_mode mode)
> +{
> +	int ret;
> +	unsigned long flags;
> +	struct ucan_priv *up = netdev_priv(netdev);
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		dev_dbg(&up->udev->dev,
> +			"%s: Restarting device\n",
> +			__func__);
> +		ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESTART, 0, 0);
> +		up->can.state = CAN_STATE_ERROR_ACTIVE;
> +
> +		/* check if queue can be restarted,
> +		 * up->available_tx_urbs must be protected by the
> +		 * lock
> +		 */
> +		spin_lock_irqsave(&up->context_lock, flags);
> +
> +		if (up->available_tx_urbs > 0)
> +			netif_wake_queue(up->netdev);
> +
> +		spin_unlock_irqrestore(&up->context_lock, flags);
> +
> +		return ret;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +/* Probe the device, reset it and gather general device information */
> +static int ucan_probe(struct usb_interface *intf,
> +		      const struct usb_device_id *id)
> +{
> +	int ret;
> +	int i;
> +	u32 protocol_version;
> +	struct usb_device *udev;
> +	struct net_device *netdev;
> +	struct usb_host_interface *iface_desc;
> +	struct ucan_priv *up;
> +	struct usb_endpoint_descriptor *ep;
> +	struct usb_endpoint_descriptor *out_ep;
> +	struct usb_endpoint_descriptor *in_ep;
> +	union ucan_ctl_payload *ctl_msg_buffer;
> +	char firmware_str[sizeof(union ucan_ctl_payload) + 1];
> +
> +	udev = interface_to_usbdev(intf);
> +
> +	/* Stage 1 - Interface Parsing
> +	 * ---------------------------
> +	 *
> +	 * Identifie the device USB interface descriptor and its
> +	 * endpoints. Probing is aborted on errors.
> +	 */
> +
> +	/* check if the interface is sane */
> +	ret = -ENODEV;
> +	iface_desc = intf->cur_altsetting;
> +	if (!iface_desc)
> +		goto err;
> +
> +	/* interface sanity check */
> +	if (iface_desc->desc.bNumEndpoints != 2) {
> +		dev_err(&udev->dev,
> +			"%s: incompatible (possibly old) interface. It must have 2 endpoints but has %d\n",
> +			__func__, iface_desc->desc.bNumEndpoints);
> +		goto err;
> +	}
> +
> +	dev_info(&udev->dev, "%s: found UCAN device on interface #%d\n",
> +		 __func__, iface_desc->desc.iInterface);
> +
> +	/* check interface endpoints */
> +	in_ep = NULL;
> +	out_ep = NULL;
> +	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
> +		ep = &iface_desc->endpoint[i].desc;
> +
> +		if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != 0) &&
> +		    ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> +		     USB_ENDPOINT_XFER_BULK)) {
> +			/* In Endpoint */
> +			in_ep = ep;
> +		} else if (((ep->bEndpointAddress & USB_ENDPOINT_DIR_MASK) ==
> +			    0) &&
> +			   ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
> +			    USB_ENDPOINT_XFER_BULK)) {
> +			/* Out Endpoint */
> +			out_ep = ep;
> +		}
> +	}
> +
> +	/* check if interface is sane */
> +	if (!in_ep || !out_ep) {
> +		dev_err(&udev->dev, "%s: invalid endpoint configuration\n",
> +			__func__);
> +		goto err;
> +	}
> +	if (in_ep->wMaxPacketSize < sizeof(struct ucan_message_in)) {
> +		dev_err(&udev->dev, "%s: invalid in_ep MaxPacketSize\n",
> +			__func__);
> +		goto err;
> +	}
> +	if (out_ep->wMaxPacketSize < sizeof(struct ucan_message_out)) {
> +		dev_err(&udev->dev, "%s: invalid out_ep MaxPacketSize\n",
> +			__func__);
> +		goto err;
> +	}
> +
> +	/* Stage 2 - Device Identification
> +	 * -------------------------------
> +	 *
> +	 * The device interface seems to be a ucan device. Do further
> +	 * compatibility checks. On error probing is aborted, on
> +	 * success this stage leaves the ctl_msg_buffer with the
> +	 * reported contents of a GET_INFO command (supported
> +	 * bittimings, tx_fifo depth). This information is used in
> +	 * Stage 3 for the final driver initialisation.
> +	 */
> +
> +	/* Prepare Memory for control transferes */
> +	ctl_msg_buffer = devm_kzalloc(&udev->dev,
> +				      sizeof(union ucan_ctl_payload),
> +				      GFP_KERNEL);
> +	if (!ctl_msg_buffer)
> +		goto err;
> +
> +	/* get protocol version
> +	 *
> +	 * note: ucan_ctrl_command_* wrappers connot be used yet
> +	 * because `up` is initialised in Stage 3
> +	 */
> +	ret = usb_control_msg(udev,
> +			      usb_rcvctrlpipe(udev, 0),
> +			      UCAN_COMMAND_GET,
> +			      USB_DIR_IN | USB_TYPE_VENDOR |
> +					USB_RECIP_INTERFACE,
> +			      cpu_to_le16(UCAN_COMMAND_GET_PROTOCOL_VERSION),
> +			      iface_desc->desc.bInterfaceNumber,
> +			      ctl_msg_buffer,
> +			      sizeof(union ucan_ctl_payload),
> +			      UCAN_USB_CTL_PIPE_TIMEOUT);
> +
> +	/* older firmware version do not support this command - those
> +	 * are not supported by this drive
> +	 */
> +	if (ret != 4) {
> +		dev_err(&udev->dev,
> +			"%s: could not read protocol version, ret=%d. The firmware on this device is too old, please update!\n",
> +			__func__, ret);
> +		if (ret >= 0)
> +			ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* this driver currently supports protocol version 3 only */
> +	protocol_version =
> +		le32_to_cpu(ctl_msg_buffer->cmd_get_protocol_version.version);
> +	if (protocol_version < UCAN_PROTOCOL_VERSION_MIN ||
> +	    protocol_version > UCAN_PROTOCOL_VERSION_MAX) {
> +		dev_err(&udev->dev, "%s: device protocol version %d is not supported\n",
> +			__func__, protocol_version);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	dev_info(&udev->dev, "%s: device protocol version %d ok\n", __func__,
> +		 protocol_version);
> +
> +	/* request the device information and store it in ctl_msg_buffer
> +	 *
> +	 * note: ucan_ctrl_command_* wrappers connot be used yet
> +	 * because `up` is initialised in Stage 3
> +	 */
> +	ret = usb_control_msg(udev,
> +			      usb_rcvctrlpipe(udev, 0),
> +			      UCAN_COMMAND_GET,
> +			      USB_DIR_IN | USB_TYPE_VENDOR |
> +					USB_RECIP_INTERFACE,
> +			      cpu_to_le16(UCAN_COMMAND_GET_INFO),
> +			      iface_desc->desc.bInterfaceNumber,
> +			      ctl_msg_buffer,
> +			      sizeof(ctl_msg_buffer->cmd_get_device_info),
> +			      UCAN_USB_CTL_PIPE_TIMEOUT);
> +
> +	if (ret < 0) {
> +		dev_err(&udev->dev, "%s: failed to retrieve device info\n",
> +			__func__);
> +		goto err;
> +	}
> +	if (ret < sizeof(ctl_msg_buffer->cmd_get_device_info)) {
> +		dev_err(&udev->dev, "%s: device reported invalid device info\n",
> +			__func__);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	if (ctl_msg_buffer->cmd_get_device_info.tx_fifo == 0) {
> +		dev_err(&udev->dev, "%s: device reported invalid tx-fifo size\n",
> +			__func__);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	/* Stage 3 - Driver Initialisation
> +	 * -------------------------------
> +	 *
> +	 * Register device to Linux, prepare private structures and
> +	 * reset the device.
> +	 */
> +
> +	/* allocate driver resources */
> +	netdev = alloc_candev(sizeof(struct ucan_priv),
> +			      ctl_msg_buffer->cmd_get_device_info.tx_fifo);
> +	if (!netdev) {
> +		dev_err(&udev->dev, "%s: cannot allocate candev\n", __func__);
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	up = netdev_priv(netdev);
> +
> +	/* initialze data */
> +	up->udev = udev;
> +	up->intf = intf;
> +	up->netdev = netdev;
> +	up->intf_index = iface_desc->desc.bInterfaceNumber;
> +	up->in_ep = in_ep;
> +	up->out_ep = out_ep;
> +	up->ctl_msg_buffer = ctl_msg_buffer;
> +	up->context_array = NULL;
> +	up->available_tx_urbs = 0;
> +
> +	up->can.state = CAN_STATE_STOPPED;
> +	up->can.bittiming_const = &up->device_info.bittiming_const;
> +	up->can.do_set_bittiming = ucan_set_bittiming;
> +	up->can.do_set_mode = &ucan_set_mode;
> +	spin_lock_init(&up->context_lock);
> +	netdev->netdev_ops = &ucan_netdev_ops;
> +
> +	usb_set_intfdata(intf, up);
> +	SET_NETDEV_DEV(netdev, &intf->dev);
> +
> +	/* parse device information
> +	 * the data retrieved in Stage 2 is still available in
> +	 * up->ctl_msg_buffer
> +	 */
> +	ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
> +
> +	/* just print some device information - if available */
> +	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
> +				     sizeof(union ucan_ctl_payload));
> +	if (ret > 0) {
> +		/* copy string while ensuring zero terminiation */
> +		strncpy(firmware_str, up->ctl_msg_buffer->raw,
> +			sizeof(union ucan_ctl_payload));
> +		firmware_str[sizeof(union ucan_ctl_payload)] = '\0';
> +	} else {
> +		strcpy(firmware_str, "unknown firmware");
> +	}
> +
> +	/* device is compatible, reset it */
> +	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
> +	if (ret < 0)
> +		goto err_free_candev;
> +
> +	init_usb_anchor(&up->rx_urbs);
> +	init_usb_anchor(&up->tx_urbs);
> +
> +	up->can.state = CAN_STATE_STOPPED;
> +
> +	/* register the device */
> +	ret = register_candev(netdev);
> +	if (ret)
> +		goto err_free_candev;
> +
> +	/* initialisation complete, log device info */
> +	dev_info(&up->udev->dev,
> +		 "%s: device reports:\n"
> +		 "  Clock frequency [Hz]     : %d\n"
> +		 "  TX FIFO length           : %d\n"
> +		 "  Time segment 1 [min-max] : %d-%d\n"
> +		 "  Time segment 2 [min-max] : %d-%d\n"
> +		 "  SWJ [max]                : %d\n"
> +		 "  Prescaler [min-max,step] : %d-%d,%d\n"
> +		 "  Supported modes          : %s%s%s%s%s = 0x%x\n"
> +		 "  Firmware                 : %s\n",
> +		 __func__,
> +		 up->can.clock.freq, up->device_info.tx_fifo,
> +		 up->can.bittiming_const->tseg1_min,
> +		 up->can.bittiming_const->tseg1_max,
> +		 up->can.bittiming_const->tseg2_min,
> +		 up->can.bittiming_const->tseg2_max,
> +		 up->can.bittiming_const->sjw_max,
> +		 up->can.bittiming_const->brp_min,
> +		 up->can.bittiming_const->brp_max,
> +		 up->can.bittiming_const->brp_inc,
> +		 (up->can.ctrlmode_supported & CAN_CTRLMODE_LOOPBACK) ?
> +			"LOOPBACK" : "",
> +		 (up->can.ctrlmode_supported & CAN_CTRLMODE_LISTENONLY) ?
> +			" | LISTENONLY" : "",
> +		 (up->can.ctrlmode_supported & CAN_CTRLMODE_3_SAMPLES) ?
> +			" | 3_SAMPLES" : "",
> +		 (up->can.ctrlmode_supported & CAN_CTRLMODE_ONE_SHOT) ?
> +			" | ONE_SHOT" : "",
> +		 (up->can.ctrlmode_supported & CAN_CTRLMODE_BERR_REPORTING) ?
> +			" | BERR_REPORTING" : "",
> +		 up->can.ctrlmode_supported,
> +		 firmware_str);

Ditto!

> +	dev_info(&udev->dev, "%s: registered UCAN device at %s\n",
> +		 __func__, netdev->name);
> +
> +	/* success */
> +	return 0;
> +
> +err_free_candev:
> +	free_candev(netdev);
> +err:
> +	return ret;
> +}
> +
> +/* disconnect the device */
> +static void ucan_disconnect(struct usb_interface *intf)
> +{
> +	struct usb_device *udev;
> +	struct ucan_priv *up = usb_get_intfdata(intf);
> +
> +	udev = interface_to_usbdev(intf);
> +
> +	usb_set_intfdata(intf, NULL);
> +
> +	if (up) {
> +		unregister_netdev(up->netdev);
> +		free_candev(up->netdev);
> +	}
> +}
> +
> +static struct usb_device_id ucan_table[] = {
> +	/* Mule (soldered onto compute modules) */
> +	{USB_DEVICE_INTERFACE_NUMBER(0x2294, 0x425a, 0)},
> +	/* Seal (standalone USB stick) */
> +	{USB_DEVICE_INTERFACE_NUMBER(0x2294, 0x425b, 0)},
> +	{} /* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, ucan_table);
> +/* driver callbacks */
> +static struct usb_driver ucan_driver = {
> +	.name = "ucan",
> +	.probe = ucan_probe,
> +	.disconnect = ucan_disconnect,
> +	.id_table = ucan_table,
> +};
> +
> +module_usb_driver(ucan_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Martin Elshuber <martin.elshuber@theobroma-systems.com>");
> +MODULE_AUTHOR("Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>");
> +MODULE_DESCRIPTION("Driver for Theobroma Systems UCAN devices");

I will have a closer look later today.

Thanks,

Wolfgang.
