Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93818C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046B2189B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 12:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAnDBe0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3046B2189B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHLPU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 11:20:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHLPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 11:20:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so11945153wrr.8;
        Sun, 12 Aug 2018 05:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRivWd782ip/TYCf/ORetttw3HjD1XwmlHcyUYZWdag=;
        b=eAnDBe0Y7sHiPRSq5fDt2wBH11Qf9ET+/ND8nBMPffNzfK8tt0G2xBs9KeWamFzFmZ
         cd4ZpYpQeHEn26Vq5KlUfzPKbTTs/gPKWCW/XTjZCFmB6jzkZ9V4+JDCCdH1O2o6RPns
         BYUVuT9JxDCn4r4rf7t3nzM9uptJ3/7IizyJa9sEsRimaKOBD3/g+yesdHVedBbvc/YL
         QpyhkEX4iLYswC8rrNXYqJerE8MfV99/ucdDZTKkZh04mPYTj+uZnZW2bmLjHkqAT+8x
         prp+CQWnPIkbi4E87XeO107SCAwVDM6GPlxNsd0um9vfiBgxBHFYIQ9kcB4mWYtkDbat
         R1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRivWd782ip/TYCf/ORetttw3HjD1XwmlHcyUYZWdag=;
        b=JZz98gmBNLOPi53FICPjOys2zoM1vzHSiSpZmTHjRSM9UP9TzwZUXvitQ67waV+LxG
         CvlgeZTyq+6mAhApbXDuDGsMF9E2kashTDysO4CU8y8U9MfL0Q1PI2GZiT87uUvYJqps
         /SOlVTYq2KlgOt/Vo+3ARLq+WZdF9IPlyd4ombNm2Ze8mjndDe2ZnSIMstACc7XTfTyb
         UYhVBHEN1hvRpKAGrVewZV/3vSNVRM32Z7/AC9/lp2pRp3zAu0f5QePo46W7QoGFr+vW
         pf2dyiY8Gm6vwRVRxP1bKCjwIMHTvZStvUooDSWgWYLnNyodMXwgENUYn7/R3/MngzcZ
         tGDw==
X-Gm-Message-State: AOUpUlHfN9UsU6fwyUV7tbtlmo9u2tqx0Fs+t11Ses5SRcHReokuV8wA
        SlG5ZUMbSDPXjBzJ6lo7hd8=
X-Google-Smtp-Source: AA+uWPzpNj6ksG5z0kqIjQ5r3elgRTOzzTenRmDO7LkD55aEF9jQggE5xnPuvFXHdjq9fh+Tmq0G4w==
X-Received: by 2002:adf:9261:: with SMTP id 88-v6mr7870713wrj.62.1534077748652;
        Sun, 12 Aug 2018 05:42:28 -0700 (PDT)
Received: from debian64.daheim (p4FD09A1D.dip0.t-ipconnect.de. [79.208.154.29])
        by smtp.gmail.com with ESMTPSA id q70-v6sm14796692wmd.39.2018.08.12.05.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Aug 2018 05:42:27 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.91)
        (envelope-from <chunkeey@gmail.com>)
        id 1fophT-0004df-4y; Sun, 12 Aug 2018 14:42:27 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: Add sdm660 pinctrl driver
