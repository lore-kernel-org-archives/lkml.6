Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA5C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6963C20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6963C20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeGLGRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:17:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeGLGRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:17:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FDBDC97;
        Thu, 12 Jul 2018 06:09:46 +0000 (UTC)
Date:   Thu, 12 Jul 2018 08:09:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, ltyrala@cadence.com,
        adouglas@cadence.com
Subject: Re: [PATCH 01/31] usb: usbssp: Defined register maps and other
 useful structures.
Message-ID: <20180712060944.GA20905@kroah.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-2-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531374448-26532-2-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:46:58AM +0100, Pawel Laszczak wrote:
> It is a first patch introduce Cadence USBSSP DRD
> controller. This patch is related to device side.
> 
> Device part of USBSSP controller base on standard
> XHCI specification.
> 
> File define macros used bye USBSSP controller,
> structures holding and grouping registers, and other
> object that are used by device controller.
> 
> Register map include:
> struct usbssp_cap_regs - Capabilities Register Set.
> struct usbssp_op_regs - Operational Register Set.
> struct usbssp_intr_reg - Interrupter Register Set.
> struct usbssp_run_regs - Runtime Register Set.
> 
> Object used by hardware includes:
> struct usbssp_doorbell_array - array used for arming command and
> 	transfer rings.
> struct usbssp_slot_ctx - holds information related to Slot Context.
> struct usbssp_ep_ctx - hold information related to Endpoint Context.
> struct usbssp_input_control_ctx - hold information about
> 	Input Control Context.
> struct usbssp_link_trb - define link TRB.
> struct usbssp_transfer_event - define Transfer Event TRB.
> struct usbssp_event_cmd - define Command Event TRB.
> struct usbssp_generic_trb - generic used TRB object.
> 
> Patch also add some high level object that hold  information
> used in driver.
> 
> Some of them are:
> struct usbssp_udc - main object in driver which is passed
> 	as parameter to most of function in driver and allows
> 	to access to all other structures.
> struct usbssp_ep - holds information related to USB endpoint.
> struct usbssp_command - describe command send to Event Ring.
> struct usbssp_device - holds information relate do USB device.
> struct usbssp_segment - holds information describing segments of TRBs.
> struct usbssp_td  - hold information about Transfer Descriptor.
> struct usbssp_ring - holds information related to Transfer, Event or
> 	Command ring.
> struct usbssp_request - holds information related to single transfer.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/usbssp/gadget.h | 1567 +++++++++++++++++++++++++++++++++++
>  1 file changed, 1567 insertions(+)
>  create mode 100644 drivers/usb/usbssp/gadget.h
> 
> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
> new file mode 100644
> index 000000000000..486e868068b7
> --- /dev/null
> +++ b/drivers/usb/usbssp/gadget.h
> @@ -0,0 +1,1567 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USBSSP device controller driver
> + *
> + * Copyright (C) 2018 Cadence.
> + *
> + * Author: Pawel Laszczak
> + *
> + * A lot of code based on Linux XHCI driver.
> + * Origin: Copyright (C) 2008 Intel Corp.
> + */
> +
> +#ifndef __LINUX_USBSSP_GADGET_H
> +#define __LINUX_USBSSP_GADGET_H
> +
> +#include <linux/usb.h>
> +#include <linux/timer.h>
> +#include <linux/kernel.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/usb/gadget.h>

Why does this .h file need all of these?  Only include what is needed to
build this specific file if at all possible.

> +
> +/* Max number slots - only 1 is allowed */
> +#define DEV_MAX_SLOTS 1
> +
> +/* max ports for USBSSP-Dev - only 2 are allowed*/
> +#define MAX_USBSSP_PORTS	2
> +
> +#define USBSSP_EP0_SETUP_SIZE 512
> +
> +/*16 for in and 16 for out */

"/* 16..."

> +#define USBSSP_ENDPOINTS_NUM	32

Odd alignment of all of these defines, either make them line up or not,
what you have is an odd mix of tabs and spaces.

