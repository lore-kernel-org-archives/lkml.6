Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A666CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEDA2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzusdV7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEDA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeIYJVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:21:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52876 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIYJVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:21:23 -0400
Received: by mail-it1-f194.google.com with SMTP id h3-v6so13571428ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 20:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbvantTxYQoNqplUr3kHGbh6zQ1QSXQ8ERbf2W2is6c=;
        b=XzusdV7RXmDU9MHYhe5+8++vfp98e+O4axGXUkbWPzCiPS5Vt8PfLQVgldj+JD/1UE
         EWwDTWbhsVKa5RNFEFrlCeHhbTV4OrhUUXGhl5ArHD9AyN0iRmcaZ8XeD5yJnLcKcNm6
         clLLfUeJAGTyoTTZqyFESFRJtzPcccoNOYD4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbvantTxYQoNqplUr3kHGbh6zQ1QSXQ8ERbf2W2is6c=;
        b=thstM1U1vZ3K8bW6A1RKHtaC1D0RRHqi3RVgKU0lgCru7uMm0KJdMuNU/YyCdQuGtf
         LROAQ2Bece/inWRi9r4F+eLl5uPBSHRVrFQOSkeodov7yRLvZO24fb4t4HvgAkQTKPCs
         IAqwtQ0aigdd5FSlMsWVEr6IqdlnHw80PNXUQnEUs0Ydzue8mSmmlPttrH4lOM0W2AZG
         SUlQpcRDTCWTGjb1y3Qi3ql6tLtp2YMPB41oytxkCa+9+/+B9qMWy9sCQBKVRuj3dMJy
         vKlA4Uhdnn91XZuppEy+w4C+yKoSI59HbQwi2bmTeOLT9L6pgJxKuYyyvtSJXi9xBh3q
         Ir/w==
X-Gm-Message-State: ABuFfoiY7dJcUg9dZdPGEetQy6os7zRWJa2ywNNJfrY1mlOySMgz8zU5
        SR1Zb9OsnJ9KjUMpDsACyND39A==
X-Google-Smtp-Source: ACcGV61TDm/frMMX2D5ZoNphQv/aao/1Ta90jReoftH0tLkwpNhB7IUDPQsRziG3JhauEDOstcqhSQ==
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr1202082ite.16.1537845360524;
        Mon, 24 Sep 2018 20:16:00 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id 17-v6sm713277ite.13.2018.09.24.20.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 20:15:59 -0700 (PDT)
Date:   Mon, 24 Sep 2018 22:15:58 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 164/235] pinctrl: pinmux: Return selector to the
 pinctrl driver
Message-ID: <20180925031558.3k6ukkfhbndgbm65@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113121.469295005@linuxfoundation.org>
 <20180924230710.o7bqbw353few6pjw@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924230710.o7bqbw353few6pjw@xps.therub.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 06:07:10PM -0500, Dan Rue wrote:
> On Mon, Sep 24, 2018 at 01:52:30PM +0200, Greg Kroah-Hartman wrote:
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> I bisected a boot failure on an x15 (arm) board to this commit on
> 4.18.10-rc1. I'm also seeing issues on 4.14 and 4.18 with arm64 boards
> hikey and dragonboard 410c, but I have not investigated them yet (they
> could be unrelated).
> 
> I see there are fixes to this commit that have not been backported.
> Namely:
> 
> 823dd71f58eb ("pinctrl: ingenic: Fix group & function error checking")
> a203728ac6bb ("pinctrl: core: Return selector to the pinctrl driver")
> 
> However, I tried adding those two in but I still see the boot failure on
> x15.

Dropping 9c5cd7b6ca4e ("pinctrl: pinmux: Return selector to the pinctrl
driver") does appear to fix the boot issues I'm seeing on x15 and hikey.

Dan

> 
> Dan
> 
> > 
> > ------------------
> > 
> > From: Tony Lindgren <tony@atomide.com>
> > 
> > [ Upstream commit f913cfce4ee49a3382a9ff95696f49a46e56e974 ]
> > 
> > We must return the selector from pinmux_generic_add_function() so
> > pin controller device drivers can remove the right group if needed
> > for deferred probe for example. And we now must make sure that a
> > proper name is passed so we can use it to check if the entry already
> > exists.
> > 
> > Note that fixes are also needed for the pin controller drivers to
> > use the selector value.
> > 
> > Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions for
> > managing groups")
> > Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> > Cc: Christ van Willegen <cvwillegen@gmail.com>
> > Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> > Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/pinctrl/pinmux.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > --- a/drivers/pinctrl/pinmux.c
> > +++ b/drivers/pinctrl/pinmux.c
> > @@ -308,7 +308,6 @@ static int pinmux_func_name_to_selector(
> >  		selector++;
> >  	}
> >  
> > -	dev_err(pctldev->dev, "function '%s' not supported\n", function);
> >  	return -EINVAL;
> >  }
> >  
> > @@ -775,6 +774,16 @@ int pinmux_generic_add_function(struct p
> >  				void *data)
> >  {
> >  	struct function_desc *function;
> > +	int selector;
> > +
> > +	if (!name)
> > +		return -EINVAL;
> > +
> > +	selector = pinmux_func_name_to_selector(pctldev, name);
> > +	if (selector >= 0)
> > +		return selector;
> > +
> > +	selector = pctldev->num_functions;
> >  
> >  	function = devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
> >  	if (!function)
> > @@ -785,12 +794,11 @@ int pinmux_generic_add_function(struct p
> >  	function->num_group_names = num_groups;
> >  	function->data = data;
> >  
> > -	radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
> > -			  function);
> > +	radix_tree_insert(&pctldev->pin_function_tree, selector, function);
> >  
> >  	pctldev->num_functions++;
> >  
> > -	return 0;
> > +	return selector;
> >  }
> >  EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
> >  
> > 
> > 
