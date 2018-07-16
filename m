Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C77ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5034208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFn2XBJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5034208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeGPUKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:10:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38024 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:10:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so7903991pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vDNNbMALTMFXifP8zFUGXLrYbeOj/2F7ZtBvsefTJMI=;
        b=FFn2XBJ2/lBuvSSUoseGcl4y5vfIwgBCbQwEqlNU8uqzqfWI8bIqn4iDHB5meL5LjC
         M09bfV6gkOV7ijZX/qRVR6vDDQfqEgmXJtfbFacHy0j8r6nvLYnj+ijyC6OtNaBjO6NC
         26srIJyQ4/PS06R8j+D4SZuWKfViUCMvj9MAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vDNNbMALTMFXifP8zFUGXLrYbeOj/2F7ZtBvsefTJMI=;
        b=YBpvgfZtDKBbGnQh8aCVcRQfdKbkexgaun/fWhgb4qn3Btjm/WzkkpE5q1ClHejq5P
         WNf39eP1C5Z74rUiFo7LkJpIhz70DvwSTiiGP1qGlG9at/Js0gfgu3dC9yXv2zXRgiUx
         wQr6EM3MaqVKBtB2Ul+2FK3Tyjvkk3bSbJD6xkS2dbx1AtPXm2Qb3wAD/lyvfL9r98mZ
         6q2fP6RY6OMbVgmWJC9JLodiz5hR5hVAYtpP7KnnHGRGxmOpEGb7ZuQ5TtZEkhxaig2z
         Xhur/i9qr5mwA4fQvYHMRfZcXfhXvDps1zNCQgM5x7abltgE7y12vbIVtvd8IkA6KXo6
         u6SA==
X-Gm-Message-State: AOUpUlH5UDH9QefzdsQlfF2qqvdv9GlidsGHb0cvfnBS89CCUfrvLKW7
        t3iW2NJLsDkx8VT4ZUZv+inSbw==
X-Google-Smtp-Source: AAOMgpdlBHM2krlewtIM/AlYygL08Go9XEurYwElvDVDwptn9+B8RMhRSXUYjH+KOH6NiDiHpOWmYQ==
X-Received: by 2002:a63:2246:: with SMTP id t6-v6mr16812904pgm.258.1531770075691;
        Mon, 16 Jul 2018 12:41:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z10-v6sm48985998pfh.83.2018.07.16.12.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 12:41:15 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:41:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 07/12] PM / devfreq: export devfreq_class
Message-ID: <20180716194114.GA129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234837epcas5p1da751e0394c16816b95ac1956bf6de20@epcas5p1.samsung.com>
 <20180703234705.227473-8-mka@chromium.org>
 <5B3C5B78.6020401@samsung.com>
 <20180706180923.GH129942@google.com>
 <41164a91-b271-5f3b-b461-21ff5997cc84@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41164a91-b271-5f3b-b461-21ff5997cc84@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, Jul 12, 2018 at 06:08:36PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 07일 03:09, Matthias Kaehlcke wrote:
> > Hi,
> > 
> > On Wed, Jul 04, 2018 at 02:30:32PM +0900, Chanwoo Choi wrote:
> > 
> >> I didn't see any framework which exporting the class instance.
> >> It is very dangerous. Unknown device drivers is able to reset
> >> the 'devfreq_class' instance. I can't agree this approach.
> > 
> > While I agree that it is potential dangerous it is actually a common
> > practice to export the class:
> > 
> 
> I tried to find the real usage of exported class instance
> and I add the comment for each class instance. Almost exported class
> instance are used in the their own director or some exported class
> like rio_mport_class/switchtec_class are created from specific device driver
> instead of subsystem.
> 
> Only following two cases are used on outside of subsystem directory.
> devtmpfs.c and alarmtimer.c are core feature of linux kernel.
> 
> 	drivers/base/devtmpfs.c uses 'block_class'.
> 	kernel/time/alarmtimer.c uses 'rtc_class'.
> 
> I cannot yet agree this approach due to only block_class and rtc_class.

I thought your main concern was that the class is exported, which is
what several other subsystems do. That the class isn't used outside of
the subsystem directory most likely means that there is no need for
it, rather than that it shouldn't be done at all (depending on the
type of use of course).

In any case not exporting the class object provides a limited
protection against potential abuse of the class at best. To use the
class API all that is needed is a 'struct device' of a devfreq device,
which has a pointer to the class object (dev->class).

Theoretically I could register a fake devfreq device to obtain access
to the class object, though that doesn't seem a very neat approach ;-)

> You added the following comment why devfreq_class instance is necessary.
> Actullay, I don't know the best solution right now. But, all device drivers
> can be added or removed if driver uses the module type. It is not a problem
> for only devfreq instance.

Certainly it's not a problem limited to devfreq devices. In many other
cases bus notifiers can be used, but since devfreq devices areen't
tied to a specific bus this is not an option here.

If you really don't want to export the class we could add wrappers
for (un)registering a class interface:

int devfreq_class_interface_register(struct class_interface *)
void devfreq_class_interface_unregister(struct class_interface *)

The wrappers would have to assign ci->class since the throttler
can't see the class object.

Or add notifiers for device addition/removal, though the throttler
relies on the behavior of the class_interface which also notifies
about devices added before registration. This might not be what other
potential users of the notifiers expect.

Thanks

Matthias

> /*
> +	 * devfreq devices can be added and removed at runtime, hence they
> +	 * must also be handled dynamically. The class_interface notifies us
> +	 * whenever a device is added or removed. When the interface is
> +	 * registered ci->add_dev() is called for all existing devfreq
> +	 * devices.
> */
> 
> 
> > grep "extern struct class " include/linux/ -R
> > include/linux/rio.h:extern struct class rio_mport_class;
> rio_mport_class is created on drivers/rapidio/rio-drivers.c.
> It means that just device driver create the 'rio_mport_class' class
> instead of any linux kernel subsystem.
> 
> > include/linux/tty.h:extern struct class *tty_class;
> tty_class is not used on outside of drivers/tty
> 
> > include/linux/fb.h:extern struct class *fb_class;
> fb_class is not used on outside of drivers/video/fbdev
> 
> > include/linux/ide.h:extern struct class *ide_port_class;
> ide_port_class is not used on outside of drivers/ide.
> 
> > include/linux/device.h:extern struct class * __must_check __class_create(struct module *owner,
> 
> > include/linux/devfreq.h:extern struct class *devfreq_class;
> not yet
> 
> > include/linux/switchtec.h:extern struct class *switchtec_class;
> switchtec_class is created on drivers/pci/switch/switchtec.c
> and then switchtec_class is only used on drivers/ntb/hw/mscc/ntb_hw_switchtec.c.
> It is not subsystem. Just switchtec.c device driver makes the their own class.
> 
> > include/linux/input.h:extern struct class input_class;
> 	input_class is not used on outside of drivers/input.
> 
> > include/linux/power_supply.h:extern struct class *power_supply_class;
> 	power_supply_class is not used on outside of drivers/power/supply.
> 
> 
> > include/linux/genhd.h:extern struct class block_class;
> 	drivers/base/devtmpfs.c uses 'block_class'.
> 
> > include/linux/rtc.h:extern struct class *rtc_class;
> 	kernel/time/alarmtimer.c uses 'rtc_class'.
> 
> > 
> > struct class_interface and class_interface_register() would be
> > pointless without exported classes.
> > 
> > My understanding is that the kernel is often lax on encapsulation and
> > exposes private/delicate data pragmatically within the kernel when
> > needed because "the kernel trusts itself".
