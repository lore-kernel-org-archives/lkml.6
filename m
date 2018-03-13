Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeCMR4T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:56:19 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:46046 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752519AbeCMR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:56:16 -0400
Subject: Re: [PATCH v2 0/1] Open questions
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Message-ID: <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
Date: Tue, 13 Mar 2018 18:40:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This email addresses open questions from the v1 review cycle.

Three emails are answered, you can skip to sections
by searching for the header text:

* On 07.02.18 08:17, Wolfgang Grandegger wrote
* On 09.02.18 11:40, Marc Kleine-Budde wrote
* On 06.02.18 12:58, Andri Yngvason wrote

Best regards,
Jakob


On 07.02.18 08:17, Wolfgang Grandegger wrote:
 > - please remove dev_dbg's just useful for driver development,
 >    especially in the TX and RX path.

Done

 > - I do not see CAN error states being handled. It's
 >    mandatory!

Done

 > - The TX done is handled when the transmission callback is done.
 >    This has some unnice side effects. A real TX done message would
 >    be much better.

Done

 > Is "enpoint" a typo? Here an in a few other places!

Done

 >> +/* Callback when the device sends the IRQ sate *
 >
 > Typo!

Done; Interrupt Endpoint is gone in favor of TX_COMPLETE message (Used 
for Flow Control).

 >> +    if (cf->can_dlc > sizeof(m->msg.can_msg.data))
 >> +        goto err_freeskb;
 >
 > Is'nt this worth an error message?
 >
 >> +
 >> +    if (cf->can_dlc < 0)
 >> +        goto err_freeskb;
 >
 > Ditto.

sizeof: Added error message
can_dlc < 0: if statement is unneccessary (can_dlc is u8, and 
comparision always evaluates fasle); statment deleted

 >> +    if (cf->can_id & CAN_RTR_FLAG) {
 >> +        cf->can_id |= CAN_RTR_FLAG;
 >
 > This flags is already set.

Fixed

 >> +        cf->can_id |= CAN_ERR_FLAG;
 >
 > Ditto.

Fixed; Error Frame handling revised

 >> +    ret = usb_submit_urb(up->irq_urb, GFP_KERNEL);
 >> +    if (ret) {
 >> +        kfree(up->irq_data);
 >> +        usb_free_urb(up->irq_urb);
 >
 > Please use labels to cleanup in reverse order.
 >
 >> +        goto err;
 >> +    }

Done; Interrupt Endpoint is gone in favor of TX_COMPLETE message (Used 
for Flow Control).

 >> +        urb = usb_alloc_urb(0, GFP_KERNEL);
 >> +        if (!urb)
 >> +            goto err;
 >
 > What about:
 >
 >          kfree(up->irq_data);
 >          usb_free_urb(up->irq_urb);

Revised open code; Interrupt Endpoint is gone ... you know already about 
this.

 >> +    /* Infvalid interface Settings */
 >
 > Typo.

Fixed; probe code revised

 >> +    if (up->in_ep->wMaxPacketSize < sizeof(struct ucan_message_in))
 >> +        goto err_free_candev;
 >> +    if (up->out_ep->wMaxPacketSize < sizeof(struct ucan_message_out))
 >> +        goto err_free_candev;
 >> +    if (up->irq_ep->wMaxPacketSize < sizeof(u32))
 >> +        goto err_free_candev;
 >
 > Could be or'ed together.

I believe separating them support readability

On 09.02.18 11:40, Marc Kleine-Budde wrote:
 > Does the controller have a serial number and expose it via the USB? Does
 > it show up as ID_SERIAL_SHORT by "udevadm info --path=...."?

Yes!

# udevadm info /sys/class/net/can0 | grep ID_SERIAL_SHORT
E: ID_SERIAL_SHORT=004000405750511920353631

 >> +++ b/Documentation/networking/can_ucan_protocol.txt
 >
 > Can you convert the Textfilen into .rst
 > (http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html)?

Done; Updated file reflecting protocol changes

 >> +The UCAN protocol has been designed to be hardware-independent.
 >> +It is modeled closely after how Linux represents CAN devices
 >
 > modelled

We believe it is modeled in en_US (modelled is used in en_GB)

 >> +All structures mentioned in this document are defined in
 >> +drivers/net/can/usb/ucan.h .
 >
 > Please fold the .h into the .c file. As no one besides the driver 
uses them.

Done

 >> +IN enpoint: The device sends CAN frames and device
 >
 > endpoint

Done

 >> +the device uses the "len" field to jump to the next
 >> +ucan_message_out value. Each ucan_message_out must be aliged
 >
 > aligned

