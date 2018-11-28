Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D602082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D602082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeK1RXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:23:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16051 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726972AbeK1RXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:23:16 -0500
X-UUID: 4fc6aa946fca45deb515d382ce0720d4-20181128
X-UUID: 4fc6aa946fca45deb515d382ce0720d4-20181128
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2016612770; Wed, 28 Nov 2018 14:22:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Nov
 2018 14:22:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Nov 2018 14:22:29 +0800
Message-ID: <1543386149.32173.87.camel@mhfsdcap03>
Subject: Re: [PATCH] usb/mtu3: power down device ip at setup
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Hsin-Yi, Wang" <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 28 Nov 2018 14:22:29 +0800
In-Reply-To: <20181128060412.630-1-hsinyi@chromium.org>
References: <20181128060412.630-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

On Wed, 2018-11-28 at 14:04 +0800, Hsin-Yi, Wang wrote:
> Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> so host ip sleep will fail at ssusb_host_disable.
> 
> Power down device ip at ssusb_host_setup.
> 
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> ---
>  drivers/usb/mtu3/mtu3_host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> index c871b94f3e6f..d17cf43305db 100644
> --- a/drivers/usb/mtu3/mtu3_host.c
> +++ b/drivers/usb/mtu3/mtu3_host.c
> @@ -192,9 +192,17 @@ int ssusb_host_disable(struct ssusb_mtk *ssusb, bool suspend)
>  static void ssusb_host_setup(struct ssusb_mtk *ssusb)
>  {
>  	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
> +	void __iomem *ibase = ssusb->ippc_base;
>  
>  	host_ports_num_get(ssusb);
>  
> +	/*
> +	 * device ip is default power-on in fact
The device ip is power-off by default, no need power down it here.

On which platform did you encounter the issue?

> +	 * power down device ip, otherwise ip-sleep will fail
> +	 */
> +	if (ssusb->dr_mode == USB_DR_MODE_HOST)
> +		mtu3_setbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
> +


>  	/*
>  	 * power on host and power on/enable all ports
>  	 * if support OTG, gadget driver will switch port0 to device mode


