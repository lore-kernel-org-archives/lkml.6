Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F957C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2643621524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teWOGNtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2643621524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390192AbeHGTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:34:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38978 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbeHGTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:34:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so14048931lji.6;
        Tue, 07 Aug 2018 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NN/M74K2wMWhEVDu0QmgduoWTZ9a+7qt+XXkaOMAOw=;
        b=teWOGNtpUK59vsyepb15vzkSJQXBqAGa6lICOlyEBQ9XO57axlvYf1J4N6LrX6J/CM
         y79LYP6U/7NMSQC7U8G2TJtiZkOFG/8Lmg3ZlSqF+ahXo4g5hP3m7A6g5PdlP55uhCbo
         doRGTh6rA30Sog+iYtOt9GDma2RbZiNUHaNT1zMF0x0HWdiJIRLUeo9s6Tb8GDO8WaUo
         UqbgIn2eH8zxJ0dwneHHjLECxxgVF4ty0W8hqqlBhXMxOCLfpOmPitCD3DFq/oYVidbP
         bflfrNcsKs9nvFpOEynB2GDmThws+EyZQgQ228uqotWtKC/vju8rlXXBhl7ckRo6RXgc
         WOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NN/M74K2wMWhEVDu0QmgduoWTZ9a+7qt+XXkaOMAOw=;
        b=VxbcJVJT/H52xzm/THXr7Q2JzW9FD69qcFlEnafMGdg/T+y0swN9EgXWq70bUolIpA
         edW79EYlXo/DuSMYoCloA37IvqA+UIvgPLv0LAo0glbDOq3IArFvTh7a8gthIt+qVwjT
         By5VTAHjglhBIJRvpU+PZoG8g+gmcRnMKcQO/iHn8iB87R6qZ+9of5/eHB8F25KnjsI0
         dfdLpgosD+GCsJLDJsltyBjhs6No9r87+gfGrxridu5C6tIkl0CvxQWGNB2GohiAlwo9
         P5c/pX6gJKt5ReHmwoiUwQFOmkwy+160dUTl+h3rzCGEFLXjviIrVAAu3NLTr/HOfkmL
         l6pQ==
X-Gm-Message-State: AOUpUlHYGgsUQZ16gnfGQXhDHmpEYrxkZLWhO0wsMxBc63sQj3tH+OvN
        mNnysjr2C1I1mEglJgp38C0=
X-Google-Smtp-Source: AAOMgpebl4wAMucs8jeYgaiWn3nISH2zJmWRt9YifwvatagwMocnomiw7CfZAzc5DSABJoGqObT5hw==
X-Received: by 2002:a2e:40ca:: with SMTP id r71-v6mr15839486lje.41.1533662337939;
        Tue, 07 Aug 2018 10:18:57 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id r73-v6sm337213ljb.16.2018.08.07.10.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 10:18:57 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct mapping
Date:   Tue, 07 Aug 2018 19:19:57 +0200
Message-ID: <5726821.9hm6pNmUJb@z50>
In-Reply-To: <20180807191420.04431e8e@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-10-jmkrzyszt@gmail.com> <20180807191420.04431e8e@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 7, 2018 7:14:20 PM CEST Boris Brezillon wrote:
> On Tue,  7 Aug 2018 00:29:15 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Certain GPIO array lookup results may map directly to GPIO pins of a
> > single GPIO chip in hardware order.  If that condition is recognized
> > and handled efficiently, significant performance gain of get/set array
> > functions may be possible.
> > 
> > While processing a request for an array of GPIO descriptors, verify if
> > the descriptors just collected represent consecutive pins of a single
> > GPIO chip.  Pass that information with the array to the caller so it
> > can benefit from enhanced performance as soon as bitmap based get/set
> > array functions which can make efficient use of that are available.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> >  Documentation/driver-api/gpio/consumer.rst |  4 +++-
> >  drivers/gpio/gpiolib.c                     | 14 ++++++++++++++
> >  include/linux/gpio/consumer.h              |  1 +
> >  3 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
> > index aa03f389d41d..38a990b5f3b6 100644
> > --- a/Documentation/driver-api/gpio/consumer.rst
> > +++ b/Documentation/driver-api/gpio/consumer.rst
> > @@ -109,11 +109,13 @@ For a function using multiple GPIOs all of those can be obtained with one call::
> >  					   enum gpiod_flags flags)
> >  
> >  This function returns a struct gpio_descs which contains an array of
> > -descriptors::
> > +descriptors.  It may also contain a valid descriptor of a single GPIO chip in
> > +case the array strictly matches pin hardware layout of the chip::
> >  
> >  	struct gpio_descs {
> >  		unsigned int ndescs;
> >  		struct gpio_desc *desc[];
> > +		struct gpio_chip *chip;
> 
> chip is placed at the beginning of the struct in the real code, which
> is expected since putting it at the end won't work because of the
> desc[] declaration.

Yes, I've already noticed that and will fix on next iteration, thanks.

Janusz


