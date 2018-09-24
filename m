Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA54C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1FF2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI9VG8+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1FF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbeIYAtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:49:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35391 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeIYAtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:49:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so9426239pfh.2;
        Mon, 24 Sep 2018 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FjiUbqm4sKEvGIQO0y/278aRNsA2PyTdOrFuTKjaUrQ=;
        b=KI9VG8+2W9zWmIf45NyfFC/q1FHhblzXKxJHXCICn2OV8AKimaNfqvBRQNeSh0Udw3
         kHQnA6uigs7u5mptkOfTMJld4i3kd3NGL4C4cTy8Jgcu/OtdBKqtSTYqdS4N6NUAL5Tf
         CZ6W4zhI+Rso+fqA+YqbqySu48lHfzs0/+zSLFBi8xdO9ftT+9wukzxJGwy2Ch2YZ6H3
         1iD3FBMuoT32u+PcjUiH9mY8OtoVMNSazVUUtLU5pfyzzUfdbwm3dewgb7xJ/lfvTVBg
         YxHIDkq+hd6da+vEhCdD/Lg+A8tFf5LQvnbP46mtDtdxFGyH+dxOHfxFt6z7ZxICUJqI
         L+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FjiUbqm4sKEvGIQO0y/278aRNsA2PyTdOrFuTKjaUrQ=;
        b=nwjor2Pjw6oPPjpcGQ3vRBPqMs54qmLWOsvGHM9dsSzwsMpIDwYoAUK1m5gznIfjEk
         haldlx+NGcbJAMvh8nJVv6h/RULIDMD7PuXoCS1z4c5SBWxLhhC5BMBFB9iSpByspVeG
         8bwXKtW6FzKqhl2lrWT4sEk/cRs1U36jbNFt/6+inbiCD71YkJRfLfO828idvzyg1/So
         bCdI8ni0Y9uorn7kxxlRi/r1lERCfxEMKXcbssFESzu9gLR+ZdGaIw3++wulAq8XCOZ+
         Tln36wM7itGX4cwyat9lv4lQuPKlAjPdVZNSEFvaUgPwZqyrmk8UuxbenTTUErfQg/bB
         vgZw==
X-Gm-Message-State: ABuFfojENMrm4nRJt4Q7+58R10RON2wxetVYoLNzncrJNhE7qIZbaIbZ
        ZYwRi+Y17JolrPxLKhjAiD0=
X-Google-Smtp-Source: ACcGV60mu0LCdg51l4ePmKNdN2c8x2gVd3418blglG3FD2ckUARyNpHq06HHVv1ZYBgFBnc+B0Ek/Q==
X-Received: by 2002:a62:68c3:: with SMTP id d186-v6mr139886pfc.70.1537814746819;
        Mon, 24 Sep 2018 11:45:46 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y7-v6sm56375pge.8.2018.09.24.11.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 11:45:45 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:45:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180924184543.GB156847@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924132050.GK11965@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 04:20:50PM +0300, Heikki Krogerus wrote:
> Hi Dmitry,
> 
> On Fri, Sep 21, 2018 at 04:31:19PM -0700, Dmitry Torokhov wrote:
> > > > +	if (!parent_pset)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +
> > > > +	p = pset_create_set(properties);
> > > > +	if (IS_ERR(p))
> > > > +		return ERR_CAST(p);
> > > > +
> > > > +	p->dev = dev;
> > > 
> > > That looks wrong.
> > > 
> > > I'm guessing the assumption here is that the child nodes will never be
> > > assigned to their own devices, but you can't do that. It will limit
> > > the use of the child nodes to a very small number of cases, possibly
> > > only to gpios.
> > 
> > If I need to assign a node to a device I'll use device_add_properties()
> > API. device_add_child_properties() is for nodes living "below" the
> > device.
> 
> device_add_properties() is not available to us before we have the
> actual struct device meant for the properties. If the child device is
> populated outside of the "boardfiles" then we have to be able to link
> it to the child node afterwards.

I think we are talking about totally different use cases and that is why
we are having hard time coming to a mutually agreeable solution. Could
you please describe in more detail what you would like to achieve,
and preferably show how it is described now with DT and/or ACPI, so that
I have a better frame of reference.

Thanks.

-- 
Dmitry
