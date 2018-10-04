Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44907C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08B72098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2dm0exD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08B72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJDRXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:23:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeJDRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:23:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so2954314pgm.7;
        Thu, 04 Oct 2018 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DIrB1GFmPaUBymO1pImmGm1WpkpLxTjq2keCTPeUT4w=;
        b=b2dm0exDSD+LuLekoDzUxOqXLilQhJus9JzO2K2//rUGhRQv3WG56STzbqDjRSigxY
         KdTbkmYfisZ01Ljh3chs4eMED6H19q6dzps5KNF6hmek7Lbd2T00kX60Qup0tRHVk3OK
         oBkMuWB9dNF9z//S1Vp88vF63Emez/M2F8MHIKsn8Z8Gs8dMdTxZhDz/jkiT6i/3lIps
         cWZOIUvSAK6Dct4E5H1sSYHSkj62moHNiKjdcZw1qWMWC1VVbV6Mo0pEDiVYgkuaRAG3
         M5J/vzNFXcRPm5KSmvHXsHpQCoyGzfrbu13iPg7nGFi5pxPTX4EZwi8BInx9gc0/YHbV
         JX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DIrB1GFmPaUBymO1pImmGm1WpkpLxTjq2keCTPeUT4w=;
        b=V7xxkU34z2qa+MfPE6jxKwkqmQYgtn6eGVy5YYrKWYbsjxnq9+Q2DYOz6p2xc+y3ms
         26ia/dGjjnuQSqGYe2ySBz/hfmCSprDO3kxAKeNMXFUXgxUT67tKvgXh3LciOCJd0//E
         il+/jkSNOefYMZ7PHab3nh8pHnEnbwHCqMClBGjxNEQ7nA4Lhb2z8oew3dadXGFoRwaQ
         ItCbILZxN2C3tnxR2kuhs5/MNetxfzLRq8/29b/fJ/Ez4BgD3YbbmrgmRbS3ZZ5ZfR8l
         T2+L/b85dD/dEWFrt01sNmdaYMmRR4E3DNtuxuns/iHrBHimh5Lm1xDOn9yHYXRRYcE/
         PQXw==
X-Gm-Message-State: ABuFfogzBeTdnJE0BllfS20xFmdSDTudJ01ur3TeEhI/vyhSeMjbs9wq
        NBkKiBz5itVptM71k4PE27MkPR36
X-Google-Smtp-Source: ACcGV62z0Ra/+cRbAXfWNVb2JKRWOcKurVaM1q5FyQGVPzKQn4cVoJNrvQWrqTvtvp5IzbS0wLz1aQ==
X-Received: by 2002:a63:ef53:: with SMTP id c19-v6mr5119548pgk.386.1538649040192;
        Thu, 04 Oct 2018 03:30:40 -0700 (PDT)
Received: from icarus (122-223-50-245.fukuoka.fdn.vectant.ne.jp. [122.223.50.245])
        by smtp.gmail.com with ESMTPSA id m15-v6sm11925440pfk.149.2018.10.04.03.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 03:30:39 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:30:28 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Message-ID: <20181004103028.GA4779@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
 <20181002082142.GC15943@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181002082142.GC15943@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:21:42AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 02, 2018 at 09:42:48AM +0200, Rasmus Villemoes wrote:
> > On 2018-10-02 03:13, William Breathitt Gray wrote:
> 
> > The cover letter says
> > 
> >   The clump_size argument can be an arbitrary number of bits and is not
> >   required to be a multiple of 2.
> > 
> > by which I assume you mean "power of 2", but either way, the above code
> > does not seem to take into account the case where bits_offset +
> > clump_size straddles a word boundary, so it wouldn't work for a
> > clump_size that does not divide BITS_PER_LONG.
> 
> E.g. 3 bits in a clump? Hmm...
> 
> Why would we need that? I mean some real use case?

GPIOs in hardware may be routed to devices logically in groups of I/O
lines, yet must still be accessed via the word-sized registers on the
operating machine.

For example, suppose a GPIO card is used to control a set of shower
devices. The card supports 4 shower devices, each device controlled by 3
lines of I/O: enable, hot-cold selection, high-low pressure selection.
In this case, a operating machine would still have to access the GPIO
lines via the I/O registers (e.g. 8-bit port I/O); but with a macro
handling a clump size of 3-bits, we can loop logically by each shower
device which is much simpler from a driver perspective.

William Breathitt Gray
