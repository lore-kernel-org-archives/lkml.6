Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B445FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA952133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA952133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeK2CwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:52:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57794 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeK2CwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:52:20 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wASFo8Dn005207;
        Wed, 28 Nov 2018 09:50:08 -0600
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wASFo8gw086565
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 09:50:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 28
 Nov 2018 09:50:08 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 28 Nov 2018 09:50:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wASFo4Gu007091;
        Wed, 28 Nov 2018 09:50:05 -0600
Subject: Re: [RFC PATCH v2 12/15] usb:cdns3: Adds enumeration related
 function.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-13-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFEB92C.9060903@ti.com>
Date:   Wed, 28 Nov 2018 17:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1542535751-16079-13-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/18 12:09, Pawel Laszczak wrote:
> Patch implements a set of function related to enumeration process.
> Some standard requests are handled on controller driver level and
> other are delegated to gadget core driver.
> All class requests are delegated to gadget core driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/ep0.c    | 491 ++++++++++++++++++++++++++++++++++++-
>  drivers/usb/cdns3/gadget.c | 119 +++++++++
>  drivers/usb/cdns3/gadget.h |   4 +
>  3 files changed, 610 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
> index eb92fd234bd7..6f33d98f7684 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/ep0.c
> @@ -10,6 +10,7 @@
>   *	    Peter Chen <peter.chen@nxp.com>
>   */
>  
> +#include <linux/usb/composite.h>
>  #include "gadget.h"
>  
>  static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
> @@ -52,9 +53,31 @@ static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
>  		writel(EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
>  }
>  
> +/**
> + * cdns3_ep0_delegate_req - Returns status of handling setup packet
> + * Setup is handled by gadget driver
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns zero on success or negative value on failure
> + */
> +static int cdns3_ep0_delegate_req(struct cdns3_device *priv_dev,
> +				  struct usb_ctrlrequest *ctrl_req)
> +{
> +	int ret;
> +
> +	spin_unlock(&priv_dev->lock);
> +	priv_dev->setup_pending = 1;
> +	ret = priv_dev->gadget_driver->setup(&priv_dev->gadget, ctrl_req);
> +	priv_dev->setup_pending = 0;

Why is setup_pending flag being set and cleared?

> +	spin_lock(&priv_dev->lock);
> +	return ret;
> +}
> +
>  static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
>  {
> -	//TODO: Implements this function
> +	priv_dev->ep0_data_dir = 0;
> +	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma, 8, 0);

why hardcode to 8?
Don't vendor specific requests have different lengths?

