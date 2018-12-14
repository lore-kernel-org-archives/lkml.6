Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470AC20645
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RnCilNpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470AC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeLNJdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:33:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34209 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:33:00 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so4426390ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KoCIBm7CBYW1uN3jnXZWO/ouZf8zQtKhVCgewJTPktc=;
        b=RnCilNpBMh296ngDHxeR53eYl6mQllihE2UNOPQ6XAZkFql5IyUCJs3Txc/3x3n/bc
         +AGDMgyFIY2e5+7Tj58A9aRDe7S/uDY6LbTfUvClXSqvyXWocfmbAlWkFZQ7rdWedf7R
         5/shAm4uuwKIdreoZb4lS6PAEmycAnqRKODSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KoCIBm7CBYW1uN3jnXZWO/ouZf8zQtKhVCgewJTPktc=;
        b=dD1QLAlRaj6tTfKk+g7FX+AUr8oa8xhYZh97E6QHHMaxz3fD19AeJeTMfffkOAUCr3
         Bnl4eKzoIhaFXm1P4z8CvgGZU6EcUeKEfppd+haTg6eqaeqR+D68iByttYYaQk/dWI6/
         Q+9SXPBsZ77plhbhp3xduhh3jCcGJZFBQlNq7B2F81k8o6opixR1ZbMDoElovSRQmeyS
         RyI8w8KXlAJJw9K6ZaTiBkBiYBybzanA43gtRff+8otPGmrQ4ZHlceQoRUOqAeIg6bDB
         DOLd+tjUyslfHGKmULGC6xNlafYYrVD4YNhMkgRrbcrisWMw0rDjIO/iCWP94g+tJU0d
         qTJw==
X-Gm-Message-State: AA+aEWZThxCpa48Bz2EHHByaU3G2KB9VCjwwYrJ6cRYbIGdL9AFopRzB
        BlsHsV+EXXOFbV9NR6y7pZqPUQ==
X-Google-Smtp-Source: AFSGD/UFCMXtiPLj26hVHKoXYOz4QiBOf8ozLmkaWzoz1OS+7KBfQ91xE4KLvM660TSp60rMoEDFOA==
X-Received: by 2002:aa7:cdda:: with SMTP id h26mr2440576edw.248.1544779978106;
        Fri, 14 Dec 2018 01:32:58 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s12sm1380329edb.43.2018.12.14.01.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 01:32:57 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:32:55 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 06/15] drm/i915: Keep malloc references to MST ports
Message-ID: <20181214093255.GO21184@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-7-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-7-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:25:35PM -0500, Lyude Paul wrote:
> So that the ports stay around until we've destroyed the connectors, in
> order to ensure that we don't pass an invalid pointer to any MST helpers
> once we introduce the new MST VCPI helpers.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_connector.c | 4 ++++
>  drivers/gpu/drm/i915/intel_dp_mst.c    | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/intel_connector.c b/drivers/gpu/drm/i915/intel_connector.c
> index 18e370f607bc..37d2c644f4b8 100644
> --- a/drivers/gpu/drm/i915/intel_connector.c
> +++ b/drivers/gpu/drm/i915/intel_connector.c
> @@ -95,6 +95,10 @@ void intel_connector_destroy(struct drm_connector *connector)
>  	intel_panel_fini(&intel_connector->panel);
>  
>  	drm_connector_cleanup(connector);
> +
> +	if (intel_connector->port)

We set this as the first thing in intel_dp_add_mst_connector, so this
check isn't doing anything.

> +		drm_dp_mst_put_port_malloc(intel_connector->port);
> +
>  	kfree(connector);
>  }
>  
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index f05427b74e34..4d6ced34d465 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -484,6 +484,8 @@ static struct drm_connector *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
>  	if (ret)
>  		goto err;
>  
> +	drm_dp_mst_get_port_malloc(port);

Needs to be moved up where we assing intel_connector->port, or it'll
underflow on cleanup on error paths.

> +
>  	return connector;
>  
>  err:
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
