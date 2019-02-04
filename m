Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD21C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6672E2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aENnijJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfBDQAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:00:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44175 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfBDQAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:00:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so266922edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mflHSiJStNNAU4+Jb4KJeMnsQVxuKzMPdqStOrCT6FI=;
        b=aENnijJVQboPfAIqajwrS/v3HzpRCF8efoIXP2JTKZ3XSqoBaBqOYt+5QqVzSq0KCA
         /2bjQW0qGEqb3O3U9k9Lvopk9SEUQO1cuDu6ApruyY9TlfkDJZTslNyiGnw8WltYm9Ox
         D9iHXYdgVSZApnOncsFz8AoOZQab8+Ajw9CGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mflHSiJStNNAU4+Jb4KJeMnsQVxuKzMPdqStOrCT6FI=;
        b=NKF+6xQRHHIurxfWxS884aW0hIwVP/EEZGfAFwSqhhJ8PrHP3J8NcDZXvFaH6SnVYo
         v7xavergt1ud83BBJMnBk49GH+7hVw55Remn13Eb8AHZGhIfNou/Ev0A8JgFr7w02G2f
         yd+dZDuLwelih0qriGxPiY/t5QYYExxWfRN0BENLI5CFD2K5aY2GCCrY9Kk5RFmi0uAD
         LCglaiJLUo25J6NRMjy3dUxfdr0smtqskUGik1Ha5ocrtHp+volQKOmsCN8OShAr484C
         wZtL6suo0lesx2+r8vJgMGM1OpwEguaY4qCqojMX/BfLs+X/dyx6oUlNNoiCR+nvqbT4
         8NDw==
X-Gm-Message-State: AHQUAubh74PFMu1dNGWTO61c/1G/XWm0zHnHqjl+4NVA3789RZku8LIw
        mMzym2kP5ao9r7MLgiKLy7osHA==
X-Google-Smtp-Source: AHgI3IZtPXFcWnjya4AfV3lUUyQR52KbxlH2qiD9tx5FNp7oCMYtEK7jRIzAAJUs2R1wKO2ISLqQ5g==
X-Received: by 2002:a50:9770:: with SMTP id d45mr43114edb.49.1549296029018;
        Mon, 04 Feb 2019 08:00:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e14sm4434840edb.79.2019.02.04.08.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 08:00:28 -0800 (PST)
Date:   Mon, 4 Feb 2019 17:00:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] components: multiple components for a device
Message-ID: <20190204160025.GV3271@phenom.ffwll.local>
Mail-Followup-To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <1548917996-28081-2-git-send-email-ramalingam.c@intel.com>
 <20190131144640.17896-1-daniel.vetter@ffwll.ch>
 <20190131144640.17896-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131144640.17896-2-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 03:46:40PM +0100, Daniel Vetter wrote:
> Component framework is extended to support multiple components for
> a struct device. These will be matched with different masters based on
> its sub component value.
> 
> We are introducing this, as I915 needs two different components
> with different subcomponent value, which will be matched to two
> different component masters(Audio and HDCP) based on the subcomponent
> values.
> 
> v2: Add documenation.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1 code)
> Signed-off-by: Ramalingam C <ramalingam.c@intel.com> (v1 commit message)
> Cc: Ramalingam C <ramalingam.c@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Hi Greg&Russell,

Now that there's nice documentation on everything, any comments on these
two patches?

Thanks, Daniel

