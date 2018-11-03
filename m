Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33874C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5EA20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5EA20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeKDE0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:26:51 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:50643 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbeKDE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:26:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CCF1583777EE;
        Sat,  3 Nov 2018 19:14:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl03_45bb5c548e842
X-Filterd-Recvd-Size: 3649
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Nov 2018 19:14:39 +0000 (UTC)
Message-ID: <63f0e18c8335b6431f0f7dcf0895c73d85b11fa4.camel@perches.com>
Subject: Re: [RFC PATCH v1 13/14] usb:cdns3: Adds debugging function.
From:   Joe Perches <joe@perches.com>
To:     Pawel Laszczak <pawell@cadence.com>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, rogerq@ti.com,
        linux-kernel@vger.kernel.org, adouglas@cadence.com,
        jbergsagel@ti.com, peter.chen@nxp.com, pjez@cadence.com,
        kurahul@cadence.com
Date:   Sat, 03 Nov 2018 12:14:37 -0700
In-Reply-To: <1541267487-3664-14-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
         <1541267487-3664-14-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-03 at 17:51 +0000, Pawel Laszczak wrote:
> Patch implements some function used for debugging driver.
[]
> +static inline char *cdns3_decode_ep_irq(u32 ep_sts, const char *ep_name)
> +{
> +	static char str[256];
> +	int ret;
> +
> +	ret = sprintf(str, "IRQ for %s: %08x ", ep_name, ep_sts);
> +
> +	if (ep_sts & EP_STS_SETUP)
> +		ret += sprintf(str + ret, "SETUP ");
> +	if (ep_sts & EP_STS_IOC)
> +		ret += sprintf(str + ret, "IOC ");
> +	if (ep_sts & EP_STS_ISP)
> +		ret += sprintf(str + ret, "ISP ");
> +	if (ep_sts & EP_STS_DESCMIS)
> +		ret += sprintf(str + ret, "DESCMIS ");
> +	if (ep_sts & EP_STS_STREAMR)
> +		ret += sprintf(str + ret, "STREAMR ");
> +	if (ep_sts & EP_STS_MD_EXIT)
> +		ret += sprintf(str + ret, "MD_EXIT ");
> +	if (ep_sts & EP_STS_TRBERR)
> +		ret += sprintf(str + ret, "TRBERR ");
> +	if (ep_sts & EP_STS_NRDY)
> +		ret += sprintf(str + ret, "NRDY ");
> +	if (ep_sts & EP_STS_PRIME)
> +		ret += sprintf(str + ret, "PRIME ");
> +	if (ep_sts & EP_STS_SIDERR)
> +		ret += sprintf(str + ret, "SIDERRT ");
> +	if (ep_sts & EP_STS_OUTSMM)
> +		ret += sprintf(str + ret, "OUTSMM ");
> +	if (ep_sts & EP_STS_ISOERR)
> +		ret += sprintf(str + ret, "ISOERR ");
> +	if (ep_sts & EP_STS_IOT)
> +		ret += sprintf(str + ret, "IOT ");
> +
> +	return str;
> +}

This bit is pretty unsightly.
Especially the static in each inline

> +
> +char *cdns3_decode_epx_irq(struct cdns3_endpoint *priv_ep)
> +{
> +	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
> +
> +	return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
> +				   priv_ep->name);
> +}
> +
> +char *cdns3_decode_ep0_irq(struct cdns3_device *priv_dev, int dir)
> +{
> +	if (dir)
> +		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
> +					   "ep0IN");
> +	else
> +		return cdns3_decode_ep_irq(readl(&priv_dev->regs->ep_sts),
> +					   "ep0OUT");
> +}
> +
[]
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
[]
> @@ -604,12 +604,15 @@ void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir)
>  	cdns3_select_ep(priv_dev, 0 | (dir ? USB_DIR_IN : USB_DIR_OUT));
>  	ep_sts_reg = readl(&regs->ep_sts);
>  
> +	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_ep0_irq(priv_dev, dir));
[]
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
[]
> @@ -537,6 +547,8 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
>  	cdns3_select_ep(priv_dev, priv_ep->endpoint.address);
>  	ep_sts_reg = readl(&regs->ep_sts);
>  
> +	dev_dbg(&priv_dev->dev, "%s\n", cdns3_decode_epx_irq(priv_ep));
> 

