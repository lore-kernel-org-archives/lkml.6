Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67887C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271552082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="v18Hj2yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271552082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeLABfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:35:11 -0500
Received: from onstation.org ([52.200.56.107]:36454 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLABfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:11 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id B68E317A;
        Fri, 30 Nov 2018 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543587941;
        bh=ziVPNqT7ytE7nyFK3HEdr0V5ujEnS/km76ToNwyRvGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v18Hj2yu3RdGA/mpsyYv0/RHibyxr3Bvkx2F9W0GikrJgBCqpTYiovzD2h0owQYIy
         IDK1UTrVkjnc9VbtPkmALps5rvlLedEz0VYaDzmP4gj3uNMqU1mazOyDP6ThO7kgLJ
         6ujYkpSG7pBdEUDKqV4UrvS1JC6TQBHog2ayIMNg=
Date:   Fri, 30 Nov 2018 09:25:40 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Craig Tatlor <ctatlor97@gmail.com>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-ID: <20181130142540.GB27500@basecamp>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181127105642.uu56phxjfl7bjl2p@holly.lan>
 <20181130135927.GA27500@basecamp>
 <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+-AZFf==911Pmf_ObUk+3VQgC+2+BvQ9q8LyQ_v=FdOA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:13:04AM -0600, Rob Herring wrote:
> > > It's quite unusual for a backlight device to have a trivial binding.
> > >
> > > The driver supports fairly extensive parametrization via struct
> > > lm3530a_platform_data. It is really the case that none of these
> > > properties should ever be set via DT?
> >
> > Hi Daniel,
> >
> > I initially assumed that we would let user space configure these values
> > once the system has booted, but you are right that these should be
> > available in device tree.
> >
> > The driver has two different LED banks that can be configured
> > independently.
> 
> That is usually represented with child nodes which makes this anything
> but trivial. Plus, given that we have bindings for LEDs/backlights, no
> LED/backlight controller is a trivial device.

Hi Rob,

I agree and I'm not going to use a trivial binding for v2. See below for
some questions that I have from my last email.


> > How do you feel about having a single property in
> > device tree populate the initial values for both banks? I propose that
> > we could use the property default-brightness-level for leda_init_brt
> > and ledb_init_brt in struct lm3630a_platform_data. The max-brightness
> > property can populate leda_max_brt and ledb_max_brt.
> >
> > I need to look at other bindings this weekend to see if there are any
> > standard properties that I can use for leda_ctrl/ledb_ctrl, pwm_ctrl,
> > and pwm_period.
> >
> > Brian
> >
