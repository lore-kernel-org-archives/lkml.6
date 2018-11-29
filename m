Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A972C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8B620863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8B620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeK2Ram (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:30:42 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42067 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727643AbeK2Ram (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:30:42 -0500
X-UUID: a910dc311edc44da9374e8aa4e1753cc-20181129
X-UUID: a910dc311edc44da9374e8aa4e1753cc-20181129
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 64181748; Thu, 29 Nov 2018 14:26:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 29 Nov
 2018 14:26:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Nov 2018 14:26:15 +0800
Message-ID: <1543472774.32173.114.camel@mhfsdcap03>
Subject: Re: [PATCH v4] usb/mtu3: power down device ip at setup
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Hsin-Yi, Wang" <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 29 Nov 2018 14:26:14 +0800
In-Reply-To: <20181129031627.45006-1-hsinyi@chromium.org>
References: <20181128095358.42498-1-hsinyi@chromium.org>
         <20181129031627.45006-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Hsin-Yi,

On Thu, 2018-11-29 at 11:16 +0800, Hsin-Yi, Wang wrote:
> Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> so host ip sleep will fail at ssusb_host_disable.
> 
> Power down device ip at ssusb_host_setup.
> 
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> ---
> ChangeLog:
> V3->V4:
>   *update comment
> ---
>  drivers/usb/mtu3/mtu3_plat.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 46551f6d16fd..e086630e41a9 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -200,6 +200,14 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
>  	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
>  	udelay(1);
>  	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> +
> +	/*
> +	 * device ip may be powered on in firmware/BROM stage before entering
> +	 * kernel stage;
> +	 * power down device ip, otherwise ip-sleep will fail when working as
> +	 * host only mode
> +	 */
> +	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
>  }
>  
>  /* ignore the error if the clock does not exist */

Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot



