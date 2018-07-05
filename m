Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00E223F84
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V777G2QX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00E223F84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGEMvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:51:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54924 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbeGEMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:51:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so10889393wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9uCBx37dAySXP3UULrYIpnrt8nI9YVdLIpZKUjnpc18=;
        b=V777G2QXG8ZnUqByVed4XnlkhGcVNIbFgCXseE+63k4FC9DLP0xopW/1vDBti6CN+h
         fn3kNPMvrWg53WsjLvkmYs0ZILUk/t4p+RFCwDla2Ryl7XK4Jkdp7DMFUZTwBQxZ4aUx
         ShZJFEJM3A4l1yuPkwJB2aA7IXlaSEqmxsdVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9uCBx37dAySXP3UULrYIpnrt8nI9YVdLIpZKUjnpc18=;
        b=pbuhtkGUE5b58aYRiuYlyfgmAbgKG+EP+XvAp63Vrc0MzGSvqLGox29FvVPTGM+sfp
         4IhRend5dZDNUdTfrSJjS6U8VGiAmOeeFg48VB5DfxjXotYjZZGRkZ1ifCLC7oc1M1Ly
         qIQ9zxltQeUVSQi0ANbUh6J2pzcPkUtRbAFg4H7nae0ktL44NZeSkP3Tm1JvWnpF4Lij
         c2elbATieezE0hxPfv+F1g+Fm6eYlqKqYnfCsDKPRhLlmsci53wyVnTj/RKOd/c+vT8y
         LBxODduhzctiTu7IOQH1/incuU1LJhjVZnK7n2+nkp4wdNfheTwavcpM1I7OrwPOasNR
         FBjA==
X-Gm-Message-State: APt69E0cAjuaBv/qkhcv/954xjFeXYqCOefabfx8/IdDMCUPIp1GFBD3
        BeYYuTzHyci0HCePpUNRVq33Tw==
X-Google-Smtp-Source: AAOMgpfhgukrkMtxlvkoIPb+4QuFccnGJVktWW4cGtxQAO7SHbWig40gAlzyduaEuTgggU+50S8npA==
X-Received: by 2002:a1c:d543:: with SMTP id m64-v6mr3792886wmg.12.1530795087705;
        Thu, 05 Jul 2018 05:51:27 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id i4-v6sm4516720wrq.28.2018.07.05.05.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 05:51:26 -0700 (PDT)
Date:   Thu, 5 Jul 2018 13:51:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180705125124.GQ496@dell>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705091813.GK496@dell>
 <20180705103442.GA8426@localhost.localdomain>
 <20180705111705.GN496@dell>
 <20180705122923.GD8426@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705122923.GD8426@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > +++ b/include/linux/mfd/bd71837.h
> > > > > @@ -0,0 +1,391 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > 
> > > > I thought these were meant to use C++ (//) comments?
> > > 
> > > The checkpatch.pl did complain if I used // comment on SPDX line for
> > > header file. OTOH for c-file it required // comments and complained
> > > about /* */ - version. So I did as it suggested and used 
> > 
> > Well that's just dandy -- who comes up with this stuff?
> 
> Engineers I bet =)

Ones who do not suffer from OCD, clearly!

> > > > > +/* Copyright (C) 2018 ROHM Semiconductors */
> > > > > +
> > > > > +/*
> > > > > + * ROHM BD71837MWV header file
> > > > > + */
> > > > 
> > > > If you prefix the mentions of (BD,bd)71837 with (ROHM,rohm) then this
> > > > comment becomes redundant and you can remove it.
> > > 
> > > I am sorry but I am not sure what you suggest here. Do you mean I should
> > > add ROHM or rohm to all definitions here? I think that would make
> > > definitions pretty long so I would certinly need to split more lines.
> > > Such cange would also impact already applied patches. So maybe I
> > > misinterpreted your comment? And in case I did not - can this prefixing of
> > > types - be done as a separate patch set as it impacts to regulators and
> > > clk too? (clk is not yet applied so that is easy to change though).
> > 
> > Any lines which are already long, you can justify as not having to do
> > this, however I think for the filenames and function names it would
> > be nice if they were prefixed.
> 
> Right. For file names this should be easily doable. And when the regmap
> wrappers are removed there are no public functions left. And I think the
> name of file containing the functions is sufficient for grouping
> functions under "Rohm", right? 

That's fine.

> > Filenames are particularly important.  That way all of the Rohm
> > drivers will be grouped.  Unless you can be assured that all Rohm
> > devices will be prefixed by 'bd', then the point is slightly mooted,
> > however since 'bd' doesn't really correlate with 'rohm' it's still
> > difficult to assume that bd* drivers are associated with Rohm -- if
> > you catch my drift.
> 
> I guess I do catch it. And no, all ROHM stuff will definitely not be
> prefixed with bd - which is the name of the power chip

> I mean power IC series.

Now you're getting it! ;)

> > > > > +struct bd71837_board {
> > > > > +	struct regulator_init_data *init_data[BD71837_REGULATOR_CNT];
> > > > > +	int	gpio_intr;
> > > > > +};
> > > > 
> > > > Where is this populated?
> > > > 
> > > Currently nowhere as I use device-tree for getting the regulator/irq
> > > config. This is for architectures which do not use DT - but as I don't
> > > have one for testing I did leave the depends_on OF. If it was populated
> > > I would expect it to be done in some setup code.
> > 
> > Please don't add code for 'what ifs'.
> > 
> > Please remove it and add it back when you need it.
> 
> Allright. Although this will also break the regulator part then...

Well, it's broken anyway ...

> > > > > +/*
> > > > > + * bd71837 sub-driver chip access routines
> > > > > + */
> > > > > +
> > > > 
> > > > Please don't abstract APIs for no reason.
> > > > 
> > > > Use the regmap_* API directly instead.
> > > > 
> > > 
> > > Yes. This was already pointed out by Stephen Boyd. But again, as part of
> > > the patches (reguators) were already applied using the wrappers - I asked
> > > if I can remove these in separate patch set after getting this initial
> > > version out.
> > 
> > That is one of the issues with applying related patches without each
> > of them being reviewed first.  Applying unsuitable code is not the
> > correct thing to do, sorry.
> 
> So I assume you are not Ok with adding the wrappers and removing them
> with later set of patches? I'll do following workaround then:

No, I'm not okay with that at all. :|

> 1. Change MFD Kconfig option name => current regulator code will not be
> compiled even if the MFD would be applied.
> 2. Change MFD according to this discussion (and break the compatibility
> with applied regulator code)
> 3. Fix the regulator code with further patches to Mark
> 4. Fix the depends_on Kconfig option in regulator tree to match the new
> one suggested here.
> 
> Does this sound reasonable?

That's how I would do it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
