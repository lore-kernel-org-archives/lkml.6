Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6018C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B8E2152E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQjRxik/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B8E2152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbeHGTEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:04:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34236 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389136AbeHGTEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:04:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so13999482ljk.1;
        Tue, 07 Aug 2018 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+Db8TaKs+BhtQSpksdvvOhIqZRZ+v0flkYV64y5N9M=;
        b=oQjRxik/wv9X/yRtQPw4gK4O9SQGQ/SyzwYJcekYnkzE4/oqfaE+hgV0GnadjPR96a
         Jx1rfPO+tt/JZj/lHUsBOgjWCfPvx+7n/BeTfjyRsNy7T7UPXsW9LmmJUKYhBUnRL5RX
         /tFX8DUIViG87BqOomgTTpvMljOVFe5sbW18gvTYcJcAPAIzr1gQQ/CFcVLHReCB4yaY
         jlFstgK8rn3yj5gpzv2bT2prOUL+DAk9vYCeFXmNHO+AJziRX8g2MNF+Lkut5KDPjT0/
         ZiRon6w+pDT1pq2kzmXbqcfuu00crh5PFCb2vjhl8WPCJIgs346UPha0cmXlvBIg+AVE
         RyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+Db8TaKs+BhtQSpksdvvOhIqZRZ+v0flkYV64y5N9M=;
        b=Z0YeLNd6KcfwFC38DytVdaayOY7RuwbRa8djpxHigtZHHgJXhnZ2cbEAMfX4rq4eCB
         47Wv5UPPoc71k+OTAi0glZ5KZQS9uujT+oDFf57/xwpfrGJHK7KQekDzw3fg85Vj4PgN
         xoNWRtQlQXpBpF6+thK00HYvKj/45nyh0t+otEMeU6l0t/cUdNRLczWs4yA2s8xWLdrf
         5WKmBoNNGKurNfrujR5srghnATi+EI9FLWbwogDJ/I1naLn+vij2fvyDBW7qwoMhd0PZ
         aHIFaYkHIHUnqKk2tq9J+Swe7r3oSnEvc/lPvd/5z3Gy+26koA5ehmoQajH4lOiz5D6K
         depQ==
X-Gm-Message-State: AOUpUlEvIJ99K3vj5qTsT62bjkpJ2KFNDvjUfsJAu94r31j1Rg8rPegu
        I03YC0A3q/nqB7jcVk8GJxc=
X-Google-Smtp-Source: AAOMgpd9qPwyhBtnOeilr8p8wBWG07o9TVPftN4pkwSt7BOSvppKhSB5ATrC7PC9QG1CQQezontrFQ==
X-Received: by 2002:a2e:2096:: with SMTP id g22-v6mr15858660lji.37.1533660563644;
        Tue, 07 Aug 2018 09:49:23 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id q16-v6sm314115ljj.68.2018.08.07.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 09:49:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct mapping
Date:   Tue, 07 Aug 2018 18:50:22 +0200
Message-ID: <1793769.2WP40jSPqy@z50>
In-Reply-To: <CACRpkdZtuU6zXBz6UqprE7-31vW9-1ZabFjyzHBgWaTgmqkbbQ@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-10-jmkrzyszt@gmail.com> <CACRpkdZtuU6zXBz6UqprE7-31vW9-1ZabFjyzHBgWaTgmqkbbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tuesday, August 7, 2018 1:29:43 AM CEST Linus Walleij wrote:
> Hi Janusz!
> 
> On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> 
wrote:
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
> (...)
> >  This function returns a struct gpio_descs which contains an array of
> > -descriptors::
> > +descriptors.  It may also contain a valid descriptor of a single GPIO 
chip in
> > +case the array strictly matches pin hardware layout of the chip::
> >
> >         struct gpio_descs {
> >                 unsigned int ndescs;
> >                 struct gpio_desc *desc[];
> > +               struct gpio_chip *chip;
> 
> This must be motivated: if the only purpose is to indicate to the consumer 
that
> all GPIOs are on the same chip, why not just have a
> 
> bool all_on_same_chip;
> 
> That you set to true if these are all on the same chip?

My approach would probably save one or two instructions per get/set call, but 
I'm not stuck to it and will be happy to find a better solution.

How about folding the chip descriptor inside an additional structure, private 
to drivers, with internals not revealed to consumers?

Thanks,
Janusz


