Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933081AbeB1Q40 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:56:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40565 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932164AbeB1Q4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:56:24 -0500
Date: Wed, 28 Feb 2018 17:56:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org
Subject: Re: [RFC 0/4] Add support for the Gateworks System Controller
Message-ID: <20180228165618.GC29484@lunn.ch>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <20180228144424.GC12303@lunn.ch>
 <CAJ+vNU3hG7z1mB0xKFZu-8o1r3hj-pOqkfVnWHvxxaxzrpGuzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3hG7z1mB0xKFZu-8o1r3hj-pOqkfVnWHvxxaxzrpGuzw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim

Cool. I would say this is done right.

> One issue I'm trying to figure out the best way to deal with is the
> fact that the GSC can 'NAK' transactions occasionally which is why I
> override the regmap read/write functions and provide retries. This
> resolves the issue for the mfd core driver and sub-module drivers but
> doesn't resolve the issue with these 'emulated devices' which have
> their own stand-alone drivers. I'm not sure how to best deal with that
> yet. I tried to add retires to the i2c adapter but that wasn't
> accepted upstream because it was too generic and I was told I need to
> work around it in device-drivers.

How about writing an i2c bus driver which sits directly on top of
another i2c bus? Basically a one port i2c mux.

The current mux code does not seem to directly allow it, since it
calls i2c_transfer() directly on the parent, where as you want it to
call your own i2c_transfer function. But maybe you could expended the
core mux code to allow the i2c_mux_core structure to contain a transfer
function?

      Andrew