Date:   Sun, 12 Aug 2018 14:42:27 +0200
Message-ID: <2710770.4cMFGZ35A3@debian64>
In-Reply-To: <4A3869BF-2069-409A-B291-427971AF89FA@gmail.com>
References: <20180811162520.11641-1-ctatlor97@gmail.com> <2202961.SmUWKIdeCe@debian64> <4A3869BF-2069-409A-B291-427971AF89FA@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 12, 2018 9:18:19 AM CEST you wrote:
> On 11 August 2018 18:27:43 BST, Christian Lamparter <chunkeey@gmail.com> wrote:
> >On Saturday, August 11, 2018 6:25:19 PM CEST Craig Tatlor wrote:
> >> Add initial pinctrl driver to support pin configuration with
> >> pinctrl framework for sdm660.
> >> Based off CAF implementation.
> >> 
> >> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> >> ---
> >> 
> >> diff --git
> >a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> >b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> >> new file mode 100644
> >> index 000000000000..85e6c6c17c04
> >> --- /dev/null
> >> +++
> >b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> >> @@ -0,0 +1,195 @@
> >> +Qualcomm Technologies, Inc. SDM660 TLMM block
> >> +
> >> +This binding describes the Top Level Mode Multiplexer block found in
> >the
> >> +SDM660 platform.
> >> +
> >> +- compatible:
> >> +	Usage: required
> >> +	Value type: <string>
> >> +	Definition: must be "qcom,sdm660-pinctrl"
> >> +
> >> +- reg:
> >> +	Usage: required
> >> +	Value type: <prop-encoded-array>
> >> +	Definition: the base address and size of the TLMM register space.
> >> +
> >> +- interrupts:
> >> +	Usage: required
> >> +	Value type: <prop-encoded-array>
> >> +	Definition: should specify the TLMM summary IRQ.
> >> +
> >> +- interrupt-controller:
> >> +	Usage: required
> >> +	Value type: <none>
> >> +	Definition: identifies this node as an interrupt controller
> >> +
> >> +- #interrupt-cells:
> >> +	Usage: required
> >> +	Value type: <u32>
> >> +	Definition: must be 2. Specifying the pin number and flags, as
> >defined
> >> +		    in <dt-bindings/interrupt-controller/irq.h>
> >> +
> >> +- gpio-controller:
> >> +	Usage: required
> >> +	Value type: <none>
> >> +	Definition: identifies this node as a gpio controller
> >> +
> >> +- #gpio-cells:
> >> +	Usage: required
> >> +	Value type: <u32>
> >> +	Definition: must be 2. Specifying the pin number and flags, as
> >defined
> >> +		    in <dt-bindings/gpio/gpio.h>
> >> +
> >> +Please refer to ../gpio/gpio.txt and
> >../interrupt-controller/interrupts.txt for
> >> +a general description of GPIO and interrupt bindings.
> >You want to specify gpio-ranges here as well. The property is explained
> >in Section "2.1) gpio- and pin-controller interaction" in
> >../gpio/gpio.txt
> >
> >Without it, the gpio-hogs construct (part of ../gpio/gpio.txt) will
> >cause
> >the driver to fail during boot. (try it, ;-) )
> Would gpio-ranges make sense for this, as the gpio and pinctrl are in same block?
Yes, it's part of the ../gpio/gpio.txt which you link.
Here's a copy of the relevant section that explains this
gpio- and pin-controller interaction.


|2.1) gpio- and pin-controller interaction
|-----------------------------------------
|
|Some or all of the GPIOs provided by a GPIO controller may be routed to pins
|on the package via a pin controller. This allows muxing those pins between
|GPIO and other functions.
|It is useful to represent which GPIOs correspond to which pins on which pin
|controllers. The gpio-ranges property described below represents this, and
|contains information structures as follows:
|
|       gpio-range-list ::= <single-gpio-range> [gpio-range-list]
|       single-gpio-range ::= <numeric-gpio-range> | <named-gpio-range>
|       numeric-gpio-range ::=
|                       <pinctrl-phandle> <gpio-base> <pinctrl-base> <count>
|       named-gpio-range ::= <pinctrl-phandle> <gpio-base> '<0 0>'
|       pinctrl-phandle : phandle to pin controller node
|       gpio-base : Base GPIO ID in the GPIO controller
|       pinctrl-base : Base pinctrl pin ID in the pin controller
|       count : The number of GPIOs/pins in this range
|
|The "pin controller node" mentioned above must conform to the bindings
|described in ../pinctrl/pinctrl-bindings.txt.
|...

As for the reason why gpio-ranges is what it is, please look at the ML
discussion from the "pinctrl: msm: fix gpio-hog related boot issues" thread
on <https://patchwork.kernel.org/patch/10339127/> and the posts by 
Linus Walleij: <https://patchwork.kernel.org/patch/10339127/#21903101> and
Stephen Boyd: <https://patchwork.kernel.org/patch/10339127/#21867185>.
(It's quite a bit to take in)

> Seems no other qcom pinctrl drivers have it and I'm able to boot without it.
Ok, let's run an experiment. Please remove the gpio-ranges property and try
adding a test gpio-hog to your device's DTS:

something like (I randomly selected GPIO5, but it shouldn't
matter which gpio you select here. If you know a unused/NC
pin/gpio, then you can use it instead):

&tlmm {
	test-hog {
		gpio-hog;
		gpios = <5 0>;
		output-low;
		line-name = "test hog";
	};
};

compile&install it and then watch the kernel on the next boot:

without the gpio-ranges present, it will spew out something along the
lines of:

| requesting hog GPIO test hog (chip 3000000.pinctrl, offset 5) failed, -517
| gpiochip_add_data: GPIOs 0..114 (3000000.pinctrl) failed to register
| sdm660-pinctrl 3000000.pinctrl: Failed register gpiochip

The single gpio-hog causes havoc and takes down the sdm660-pinctrl with it.
And every driver that depends on the pinctrl to setup the pin muxing/config
will fail to load as well. (check out /sys/kernel/debug/pinctrl/, it will be
empty.)

Regards,
Christian


