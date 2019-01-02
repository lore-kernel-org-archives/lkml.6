Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88133C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC262171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/FK7wKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfABCSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 21:18:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfABCSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 21:18:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so14545248pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 18:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7xDoBsxjL/9axgZjE/eujXcLSvapi3M61/4VaHpVYlk=;
        b=Q/FK7wKAi+CV+qI2Qe6dNoo5WOyW1NMIKQeiCJAQRbRYIOiA5VTx3DE7DVFOQVmUgt
         fxamEOckC5bhhaVS7If37fdVOECTpaBp3dxeMWSCH0fw6ZaHGcKDzv6A/5rHeWG0UZA7
         zWdRU4kErM2eGrVH/JWqzkpcg3iVcdtDLV098=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7xDoBsxjL/9axgZjE/eujXcLSvapi3M61/4VaHpVYlk=;
        b=Bkv1wXFr7LoJO/fH/dyWFU+nB39Bmf/7M1tqE6IOu021zlRFfQy/Z7iwk1yLL0Hc12
         ovUQB72YNPLDk+NhFl6dy+yN+FYhOcxWfrX0xF3qJKWXDS+gYbow6trr7GUDKf1BmMZR
         IrRFWNVyLqhpPe1D0XsrrbFR0bW71Myq5v5ABaXbUL1bLL5v48wju9i5Ufo6gz99quEP
         peXQzOp5V+knvMQuTueM2Q/eTWYw+ID498/2TOYy3TiVpWQmTeiRskDm9nUZKUg+0ePr
         k/0wUFgeclA5pVfZWr7XuLK1AfKTUCm26OhnSHMA+M+l5o71d9wHGqOvJydM9BhLUWvg
         2qmA==
X-Gm-Message-State: AA+aEWYtt/ZsUbsAQnVLqUax6iW1xA/yviEUce0MDIedxkd2zsjHAep1
        gdnWedvYK9RPGlNWMF0A0+5N
X-Google-Smtp-Source: ALg8bN5SUCGVmvhme59s+8LtsbcA++xANlPWDiYXloYoDEXcIZLGke+BRJXtXhX2kE9wbeWAV9u8+w==
X-Received: by 2002:a62:33c1:: with SMTP id z184mr42657566pfz.104.1546395493326;
        Tue, 01 Jan 2019 18:18:13 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:710:efc6:504b:339d:2535:e1e1])
        by smtp.gmail.com with ESMTPSA id e65sm94457177pfc.74.2019.01.01.18.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Jan 2019 18:18:12 -0800 (PST)
Date:   Wed, 2 Jan 2019 07:48:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Joe Perches <joe@perches.com>, afaerber@suse.de
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
Message-ID: <20190102021805.GA3955@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
 <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
 <20190101032622.GC2736@Mani-XPS-13-9360>
 <a935ceb348e5b4efb754484da745425afa1e7713.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a935ceb348e5b4efb754484da745425afa1e7713.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Jan 01, 2019 at 08:56:49AM -0800, Joe Perches wrote:
> On Tue, 2019-01-01 at 08:56 +0530, Manivannan Sadhasivam wrote:
> > Hi Joe,
> 
> Hi Manivannan.
> 
> > On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> > > On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> > > > Add the linux-actions mailing list for Actions Semi SoC architecture.
> > > 
> > > Unrelated to adding this L: entry
> > > 
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > []
> > > > @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> > > >  M:	Andreas Färber <afaerber@suse.de>
> > > >  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > > +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> > > >  S:	Maintained
> > > >  N:	owl
> > > 
> > > The N: entry matches too many non-owl entries like:
> > > 
> > > Documentation/parport-lowlevel.txt
> > > drivers/misc/ibmasm/lowlevel.c
> > > drivers/misc/ibmasm/lowlevel.h
> > > fs/udf/lowlevel.c
> > > net/ipv6/ip6_flowlabel.c
> > > sound/soc/samsung/lowland.c
> > > 
> > > Maybe there should be two entries
> > > 
> > > N:	/owl
> > > N:	-owl
> > > 
> > 
> > Thanks for letting us know. Yes, we need to change it. How about below?
> > 
> > N: owl-
> > N: -owl
> > 
> > Will do it as a follow-up patch if agreed!
> 
> from MAINTAINERS:
> 
> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.
> 
> F: entries are preferred to N: entries because the
> get_maintainer.pl script does not assume that the
> N: entries are exclusively maintained.  Maybe use a
> more comprehensive F: list like:
> 
> F:	Documentation/devicetree/bindings/*/*owl-*
> F:	arch/arm/boot/dts/owl-*
> F:	drivers/*/owl-*
> F:	drivers/*/*-owl*
> F:	drivers/*/*/owl-*
> F:	drivers/*/*/*-owl*
> F:	include/dt-bindings/power/owl-*
> F:	include/linux/soc/actions/owl-sps.h
> 

Makes sense!

Andreas: What is your opinion on above entries?

Thanks,
Mani

> 
