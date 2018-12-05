Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CACC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A540F2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A540F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeLEHAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:00:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38068 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:00:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so17301570lja.5;
        Tue, 04 Dec 2018 23:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=27B9qMspjDD1AgXG4zXqfQyvg5Itc4l3gB9owMvrM3Q=;
        b=X8r4j3cumJPUoM42jCpaX1QVOZBC5fHMtE2okmGlcCQSjfLtudFiSQUdab7fpek8oe
         Aug0gKiHdqV+PdO0paIEmETccbcxvcwAUBXPzd1bsZZePNRAi0SAt4XW6moZYLM6i75f
         ApHxVI+444+ebEoCh+0J9qdqOWyNhqrBIDtK6fNiBLJ/a84+fZKWwcCPPycNhF3Pk8/9
         2j1+8cED07Pb4VWqEUHTTO8JTohkAPlMO5RaX4gt+7i96yDkgUcqefFFtFl+RhXh4HPR
         Y7HFBZvFbekO7Ll/+1lgt6GHXa/2wlLAce0iuI3e1sjyYi/wpoyVz9bjF/L8BG76rI3Y
         ATDA==
X-Gm-Message-State: AA+aEWafRu1xXnZo/ZqcAUHDhfQeNG/h9wRcrQGg+bpigrh1mSuQGIHY
        DKQq4NwFsQ/Rag+HhUhxM0k=
X-Google-Smtp-Source: AFSGD/WiwQEFwql3iiSwej26/LOJHQCZfhdkkv48Wrxs4/02xOu2RhZf3qo3aFV6UA4/3LLifIZWHw==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr14439032ljf.47.1543993249678;
        Tue, 04 Dec 2018 23:00:49 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q127-v6sm3917951ljq.45.2018.12.04.23.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 23:00:49 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:00:46 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mazziesaccount@gmail.com, mturquette@baylibre.com,
        cw00.choi@samsung.com, krzk@kernel.org, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, pavel@ucw.cz, andrew.smirnov@gmail.com,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <20181205070046.GD31204@localhost.localdomain>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
 <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154395229720.88331.16585219136189943316@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

I copied some parts of the v4 discussion here as well. Let's continue
them under this one email thread. (and yep, this is my bad we now have
multiple email threads - I did these new patches without waiting for
the final conclusion. I should try to be more patient in the future...)

> > > I think we should use parent device's node, not the paren node in DT,        
> > > right? But I agree, we should only look "one level up in the chain".         
                                                                                 
> > Are these two things different? I'm suggesting looking at                      
> > device_node::parent and trying to find a #clock-cells property.                
                                                                                 
> I thought that MFD sub-devices may completely lack the DT node but I
> will verify this tomorrow.

So yep. It appears that the DT node for MFD sub-device is left NULL.
This is quite logical as there really is no clk sub-node in MFD (pmic)
node. The option to "hack around" this would be setting the of_node to
parent node in driver code. But this feels wrong. Drivers should not
mess with the "dt node ownership" - and it also feels a bit odd when
many devices use same DT node. I think we may hit in problems when
obtaining resources or doing reference counting. Hence I think we should
keep the of_node NULL for sub-device if the sub-device does not have own
node inside the main devie node. And I think Rob was not a fan of having
own nodes for sub-devices inside the MFD node (AFAIR my first driver
draft for this device had it but Rob and you thought that was not correct).

On Tue, Dec 04, 2018 at 11:38:17AM -0800, Stephen Boyd wrote:
> Quoting Matti Vaittinen (2018-12-04 03:34:53)
> > It seems to be usual for MFD devices that the created 'clock sub-device'
> > do not have own DT node. The clock provider information is usually in the
> > main device node which is owned by the MFD device. Change the devm variant
> > of clk of-provider registration to check the parent device node if given
> > device has no own node or if the node does not contain the #clock-cells
> > property. In such case use the parent node if it contains the #clock-cells.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/clk/clk.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 78c90913f987..66dc7c1483d7 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3893,6 +3893,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >         of_clk_del_provider(*(struct device_node **)res);
> >  }
> >  
> > +static int of_is_clk_provider(struct device_node *np)
> > +{
> > +       return !!of_find_property(np, "#clock-cells", NULL);
> > +}
> > +
> >  /**
> >   * devm_of_clk_add_hw_provider() - Managed clk provider node registration
> >   * @dev: Device acting as the clock provider. Used for DT node and lifetime.
> > @@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
> >   *
> >   * Returns 0 on success or an errno on failure.
> >   *
> > - * Registers clock provider for given device's node. Provider is automatically
> > - * released at device exit.
> > + * Registers clock provider for given device's node. If the device has no DT
> > + * node or if the device node lacks of clock provider information (#clock-cells)
> > + * then the parent device's node is scanned for this information. If parent node
> > + * has the #clock-cells then it is used in registration. Provider is
> > + * automatically released at device exit.
> >   */
> >  int devm_of_clk_add_hw_provider(struct device *dev,
> >                         struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> > @@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >         struct device_node **ptr, *np;
> >         int ret;
> >  
> > +       np = dev->of_node;
> > +
> > +       if (!of_is_clk_provider(dev->of_node))
> > +               if (of_is_clk_provider(dev->parent->of_node))
> > +                       np = dev->parent->of_node;
> 
> As said on v5, let's just modify of_clk_add_provider() to do the parent
> search.

But that won't solve the issue if we don't do "dirty hacks" in driver.
The devm interface still only gets the device-pointer, not the DT node
as argument. And if DT node for device is NULL (like in MFD cases) -
then there is no parent node, only parent device with a node. For plain
of_clk_add_provider() the driver can just give the parent's node pointer
in cases where it knows it is the parent who has the provider data in
DT. But our original problem is in devm interfaces.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
