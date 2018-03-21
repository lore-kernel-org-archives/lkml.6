Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELvaRl0+Rs4PbyHddyGdodh955tlMdiZ3usQ6l7lt9/8jHfOUAY3yFvNb8tDjA7iF/jA9NsD
ARC-Seal: i=1; a=rsa-sha256; t=1521633026; cv=none;
        d=google.com; s=arc-20160816;
        b=KiQma0jcTQnhVFjE9zMFZZfjr45boZQ95eXuiMuJebsM+dM10uW+Q8WAe/reEDVNSi
         QfQhYRGMKNBGmLPWNuXR2AgoJYr0MEF3NrLAl+3P9wJFBEcNXYyjytHDtStWbDtM0uFM
         +DGiY3B9+viocboxAYa7ZuA+Lu2L5a+XdhbWJXdsvSbM+hDaTmlHv5ATyydvLIIquSSo
         vrfZpjeYS+Ver4dasdhu/T8e93pAc982h5wzzVsF3zH+mH0HnPGtE28TFAG6ILLdD39l
         3ph1L2c1dTvhqCbDM58YJT2r1t79wb0tCqnlONdQbJDDbyp7+wCocAgjVTTKEbwGqL4C
         3GAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=ow0XoUDy5ahqpRFJxj/4XWZOox9EuXHJwmDZDKLQ9u0=;
        b=cmk+Lio8A7+sN/jBfXV4LmOmfS/6tJSiWNXZ/siuYdTzxNb1LrMMI9N9Era9cG6yT8
         ZEXEd4YHvJ9THz8jU74VDje9B9p7NmC028uBuTEmX/XXcXHNRkmMQ/VJEL4SyodFcge0
         8zc06B/9HyERpTvfIWWqW5yP7ARJojiU05SfuZrssqxZai6/3qSRV8Hwo8arfMUEtBqA
         n/vWT2i3S1y6ofnSxtLoGldvOqxFv00nWKdqOWDkfNXslqUbVy+RBLAdyosFTOQS1x6k
         Pxkpn8P27t75ejY08vHeWTOfEjL4T3uO1OTa4SJeuswu1WSOFEOw+kXK7BzIybMKLzOA
         WvMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: ea00ce1ae4554c1ea00c4310d4c80442-20180321
Message-ID: <1521633020.3717.128.camel@mhfsdcap03>
Subject: Re: [usb-next PATCH] usb: xhci: skip phys initialization of shared
 hcd
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Roger Quadros <rogerq@ti.com>
CC: Mathias Nyman <mathias.nyman@intel.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Date: Wed, 21 Mar 2018 19:50:20 +0800
In-Reply-To: <ae71fdae-43aa-9df3-3f81-8a92460d61b9@ti.com>
References: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
	 <ae71fdae-43aa-9df3-3f81-8a92460d61b9@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595526733993033305?=
X-GMAIL-MSGID: =?utf-8?q?1595547871939250831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Roger,

On Wed, 2018-03-21 at 11:05 +0200, Roger Quadros wrote:
> Hi Chunfeng,
> 
> On 21/03/18 08:12, Chunfeng Yun wrote:
> > The phys has already been initialized when add primary hcd,
> > including usb2 phys and usb3 phys also if exist, so needn't
> > re-parse "phys" property again.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/host/xhci-mtk.c  | 1 +
> >  drivers/usb/host/xhci-plat.c | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index 7334da9..6bb23fb 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> >  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> >  		xhci->shared_hcd->can_do_streams = 1;
> >  
> > +	xhci->shared_hcd->skip_phy_initialization = 1;
> >  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> >  	if (ret)
> >  		goto dealloc_usb2_hcd;
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 6700e5e..65a4294 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >  	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
> >  		xhci->shared_hcd->can_do_streams = 1;
> >  
> > +	xhci->shared_hcd->skip_phy_initialization = 1;
> 
> I think this is unnecessary.
> There aren't separate PHYs for the primary and shared HCDs right?
Yes, the primary and shared HCDs will get the same PHYs provided by
"phys" property.

> 
> Also how can you be sure that phy_init() has been done for all platform HCD users?
Here I assume that "phys" and "usb-phy" properties are not used at the
same time. There are two cases:
1. Using "usb-phy": no "phys" to be got by shared HCD.
2. Using "phys": the primary HCD will get those phys, so shared HCD can
skip them.

> 
> >  	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
> >  	if (ret)
> >  		goto dealloc_usb2_hcd;
> > 
> 