> +/**
> + * struct usbssp_cap_regs - USBSSP Registers.
> + * @hc_capbase:		length of the capabilities register and DC version number
> + * @hcs_params1:	HCSPARAMS1 - Structural Parameters 1
> + * @hcs_params2:	HCSPARAMS2 - Structural Parameters 2
> + * @hcs_params3:	HCSPARAMS3 - Structural Parameters 3
> + * @hcc_params:		HCCPARAMS - Capability Parameters
> + * @db_off:		DBOFF - Doorbell array offset
> + * @run_regs_off:	RTSOFF - Runtime register space offset
> + * @hcc_params2:	HCCPARAMS2 Capability Parameters 2,
> + */
> +struct usbssp_cap_regs {
> +	__le32	hc_capbase;
> +	__le32	hcs_params1;
> +	__le32	hcs_params2;
> +	__le32	hcs_params3;
> +	__le32	hcc_params;
> +	__le32	db_off;
> +	__le32	run_regs_off;
> +	__le32	hcc_params2;
> +	/* Reserved up to (CAPLENGTH - 0x1C) */
> +};

Does this, and your other structures that map to hardware, need to be
__packed?

> +
> +/* Reset DC - resets internal DC state machine and all registers (except
> + * PCI config regs).
> + */
> +#define CMD_RESET	(1 << 1)

For all of these, try using the BIT() macro.

> +/* bit 2 reserved and zeroed */
> +/* true: port has an over-current condition */
> +#define PORT_OC			(1 << 3)
> +/* true: port reset signaling asserted */
> +#define PORT_RESET		(1 << 4)
> +/* Port Link State - bits 5:8
> + * A read gives the current link PM state of the port,
> + * a write with Link State Write Strobe set sets the link state.
> + */
> +
> +#define PORT_PLS_MASK	(0xf << 5)
> +#define XDEV_U0		(0x0 << 5)

Your spacing just doesn't make much sense at all.  Is that comment for
the line above, or below?  Please make these easier to understand, as it
is, they are not.

> +#define XDEV_RESUME		(0xf << 5)
> +
> +/* true: port has power (see HCC_PPC) */
> +#define PORT_POWER	(1 << 9)

Ok, that works, but why no blank line after this?  You dive right into
another comment:

> +/* bits 10:13 indicate device speed:
> + * 0 - undefined speed - port hasn't be initialized by a reset yet
> + * 1 - full speed
> + * 2 - low speed
> + * 3 - high speed
> + * 4 - super speed
> + * 5-15 reserved
> + */
> +#define DEV_SPEED_MASK		(0xf << 10)

And try using the multi-line format that the rest of the kernel uses
(not networking), it's easier to read.

> +/* Port Link State Write Strobe - set this when changing link state */
> +#define PORT_LINK_STROBE	(1 << 16)

Again with the BIT() usage.

Just clean up the whitespace to make this whole file easier to read
please, I'm stopping reviewing here.

Oops, no, one final thing:

> +#define usbssp_dbg(usbssp_data, fmt, args...) \
> +	dev_dbg(usbssp_data->dev, fmt, ## args)
> +
> +#define usbssp_err(usbssp_data, fmt, args...) \
> +	dev_err(usbssp_data->dev, fmt, ## args)
> +
> +#define usbssp_warn(usbssp_data, fmt, args...) \
> +	dev_warn(usbssp_data->dev, fmt, ## args)
> +
> +#define usbssp_warn_ratelimited(usbssp_data, fmt, args...) \
> +	dev_warn_ratelimited(usbssp_data->dev, fmt, ## args)
> +
> +#define usbssp_info(usbssp_data, fmt, args...) \
> +	dev_info(usbssp_data->dev, fmt, ## args)

All drivers feel they are unique and special like all other drivers, so
they want to create their own debugging macros.  Don't do it, just use
dev_dbg() and friends directly please.  It saves no one any time to use
special ones as then everyone has to go and look up exactly what they
do.

Don't be special, you are like all of the rest of us :)

thanks,

greg k-h
