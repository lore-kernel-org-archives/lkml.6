Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C91DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2A0218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="eWv2kqyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfB0HaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:30:00 -0500
Received: from chill.innovation.ch ([216.218.245.220]:40932 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0H37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:29:59 -0500
Date:   Tue, 26 Feb 2019 23:29:58 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch E030B640135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1551252598;
        bh=AoojyuobgkGnwxiIdeglMMd4b4EKoMnBreU3SCs6BTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWv2kqyzRBwT63IRa3KVcHk5TwW1P1QE3HrlAJps7eKin7PcS2y421JlGJYuBg3bh
         IKREvdBhAaOPw3w6jkBDn0CxhOkhfsazBewh7O/17aky9hONw1H2GAlZ6/2/1U+rI8
         QxW1W3jFoafCejqK0eU/n0CwDV5nz6izcFXk3k6jXML00dkEWIXQk6NW4/TMMiVnaO
         NRpeMj0KW5efchC39CUZ/yR6kn87CDbqTfvBcDHHpfRNcRCaCm8UfOxrlNhWxbmiuj
         LukKd0Xl7t4VVJBMPfVZzILt8jLEu+SuA136P6gEdjOx0oY4qx60WDIb2Gi9oqekeT
         3IJ6zylEa0SMQ==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190227072958.GA10349@innovation.ch>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
 <20190226092059.GV9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226092059.GV9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Feb 26, 2019 at 11:20:59AM +0200, Andy Shevchenko wrote:
> On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
> > 
> > In order for this driver to work, the proper SPI drivers need to be
> > loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> > for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> > reason enabling this driver in the config implies enabling the above
> > drivers.
> 
> > +config KEYBOARD_APPLESPI
> > +	tristate "Apple SPI keyboard and trackpad"
> 
> > +	depends on ACPI && SPI && EFI
> 
> I would rather want to see separate line for SPI...
> 
> > +	depends on X86 || COMPILE_TEST
> 
> ...like here
> 
> 	depends on SPI

Sure. Generally, what is the criteria/rule here for splitting
conjunctions into separate 'depends'?

[snip]
> + #define DEV(applespi)           (&(applespi)->spi->dev)
[snip]
> > +	if (memcmp(applespi->tx_status, status_ok, APPLESPI_STATUS_SIZE)) {
> 
> > +		dev_warn(DEV(applespi), "Error writing to device: %*ph\n",
> 
> Hmm... DEV() is too generic name for custom macro. And frankly I don't think
> it's good to have in the first place.

Yeah, I've been having trouble coming up with a better (but still
succinct) name - CORE_DEV()? RAW_DEV()? DEV_OF()? However, because
this expression is used in many places throughout the driver (mostly,
but not only, for logging statements) I feel like it's good to factor
it out. But I'll defer to your .

[snip]
> > +static void
> > +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> > +{
> > +	unsigned char tmp;
> 
> > +	unsigned long *modifiers =
> > +			(unsigned long *)&keyboard_protocol->modifiers;
> 
> I would leave it on one online despite checkpatch warning (also, instead of
> (unsigned long *) the (void *) might be used as a small trick).
> 
> > +
> > +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> > +	    !applespi_controlcodes[fnremap - 1])
> > +		return;
> > +
> > +	tmp = keyboard_protocol->fn_pressed;
> > +	keyboard_protocol->fn_pressed = test_bit(fnremap - 1, modifiers);
> > +	if (tmp)
> 
> > +		__set_bit(fnremap - 1, modifiers);
> > +	else
> > +		__clear_bit(fnremap - 1, modifiers);
> 
> Oh, this is not good. modifiers should be really unsigned long bounary,
> otherwise it is potential overflow.
> 
> Best to fix is to define them as unsigned long in the first place.

Can't do that directly, because keyboard_protocol->modifiers is a
field in the data received from the device, i.e. defined by that
protocol. Instead I could make a copy of the modifiers and pass that
around separately (i.e. in addition to the keyboard_protocol struct).

However, the implied size assertions here would basically still apply:

  MAX_MODIFIERS == sizeof(keyboard_protocol->modifiers) * 8
  ARRAY_SIZE(applespi_controlcodes) == sizeof(keyboard_protocol->modifiers) * 8

(hmm, MAX_MODIFIERS is really redundant - getting rid of it...)

Would using compiletime_assert()'s be an acceptable alternate approach
here? It would serve to both document the size constraint and to
protect against overflow due to an error in some future edit. E.g.

 applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
 {
        unsigned char tmp;
        unsigned long *modifiers = (void *)&keyboard_protocol->modifiers;
+
+       compiletime_assert(ARRAY_SIZE(applespi_controlcodes) ==
+                          sizeof_field(struct keyboard_protocol, modifiers) * 8,
+                          "applespi_controlcodes has wrong number of entries");
 
        if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
            !applespi_controlcodes[fnremap - 1])
 		return;
 
 	tmp = keyboard_protocol->fn_pressed;
 	keyboard_protocol->fn_pressed = test_bit(fnremap - 1, modifiers);
 	if (tmp)
 
 		__set_bit(fnremap - 1, modifiers);
 	else
 		__clear_bit(fnremap - 1, modifiers);
 }

> > +}
> 
> > +					   applespi->last_keys_fn_pressed[i]);
> > +		input_report_key(applespi->keyboard_input_dev, key, 0);
> > +		applespi->last_keys_fn_pressed[i] = 0;
> > +	}
> 
> > +	for (i = 0; i < MAX_MODIFIERS; i++) {
> 
> > +		u8 *modifiers = &keyboard_protocol->modifiers;
> > +
> > +		if (test_bit(i, (unsigned long *)modifiers))
> 
> Oh, this is not good idea, see above.

See above. (I presume duplicating the compiletime_assert() here isn't
necessary, if going that route?)


  Cheers,

  Ronald

