Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FF82184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R/JiUN3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfBEQUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:20:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42047 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfBEQUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:20:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id r15so1884160eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6yba8XBsXAcw7U89xtoaE5mDD1Ox/rn14fVGy5S4Kw=;
        b=R/JiUN3QEdFZSoEfnsBWejQAr2B6hMlPL5nRMNWMHLfMryiVGjuL/vs1C52MG+VFWv
         CzmiMuK56ByidlkDuvEtq3oQm9YrsEbn8D5+mDU9vQjU8QwxdgOVUUw4yIcjOMuLdx/d
         IKNSl1Q9WhcjL+burzgDuNMwGJrId+tHNd3IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=l6yba8XBsXAcw7U89xtoaE5mDD1Ox/rn14fVGy5S4Kw=;
        b=k6NPkkslDGRfY/nyS1cMqLUaPz+GMD9niMzYBwjY+BmJOpm5szLfEyFUGCUxang4zh
         t7O6aFRebupbHmaACLiU5rkOBOopBYKKIQNJd1WEF0FodYP3LrvUSc/+DNtBpNvh9KDc
         kXgeOd+qPQFZMiHBZs3ESjm1soICEHOLWUo/rRrdHiU0wfpPMfoR7Ae4/q5gIYhmI4iM
         euPCfHBrMt1LHIgfHctdKg9xD34cakV5fQOEvyckiMPOY5es/y/NBtSC2D6dy6VlHkkF
         Tm9NeSYfupF2z+FsVHAj0Go+gjRuVITgRq2WMld9as9z+HADOVdH1FzjTL0oRCWe/oJL
         sFfw==
X-Gm-Message-State: AHQUAubKsmmXJckW1haNSF/LCe5LApvZyBaClnvSTpxnfE8w64AjzUWz
        vkypfQ0E185KAKrIILlmsaq4YC43c0n6rQ==
X-Google-Smtp-Source: AHgI3IZM+oJ5tQfTaL2BHBnXGgZAmGXrvgnc0yioMb3nLklxvR/7XIitODg+hX9yexnMz+W4vnZjwg==
X-Received: by 2002:a50:cdd0:: with SMTP id h16mr4660293edj.151.1549383605381;
        Tue, 05 Feb 2019 08:20:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id v11sm5015185edy.49.2019.02.05.08.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 08:20:04 -0800 (PST)
Date:   Tue, 5 Feb 2019 17:20:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/2] component: Add documentation
Message-ID: <20190205162001.GE3271@phenom.ffwll.local>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <1548917996-28081-2-git-send-email-ramalingam.c@intel.com>
 <20190131144640.17896-1-daniel.vetter@ffwll.ch>
 <CAJZ5v0hhYnRs+J6w+EAsd=0+MJ9irBThLiUC+ptgvyKyeo5f7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hhYnRs+J6w+EAsd=0+MJ9irBThLiUC+ptgvyKyeo5f7A@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:47:58AM +0100, Rafael J. Wysocki wrote:
>  w/compOn Thu, Jan 31, 2019 at 3:46 PM Daniel Vetter
> <daniel.vetter@ffwll.ch> wrote:
> >
> > Someone owes me a beer ...
> >
> > While typing these I think doing an s/component_master/aggregate/
> > would be useful:
> > - it's shorter :-)
> > - I think component/aggregate is much more meaningful naming than
> >   component/puppetmaster or something like that. At least to my
> >   English ear "aggregate" emphasizes much more the "assemble a pile of
> >   things into something bigger" aspect, and there's not really much
> >   of a control hierarchy between aggregate and constituing components.
> >
> > But that's way more than a quick doc typing exercise ...
> >
> > Thanks to Ram for commenting on an initial draft of these docs.
> 
> Look goods to me overall (even though I'm not super-familiar with the
> component framework), but see below.
> 
> > Cc: "C, Ramalingam" <ramalingam.c@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  Documentation/driver-api/device_link.rst |   3 +
> >  Documentation/driver-api/index.rst       |   1 +
> >  drivers/base/component.c                 | 107 ++++++++++++++++++++++-
> >  include/linux/component.h                |  70 +++++++++++++++
> >  4 files changed, 178 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> > index d6763272e747..2d5919b2b337 100644
> > --- a/Documentation/driver-api/device_link.rst
> > +++ b/Documentation/driver-api/device_link.rst
> > @@ -1,6 +1,9 @@
> >  .. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
> >  .. |struct generic_pm_domain| replace:: :c:type:`struct generic_pm_domain <generic_pm_domain>`
> >
> > +
> > +.. _device_link:
> > +
> >  ============
> >  Device links
> >  ============
> > diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> > index ab38ced66a44..c0b600ed9961 100644
> > --- a/Documentation/driver-api/index.rst
> > +++ b/Documentation/driver-api/index.rst
> > @@ -22,6 +22,7 @@ available subsections can be seen below.
> >     device_connection
> >     dma-buf
> >     device_link
> > +   component
> 
> Do I think correctly that this doc is going to be generated
> automatically from the kerneldoc comments in component.c?

