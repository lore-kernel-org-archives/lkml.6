Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D57DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17FE205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ofyguocm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17FE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeJQWTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:19:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34977 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQWTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:19:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id d21-v6so17808494qtq.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+V+1tdObalfpAa88mC/A06Ihj6E2es3DkukF8lOEjQM=;
        b=OfyguocmKYwUM0YN79sptX8QQJ6ISrE5BDpU6jbLH+bxqfV+3oePtQ0IJjd3IBqsIk
         20apZbfxDOIReRisA+0CLXRIaAxy+lkyVSpJBTtGDFcsFE1BVHsT+UlFrRuc6Gy6ryV9
         NMSOCpBkJVPs+IbrV7q6HsCg4EbeGO2AOf6nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+V+1tdObalfpAa88mC/A06Ihj6E2es3DkukF8lOEjQM=;
        b=CYR1Yx9SuG+MK3FJSsMmVuQTuQ15j+O5OYZmUXnaGWkxKfi8DokeZVys+S6eZrYe1o
         cDX1kFwLxtFlaSO7exhRVq4Xaz+oBZIU002KyScjhZxfu0JDLQEGH8IbqrqQFi4R5r/P
         gI8PWNe+tKam3kuHFx4TFY8pKJ+GfXtN9FMNUbUDWm6tQEiX4hlfNnb6HuRhV7u05fCD
         Jp3HLSbdOuop4Ie83DsZIofgxIb1QKDtMdu3+d/AH6QI1z4JQcbw5A2DRoKSLl/DKv9k
         +/HFgAM96rIydq7lMBmzARFrrQeG9AXafoEo4OYXpG3YDZvnSXBMdGHojQW8FBjZnadp
         WBiQ==
X-Gm-Message-State: ABuFfoi7/oXGuuTZYAmuxaAlIgi+H2oB1NLuIVoHcpUUOk1Ag229YZ/W
        v3hYjHcVvnZ/R1YtuUs+2wxo/w==
X-Google-Smtp-Source: ACcGV63N3J8e0lF22lCyndUZsDbaDPfRtlGQKUDGuE5wbzTbNhxOCHP4A4SwzzeoXNBMkUo+L3o80A==
X-Received: by 2002:aed:3024:: with SMTP id 33-v6mr20773244qte.29.1539786199479;
        Wed, 17 Oct 2018 07:23:19 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id l43-v6sm13559575qtc.80.2018.10.17.07.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 07:23:18 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:23:17 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roman Yeryomin <roman@advem.lv>
Subject: Re: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810171009560.1498@knanqh.ubzr>
References: <20181015221629.13924-1-stefan@agner.ch> <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com> <20181016084416.GF30658@n2100.armlinux.org.uk> <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Arnd Bergmann wrote:

> On Tue, Oct 16, 2018 at 10:43 PM Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 16 Oct 2018, Russell King - ARM Linux wrote:
> > > On Tue, Oct 16, 2018 at 10:00:19AM +0200, Linus Walleij wrote:
> > > > On Tue, Oct 16, 2018 at 12:16 AM Stefan Agner <stefan@agner.ch> wrote:
> > > It's not obvious yet whether this is right - it contradicts the GCC
> > > manual, but then we have evidence that it's required for some GCC
> > > versions where GCC may clone the function, or if the function is
> > > used within the same file.
> >
> > Why not getting rid of __naked altogether? Here's what I suggest:
> >
> > ----- >8
> > Subject: [PATCH] ARM: remove naked function usage
> >
> > Convert page copy functions not to rely on the naked function attribute.
> >
> > This attribute is known to confuse some gcc versions when function
> > arguments aren't explicitly listed as inline assembly operands despite
> > the gcc documentation. That resulted in commit 9a40ac86152c ("ARM:
> > 6164/1: Add kto and kfrom to input operands list.").
> 
> It's probably worth noting that the minimum gcc version for compiling
> the kernel is now gcc-4.6, which I think does not suffer from the gcc-4.5
> bug that triggered the change. See in particular commits 9c695203a7dd
> ("compiler-gcc.h: gcc-4.5 needs noclone and noinline on __naked functions")
> and d124b44f09ca ("Compiler Attributes: naked was fixed in gcc 4.6").
> 
> The first one made sure we don't inline these functions, so gcc-4.5
> no longer runs into the problem even in the absence of the workaround,
> and the second patch reverts that again, noting that gcc-4.6 is fixed.
> 
> I don't see anything wrong with converting the functions to not
> use __naked at all, but I think we can also just revert the original
> commit 9a40ac86152c to get it to build with clang. When I last
> played with clang on arm32, that's what I did. I'll reply with the
> patch I have in my randconfig tree.

The __naked attribute has idiosyncrasies of its own, regardless of any 
potential bugs, that sometimes makes it harder to maintain and prevent 
extra optimizations that the compiler could otherwise take care of. So I 
think that this is a good thing to get rid of __naked when its usage 
isn't necessary, like the instances in this patch.

The remaining instances are cases where there is simply no stack 
available making __naked necessary in those cases.


Nicolas
