Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0807C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D3620874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDMUc/xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D3620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeFRINa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:13:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37737 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeFRIN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:13:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so13735157wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0F92LLMWkGHMTKuNF7dWD+TT0O8VkvleVwCa0Ni3QrQ=;
        b=bDMUc/xmvSww3UIJr4/871acjFA47m/JuF4d9xkGDMyWIDwV54fc4goLVXfTFWzuiC
         BfYZi+xG34kDeF7xOQt6JfpkxQT0Q0w5SuaF/YBWkk9rSI4qZvB0s6fFSZiETZZeQ1BO
         7JZ1euBxJtYCN1Ni1guJgUNJqERP2abxS+EtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0F92LLMWkGHMTKuNF7dWD+TT0O8VkvleVwCa0Ni3QrQ=;
        b=QOGvFnGN2CXHrISQw6EUHCXtIxu5DRxL4gG0nOSAZl8ji0KEcI4Q55frxpQKgXcG+k
         o0b4ECExRbWt3rKO1lVOPFza3ffF8B+qFo3zHtjQtBepK2Q/PW/hTjtIDjDBuqh7rW4s
         1HXoWC26XBzrUvFqIhH8XpyK8WXW+qy0NeLRot2s3aXoGDyjoSyHhK0Kx4sPoGuHKeJZ
         yvGfLoY2L2VkGAxnnUjNaO2lbYqKkOyNfF3+mke1REmVuek9Y3hjZLUtlM/iG72d7/BT
         smbS5iOeByLXP0J1AFytdVBRE9/tClQJ3Vm7UwR/4GZGq0xB/sms6EmojrOyUNqsNtUA
         aUbw==
X-Gm-Message-State: APt69E1l0TLzr+N/nAgRbiW37nO77b6WvnKKEdNVLW0XodnUrDtimZNM
        LckVkEclVX9Vk/8My2W+2kB7wA==
X-Google-Smtp-Source: ADUXVKIt/xQAHEA2i7NEni1W7ku0s5+rRRKx7rEFo7dQbcVq8xfy9yNn5S5rpB6uQwTIXpXneJ+Pdg==
X-Received: by 2002:a1c:6744:: with SMTP id b65-v6mr7486659wmc.9.1529309606199;
        Mon, 18 Jun 2018 01:13:26 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id n56-v6sm33866473wrn.72.2018.06.18.01.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 01:13:25 -0700 (PDT)
Date:   Mon, 18 Jun 2018 09:13:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 03/12] mfd: cros_ec: Make license text and module
 license match.
Message-ID: <20180618081323.GM31141@dell>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-4-enric.balletbo@collabora.com>
 <20180618071801.GI31141@dell>
 <20180618072021.GJ31141@dell>
 <CAFqH_51Fsyr-zE4zzKLxqPZeep9gj7X_1HOnBeEbg9jXju8S4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqH_51Fsyr-zE4zzKLxqPZeep9gj7X_1HOnBeEbg9jXju8S4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018, Enric Balletbo Serra wrote:

> Hi Lee,
> Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 18 de juny
> 2018 a les 9:21:
> >
> > On Mon, 18 Jun 2018, Lee Jones wrote:
> >
> > > On Wed, 06 Jun 2018, Enric Balletbo i Serra wrote:
> > >
> > > > The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
> > > > GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
> > > > boiler plate does not match, go for boiler plate license.
> > > >
> > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > ---
> > > >
> > > > Changes in v3: None
> > > > Changes in v2: None
> > > >
> > > >  drivers/mfd/cros_ec.c     | 2 +-
> > > >  drivers/mfd/cros_ec_i2c.c | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Applied, thanks.
> >
> > I've just seen Joe's comment.
> >
> 
> Did you read my answer [1] to the Joe's email?
> 
> According to the doc if MODULE_LICENSE is GPL that means  GPL-2.0 or
> later which to be strict is wrong if your file is GPL-2.0 only. It's
> right that there are modules in the kernel that have this mismatch but
> IMHO is wrong, there are also some examples where people fix this, i.e
> [2]

I did.  Did you read his comment about making these changes wider?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
