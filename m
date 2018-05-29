Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935738AbeE2Op3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:45:29 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:56033 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935287AbeE2OpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:45:22 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: William Wu <william.wu@rock-chips.com>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "sergei.shtylyov@cogentembedded.com"
        <sergei.shtylyov@cogentembedded.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "huangtao@rock-chips.com" <huangtao@rock-chips.com>,
        "dianders@google.com" <dianders@google.com>,
        "daniel.meng@rock-chips.com" <daniel.meng@rock-chips.com>,
        "John.Youn@synopsys.com" <John.Youn@synopsys.com>,
        "fml@rock-chips.com" <fml@rock-chips.com>
Subject: Re: [PATCH] usb: dwc2: fix the incorrect bitmaps for the ports of
 multi_tt hub
Thread-Topic: [PATCH] usb: dwc2: fix the incorrect bitmaps for the ports of
 multi_tt hub
Thread-Index: AQHT8OxXMtSRTMYeG0CT9CelkWDIlA==
Date: Tue, 29 May 2018 14:45:10 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013135A5A0@am04wembxa.internal.synopsys.com>
References: <1526897520-9340-1-git-send-email-william.wu@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.165]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TEjYTF029222

Acked-by Minas Harutyunyan hminas@synopsys.com>

On 5/21/2018 2:13 PM, William Wu wrote:
> The dwc2_get_ls_map() use ttport to reference into the
> bitmap if we're on a multi_tt hub. But the bitmaps index
> from 0 to (hub->maxchild - 1), while the ttport index from
> 1 to hub->maxchild. This will cause invalid memory access
> when the number of ttport is hub->maxchild.
> 
> Without this patch, I can easily meet a Kernel panic issue
> if connect a low-speed USB mouse with the max port of FE2.1
> multi-tt hub (1a40:0201) on rk3288 platform.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
>   drivers/usb/dwc2/hcd_queue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> index d7c3d6c..9c55d1a 100644
> --- a/drivers/usb/dwc2/hcd_queue.c
> +++ b/drivers/usb/dwc2/hcd_queue.c
> @@ -383,7 +383,7 @@ static unsigned long *dwc2_get_ls_map(struct dwc2_hsotg *hsotg,
>   	/* Get the map and adjust if this is a multi_tt hub */
>   	map = qh->dwc_tt->periodic_bitmaps;
>   	if (qh->dwc_tt->usb_tt->multi)
> -		map += DWC2_ELEMENTS_PER_LS_BITMAP * qh->ttport;
> +		map += DWC2_ELEMENTS_PER_LS_BITMAP * (qh->ttport - 1);
>   
>   	return map;
>   }
> 
