Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD1EFA3750
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C003E21524
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rogwlU1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C003E21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeIMVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:09:57 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:34645 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeIMVJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:09:57 -0400
Received: by mail-wr1-f51.google.com with SMTP id g33-v6so6600838wrd.1;
        Thu, 13 Sep 2018 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4xUwRqlPAT7eIFnyjclBdSaLr9ed5NtS56xAa3ZeNKw=;
        b=rogwlU1RcjgZlOgXAIYJPaC5dN87654tI7H0ouzOhf1zqMvHUPDzz26vCKc5g/wVPy
         3nrnwd0mVK9xVHNFI4XnOyaKQ6KToxyhJ9mrmXYpxV3rQsVH0IYkRKZUfi2P3cesGzh8
         5RM6XrAK+V87mMfjzrw5hwBjWZjNChWnhTE3r4zmOgnrJP96DcUwEgsBCDF9j24Mj9x7
         2D3xf0rbwAc1iPeCF4bgn4gTv9AZ/x8NdNoWH4m/ke0ex4NTB2Uk+NsXk9sW1fIzyVI1
         MjiQJ16Jxq5+O9/rbKj5vwDOEZzf6i494e/zoBA7tQa9G8+/pidCOdVtq5/vtLkqmhrh
         Z3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4xUwRqlPAT7eIFnyjclBdSaLr9ed5NtS56xAa3ZeNKw=;
        b=tXHaLjSXLnL5VfVJ/qh/c1g8NkYOFDNA+TCQRUO+N0rjmgwzgDPleEB4sejX2t9BVu
         eDS/023f6BX6uMNRXUn2CaRa/SkTPI/Eq7/VSF3neiSWkUH4jqshErfaxuVSccjUBZBQ
         brnQ1QYpGSmqo2HPZLEf8lMZRLqcMPC/qe5jinA5PKPWvw60ph+7O8HP8uNYESC+tr27
         2Xu66W6KD+uT4OzkZMNjdYMs+TrgOHHy3LQpZfgrV7pK6ds5SqIt8OL30UmcfyXb6Ieo
         ct0dNN5Sk5GDqPIEFBjuGvVMd6N7JI2mpouDpuUMy0/4UaVp6DpZyUsfAGEUzPaivg6s
         wcAg==
X-Gm-Message-State: APzg51D6ooASdSZIjAiZ2Yt0aOAvoePMylM9M8Uigs6gOGsMdLEpiHvc
        dZ9sdZ/0XTzr4FahiuazqwQ=
X-Google-Smtp-Source: ANB0VdYObetqnwGqRFRW3ev+5aApFxM+Ure+s57LjukVfJcn5hIRZrU2g0PimQQk0+Bvryhh8G+Iig==
X-Received: by 2002:a5d:6984:: with SMTP id g4-v6mr6166397wru.232.1536854387411;
        Thu, 13 Sep 2018 08:59:47 -0700 (PDT)
Received: from localhost (p2E5BE549.dip0.t-ipconnect.de. [46.91.229.73])
        by smtp.gmail.com with ESMTPSA id 75-v6sm9722230wml.21.2018.09.13.08.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 08:59:46 -0700 (PDT)
Date:   Thu, 13 Sep 2018 17:59:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Multi-parent IRQ domains
Message-ID: <20180913155945.GA19903@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

I've been trying to implement a feature on recent Tegra chips that's
called "wake events". These wake events are implemented as part of the
power management controller (PMC) and they control which events can be
used to wake the system from suspend. Events include things like an
alarm interrupt from an RTC, or the GPIO interrupt hooked up to a
power button for example.

We already have a driver for a couple of other things that the PMC does,
so I thought it'd be natural to implement this functionality as an IRQ
chip in the PMC driver. The way that this would work is that for all the
devices that are wakeup sources, we'd end up specifying the PMC as the
interrupt parent and the PMC would then itself have the main GIC as its
parent. That way, the hierarchical IRQ domain infrastructure would take
care of pretty much everything.

Unfortunately I've run into some issues here. One problem that I'm
facing is that PMC could have more than one parent. For example, the RTC
alarm interrupt goes straight to the GIC, but the power button GPIO goes
through the GPIO controller first and then to the GIC. This doesn't seem
to be something that's currently possible.

