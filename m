Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D963120863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="jdnwChF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D963120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLABIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:08:53 -0500
Received: from onstation.org ([52.200.56.107]:36392 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLABIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:08:52 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id C776417A;
        Fri, 30 Nov 2018 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543586368;
        bh=VszxlV3PLbCwlZ94qvm69eC/GenPRr+20OAvuD312nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdnwChF2f9IsmtNZUCCn5+JI8bgRAP7udBk4DPsvo2fzYUAjrjjkvgLSlahSx/PCe
         pDeZpcCEdvMmm3/CIDq0kFYVz8tkVsMp0S9hvnpUUthtOeONxxBz2bqmT/VZHZMRP7
         7s8BuunyXml3z4POgGN7SQMXyINmDIW6xbFov2GQ=
Date:   Fri, 30 Nov 2018 08:59:27 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan@marek.ca, ctatlor97@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-ID: <20181130135927.GA27500@basecamp>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181127105642.uu56phxjfl7bjl2p@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127105642.uu56phxjfl7bjl2p@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:56:42AM +0000, Daniel Thompson wrote:
> On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
> > Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.
> 
> It's quite unusual for a backlight device to have a trivial binding.
> 
> The driver supports fairly extensive parametrization via struct
> lm3530a_platform_data. It is really the case that none of these
> properties should ever be set via DT?

Hi Daniel,

I initially assumed that we would let user space configure these values
once the system has booted, but you are right that these should be
available in device tree.
 
The driver has two different LED banks that can be configured
independently. How do you feel about having a single property in
device tree populate the initial values for both banks? I propose that
we could use the property default-brightness-level for leda_init_brt
and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
property can populate leda_max_brt and ledb_max_brt.

I need to look at other bindings this weekend to see if there are any
standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
and pwm_period.

Brian


> 
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> > index 6ab001fa1ed4..86486368dc35 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> > @@ -182,6 +182,7 @@ taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
> >  ti,ads7828		8-Channels, 12-bit ADC
> >  ti,ads7830		8-Channels, 8-bit ADC
> >  ti,amc6821		Temperature Monitoring and Fan Control
> > +ti,lm3630a		Texas Instruments LM3630A Backlight Chip
> >  ti,tsc2003		I2C Touch-Screen Controller
> >  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> >  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> > -- 
> > 2.17.2
> > 
