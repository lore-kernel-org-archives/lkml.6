Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F702146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kj7WStdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBHPXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:23:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42350 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfBHPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:23:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id r15so3043595eds.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EHTr0RB9ZdzNKt00ELomTTS3xhMSfRUrzRC2DiCFv5k=;
        b=kj7WStdtoN8HuOdjFDr7VU8uWudfaY7/4NXNAuadJITPvLXNod94TZNkullMXHeGiy
         xKuZXr5JfduA/l1hUpN7eccceAFvFmM7Jd/BD/jCEKawY+Ywu7cB7yhfRT3Et+mX4ndF
         rIVYcekK4YueMhwZLA3srZT0Dc17G2NFHCQ80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EHTr0RB9ZdzNKt00ELomTTS3xhMSfRUrzRC2DiCFv5k=;
        b=qfA4oiD1CWaXZCvDMyD0QcSGrgQrceLKVQQSGHr8aIOF0dQvNgSgQGUF6kuerB04vG
         Ypeo3N3/lwXphH9fIqvD7CWW3e+nDVdHp4UN0A+ZJOhOna5Pzs7+0Ugq0MK8NPS8CMRP
         fg9PB298wi4GFuvUaf6lbK+qgY1sugGMVVNPcnzN4R+cDia4AKhoBmmIUTYYGLcsY6J3
         cOstdx/I3oWhosCWQoDfrrFc69N/JTIO6Lb9Rn09Ov3X+CxK9NnSmXdRfXZJvYJZWkXI
         BRzX/GKziVhW6eQAJKryDPeyjZHqm8UquDEDtqCxOsn2TZxoWhw0D5dEeW0s+Bt4BrwU
         n9Qg==
X-Gm-Message-State: AHQUAuY7+vwt1zh2z1Bah7dTV+Irqp4bxH+dhxBGCs3a9au6zzjsKEjw
        mZvkQWXhB2x8/agsWmNyplR9zQ==
X-Google-Smtp-Source: AHgI3IZrdXWitiPZ3fEikVXBIQDkDbyyQgudXBltyqEjbrviN8lrM9UYbQvsbAqb7YrvWIoZLPiL4A==
X-Received: by 2002:a17:906:64d:: with SMTP id t13mr15865843ejb.53.1549639408458;
        Fri, 08 Feb 2019 07:23:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s46sm697227edd.9.2019.02.08.07.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:23:27 -0800 (PST)
Date:   Fri, 8 Feb 2019 16:23:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/4] components: multiple components for a device
Message-ID: <20190208152325.GL23159@phenom.ffwll.local>
Mail-Followup-To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
 <20190207232759.14553-2-daniel.vetter@ffwll.ch>
 <20190208102849.qpozfixt77727ojx@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208102849.qpozfixt77727ojx@shell.armlinux.org.uk>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:28:49AM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Feb 08, 2019 at 12:27:57AM +0100, Daniel Vetter wrote:
