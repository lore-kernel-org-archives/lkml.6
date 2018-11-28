Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B57C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951E1208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeK1Ume (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:42:34 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2257 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727541AbeK1Ume (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:42:34 -0500
X-UUID: 581355e028a84017a5365610883681fa-20181128
X-UUID: 581355e028a84017a5365610883681fa-20181128
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2052448691; Wed, 28 Nov 2018 17:41:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Nov
 2018 17:41:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Nov 2018 17:41:09 +0800
Message-ID: <1543398069.32173.112.camel@mhfsdcap03>
Subject: Re: [V2] usb/mtu3: power down device ip at setup
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "Hsin-Yi, Wang" <hsinyi@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 28 Nov 2018 17:41:09 +0800
In-Reply-To: <20181128092953.41541-1-hsinyi@chromium.org>
References: <20181128060412.630-1-hsinyi@chromium.org>
         <20181128092953.41541-1-hsinyi@chromium.org>
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

On Wed, 2018-11-28 at 17:29 +0800, Hsin-Yi, Wang wrote:
> Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
> so host ip sleep will fail at ssusb_host_disable.
> 
> Power down device ip at ssusb_host_setup.
need modify it, not in ssusb_host_setup now
> 
> 
> Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
> ---
>  drivers/usb/mtu3/mtu3_plat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 46551f6d16fd..cdef66141e20 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -200,6 +200,12 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
>  	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
>  	udelay(1);
>  	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
> +
> +	/*
> +	 * device ip is default power-on in fact
change as: device ip maybe poweron in LK/BROM stage before enter kernel
stage;
> +	 * power down device ip, otherwise ip-sleep will fail
power down device ip, otherwise ip-sleep will fail when works as host
only mode
> +	 */
> +	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
>  }
>  
>  /* ignore the error if the clock does not exist */

Thanks a lot