The way I imagine this to work from a DT perspective is as follows:

	rtc: rtc@c2a0000 {
		compatible = "nvidia,tegra194-rtc", "nvidia,tegra20-rtc";
		reg = <0x0c2a0000 0x10000>;
		interrupt-parent = <&pmc>;
		interrupts = <73 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
		status = "disabled";
	};

	pmc: pmc@c360000 {
		compatible = "nvidia,tegra194-pmc";
		reg = <0x0c360000 0x10000>,
		      <0x0c370000 0x10000>,
		      <0x0c380000 0x10000>,
		      <0x0c390000 0x10000>,
		      <0x0c3a0000 0x10000>;
		reg-names = "pmc", "wake", "aotag", "scratch", "misc";

		#interrupt-cells = <5>;
		interrupt-controller;
	};

	gpio-keys {
		compatible = "gpio-keys";

		power {
			label = "Power";
			gpios = <&gpio_aon TEGRA194_AON_GPIO(EE, 4)
					   GPIO_ACTIVE_LOW>;
			linux,input-type = <EV_KEY>;
			linux,code = <KEY_POWER>;
			debounce-interval = <10>;
			interrupt-parent = <&pmc>;
			interrupts = <29 &gpio_aon TEGRA194_AON_GPIO(EE, 4)
						   IRQ_TYPE_LEVEL_LOW 0>;
			wakeup-source;
		};
	};

The above is somewhat brittle because the PMC needs to be able to cover
both GIC and GPIO interrupt specifiers, so it gets 5 interrupt cells
(one for the wake event ID, one for a phandle to the parent controller
and two or three for the parent specifier). It'd be nicer if we could
actually have specifiers that exactly match the bindings for the
respective parent controllers (so that the GPIO specifier didn't have to
contain the dummy 0 at the end), but I don't see a way how that can be
achieved, given how we have to "embed" the specifier in another. We
could probably make it work in code, but DTC would still flag these as
errors.

One thing I briefly looked into was using interrupt-map to implement
this, which would give us a nice way of mapping arbitrary parent
interrupts to wake events. However, since we need to program some of the
PMC registers at ->irq_set_wake() time, using simply an interrupt-map
wouldn't do the trick, since we wouldn't be implementing an IRQ chip and
hence wouldn't be able to install any callbacks.

Perhaps a simple way to implement this would be to just blindly enable
all wake events, but that's not really what we want. We really only want
to enable them for devices that can be wakeup sources. Otherwise we may
get wakeups for completely unrelated GPIO activity.

I tried implementing support for multiple parents within the PMC driver
by looking up the parent domain based on the phandle from the specifier
at IRQ domain ->alloc() and ->translate() time, but I run into deadlock
when I do that, so before I go and open up a can of worms I wanted to
get your input on what the best way forward would be.

Does anyone have any ideas on how to solve this? Perhaps there's a
better solution to this that doesn't involve IRQ infrastructure that I'm
not aware of?

Thanks,
Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluaiW0ACgkQ3SOs138+
s6HYJA/9HViIu3YoQMRYX9pH199SbtFo8nEFrlXyUbAr9fCcTGKz6FnoNYqlN/wD
GlSP0mpfAn76N8E3V+xuWtgLRihPIew7K1q8Uynxy9RussCZPIyyD4rwOFvbmvX2
1HHtCl/Phh0fYF+oCmM5H3JTj/Na6a5fTN+9357FFXteMnyqzpNvHbdZIEKvv4qt
r1iYIDlGoqQX5zwIBgCxlFB+vDsbNaSCBY4cZKxfKMuLLqAH/ITMWK9T4ANTn/u1
DZWvx9fl3zZiN1enMJ+8oz9rX3EKXkj8RdcYwSl4HL8+quCrCauslz1yQo+Ahw+q
SEo9IIJIoxNy5FGEWg3m2G455oQ7KtsksZJO9KXusrtcbOhptuk9I4B0A3GfR+Az
vMM1j2f7I2KiyrDCxqvo+2e9pBUWUZfp0uNHlFno5jXoSK7x27NRnJdLYb/ac2lP
BfsfY1OJRONOkOvsHXnK7YxCbKJY7yT7/c3C3PjQKB/5yDAP8ULwvlCN2Zc1sz/p
usONA2fziuXHhWCCke0YNeKYXb2oQqXNPAq9UDn2AaZKzPQaewnF82Q/zcwbZ+Ut
jVcW0S6wIxQC7R56BZaGjuhpl9elSLD4idl8u1LWxkmM2cphxf+Cj8zaBLV4HcWV
DC0fe7bC73x0rmknhdt5WFK7L8wnsa1nt2bvHVcWPZjO1WBtOak=
=gT9u
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
