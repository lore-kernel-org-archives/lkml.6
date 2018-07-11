Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB3920652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB3920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbeGKNcD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:32:03 -0400
Received: from muru.com ([72.249.23.125]:51086 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbeGKNcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:32:03 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 65B44809B;
        Wed, 11 Jul 2018 13:30:46 +0000 (UTC)
Date:   Wed, 11 Jul 2018 06:27:39 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org
Subject: Re: Vibrations on Droid 4?
Message-ID: <20180711132739.GL99251@atomide.com>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180711080218.GA21225@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180711 08:05]:
> Hi!
> 
> > > Its parent is gpio@4805d000 , and that one seems to be present.
> > > 
> > > user@devuan:/sys/bus/platform/devices$ ls 4805d000.gpio
> > > driver				       driver_override  gpio
> > > gpiochip5  modalias  of_node  power  subsystem  uevent
> > 
> > Sorry, something went wrong with merging this. The parent
> > of ti,omap-dmtimer-pwm and pwm-vibrator should be / and
> > not gpio6.
> 
> Ok, got it to probe... after dts fix and adding EPROBE_DEFFER to
> driver.
..
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -159,13 +159,7 @@
>  
>  		dais = <&mcbsp2_port>, <&mcbsp3_port>;
>  	};
> -};
> -
> -&dss {
> -	status = "okay";
> -};
>  
> -&gpio6 {
>  	pwm8: dmtimer-pwm-8 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vibrator_direction_pin>;
> @@ -192,7 +186,10 @@
>  		pwm-names = "enable", "direction";
>  		direction-duty-cycle-ns = <10000000>;
>  	};
> +};
>  
> +&dss {
> +	status = "okay";
>  };
>  
>  &dsi1 {

Hmm sorry if I did a mismerge on the above. A note to
myself to stop applying patches that apply with fuzz,
that is clearly dangerous with dts files with lots
of similar named properties.

Regards,

Tony
