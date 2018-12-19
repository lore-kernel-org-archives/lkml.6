Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58864C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DC021841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cbNho6X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLSNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:42:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42124 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeLSNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:42:50 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so10850063edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sY8IcarFO4T0ZR6q85ugn+E/ODHNndUb+Ua/y8rDTdg=;
        b=cbNho6X003UsCEFZhpwJj2RsKs6TZQTJF+S8JEE8WZ8sLUzGjzIUHMtlHg6bf6HceL
         8TOh3CGA5yvvgPDZK78JhYgQR0JoEbIUwGQwuK09A+WEFafwqYOAW3p6sT7vMa4s6kA0
         5fIVFXxK2coHoWSTSmm+2LcUptRzs6vrhJ7xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sY8IcarFO4T0ZR6q85ugn+E/ODHNndUb+Ua/y8rDTdg=;
        b=hzPjhODyQHP/gesglTNMB9lE0THTp6vScTsPAW5GQCrLbq7w2rCh/6nNuygW4R5X4I
         mLFKJAMq7ojYIpY1zTHdahOuPMc9v2bL6mOvGeqmPS5ucOLCBfVPPqZc5pN5KbrMZtJK
         eg4Pw1zcdoeK/kLFDjfqATf52N4kdmBwkmJL68NJkDmiFqyr5rjYsMEwIqd9TNz6K8oy
         scunHm9BSl97PCpp9QaVoiQwxLEagi23lYa2I5x3yphexsBA05RBP5FFxAgOxwYtCRhl
         lsxS6SDDtZmRcOORWiPcrXjbG3Q6/fJ/T8+iCVsFNsRxACwzzl1p1ZNs+8nBSJVrFFUe
         IhgQ==
X-Gm-Message-State: AA+aEWap0nefifs8WtWmSE13FeUUUTUuod3NXvILUQHdw3xE7eE+id0W
        p+wrVRrRkDAEzZhVFCiwSN/lOQ==
X-Google-Smtp-Source: AFSGD/Xf0BLiZh2U5P95tvSsM8Uh1wM9YFFruBqLimKPqGyB8QQEmyMVJnAd+DrRPtECu1VE9G5Swg==
X-Received: by 2002:a50:b559:: with SMTP id z25mr6742009edd.239.1545226968040;
        Wed, 19 Dec 2018 05:42:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t10-v6sm2736050ejg.41.2018.12.19.05.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 05:42:47 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:42:45 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ramalingam C <ramalingam.c@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        seanpaul@chromium.org, daniel.vetter@ffwll.ch,
        tomas.winkler@intel.com, uma.shankar@intel.com,
        ville.syrjala@linux.intel.com, chris@chris-wilson.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 04/39] component: alloc component_match without any
 comp to match
Message-ID: <20181219134245.GB21184@phenom.ffwll.local>
Mail-Followup-To: Ramalingam C <ramalingam.c@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        seanpaul@chromium.org, tomas.winkler@intel.com,
        uma.shankar@intel.com, ville.syrjala@linux.intel.com,
        chris@chris-wilson.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
References: <1544673701-6353-1-git-send-email-ramalingam.c@intel.com>
 <1544673701-6353-5-git-send-email-ramalingam.c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544673701-6353-5-git-send-email-ramalingam.c@intel.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 09:31:06AM +0530, Ramalingam C wrote:
> If all the components associated to a component master is not added
> to the component framework due to the HW capability or Kconfig
> selection, component_match will be NULL at
> component_master_add_with_match().
> 
> To avoid this, component_match_alloc() is added to the framework,
> to allcoate the struct component_match with zero associated components.
> Hence component master can be added with a component_match with zero
> associated components.
> 
> This helps the component master bind call to get triggered,
> even if no component is registered for that particular master.
> 
> This is meant for big PCI device drivers where small/optional
> features are external components, and based on usecases different
> combination of components are build as entire driver.
> 
> In such PCI device driver Load, if we use the component master for
> waiting for few  components(features) availability, only if they are
> supported by the underlying HW, then we need to allocate memory for
> component_match using the API introduced in this change before
> the call to component_master_add_with_match.
> 
> v2:
>   No Change.
> 
> Signed-off-by: Ramalingam C <ramalingam.c@intel.com>
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Greg, I expect the i915 feature that needs this will only land in 4.22.
I'm also not aware of anyone else using this (all the other component
users always use components). How do you want to get this landed?

I think either getting this into 4.21, or an ack for merging through drm
trees would work well for us.
-Daniel

> ---
>  drivers/base/component.c  | 30 ++++++++++++++++++++++++++++++
>  include/linux/component.h |  2 ++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/base/component.c b/drivers/base/component.c
> index e8d676fad0c9..0ab36b2255ea 100644
> --- a/drivers/base/component.c
> +++ b/drivers/base/component.c
> @@ -312,6 +312,36 @@ static int component_match_realloc(struct device *dev,
>  }
>  
>  /*
> + * Allocate the match without any component_match_array elements.
> + *
> + * This function is useful when the component master might end up
> + * registering itself without any matching components.
> + */
> +void component_match_alloc(struct device *master,
> +	struct component_match **matchptr)
> +{
> +	struct component_match *match = *matchptr;
> +
> +	if (IS_ERR(match))
> +		return;
> +
> +	if (match)
> +		return;
> +
> +	match = devres_alloc(devm_component_match_release,
> +			     sizeof(*match), GFP_KERNEL);
> +	if (!match) {
> +		*matchptr = ERR_PTR(-ENOMEM);
> +		return;
> +	}
> +
> +	devres_add(master, match);
> +
> +	*matchptr = match;
> +}
> +EXPORT_SYMBOL(component_match_alloc);
> +
> +/*
>   * Add a component to be matched, with a release function.
>   *
>   * The match array is first created or extended if necessary.
> diff --git a/include/linux/component.h b/include/linux/component.h
> index e71fbbbc74e2..3f6b420a58f8 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -37,6 +37,8 @@ void component_match_add_release(struct device *master,
>  	struct component_match **matchptr,
>  	void (*release)(struct device *, void *),
>  	int (*compare)(struct device *, void *), void *compare_data);
> +void component_match_alloc(struct device *master,
> +	struct component_match **matchptr);
>  
>  static inline void component_match_add(struct device *master,
>  	struct component_match **matchptr,
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