> > Component framework is extended to support multiple components for
> > a struct device. These will be matched with different masters based on
> > its sub component value.
> > 
> > We are introducing this, as I915 needs two different components
> > with different subcomponent value, which will be matched to two
> > different component masters(Audio and HDCP) based on the subcomponent
> > values.
> > 
> > v2: Add documenation.
> > 
> > v3: Rebase on top of updated documenation.
> > 
> > v4: Review from Rafael:
> > - Remove redundant "This" from kerneldoc (also in the previous patch)
> > - Streamline the logic in find_component() a bit.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1 code)
> > Signed-off-by: Ramalingam C <ramalingam.c@intel.com> (v1 commit message)
> > Cc: Ramalingam C <ramalingam.c@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/base/component.c  | 158 +++++++++++++++++++++++++++++---------
> >  include/linux/component.h |  10 ++-
> >  2 files changed, 129 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/base/component.c b/drivers/base/component.c
> > index 1624c2a892a5..7dbc41cccd58 100644
> > --- a/drivers/base/component.c
> > +++ b/drivers/base/component.c
> > @@ -47,6 +47,7 @@ struct component;
> >  struct component_match_array {
> >  	void *data;
> >  	int (*compare)(struct device *, void *);
> > +	int (*compare_typed)(struct device *, int, void *);
> >  	void (*release)(struct device *, void *);
> >  	struct component *component;
> >  	bool duplicate;
> > @@ -74,6 +75,7 @@ struct component {
> >  	bool bound;
> >  
> >  	const struct component_ops *ops;
> > +	int subcomponent;
> >  	struct device *dev;
> >  };
> >  
> > @@ -158,7 +160,7 @@ static struct master *__master_find(struct device *dev,
> >  }
> >  
> >  static struct component *find_component(struct master *master,
> > -	int (*compare)(struct device *, void *), void *compare_data)
> > +	struct component_match_array *mc)
> >  {
> >  	struct component *c;
> >  
> > @@ -166,7 +168,11 @@ static struct component *find_component(struct master *master,
> >  		if (c->master && c->master != master)
> >  			continue;
> >  
> > -		if (compare(c->dev, compare_data))
> > +		if (mc->compare && mc->compare(c->dev, mc->data))
> > +			return c;
> > +
> > +		if (mc->compare_typed &&
> > +		    mc->compare_typed(c->dev, c->subcomponent, mc->data))
> >  			return c;
> >  	}
> >  
> > @@ -192,7 +198,7 @@ static int find_components(struct master *master)
> >  		if (match->compare[i].component)
> >  			continue;
> >  
> > -		c = find_component(master, mc->compare, mc->data);
> > +		c = find_component(master, mc);
> >  		if (!c) {
> >  			ret = -ENXIO;
> >  			break;
> > @@ -327,29 +333,12 @@ static int component_match_realloc(struct device *dev,
> >  	return 0;
> >  }
> >  
> > -/**
> > - * component_match_add_release - add a component match with release callback
> > - * @master: device with the aggregate driver
> > - * @matchptr: pointer to the list of component matches
> > - * @release: release function for @compare_data
> > - * @compare: compare function to match against all components
> > - * @compare_data: opaque pointer passed to the @compare function
> > - *
> > - * Adds a new component match to the list stored in @matchptr, which the @master
> > - * aggregate driver needs to function. The list of component matches pointed to
> > - * by @matchptr must be initialized to NULL before adding the first match.
> > - *
> > - * The allocated match list in @matchptr is automatically released using devm
> > - * actions, where upon @release will be called to free any references held by
> > - * @compare_data, e.g. when @compare_data is a &device_node that must be
> > - * released with of_node_put().
> > - *
> > - * See also component_match_add().
> > - */
> > -void component_match_add_release(struct device *master,
> > +static void __component_match_add(struct device *master,
> >  	struct component_match **matchptr,
> >  	void (*release)(struct device *, void *),
> > -	int (*compare)(struct device *, void *), void *compare_data)
> > +	int (*compare)(struct device *, void *),
> > +	int (*compare_typed)(struct device *, int, void *),
> > +	void *compare_data)
> >  {
> >  	struct component_match *match = *matchptr;
> >  
> > @@ -381,13 +370,69 @@ void component_match_add_release(struct device *master,
> >  	}
> >  
> >  	match->compare[match->num].compare = compare;
> > +	match->compare[match->num].compare_typed = compare_typed;
> >  	match->compare[match->num].release = release;
> >  	match->compare[match->num].data = compare_data;
> >  	match->compare[match->num].component = NULL;
> >  	match->num++;
> >  }
> > +
> > +/**
> > + * component_match_add_release - add a component match with release callback
> > + * @master: device with the aggregate driver
> > + * @matchptr: pointer to the list of component matches
> > + * @release: release function for @compare_data
> > + * @compare: compare function to match against all components
> > + * @compare_data: opaque pointer passed to the @compare function
> > + *
> > + * Adds a new component match to the list stored in @matchptr, which the @master
> > + * aggregate driver needs to function. The list of component matches pointed to
> > + * by @matchptr must be initialized to NULL before adding the first match. This
> > + * only matches against components added with component_add().
> > + *
> > + * The allocated match list in @matchptr is automatically released using devm
> > + * actions, where upon @release will be called to free any references held by
> > + * @compare_data, e.g. when @compare_data is a &device_node that must be
> > + * released with of_node_put().
> > + *
> > + * See also component_match_add() and component_match_add_typed().
> > + */
> > +void component_match_add_release(struct device *master,
> > +	struct component_match **matchptr,
> > +	void (*release)(struct device *, void *),
> > +	int (*compare)(struct device *, void *), void *compare_data)
> > +{
> > +	__component_match_add(master, matchptr, release, compare, NULL,
> > +			      compare_data);
> > +}
> >  EXPORT_SYMBOL(component_match_add_release);
> >  
> > +/**
> > + * component_match_add_typed - add a compent match for a typed component
> > + * @master: device with the aggregate driver
> > + * @matchptr: pointer to the list of component matches
> > + * @compare_typed: compare function to match against all typed components
> > + * @compare_data: opaque pointer passed to the @compare function
> > + *
> > + * Adds a new component match to the list stored in @matchptr, which the @master
> > + * aggregate driver needs to function. The list of component matches pointed to
> > + * by @matchptr must be initialized to NULL before adding the first match. This
> > + * only matches against components added with component_add_typed().
> > + *
> > + * The allocated match list in @matchptr is automatically released using devm
> > + * actions.
> > + *
> > + * See also component_match_add_release() and component_match_add_typed().
> > + */
> > +void component_match_add_typed(struct device *master,
> > +	struct component_match **matchptr,
> > +	int (*compare_typed)(struct device *, int, void *), void *compare_data)
> > +{
> > +	__component_match_add(master, matchptr, NULL, NULL, compare_typed,
> > +			      compare_data);
> 
> You're still passing some compare data in that may need to be released,
> but you are explicitly denying the ability to provide a release
> function pointer here.  What was the reasoning behind that decision?
> If someone wanted to use this with compare_data being a device_node,
> how should that be handled?

Same way we've handled it originally, adding the new variant. I'm not a
huge fan of adding api preemptively, without a user. And the data pointer
we pass around in i915 for mei_hdcp and snd-hda-intel don't hold
references (we don't even use them, we just compare the device against
hardcoded expectations). Since the new compare_typed is entirely
orthogonal to whether you have a release function or not, that should be
simple to do.
-Daniel

> 
> Thanks.
> 
> > +}
> > +EXPORT_SYMBOL(component_match_add_typed);
> > +
> >  static void free_master(struct master *master)
> >  {
> >  	struct component_match *match = master->match;
> > @@ -616,19 +661,8 @@ int component_bind_all(struct device *master_dev, void *data)
> >  }
> >  EXPORT_SYMBOL_GPL(component_bind_all);
> >  
> > -/**
> > - * component_add - register a component
> > - * @dev: component device
> > - * @ops: component callbacks
> > - *
> > - * Register a new component for @dev. Functions in @ops will be called when the
> > - * aggregate driver is ready to bind the overall driver by calling
> > - * component_bind_all(). See also &struct component_ops.
> > - *
> > - * The component needs to be unregistered at driver unload/disconnect by calling
> > - * component_del().
> > - */
> > -int component_add(struct device *dev, const struct component_ops *ops)
> > +static int __component_add(struct device *dev, const struct component_ops *ops,
> > +	int subcomponent)
> >  {
> >  	struct component *component;
> >  	int ret;
> > @@ -639,6 +673,7 @@ int component_add(struct device *dev, const struct component_ops *ops)
> >  
> >  	component->ops = ops;
> >  	component->dev = dev;
> > +	component->subcomponent = subcomponent;
> >  
> >  	dev_dbg(dev, "adding component (ops %ps)\n", ops);
> >  
> > @@ -657,6 +692,55 @@ int component_add(struct device *dev, const struct component_ops *ops)
> >  
> >  	return ret < 0 ? ret : 0;
> >  }
> > +
> > +/**
> > + * component_add_typed - register a component
> > + * @dev: component device
> > + * @ops: component callbacks
> > + * @subcomponent: nonzero identifier for subcomponents
> > + *
> > + * Register a new component for @dev. Functions in @ops will be call when the
> > + * aggregate driver is ready to bind the overall driver by calling
> > + * component_bind_all(). See also &struct component_ops.
> > + *
> > + * @subcomponent must be nonzero and is used to differentiate between multiple
> > + * components registerd on the same device @dev. These components are match
> > + * using component_match_add_typed().
> > + *
> > + * The component needs to be unregistered at driver unload/disconnect by
> > + * calling component_del().
> > + *
> > + * See also component_add().
> > + */
> > +int component_add_typed(struct device *dev, const struct component_ops *ops,
> > +	int subcomponent)
> > +{
> > +	if (WARN_ON(subcomponent == 0))
> > +		return -EINVAL;
> > +
> > +	return __component_add(dev, ops, subcomponent);
> > +}
> > +EXPORT_SYMBOL_GPL(component_add_typed);
> > +
> > +/**
> > + * component_add - register a component
> > + * @dev: component device
> > + * @ops: component callbacks
> > + *
> > + * Register a new component for @dev. Functions in @ops will be called when the
> > + * aggregate driver is ready to bind the overall driver by calling
> > + * component_bind_all(). See also &struct component_ops.
> > + *
> > + * The component needs to be unregistered at driver unload/disconnect by
> > + * calling component_del().
> > + *
> > + * See also component_add_typed() for a variant that allows multipled different
> > + * components on the same device.
> > + */
> > +int component_add(struct device *dev, const struct component_ops *ops)
> > +{
> > +	return __component_add(dev, ops, 0);
> > +}
> >  EXPORT_SYMBOL_GPL(component_add);
> >  
> >  /**
> > diff --git a/include/linux/component.h b/include/linux/component.h
> > index 83da25bdf59c..30bcc7e590eb 100644
> > --- a/include/linux/component.h
> > +++ b/include/linux/component.h
> > @@ -34,6 +34,8 @@ struct component_ops {
> >  };
> >  
> >  int component_add(struct device *, const struct component_ops *);
> > +int component_add_typed(struct device *dev, const struct component_ops *ops,
> > +	int subcomponent);
> >  void component_del(struct device *, const struct component_ops *);
> >  
> >  int component_bind_all(struct device *master, void *master_data);
> > @@ -91,6 +93,9 @@ void component_match_add_release(struct device *master,
> >  	struct component_match **matchptr,
> >  	void (*release)(struct device *, void *),
> >  	int (*compare)(struct device *, void *), void *compare_data);
> > +void component_match_add_typed(struct device *master,
> > +	struct component_match **matchptr,
> > +	int (*compare_typed)(struct device *, int, void *), void *compare_data);
> >  
> >  /**
> >   * component_match_add - add a compent match
> > @@ -101,12 +106,13 @@ void component_match_add_release(struct device *master,
> >   *
> >   * Adds a new component match to the list stored in @matchptr, which the @master
> >   * aggregate driver needs to function. The list of component matches pointed to
> > - * by @matchptr must be initialized to NULL before adding the first match.
> > + * by @matchptr must be initialized to NULL before adding the first match. This
> > + * only matches against components added with component_add().
> >   *
> >   * The allocated match list in @matchptr is automatically released using devm
> >   * actions.
> >   *
> > - * See also component_match_add_release().
> > + * See also component_match_add_release() and component_match_add_typed().
> >   */
> >  static inline void component_match_add(struct device *master,
> >  	struct component_match **matchptr,
> > -- 
> > 2.20.1
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