No. I failed to git add component.rst, which has the necessary kernel-doc
directives to generate the documentation from the source code comments.

I've implemented all your other suggestions, thanks a lot for taking a
lot. Will send out v2 asap.

Thanks, Daniel

> 
> >     message-based
> >     sound
> >     frame-buffer
> > diff --git a/drivers/base/component.c b/drivers/base/component.c
> > index ddcea8739c12..e5b04bce8544 100644
> > --- a/drivers/base/component.c
> > +++ b/drivers/base/component.c
> > @@ -16,6 +16,33 @@
> >  #include <linux/slab.h>
> >  #include <linux/debugfs.h>
> >
> > +/**
> > + * DOC: overview
> > + *
> > + * The component frameworks allows drivers to collect a pile of sub-devices,
> 
> s/frameworks/framework/
> 
> > + * including their bound drivers, into an aggregate driver. Various subsystem
> 
> s/subsystem/subsystems/
> 
> > + * already provide functions to get hold of such components, e.g.
> > + * of_clk_get_by_name(). Anytime there's such a subsystem specific way to find a
> > + * a device the component framework should not be used.
> 
> I would use a positive statement here, like "The component framework
> can be used when such a subsystem-specific way to find a device is not
> available".
> 
> > The component framework
> > + * fills the niche of aggregate drivers for specific hardware, where further
> > + * standardization into a subsystem doesn't make sense.
> 
> I would say "would not be practical" instead of "doesn't make sense".
> 
> > The common example is
> > + * when a logical device (e.g. a DRM display driver) is spread around the SoC on
> > + * various component (scanout engines, blending blocks, transcoders for various
> > + * outputs and so on).
> > + *
> > + * The component framework also doesn't solve runtime dependencies, e.g. for
> > + * system suspend and resume operations. See also :ref:`device
> > + * links<device_link>`.
> > + *
> > + * Components are registered using component_add() and unregistered with
> > + * component_del(), usually from the driver's probe and disconnect functions.
> > + *
> > + * Aggregate drivers first assemble a component match list of what they need
> > + * using component_match_add(). This is then registered as an aggregate driver
> > + * using component_master_add_with_match(), and unregistered using
> > + * component_master_del().
> > + */
> > +
> >  struct component;
> >
> >  struct component_match_array {
> > @@ -301,10 +328,24 @@ static int component_match_realloc(struct device *dev,
> >         return 0;
> >  }
> >
> > -/*
> > - * Add a component to be matched, with a release function.
> > +/**
> > + * component_match_add_release - add a compent match with release callback
> 
> s/compent/component/ ?
> 
> > + * @master: device with the aggregate driver
> > + * @matchptr: pointer to the list of component matches
> > + * @release: release function for @compare_data
> > + * @compare: compare function to match against all components
> > + * @compare_data: opaque pointer passed to the @compare function
> > + *
> > + * This adds a new component match to the list stored in @matchptr, which the
> > + * @master aggregate driver needs to function. @matchptr must be initialized to
> > + * NULL before adding the first match.
> > + *
> > + * The allocated match list in @matchptr is automatically released using devm
> > + * actions. At that point @release will be called, to free any references held
> > + * by @compare_data, e.g. when @compare_data is a &device_node that must be
> > + * released with of_node_put().
> >   *
> > - * The match array is first created or extended if necessary.
> > + * See also component_match_add().
> >   */
> >  void component_match_add_release(struct device *master,
> >         struct component_match **matchptr,
> > @@ -367,6 +408,18 @@ static void free_master(struct master *master)
> >         kfree(master);
> >  }
> >
> > +/**
> > + * component_master_add_with_match - register an aggregate driver
> > + * @dev: device with the aggregate driver
> > + * @ops: callbacks for the aggregate driver
> > + * @match: component match list for the aggregate driver
> > + *
> > + * Registers a new aggregate driver consisting of the components added to @match
> > + * by calling one of the component_match_add() functions. Once all components in
> > + * @match are available it will be assembled by calling
> 
> A comma seems to be missing after "available".
> 
> > + * &component_master_ops.bind from @ops. Must be unregistered by calling
> > + * component_master_del().
> > + */
> >  int component_master_add_with_match(struct device *dev,
> >         const struct component_master_ops *ops,
> >         struct component_match *match)
> > @@ -403,6 +456,15 @@ int component_master_add_with_match(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(component_master_add_with_match);
> >
> > +/**
> > + * component_master_del - unregister an aggregate driver
> > + * @dev: device with the aggregate driver
> > + * @ops: callbacks for the aggregate driver
> > + *
> > + * Unregistered an aggregate driver registered with
> 
> s/Unregistered/Unregisters/ ?
> 
> > + * component_master_add_with_match(). If necessary the aggregate driver is first
> > + * disassembled by calling &component_master_ops.unbind from @ops.
> 
> Q: How does the &component_master_ops.unbind annotation work?  Does it
> produce any special output?
> 
> > + */
> >  void component_master_del(struct device *dev,
> >         const struct component_master_ops *ops)
> >  {
> > @@ -430,6 +492,15 @@ static void component_unbind(struct component *component,
> >         devres_release_group(component->dev, component);
> >  }
> >
> > +/**
> > + * component_unbind_all - unbind all component to an aggregate driver
> > + * @master_dev: device with the aggregate driver
> > + * @data: opaque pointer, passed to all components
> > + *
> > + * This unbinds all components to the aggregate @dev by passing @data to their
> 
> I guess "This" is redundant.
> 
> > + * &component_ops.unbind functions. Should be called from
> > + * &component_master_ops.unbind.
> > + */
> >  void component_unbind_all(struct device *master_dev, void *data)
> >  {
> >         struct master *master;
> > @@ -503,6 +574,15 @@ static int component_bind(struct component *component, struct master *master,
> >         return ret;
> >  }
> >
> > +/**
> > + * component_bind_all - bind all component to an aggregate driver
> > + * @master_dev: device with the aggregate driver
> > + * @data: opaque pointer, passed to all components
> > + *
> > + * This binds all components to the aggregate @dev by passing @data to their
> 
> Likewise.
> 
> > + * &component_ops.bind functions. Should be called from
> > + * &component_master_ops.bind.
> > + */
> >  int component_bind_all(struct device *master_dev, void *data)
> >  {
> >         struct master *master;
> > @@ -537,6 +617,18 @@ int component_bind_all(struct device *master_dev, void *data)
> >  }
> >  EXPORT_SYMBOL_GPL(component_bind_all);
> >
> > +/**
> > + * component_add - register a component
> > + * @dev: component device
> > + * @ops: component callbacks
> > + *
> > + * Register a new component for @dev. Functions in @ops will be call when the
> 
> s/call/called/
> 
> > + * aggregate driver is ready to bind the overall driver by calling
> > + * component_bind_all(). See also &struct component_ops.
> > + *
> > + * The component needs to be unregistered again at driver unload/disconnect by
> > + * calling component_del().
> > + */
> >  int component_add(struct device *dev, const struct component_ops *ops)
> >  {
> >         struct component *component;
> > @@ -568,6 +660,15 @@ int component_add(struct device *dev, const struct component_ops *ops)
> >  }
> >  EXPORT_SYMBOL_GPL(component_add);
> >
> > +/**
> > + * component_del - unregister a component
> > + * @dev: component device
> > + * @ops: component callbacks
> > + *
> > + * Unregister a component added with component_add(). If the component is bound
> > + * into an aggregate driver this will force the entire aggrate driver, including
> 
> A comma is missing after "driver".  Also s/aggrate/aggregate/
> 
> > + * all its components, to be unbound.
> > + */
> >  void component_del(struct device *dev, const struct component_ops *ops)
> >  {
> >         struct component *c, *component = NULL;
> > diff --git a/include/linux/component.h b/include/linux/component.h
> > index e71fbbbc74e2..67a899dd2e10 100644
> > --- a/include/linux/component.h
> > +++ b/include/linux/component.h
> > @@ -4,11 +4,31 @@
> >
> >  #include <linux/stddef.h>
> >
> > +
> >  struct device;
> >
> > +/**
> > + * struct component_ops - callbacks for component drivers
> > + *
> > + * Components are registered with component_add() and unregistered with
> > + * component_del().
> > + */
> >  struct component_ops {
> > +       /**
> > +        * @bind:
> > +        *
> > +        * Called through component_bind_all() when the aggregate driver is
> > +        * ready to bind the overall driver.
> > +        */
> >         int (*bind)(struct device *comp, struct device *master,
> >                     void *master_data);
> > +       /**
> > +        * @unbind:
> > +        *
> > +        * Called through component_unbind_all() when the aggregate driver is
> > +        * ready to bind the overall driver, or when component_bind_all() fails
> > +        * part-ways through and needs to unbind some already bound components.
> > +        */
> >         void (*unbind)(struct device *comp, struct device *master,
> >                        void *master_data);
> >  };
> > @@ -21,8 +41,42 @@ void component_unbind_all(struct device *master, void *master_data);
> >
> >  struct master;
> >
> > +/**
> > + * struct component_master_ops - callback for the aggregate driver
> > + *
> > + * Aggregate drivers are registered with component_master_add_with_match() and
> > + * unregistered with component_master_del().
> > + */
> >  struct component_master_ops {
> > +       /**
> > +        * @bind:
> > +        *
> > +        * Called when all components or the aggregate driver, as specified in
> > +        * the match list passed to component_master_add_with_match(), are
> > +        * ready. Usually there are 3 steps to bind an aggregate driver:
> > +        *
> > +        * 1. Allocate a structure for the aggregate driver.
> > +        *
> > +        * 2. Bind all components to the aggregate driver by calling
> > +        *    component_bind_all() with the aggregate driver structure as opaque
> > +        *    pointer data.
> > +        *
> > +        * 3. Register the aggregate driver with the subsystem to publish its
> > +        *    interfaces.
> > +        *
> > +        * Note that the lifetime of the aggregate driver does not align with
> > +        * any of the underlying &struct device instances. Therefore devm cannot
> > +        * be used and all resources acquired or allocated in this callback must
> > +        * be expecitly released in the @unbind callback.
> 
> s/expecitly/explicitly/
> 
> > +        */
> >         int (*bind)(struct device *master);
> > +       /**
> > +        * @unbind:
> > +        *
> > +        * Called when either the aggregate driver, using
> > +        * component_master_del(), or one of its components, using
> > +        * component_del(), is unregistered.
> > +        */
> >         void (*unbind)(struct device *master);
> >  };
> >
> > @@ -38,6 +92,22 @@ void component_match_add_release(struct device *master,
> >         void (*release)(struct device *, void *),
> >         int (*compare)(struct device *, void *), void *compare_data);
> >
> > +/**
> > + * component_match_add - add a compent match
> > + * @master: device with the aggregate driver
> > + * @matchptr: pointer to the list of component matches
> > + * @compare: compare function to match against all components
> > + * @compare_data: opaque pointer passed to the @compare function
> > + *
> > + * This adds a new component match to the list stored in @matchptr, which the
> 
> "This" appears to be redundant.
> 
> > + * @master aggregate driver needs to function. @matchptr must be initialized to
> > + * NULL before adding the first match.
> > + *
> > + * The allocated match list in @matchptr is automatically released using devm
> > + * actions.
> > + *
> > + * See also component_match_add_release().
> > + */
> >  static inline void component_match_add(struct device *master,
> >         struct component_match **matchptr,
> >         int (*compare)(struct device *, void *), void *compare_data)
> > --
> > 2.20.1
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