Done

 >> +* UCAN_OUT_COMMAND: Send a simple command to the device 
(parameters: cmd,
 >> +  subcmd, val). See the comments in drivers/net/can/usb/ucan.h for 
details.
 >
 > merge .h -> .c

Done

 >> +      UCAN is an microcontroller-based USB-CAN interface that
 >> +      is integrated on System-on-Modules made by Theobroma Systems
 >> +      (https://www.theobroma-systems.com/som-products).
 >
 > Why not link to the controller's website directly?

Did not exist at the time, now it does and we are linking to 
https://www.theobroma-systems.com/seal .

 >> + * Copyright (C) 2015 Theobroma Systems Design und Consulting GmbH
 >> + *
 >> + * This driver is inspired by the 4.0.0 version of 
drivers/net/can/usb/ems_usb.c
 >
 > Do you need to add the ems_usb.c's copyright here?

We used the ems driver as starting point for the v1 driver that we posted.
However, we are now at protocol version 3 and not much is left of the 
ems driver,
we think we can drop this statement.

 >> +#include "ucan.h"
 >> +
 >> +MODULE_LICENSE("GPL v2");
 >> +MODULE_AUTHOR("Martin Elshuber, Theobroma Systems Design und 
Consulting GmbH <martin.elshuber@theobroma-systems.com>");
 >> +MODULE_DESCRIPTION("Driver for Theobroma Systems UCAN devices");
 >
 > I think we usually have these at the end of the driver.

Done, moved to the end

 >> +#define MAX_TX_URBS 8
 >> +#define MAX_RX_URBS 8
 >> +#define TX_QUEUE_STOP_THRESHOLD 1
 >
 > Please add a common prefix to these defines, e.g. UCAN_

Done

 >> +static struct usb_device_id ucan_table[] = {
 >> +    {USB_DEVICE(0x2294, 0x425a)},
 >> +    {} /* Terminating entry */
 >> +};
 >> +
 >> +MODULE_DEVICE_TABLE(usb, ucan_table);
 >
 > Usually we have this directly in front of the function that uses it.

Done

 >> +/* Driver private data */
 >> +struct ucan {
 >
 > We usually name this struct ucan_priv, and the variable using it just
 > "priv".

We renamed the struct to ucan_priv but left "up" (user pointer) as it is 
used everywhere.

 >> +    u8 *tx_msg_buffer;
 >> +    u8 *rx_msg_buffer;
 >
 > If you use void *, you save a lot of casts.

Variables removed. Code was revised.

 >> +    m->type = __cpu_to_le16(UCAN_OUT_COMMAND);
 >> +    m->len = __cpu_to_le16(UCAN_OUT_LEN(m->msg.command));
 >
 > Why do you use __cpu_to_* instead of cpu_to_*?

Fixed, converted to cpu_to_*.

 >> +    m->msg.command.cmd = cmd;
 >> +    m->msg.command.subcmd = subcmd;
 >> +    m->msg.command.val = __cpu_to_le16(value);
 >> +
 >> +    return usb_bulk_msg(up->udev,
 >> +        usb_sndbulkpipe(up->udev, up->out_ep->bEndpointAddress &
 >> +                      USB_ENDPOINT_NUMBER_MASK),
 >> +        m, __le16_to_cpu(m->len), &len, 1000);
 >
 > Why do you assign &len? It's not used. You can pass in a NULL pointer,
 > if you are not interested in the result.
 >
 > What I don't like is the back and forth conversion of m->len. Better use
 > len.
 >
 > len = UCAN_OUT_LEN(m->msg.command);
 > m->len = cpu_to_le16(len);
 >
 > and use "len" in the usb_bulk_msg() call.

Protocol version 3 does not use usb_bulk_msg anymore, control requests 
are moved to the control pipe.

 >> +/* Request the device Information */
 >> +static int ucan_get_device_info(struct ucan *up)
 >> +{
 >> +    int ret;
 >> +    int len;
 >> +    struct can_bittiming_const *bittiming =
 >> +        &up->device_info.bittiming_const;
 >> +    struct ucan_message_in *m = (struct ucan_message_in 
*)up->rx_msg_buffer;
 >
 > Please move these two in front of the "ret" and "len".

Done

 >> +    /* retrieve the information */
 >> +    ret = usb_bulk_msg(up->udev,
 >> +        usb_rcvbulkpipe(up->udev, up->in_ep->bEndpointAddress &
 >> +                      USB_ENDPOINT_NUMBER_MASK),
 >> +        m, up->in_ep->wMaxPacketSize, &len, 1000);
 >> +    if (ret)
 >> +        return ret;
 >> +
 >
 > Please check first if "len" is the message length you think you have
 > received, before looking at the message's data.
 >
 >> +    /* check sanity */
 >> +    if (m->type != __cpu_to_le16(UCAN_IN_DEVICE_INFO))
 >> +        return -EINVAL;
 >> +
 >> +    if (__le16_to_cpu(m->len) != UCAN_IN_LEN(m->msg.device_info))
 >> +        return -EINVAL;

Code revised. The check is now at the end of Stage 2 in ucan_probe.

 >> +    bittiming->tseg2_max = m->msg.device_info.tseg2_max;
 >> +    bittiming->sjw_max   = m->msg.device_info.sjw_max;
 > Please use just one space before the "=".

Done

 >> +    if (__le16_to_cpu(m->msg.device_info.ctrlmodes) & 
UCAN_MODE_LOOPBACK)
 >> +        up->can.ctrlmode_supported |= CAN_CTRLMODE_LOOPBACK;
 >
 > You might want to convert the ctrlmodes to cpu just once and assign it
 > to a locale variable.

Done

 >> +/* Callback when the device sends the IRQ sate *
 >
 > Please remove the stray "*" at the end of this line.

Removed

 >> +    switch (urb->status) {
 >> +    case 0:
 >> +        WRITE_ONCE(up->free_slots, __le32_to_cpu(*up->irq_data));
 >
 > Can you please create and use a struct for the irq_data, too.

irq_data does not exist anymore

 >> +    /* fill the can frame */
 >> +    cf->can_id = __le32_to_cpu(m->msg.can_msg.id);
 >> +    cf->can_dlc = len - (UCAN_IN_HDR_SIZE + sizeof(m->msg.can_msg.id));
 >
 > please add get_can_dlc(....)
 >
 > Please move the special RTR dlc handling here.
 >
 >> +
 >> +    if (cf->can_dlc > sizeof(m->msg.can_msg.data))
 >> +        goto err_freeskb;
 >
 > no need to check, if you use get_can_dlc().

Done

 >> +    if (cf->can_dlc < 0)
 >> +        goto err_freeskb;
 >
 > This is always true, as dlc is an unsigned value.

Removed

 >> +    /* pass it to Linux */
 >> +    netif_receive_skb(skb);
 >
 > netif_rx(skb);
 >
 >> +
 >> +    stats->rx_packets++;
 >> +    stats->rx_bytes += cf->can_dlc;
 >
 > skb and thus cf are not valid anymore after netif_rx();

Fixed

 >> +/* callback on reception of a USB message */
 >> +static void ucan_read_bulk_callback(struct urb *urb)
 >> +{
 >> +    int ret;
 >> +    int len;
 >> +    int pos;
 > = 0;

I think it is better to leave them uninitialized to give the compiler a
chance to detect possible read of garbage. pos is initialised just before
the loop to show the code reader the initial value where it is necessary.
len was moved into the loop scope.

 >> +        /* copy the message header */
 >> +        memcpy(&m, urb->transfer_buffer, UCAN_IN_HDR_SIZE);
 >
 > Uh, that's only a half filled struct for now :)

Yes the body was copied later. But it has been changed to cast instead 
of copy.

 >> +        // copy remainder of packet
 >
 > no C++ comments

Fixed (searched for all "//")

 >> +        switch (__le16_to_cpu(m.type)) {
 >> +        case UCAN_IN_RX:
 >> +            ucan_rx_can_msg(up, &m);
 >> +            break;
 >> +        default:
 >> +            dev_warn(&up->udev->dev,
 >> +                 "invalid input message type\n");
 >> +            break;
 >> +        }
 >
 > The type check can be done before copying the data, right?

Copy was removed (see 2 comments above)

 >> +    /* get the urb context */
 >> +    if (WARN_ON(!context))
 >> +        return;
 >
 > Can this happen?

Not unless there is a bug in the code. But we want to get a message
before dereferencing a pointer.

 >> +    /* urb state check */
 >> +    if (urb->status)
 >> +        netdev_info(up->netdev, "Tx URB aborted (%d)\n", urb->status);
 >> +
 >> +    netif_trans_update(up->netdev);
 >
 > not needed

Removed, only kept in start_xmit

 >> +    /* restart the queue if necessary */
 >> +    if (netif_queue_stopped(up->netdev))
 >> +        netif_wake_queue(up->netdev);
 >
 > Just call netif_wake_queue() directly.

Fixed in two places (note; this code was revised)

 > As Wolfgang pointed out, please cleanup your error handling.

I think we fixed the issues

 >> +    m = usb_alloc_coherent(up->udev, size, GFP_ATOMIC, 
&urb->transfer_dma);
 >> +    if (!m) {
 >> +        netdev_err(netdev, "No memory left for USB buffer\n");
 >> +        usb_free_urb(urb);
 >> +        goto drop;
 >> +    }
 >
 > I think you can remove the netdev_err() as the framework will generate
 > error error messages in case of OOM.

Unless there is a buffer left in a pool Linux calls dma_alloc_attrs
which hands it over to the driver to allocate a buffer. If the
driver does not print a message I do not see any message about that

 >> +    /* build the USB message */
 >> +    if (cf->can_dlc > sizeof(m->msg.can_msg.data))
 >> +        cf->can_dlc = sizeof(m->msg.can_msg.data);
 >
 > Frames with illegal dlc have aready been dropped in
 > can_dropped_invalid_skb().

Done

 >> +    WARN_ON_ONCE(!context);
 >> +    if (!context) {
 >> +        usb_free_coherent(up->udev, size, m, urb->transfer_dma);
 >> +        usb_free_urb(urb);
 >> +        goto drop;
 >
 > you should return NETDEV_TX_BUSY in case of no context.

Done. Is it correct to not free the SKB in this case? I am not sure 
about this.

 >> +        /* Slow down tx path, if fifo state is low */
 >> +        if ((atomic_read(&up->active_tx_urbs) >= MAX_TX_URBS) ||
 >> +            (READ_ONCE(up->free_slots) < TX_QUEUE_STOP_THRESHOLD)) {
 >
 > What's the difference between free_slots and tx_urbs? Why double account?

Code was revised. There is only one variable "atomic_t avail". On open
it is initialized to the tx_queue size of the device. Once it
decreases to zero the queue is stopped. This variable it tightly
coupled to the number of available contexts and is maintained within
the respective functions

On 06.02.18 12:58, Andri Yngvason wrote:
 >> +An UCAN device uses three USB endpoints:
 > Even tough "U" is a vowel, in this case, most english speaking people 
will read
 > this as "Yoocan", which makes it awkward to say "An" in front of it. 
I recommend
 > that you change the "An" to an "A".

Fixed.

 > Nitpick: Is it not evident by the function's name what it does?
 >> +/* Request the device Information */
 >> +static int ucan_get_device_info(struct ucan *up)
 >> +{

Yes, maybe, but I'd rather still have a function comment

 > Missing one "t" in the word "state":
 >> +/* Callback when the device sends the IRQ sate *

Was removed (IRQ endpoint is gone)

 >> +               if (cf->data[1] &
 > I think you mean to say CAN_ERR_CRTL_RX_PASSIVE | 
CAN_ERR_CRTL_TX_PASSIVE:
 >> +                   (CAN_ERR_CRTL_RX_WARNING | 
CAN_ERR_CRTL_TX_WARNING)) {
 >> +                       up->can.can_stats.error_passive++;
 >> +               }
 >
 > Question: Does UCAN send CAN_ERR_CRTL_ACTIVE when the controller has 
recovered
 > back to error active?
 >
 > It seems that up->can.state is not set anywhere. The state should be 
set so that
 > it can be reported via netlink.

up->can.state is now updated. Upon restart the driver sets the
bus-state to ERROR_PASSIVE. Upon CAN events (transmission or
reception) the device sends an error frame upon bus state change (see
updated documenation). In case of BUS-OFF recover this indicates either
ERROR_ACTIVE or BUS_OFF.

 > Nitpick: This function has a lot of code segments with comments that 
explain
 > what they do. It might be a good idea to turn those segments into 
their own
 > functions. This applies to other functions aswell. Anyhow, this is 
one of those
 > things that some people would call "a matter of taste", so don't 
sweat it.
 >> +/* callback when Linux needs to send a can frame */
 >> +static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
 >> +                                  struct net_device *netdev)
 >> +{

Code structure has been improved a little

 > What is the purpose of having a separate message struct for RTR? Does 
it not
 > just complicate things? Sure, you can shave off 8 bytes, but what's 
the point?
 >> +               /***************************************************
 >> +                * Transmit CAN frame
 >> +                * (type == UCAN_TX) && ((msg.can_msg.id & 
CAN_RTR_FLAG) == 0)
 >> +                ***************************************************/

We removed it

 > Same comment as above for the RTR:
 >> +               /***************************************************
 >> +                * CAN Frame received
 >> +                * (type == UCAN_IN_RX)
 >> +                * && ((msg.can_msg.id & CAN_RTR_FLAG) == 0)
 >> +                ***************************************************/

We removed it