>  }
>  
>  static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
> @@ -90,9 +113,431 @@ static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
>  	}
>  }
>  
> +/**
> + * cdns3_req_ep0_set_configuration - Handling of SET_CONFIG standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, 0x7FFF on deferred status stage, error code on error

what is this magic number 0x7fff?

> + */
> +static int cdns3_req_ep0_set_configuration(struct cdns3_device *priv_dev,
> +					   struct usb_ctrlrequest *ctrl_req)
> +{
> +	enum usb_device_state device_state = priv_dev->gadget.state;
> +	struct cdns3_endpoint *priv_ep, *temp_ep;
> +	u32 config = le16_to_cpu(ctrl_req->wValue);
> +	int result = 0;
> +
> +	switch (device_state) {
> +	case USB_STATE_ADDRESS:
> +		/* Configure non-control EPs */
> +		list_for_each_entry_safe(priv_ep, temp_ep,
> +					 &priv_dev->ep_match_list,
> +					 ep_match_pending_list)
> +			cdns3_ep_config(priv_ep);

Why configure here? They should be configured at ep_enable. no?
And you don't need to maintain a ep_match/pending_list.

> +
> +		result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +
> +		if (result)
> +			return result;
> +
> +		if (config) {

What if result is USB_GADGET_DELAYED_STATUS?

> +			cdns3_set_hw_configuration(priv_dev);

usb_gadget_set_state(USB_STATE_CONFIGURED) ?

> +		} else {
> +			cdns3_gadget_unconfig(priv_dev);
> +			usb_gadget_set_state(&priv_dev->gadget,
> +					     USB_STATE_ADDRESS);
> +		}
> +		break;
> +	case USB_STATE_CONFIGURED:
> +		result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +
> +		if (!config && !result) {
> +			cdns3_gadget_unconfig(priv_dev);
> +			usb_gadget_set_state(&priv_dev->gadget,
> +					     USB_STATE_ADDRESS);
> +		}
> +		break;
> +	default:
> +		result = -EINVAL;
> +	}
> +
> +	return result;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_address - Handling of SET_ADDRESS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_address(struct cdns3_device *priv_dev,
> +				     struct usb_ctrlrequest *ctrl_req)
> +{
> +	enum usb_device_state device_state = priv_dev->gadget.state;
> +	u32 reg;
> +	u32 addr;
> +
> +	addr = le16_to_cpu(ctrl_req->wValue);
> +
> +	if (addr > DEVICE_ADDRESS_MAX) {

If DEVICE_ADDRESS_MAX comes from USB spec it must be in ch9.h.
Maybe add something like

#define	USB_DEVICE_MAX_ADDRESS	127

> +		dev_err(&priv_dev->dev,
> +			"Device address (%d) cannot be greater than %d\n",
> +			addr, DEVICE_ADDRESS_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (device_state == USB_STATE_CONFIGURED) {
> +		dev_err(&priv_dev->dev, "USB device already configured\n");

Message is misleading. How about "can't set_address from configured state"

> +		return -EINVAL;
> +	}
> +
> +	reg = readl(&priv_dev->regs->usb_cmd);
> +
> +	writel(reg | USB_CMD_FADDR(addr) | USB_CMD_SET_ADDR,
> +	       &priv_dev->regs->usb_cmd);
> +
> +	usb_gadget_set_state(&priv_dev->gadget,
> +			     (addr ? USB_STATE_ADDRESS : USB_STATE_DEFAULT));
> +
> +	cdns3_prepare_setup_packet(priv_dev);

why call this here? This should be done after the current ep0 request is complete.

> +
> +	writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
> +
> +	return 0;
> +}
> +
> +/**
> + * cdns3_req_ep0_get_status - Handling of GET_STATUS standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
> +				    struct usb_ctrlrequest *ctrl)
> +{
> +	__le16 *response_pkt;
> +	u16 usb_status = 0;
> +	u32 recip;
> +	u32 reg;
> +
> +	recip = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +	switch (recip) {
> +	case USB_RECIP_DEVICE:
> +		/* self powered */
> +		usb_status |= priv_dev->gadget.is_selfpowered;

if (prv_devgadget.is_selfpowered)
	usb_stats |= BIT(USB_DEVICE_SELF_POWERED);

> +
> +		if (priv_dev->gadget.speed != USB_SPEED_SUPER)

You should check controller speed directly instead.

> +			break;
> +
> +		reg = readl(&priv_dev->regs->usb_sts);
> +
> +		if (priv_dev->u1_allowed)
> +			usb_status |= BIT(USB_DEV_STAT_U1_ENABLED);
> +
> +		if (priv_dev->u2_allowed)
> +			usb_status |= BIT(USB_DEV_STAT_U2_ENABLED);
> +
> +		if (priv_dev->wake_up_flag)
> +			usb_status |= BIT(USB_DEVICE_REMOTE_WAKEUP);

Remote wakeup is not SS specific. So needs to go before the SS check.

> +		break;
> +	case USB_RECIP_INTERFACE:
> +		return cdns3_ep0_delegate_req(priv_dev, ctrl);
> +	case USB_RECIP_ENDPOINT:
> +		/* check if endpoint is stalled */
> +		cdns3_select_ep(priv_dev, ctrl->wIndex);
> +		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
> +			usb_status =  BIT(USB_ENDPOINT_HALT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	response_pkt = (__le16 *)priv_dev->setup;
> +	*response_pkt = cpu_to_le16(usb_status);
> +
> +	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
> +			       sizeof(*response_pkt), 1);
> +	return 0;
> +}
> +
> +static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
> +					   struct usb_ctrlrequest *ctrl,
> +					   int set)
> +{
> +	enum usb_device_state state;
> +	enum usb_device_speed speed;
> +	int ret = 0;
> +	u32 wValue;
> +	u32 wIndex;
> +	u16 tmode;
> +
> +	wValue = le16_to_cpu(ctrl->wValue);
> +	wIndex = le16_to_cpu(ctrl->wIndex);
> +	state = priv_dev->gadget.state;
> +	speed = priv_dev->gadget.speed;
> +
> +	switch (ctrl->wValue) {
> +	case USB_DEVICE_REMOTE_WAKEUP:
> +		priv_dev->wake_up_flag = !!set;
> +		break;
> +	case USB_DEVICE_U1_ENABLE:
> +		if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		priv_dev->u1_allowed = !!set;
> +		break;
> +	case USB_DEVICE_U2_ENABLE:
> +		if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		priv_dev->u2_allowed = !!set;
> +		break;
> +	case USB_DEVICE_LTM_ENABLE:
> +		ret = -EINVAL;
> +		break;
> +	case USB_DEVICE_TEST_MODE:
> +		if (state != USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
> +			return -EINVAL;
> +
> +		tmode = le16_to_cpu(ctrl->wIndex);
> +
> +		if (!set || (tmode & 0xff) != 0)
> +			return -EINVAL;
> +
> +		switch (tmode >> 8) {
> +		case TEST_J:
> +		case TEST_K:
> +		case TEST_SE0_NAK:
> +		case TEST_PACKET:
> +			cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
> +					       USB_CMD_STMODE |
> +					       USB_STS_TMODE_SEL(tmode - 1));
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdns3_ep0_feature_handle_intf(struct cdns3_device *priv_dev,
> +					 struct usb_ctrlrequest *ctrl,
> +					 int set)
> +{
> +	u32 wValue;
> +	int ret = 0;
> +
> +	wValue = le16_to_cpu(ctrl->wValue);
> +
> +	switch (wValue) {
> +	case USB_INTRF_FUNC_SUSPEND:
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
> +					     struct usb_ctrlrequest *ctrl,
> +					     int set)
> +{
> +	struct cdns3_endpoint *priv_ep;
> +	int ret = 0;
> +	u8 index;
> +
> +	if (!(ctrl->wIndex &  ~USB_DIR_IN))
> +		return 0;

Why is this check?

> +
> +	index = cdns3_ep_addr_to_index(ctrl->wIndex);
> +	priv_ep = priv_dev->eps[index];
> +
> +	cdns3_select_ep(priv_dev, ctrl->wIndex);
> +
> +	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
> +		return -EINVAL;

This check should be done first before you try to decode wIndex.

> +
> +	if (set) {
> +		writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
> +		priv_ep->flags |= EP_STALL;
> +	} else {
> +		struct usb_request *request;
> +
> +		if (priv_dev->eps[index]->flags & EP_WEDGE) {
> +			cdns3_select_ep(priv_dev, 0x00);
> +			return 0;
> +		}
> +
> +		writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
> +
> +		/* wait for EPRST cleared */
> +		ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
> +				      EP_CMD_EPRST, 0, 100);
> +		if (ret)
> +			return -EINVAL;
> +
> +		priv_ep->flags &= ~EP_STALL;
> +
> +		request = cdns3_next_request(&priv_ep->request_list);
> +		if (request)
> +			cdns3_ep_run_transfer(priv_ep, request);
> +	}
> +	return ret;
> +}
> +
> +/**
> + * cdns3_req_ep0_handle_feature -
> + * Handling of GET/SET_FEATURE standard USB request
> + *
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + * @set: must be set to 1 for SET_FEATURE request
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_handle_feature(struct cdns3_device *priv_dev,
> +					struct usb_ctrlrequest *ctrl,
> +					int set)
> +{
> +	int ret = 0;
> +	u32 recip;
> +
> +	recip = ctrl->bRequestType & USB_RECIP_MASK;
> +
> +	switch (recip) {
> +	case USB_RECIP_DEVICE:
> +		ret = cdns3_ep0_feature_handle_device(priv_dev, ctrl, set);
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		ret = cdns3_ep0_feature_handle_intf(priv_dev, ctrl, set);
> +		break;
> +	case USB_RECIP_ENDPOINT:
> +		ret = cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!ret)
> +		writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
> +
> +	return ret;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_sel - Handling of SET_SEL standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_sel(struct cdns3_device *priv_dev,
> +				 struct usb_ctrlrequest *ctrl_req)
> +{
> +	if (priv_dev->gadget.state < USB_STATE_ADDRESS)
> +		return -EINVAL;
> +
> +	if (ctrl_req->wLength != 6) {
> +		dev_err(&priv_dev->dev, "Set SEL should be 6 bytes, got %d\n",
> +			ctrl_req->wLength);
> +		return -EINVAL;
> +	}
> +
> +	priv_dev->ep0_data_dir = 0;
> +	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma, 6, 1);
> +	return 0;
> +}
> +
> +/**
> + * cdns3_req_ep0_set_isoch_delay -
> + * Handling of GET_ISOCH_DELAY standard USB request
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_req_ep0_set_isoch_delay(struct cdns3_device *priv_dev,
> +					 struct usb_ctrlrequest *ctrl_req)
> +{
> +	if (ctrl_req->wIndex || ctrl_req->wLength)
> +		return -EINVAL;
> +
> +	priv_dev->isoch_delay = ctrl_req->wValue;
> +	writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
> +	return 0;
> +}
> +
> +/**
> + * cdns3_ep0_standard_request - Handling standard USB requests
> + * @priv_dev: extended gadget object
> + * @ctrl_req: pointer to received setup packet
> + *
> + * Returns 0 if success, error code on error
> + */
> +static int cdns3_ep0_standard_request(struct cdns3_device *priv_dev,
> +				      struct usb_ctrlrequest *ctrl_req)
> +{
> +	int ret;
> +
> +	switch (ctrl_req->bRequest) {
> +	case USB_REQ_SET_ADDRESS:
> +		ret = cdns3_req_ep0_set_address(priv_dev, ctrl_req);
> +		break;
> +	case USB_REQ_SET_CONFIGURATION:
> +		ret = cdns3_req_ep0_set_configuration(priv_dev, ctrl_req);
> +		break;
> +	case USB_REQ_GET_STATUS:
> +		ret = cdns3_req_ep0_get_status(priv_dev, ctrl_req);
> +		break;
> +	case USB_REQ_CLEAR_FEATURE:
> +		ret = cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0);
> +		break;
> +	case USB_REQ_SET_FEATURE:
> +		ret = cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 1);
> +		break;
> +	case USB_REQ_SET_SEL:
> +		ret = cdns3_req_ep0_set_sel(priv_dev, ctrl_req);
> +		break;
> +	case USB_REQ_SET_ISOCH_DELAY:
> +		ret = cdns3_req_ep0_set_isoch_delay(priv_dev, ctrl_req);
> +		break;
> +	default:
> +		ret = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static void __pending_setup_status_handler(struct cdns3_device *priv_dev)
>  {
> -	//TODO: Implements this function
> +	struct usb_request *request = priv_dev->pending_status_request;
> +
> +	if (priv_dev->status_completion_no_call && request &&
> +	    request->complete) {
> +		request->complete(priv_dev->gadget.ep0, request);
> +		priv_dev->status_completion_no_call = 0;
> +	}
> +}
> +
> +void cdns3_pending_setup_status_handler(struct work_struct *work)
> +{
> +	struct cdns3_device *priv_dev = container_of(work, struct cdns3_device,
> +			pending_status_wq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv_dev->lock, flags);
> +	__pending_setup_status_handler(priv_dev);
> +	spin_unlock_irqrestore(&priv_dev->lock, flags);
>  }
>  
>  /**
> @@ -101,12 +546,50 @@ static void __pending_setup_status_handler(struct cdns3_device *priv_dev)
>   */
>  static void cdns3_ep0_setup_phase(struct cdns3_device *priv_dev)
>  {
> -	//TODO: Implements this function.
> +	struct usb_ctrlrequest *ctrl = priv_dev->setup;
> +	int result;
> +
> +	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
> +		result = cdns3_ep0_standard_request(priv_dev, ctrl);
> +	else
> +		result = cdns3_ep0_delegate_req(priv_dev, ctrl);
> +
> +	if (result != 0 && result != USB_GADGET_DELAYED_STATUS) {
> +		dev_dbg(&priv_dev->dev, "STALL for ep0\n");
> +		/* set_stall on ep0 */
> +		cdns3_select_ep(priv_dev, 0x00);
> +		writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
> +		writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
> +	}
>  }
>  
>  static void cdns3_transfer_completed(struct cdns3_device *priv_dev)
>  {
> -	//TODO: Implements this function
> +	if (priv_dev->ep0_request) {
> +		usb_gadget_unmap_request_by_dev(priv_dev->sysdev,
> +						priv_dev->ep0_request,
> +						priv_dev->ep0_data_dir);
> +
> +		priv_dev->ep0_request->actual =
> +			TRB_LEN(le32_to_cpu(priv_dev->trb_ep0->length));
> +
> +		dev_dbg(&priv_dev->dev, "Ep0 completion length %d\n",
> +			priv_dev->ep0_request->actual);
> +		list_del_init(&priv_dev->ep0_request->list);
> +	}
> +
> +	if (priv_dev->ep0_request &&
> +	    priv_dev->ep0_request->complete) {
> +		spin_unlock(&priv_dev->lock);
> +		priv_dev->ep0_request->complete(priv_dev->gadget.ep0,
> +						priv_dev->ep0_request);
> +
> +		priv_dev->ep0_request = NULL;
> +		spin_lock(&priv_dev->lock);
> +	}
> +
> +	cdns3_prepare_setup_packet(priv_dev);
> +	writel(EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
>  }
>  
>  /**
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 309202474e57..0202ff5f6c90 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -70,6 +70,30 @@ static u8 cdns3_ep_reg_pos_to_index(int i)
>  	return ((i / 16) + (((i % 16) - 2) * 2));
>  }
>  
> +/**
> + * cdns3_ep_addr_to_index - Macro converts endpoint address to
> + * index of endpoint object in cdns3_device.eps[] container
> + * @ep_addr: endpoint address for which endpoint object is required
> + *
> + * Remember that endpoint container doesn't contain default endpoint
> + */
> +u8 cdns3_ep_addr_to_index(u8 ep_addr)
> +{
> +	return (((ep_addr & 0x7F) - 1) + ((ep_addr & USB_DIR_IN) ? 1 : 0));
> +}
> +
> +/**
> + * cdns3_ep_addr_to_bit_pos - Macro converts endpoint address to
> + * bit position in ep_ists register
> + * @ep_addr: endpoint address for which bit position is required
> + *
> + * Remember that endpoint container doesn't contain default endpoint
> + */
> +static u32 cdns3_ep_addr_to_bit_pos(u8 ep_addr)
> +{
> +	return (1 << (ep_addr & 0x7F)) << ((ep_addr & 0x80) ? 16 : 0);
> +}
> +
>  /**
>   * cdns3_next_request - returns next request from list
>   * @list: list containing requests
> @@ -464,6 +488,99 @@ static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
>  	return ret;
>  }
>  
> +/**
> + * cdns3_ep_onchip_buffer_alloc - Try to allocate onchip buf for EP
> + *
> + * The real allocation will occur during write to EP_CFG register,
> + * this function is used to check if the 'size' allocation is allowed.
> + *
> + * @priv_dev: extended gadget object
> + * @size: the size (KB) for EP would like to allocate
> + * @is_in: the direction for EP
> + *
> + * Return 0 if the later allocation is allowed or negative value on failure
> + */
> +static int cdns3_ep_onchip_buffer_alloc(struct cdns3_device *priv_dev,
> +					int size, int is_in)
> +{
> +	if (is_in) {
> +		priv_dev->onchip_mem_allocated_size += size;
> +	} else if (!priv_dev->out_mem_is_allocated) {
> +		 /* ALL OUT EPs are shared the same chunk onchip memory */
> +		priv_dev->onchip_mem_allocated_size += size;
> +		priv_dev->out_mem_is_allocated = 1;
> +	}
> +
> +	if (priv_dev->onchip_mem_allocated_size > CDNS3_ONCHIP_BUF_SIZE) {
> +		priv_dev->onchip_mem_allocated_size -= size;
> +		return -EPERM;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +/**
> + * cdns3_ep_config Configure hardware endpoint
> + * @priv_ep: extended endpoint object
> + */
> +void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
> +{
> +	bool is_iso_ep = (priv_ep->type == USB_ENDPOINT_XFER_ISOC);
> +	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +	u32 bEndpointAddress = priv_ep->num | priv_ep->dir;
> +	u32 interrupt_mask = EP_STS_EN_TRBERREN;
> +	u32 max_packet_size = 0;
> +	u32 ep_cfg = 0;
> +	int ret;
> +
> +	if (priv_ep->type == USB_ENDPOINT_XFER_INT) {
> +		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
> +	} else if (priv_ep->type == USB_ENDPOINT_XFER_BULK) {
> +		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
> +	} else {
> +		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
> +		interrupt_mask = 0xFFFFFFFF;
> +	}
> +
> +	switch (priv_dev->gadget.speed) {
> +	case USB_SPEED_FULL:
> +		max_packet_size = is_iso_ep ? 1023 : 64;
> +		break;
> +	case USB_SPEED_HIGH:
> +		max_packet_size = is_iso_ep ? 1024 : 512;
> +		break;
> +	case USB_SPEED_SUPER:
> +		max_packet_size = 1024;
> +		break;
> +	default:
> +		//all other speed are not supported
> +		return;
> +	}
> +
> +	ret = cdns3_ep_onchip_buffer_alloc(priv_dev, CDNS3_EP_BUF_SIZE,
> +					   priv_ep->dir);

where do you free the buffer_alloc?

> +	if (ret) {
> +		dev_err(&priv_dev->dev, "onchip mem is full, ep is invalid\n");
> +		return;
> +	}
> +
> +	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
> +		  EP_CFG_BUFFERING(CDNS3_EP_BUF_SIZE - 1) |
> +		  EP_CFG_MAXBURST(priv_ep->endpoint.maxburst);
> +
> +	cdns3_select_ep(priv_dev, bEndpointAddress);
> +
> +	writel(ep_cfg, &priv_dev->regs->ep_cfg);
> +	writel(interrupt_mask, &priv_dev->regs->ep_sts_en);
> +
> +	dev_dbg(&priv_dev->dev, "Configure %s: with val %08x\n",
> +		priv_ep->name, ep_cfg);
> +
> +	/* enable interrupt for selected endpoint */
> +	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
> +			       cdns3_ep_addr_to_bit_pos(bEndpointAddress));
> +}
> +
>  /* Find correct direction for HW endpoint according to description */
>  static int cdns3_ep_dir_is_correct(struct usb_endpoint_descriptor *desc,
>  				   struct cdns3_endpoint *priv_ep)
> @@ -1104,6 +1221,8 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
>  	priv_dev->is_connected = 0;
>  
>  	spin_lock_init(&priv_dev->lock);
> +	INIT_WORK(&priv_dev->pending_status_wq,
> +		  cdns3_pending_setup_status_handler);
>  
>  	priv_dev->in_standby_mode = 1;
>  
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
> index 8c2f363f9340..db8c6cb9f2a5 100644
> --- a/drivers/usb/cdns3/gadget.h
> +++ b/drivers/usb/cdns3/gadget.h
> @@ -1070,14 +1070,18 @@ struct cdns3_device {
>  
>  int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
>  void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
> +void cdns3_pending_setup_status_handler(struct work_struct *work);
>  int cdns3_init_ep0(struct cdns3_device *priv_dev);
>  void cdns3_ep0_config(struct cdns3_device *priv_dev);
> +void cdns3_ep_config(struct cdns3_endpoint *priv_ep);
>  void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir);
>  void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
>  void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable);
>  struct usb_request *cdns3_next_request(struct list_head *list);
> +void cdns3_gadget_unconfig(struct cdns3_device *priv_dev);
>  int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
>  			  struct usb_request *request);
> +u8 cdns3_ep_addr_to_index(u8 ep_addr);
>  int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
>  int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
>  struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
