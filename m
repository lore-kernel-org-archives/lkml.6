Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A75C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025C427BA5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0PFXwRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025C427BA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeF2IGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:06:01 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43541 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeF2IFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:05:31 -0400
Received: by mail-io0-f194.google.com with SMTP id i23-v6so7682790iog.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXOXPvrAJCf2zBvOMg+6u4g42yCTf9qwdZiRf9oIBB4=;
        b=e0PFXwRyifTexV1J/Deh08BKWX+EctvpGsr+ZvQzbXenol66jX095VGQejYqc1/ld4
         khpM01q9K4EISrgURf0tJabHthxDrEJJdxPn21RI63vspK59pu3AXVKcp14MqukSDl/8
         cVo8pqNmEUcTkh4cJ4ct08XmI0P0yDU91Mq0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXOXPvrAJCf2zBvOMg+6u4g42yCTf9qwdZiRf9oIBB4=;
        b=nfaZBdybLGE6mCnCNIMElSsFuDuYKCeR842YwPTp3EUBjhYD7SifTvIHFMerLe37ou
         dS7Lu1Nu5PCsb2iBcHhFAjCElHlaB0SgufvG9TBeu/RBRz4UwhwiBhkDZZGRGLnjoWuh
         1s8SCxwPyVquqVislJ3v5mniiZdSRtr2UqAO4HhKAuHACuIIv1QO7VXwUKEpGP5qBL2N
         mVPnW1owhtQ+OGX2rVDGX95MiXPLbMlf6tUGP3ewDSZNl6To7VCxe+/tyLeUPGOyWcgd
         9YC8S/+6kg9toq3bbLvdqQgdHb6/fE5HKSouwUrZNMXbjaMVNJwnM/WJXXrO6IQu6+Mu
         W9SA==
X-Gm-Message-State: APt69E0tDUaMmgfomY7aRyz2MA37jeqhZATqkmTWi2HA+nxR5/bNDKj5
        DET433+Jet2VYWHV5b2dW/d+aHVv9EQ0mRto9xQWGw==
X-Google-Smtp-Source: AAOMgpeQnzLK+H3MRxWAm6uyvZKJPW7Tm/19MXJZ5DoiJGfPrVp7tYaNu0JW7IPHeqIUHdknLv0ycRctCRAtJ0JoCb4=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr11045134ioz.304.1530259530939;
 Fri, 29 Jun 2018 01:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180619151000.21693-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20180619151000.21693-1-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 10:05:19 +0200
Message-ID: <CACRpkdbT_3BrJxAs=giq=FDZWPL_471ZZWYxQP8RV9COM_XgJQ@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: arizona-ldo1: Use correct device to get
 enable GPIO
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, hias@horus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 5:10 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Currently the enable GPIO is being looked up on the regulator
> device itself but that does not have its own DT node, this causes
> the lookup to fail and the regulator not to get its GPIO. The DT
> node is shared across the whole MFD and as such the lookup needs
> to happen on that parent device. Moving the lookup to the parent
> device also means devres can no longer be used as the life time
> would attach to the wrong device.
>
> Additionally, the enable GPIO is active high so we should be passing
> GPIOD_OUT_LOW to ensure the regulator starts in its off state allowing
> the driver to enable it when it is ready.
>
> Fixes: e1739e86f0cb ("regulator: arizona-ldo1: Look up a descriptor and pass to the core")
> Reported-by: Matthias Reichl <hias@horus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Changes since v1:
>  - Pass GPIOD_OUT_LOW to gpiod_get_optional

Nice, thanks for fixing this!
Sorry for screwing it up :(

I wish I could be more careful, but without access to the
hardware it is sometimes pretty tricky not to break things
by mistake.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
