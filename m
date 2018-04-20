Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AB8JxZpikOWuqeTH4sB/jJVbBD7Pz6rfAScZngIAshBBkr1PVWeKYRluNEnHgDg4CKPWEemotNKp
ARC-Seal: i=1; a=rsa-sha256; t=1524234331; cv=none;
        d=google.com; s=arc-20160816;
        b=wE0IGJnCcCKBjI8tu6ScNAq2D6W3IWTEI36aeV7j25d0KX7HmyJaqqYGzu6tPYZ2pT
         LdmzhmUDJsjsvyGfAyGtDYxf3KuiLU0RD+SSTrnfYVZ/PrU0m3BzP/ButfMQf2Z2Sh8U
         KePeEovKWkzgC1uVpO0NfJi1LVTL+i0jNwJcIb9wvxFe7pTdBTpc+9IIGWep5eQhxIwE
         JoOiKiFThhh4uE6stDgnA4qmCz+xLMsEjBrIcWYFBH1hrAZGU5vOK5wfa2+47GxURfXn
         MNzNkCqX9bOpEyYeuBgpjYLmBz2h6Rds0/JDdKrMClpCwJqrq+GO/uhmWVjL2BuD8OrJ
         6j7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=SzaY70idKtePIK+t8g+k6yRZRfxhCB9nxzJwZQZBdAg=;
        b=dLeDEQqkbB2slaXVLj6jhbypVzRpwdu/LAKD2or3pK0N5RGcsDTlkloma3myMkWrjO
         XiUzF3rytOfSlge+penC6FViPSyL1c/au/dHyir0a4gA7RlEmOHW1Urud5qH4mcvYJnL
         oj7FVFIRSHfmKbxKUEdgxmNAFLJZwmuAsLFU3vML4pRyEfHodR0iO1KQB3c+Y1mh/x6Z
         +CkVkcKWOKPky7FqaPefT4TrdXmCeCfpquCigXM/opi0MsQpINxyU8wxuUqC4oPfmogL
         Ghu0l5Dsl1l0Hx9Si6rV3ZPl14xHG9q9hIXXG+vL6WchG3MwS7w0WsbKvUM0L6KYIG0I
         OF5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Ci/iit2q;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Ci/iit2q;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Fri, 20 Apr 2018 09:25:24 -0500
From: Bin Liu <b-liu@ti.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
CC: Maxime Ripard <maxime.ripard@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20180420142524.GB29011@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>, Paul Kocialkowski <contact@paulk.fr>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1522324644.1746.19.camel@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596219936239404188?=
X-GMAIL-MSGID: =?utf-8?q?1598275538878546947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > > This allows dual-role ports to be reported as having gadget mode by
> > > the
> > > musb_has_gadget helper. This is required to enable MUSB at all with
> > > MUSB
> > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE at
> > > init.
> > > 
> > > Most notably, this allows calling musb_start when needed in the
> > > virtual
> > > MUSB root HUB, regardless of whether the current mode should be
> > > gadget
> > > or host.
> > > 
> > > This fixes USB OTG on Allwinner devices that I could test it with,
> > > mainly A20 devices.
> > > 
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > 
> > Surely there's more to it than that. The gadget mode of A20 boards
> > have been working in the past, including when compiling with mUSB
> > setup as dual role.
> >
> > Is this a regression since a particular commit? Or is there another,
> > deeper issue overlooked in the commit log?
> 
> The root of the issue here is that musb_start is not called at any point
> without this patch. My understanding of the flow is the following: when
> the PHY detects that there was a VBUS/ID change, it will notify its
> listeners (mainly the musb sunxi glue layer). This will then schedule
> the driver's work (sunxi_musb_work), which does nothing since the
> SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
> calling sunxi_musb_enable, which is called from musb_platform_enable,
> that originates from musb_start.
> 
> Currently I see two places where musb_start is called:
> * musb_virthub
> * musb_gadget
> 
> In the latter case, it is in turn called from udc_start, which should
> probably (correct me if I'm wrong) happen later in the call chain than
> ID/VBUS change notification time.

I don't think it is correct that udc_start() is triggered by ID/VBUS
events, but I don't have an Allwinner platform to verify the callflow.

Have you tried to load with a gadget driver? When a gadget function is
bound to UDC, udc_start() is triggered, which in turn calls
musb_start().

> 
> In the former case, musb_start is called in the root controller hub
> control, when setting the USB_PORT_FEAT_POWER feature. This looks
> perfectly legit and IMO this is where it should be initially calling
> musb_start in the dual role case. The kernel is indeed setting the

No actually. A dual-role port should be in b_idle state by default, so
logically all actions should go to the gadget path until the port
switches to host mode.

> feature, only that it fails to enable musb without this patch.
> 
> First, I'd like to make sure that this understanding of the flow is
> correct as I may have missed something here. Does it make sense?

I am guessing you didn't load a gadget driver when testing?

> Then, it seems that the offending commit is: be9d39881fc4f
> ("usb: musb: host: rely on port_mode to call musb_start()")
> 
> That itself fixed: ae44df2e21b5
> ("usb: musb: call musb_start() only once in OTG mode")
> 
> Still, this commit was authored in June 2015, so almost 3 years ago.
> In the meantime, the sunxi driver has received feature improvements, so
> it seems hard to believe that it was broken all this time...
> 
> Cheers,

Regards,
-Bin.