> ---
>  drivers/base/component.c  | 159 +++++++++++++++++++++++++++++---------
>  include/linux/component.h |  10 ++-
>  2 files changed, 130 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index e5b04bce8544..eb7915fc5278 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -48,6 +48,7 @@ struct component;
>  struct component_match_array {
>  	void *data;
>  	int (*compare)(struct device *, void *);
> +	int (*compare_typed)(struct device *, int, void *);
>  	void (*release)(struct device *, void *);
>  	struct component *component;
>  	bool duplicate;
> @@ -75,6 +76,7 @@ struct component {
>  	bool bound;
>  
>  	const struct component_ops *ops;
> +	int subcomponent;
>  	struct device *dev;
>  };
>  
> @@ -159,7 +161,7 @@ static struct master *__master_find(struct device *dev,
>  }
>  
>  static struct component *find_component(struct master *master,
> -	int (*compare)(struct device *, void *), void *compare_data)
> +	struct component_match_array *mc)
>  {
>  	struct component *c;
>  
> @@ -167,8 +169,13 @@ static struct component *find_component(struct master *master,
>  		if (c->master && c->master != master)
>  			continue;
>  
> -		if (compare(c->dev, compare_data))
> +		if (mc->compare_typed) {
> +			if (mc->compare_typed(c->dev, c->subcomponent,
> +					      mc->data))
> +				return c;
> +		} else if (mc->compare(c->dev, mc->data)) {
>  			return c;
> +		}
>  	}
>  
>  	return NULL;
> @@ -193,7 +200,7 @@ static int find_components(struct master *master)
>  		if (match->compare[i].component)
>  			continue;
>  
> -		c = find_component(master, mc->compare, mc->data);
> +		c = find_component(master, mc);
>  		if (!c) {
>  			ret = -ENXIO;
>  			break;
> @@ -328,29 +335,12 @@ static int component_match_realloc(struct device *dev,
>  	return 0;
>  }
>  
> -/**
> - * component_match_add_release - add a compent match with release callback
> - * @master: device with the aggregate driver
> - * @matchptr: pointer to the list of component matches
> - * @release: release function for @compare_data
> - * @compare: compare function to match against all components
> - * @compare_data: opaque pointer passed to the @compare function
> - *
> - * This adds a new component match to the list stored in @matchptr, which the
> - * @master aggregate driver needs to function. @matchptr must be initialized to
> - * NULL before adding the first match.
> - *
> - * The allocated match list in @matchptr is automatically released using devm
> - * actions. At that point @release will be called, to free any references held
> - * by @compare_data, e.g. when @compare_data is a &device_node that must be
> - * released with of_node_put().
> - *
> - * See also component_match_add().
> - */
> -void component_match_add_release(struct device *master,
> +static void __component_match_add(struct device *master,
>  	struct component_match **matchptr,
>  	void (*release)(struct device *, void *),
> -	int (*compare)(struct device *, void *), void *compare_data)
> +	int (*compare)(struct device *, void *),
> +	int (*compare_typed)(struct device *, int, void *),
> +	void *compare_data)
>  {
>  	struct component_match *match = *matchptr;
>  
> @@ -382,13 +372,69 @@ void component_match_add_release(struct device *master,
>  	}
>  
>  	match->compare[match->num].compare = compare;
> +	match->compare[match->num].compare_typed = compare_typed;
>  	match->compare[match->num].release = release;
>  	match->compare[match->num].data = compare_data;
>  	match->compare[match->num].component = NULL;
>  	match->num++;
>  }
> +
> +/**
> + * component_match_add_release - add a compent match with release callback
> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @release: release function for @compare_data
> + * @compare: compare function to match against all components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * This adds a new component match to the list stored in @matchptr, which the
> + * @master aggregate driver needs to function. @matchptr must be initialized to
> + * NULL before adding the first match.
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions. At that point @release will be called, to free any references held
> + * by @compare_data, e.g. when @compare_data is a &device_node that must be
> + * released with of_node_put(). This only matches against components
> + * added with component_add().
> + *
> + * See also component_match_add() and component_match_add_typed().
> + */
> +void component_match_add_release(struct device *master,
> +	struct component_match **matchptr,
> +	void (*release)(struct device *, void *),
> +	int (*compare)(struct device *, void *), void *compare_data)
> +{
> +	__component_match_add(master, matchptr, release, compare, NULL,
> +			      compare_data);
> +}
>  EXPORT_SYMBOL(component_match_add_release);
>  
> +/**
> + * component_match_add_typed - add a compent match for a typed component
> + * @master: device with the aggregate driver
> + * @matchptr: pointer to the list of component matches
> + * @compare_typed: compare function to match against all typed components
> + * @compare_data: opaque pointer passed to the @compare function
> + *
> + * This adds a new component match to the list stored in @matchptr, which the
> + * @master aggregate driver needs to function. @matchptr must be initialized to
> + * NULL before adding the first match. This only matches against components
> + * added with component_add_typed().
> + *
> + * The allocated match list in @matchptr is automatically released using devm
> + * actions.
> + *
> + * See also component_match_add_release() and component_match_add_typed().
> + */
> +void component_match_add_typed(struct device *master,
> +	struct component_match **matchptr,
> +	int (*compare_typed)(struct device *, int, void *), void *compare_data)
> +{
> +	__component_match_add(master, matchptr, NULL, NULL, compare_typed,
> +			      compare_data);
> +}
> +EXPORT_SYMBOL(component_match_add_typed);
> +
>  static void free_master(struct master *master)
>  {
>  	struct component_match *match = master->match;
> @@ -617,19 +663,8 @@ int component_bind_all(struct device *master_dev, void *data)
>  }
>  EXPORT_SYMBOL_GPL(component_bind_all);
>  
> -/**
> - * component_add - register a component
> - * @dev: component device
> - * @ops: component callbacks
> - *
> - * Register a new component for @dev. Functions in @ops will be call when the
> - * aggregate driver is ready to bind the overall driver by calling
> - * component_bind_all(). See also &struct component_ops.
> - *
> - * The component needs to be unregistered again at driver unload/disconnect by
> - * calling component_del().
> - */
> -int component_add(struct device *dev, const struct component_ops *ops)
> +static int __component_add(struct device *dev, const struct component_ops *ops,
> +	int subcomponent)
>  {
>  	struct component *component;
>  	int ret;
> @@ -640,6 +675,7 @@ int component_add(struct device *dev, const struct component_ops *ops)
>  
>  	component->ops = ops;
>  	component->dev = dev;
> +	component->subcomponent = subcomponent;
>  
>  	dev_dbg(dev, "adding component (ops %ps)\n", ops);
>  
> @@ -658,6 +694,55 @@ int component_add(struct device *dev, const struct component_ops *ops)
>  
>  	return ret < 0 ? ret : 0;
>  }
> +
> +/**
> + * component_add_typed - register a component
> + * @dev: component device
> + * @ops: component callbacks
> + * @subcomponent: nonzero identifier for subcomponents
> + *
> + * Register a new component for @dev. Functions in @ops will be call when the
> + * aggregate driver is ready to bind the overall driver by calling
> + * component_bind_all(). See also &struct component_ops.
> + *
> + * @subcomponent must be nonzero and is used to differentiate between multiple
> + * components registerd on the same device @dev. These components are match
> + * using component_match_add_typed().
> + *
> + * The component needs to be unregistered again at driver unload/disconnect by
> + * calling component_del().
> + *
> + * See also component_add().
> + */
> +int component_add_typed(struct device *dev, const struct component_ops *ops,
> +	int subcomponent)
> +{
> +	if (WARN_ON(subcomponent == 0))
> +		return -EINVAL;
> +
> +	return __component_add(dev, ops, subcomponent);
> +}
> +EXPORT_SYMBOL_GPL(component_add_typed);
> +
> +/**
> + * component_add - register a component
> + * @dev: component device
> + * @ops: component callbacks
> + *
> + * Register a new component for @dev. Functions in @ops will be call when the
> + * aggregate driver is ready to bind the overall driver by calling
> + * component_bind_all(). See also &struct component_ops.
> + *
> + * The component needs to be unregistered again at driver unload/disconnect by
> + * calling component_del().
> + *
> + * See also component_add_typed() for a variant that allows multipled different
> + * components on the same device.
> + */
> +int component_add(struct device *dev, const struct component_ops *ops)
> +{
> +	return __component_add(dev, ops, 0);
> +}
>  EXPORT_SYMBOL_GPL(component_add);
>  
>  /**
> diff --git a/include/linux/component.h b/include/linux/component.h
> index 67a899dd2e10..9e69e2117f0b 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -34,6 +34,8 @@ struct component_ops {
>  };
>  
>  int component_add(struct device *, const struct component_ops *);
> +int component_add_typed(struct device *dev, const struct component_ops *ops,
> +	int subcomponent);
>  void component_del(struct device *, const struct component_ops *);
>  
>  int component_bind_all(struct device *master, void *master_data);
> @@ -91,6 +93,9 @@ void component_match_add_release(struct device *master,
>  	struct component_match **matchptr,
>  	void (*release)(struct device *, void *),
>  	int (*compare)(struct device *, void *), void *compare_data);
> +void component_match_add_typed(struct device *master,
> +	struct component_match **matchptr,
> +	int (*compare_typed)(struct device *, int, void *), void *compare_data);
>  
>  /**
>   * component_match_add - add a compent match
> @@ -101,12 +106,13 @@ void component_match_add_release(struct device *master,
>   *
>   * This adds a new component match to the list stored in @matchptr, which the
>   * @master aggregate driver needs to function. @matchptr must be initialized to
> - * NULL before adding the first match.
> + * NULL before adding the first match. This only matches against components
> + * added with component_add().
>   *
>   * The allocated match list in @matchptr is automatically released using devm
>   * actions.
>   *
> - * See also component_match_add_release().
> + * See also component_match_add_release() and component_match_add_typed().
>   */
>  static inline void component_match_add(struct device *master,
>  	struct component_match **matchptr,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
