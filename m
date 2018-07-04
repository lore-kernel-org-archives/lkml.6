Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E345C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD123D1A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAEqFCW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFD123D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934425AbeGDJVT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:21:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55817 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752814AbeGDJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:21:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so5032539wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=asoFyybNv5Y5O0aJb3AFb6MzPwuaVev6IKnUWSP9kkk=;
        b=hAEqFCW5bG3+4p2AB0XVxnQCS7OXEHifMri5Kwsjb2vxvGjUEJwnBwCRCPW5YgjVsI
         dEC7w1v7rvY9hxFQQX9r2SzqtJ6L+USZJ+0HfVgLxt69/L8qTUlKg8ooqdxkXevp1kw3
         uabifDPhyoXKnsz81k3TJHgqhQ9nkFgilCE/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=asoFyybNv5Y5O0aJb3AFb6MzPwuaVev6IKnUWSP9kkk=;
        b=K84lMPR8StJSM1XsC7u5ajlMvFLeq226Nzn3WqvtBK0CiJJ1JbIwEFQ6RPgOoqGbtk
         i3gzGZn1nza+r4rrm8QArBeC9SCnSRWvJ4ihVyiHFRwgD3VbULtsSVZJSJq3AnNaaU3D
         42bOZ+3jMDYwi+DLqF7ct2uj7DAZ21lwUNzQSlAV134wH/Q1dpgO1rtL07qnzWIWEVpL
         MOVB/Epd7a16/Lc0HUKzEljqAggH1g5wawZQz6IDlOIdTQ+i4U5aw9VFZCvUmWpUuo2D
         /BVsXaAT+IDNkUuvmZIG+V+c+YNSg3lS9plhD27pLXt45+LKtP6LuZcT1pGlesxEmeNP
         jbTw==
X-Gm-Message-State: APt69E33wwDiBUAFIbNG4iahr+zulp02iJaifS6GaxDrPDNq89aX8rjK
        Ut04aUb+exK0wTvGcM633I87+A==
X-Google-Smtp-Source: AAOMgpfZ+LyxCKCTptI1KNWvdYkWTuZ61zSZEScxCkoFCmO3Gl+pwJxgYWS08Wy9bcrFhrHdYQXqmQ==
X-Received: by 2002:a1c:d8:: with SMTP id 207-v6mr968370wma.99.1530696072529;
        Wed, 04 Jul 2018 02:21:12 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id h3-v6sm2735391wro.87.2018.07.04.02.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:21:11 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:21:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837
 PMIC driver
Message-ID: <20180704092109.GT20176@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <20180621103400.GB6076@localhost.localdomain>
 <20180703070200.GC20176@dell>
 <20180704084715.GI2118@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704084715.GI2118@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jul 2018, Matti Vaittinen wrote:

> On Tue, Jul 03, 2018 at 08:02:00AM +0100, Lee Jones wrote:
> > On Thu, 21 Jun 2018, Matti Vaittinen wrote:
> > 
> > > On Tue, Jun 19, 2018 at 01:55:31PM +0300, Matti Vaittinen wrote:
> > > > Patch series adding support for ROHM BD71837 PMIC.
> > > > 
> > > What is the preferred way when I send updated patches:
> > > 
> > > 1. always resend _all_ unapplied patches even if there is no changes to
> > >    some of them. (patch-vN mail thread contains _all_ unapplied patches)
> > > 2. only resend changed patches (patch-vN mail thread contains only
> > >    patches that were changed from patch-vN-1)
> > > 
> > > I have currently used approach 1 - so that no patches would be
> > > accidentally forgotten - but downside is that people need to check if
> > > they have already reviewed some of the patches. I'd rather not caused
> > > any extra work. What is the most convenient way for you guys?
> > 
> > Option 1 is preferred.
> > 
> > Just ensure you apply any tags you have collected so reviewers can see
> > which patches are pending a review.  It's also a good idea to keep a
> > succinct change log between the "--" marker and the diff stat where
> > you can state "v4: No change" or the like.
> 
> Right. Thanks. Just one question - what if I get reviewed-by for a
> patch which I later rework? Like this MFD patch where I got reviewed-by
> from Linus Walleij for v6 - but which I reworked due to comments from
> Enric and Dmitry. I have not kept the reviewed-by as the patch is not
> exactly the same Linus was originally reviewing. I guess the tags should
> be only kept for patches which are unchanged, right?

That is the $64,000 question.  The answer is "it depends".  You should
use your common sense.  Did your re-work taint the code that your
reviewer provided his tag for?  If so, drop it.  If not, keep it.

There are no hard and fast rules about these kinds of things.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
