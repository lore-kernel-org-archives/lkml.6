Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659AAC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C362146E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="LLZNGu0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfBGUym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:54:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44791 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfBGUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:54:38 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so1495824qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j/SxHDI22MNHVDQcUuFkStZMYUo2xnb3+Y53OiXYl5Y=;
        b=LLZNGu0h5GUMPESaySeqIM08FOWX7sMCKe9MP4V0hpCGmhDbrnDZF3GojjhMUxVh4o
         H2lQpQCbfLqF6u8jwPwGyQgjFws5bJkAjWf9ZjysyHGjbsuEmWpFGTjeTzrzG/6iNQfQ
         HkdqZ3FiVBpvs58NINGMGrqkhGJVXHWWofu9nJNfHPHHtjM0i0To/Nd7EzSCJP9YIPgD
         7pfS1VCKsnpjFwLveNSd5NJmhIcKm+8GVVcgGXuquyLZQpicbZNET7dTTkCSIkgIAXF6
         caHNcGn5ZR6v1jePyGMUbHMoaFoC6avxtpJ1vFv7GgxfV5HUI7yUaCu7sI+qt24hz8VW
         AlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j/SxHDI22MNHVDQcUuFkStZMYUo2xnb3+Y53OiXYl5Y=;
        b=bO1Z6BrcYl1oU+XnSakA+qxnWEyM5i5/5PTLI7gdau5LcgtKsloERgLFGuT/mGQ3hL
         pf5Ew71G4SeVIavgY08lDtLVI05FJs3Tu/7SyAZ6oo6iU0QLvotlagHxzxD9jMkHbFSX
         elP5dNt5k5GPfHOHC+wpvzFI4dKOQsoeqaFnpDrWr4UGZBaC4dQDmAICzeRIT1b5l07B
         CgjY8DNoL2mFR3oKE1fgsOUB5yABFaW7OYxjBmP79osZz3QuQqlxn0+PWbdfebcikfR4
         RkUM3r6r5J3H7KzB5RVojWaKbp63gw1mSaVxWBMs1+YVCSV4CpQcANbHWSC9pZ65lBxn
         zC3w==
X-Gm-Message-State: AHQUAua+IDXwZYGVREEoOZcmbhWSRalKptkt0FbuarZs5lrRTRHJR4Wq
        qhi4MSbRU6eDnywazy5HZq7vXg==
X-Google-Smtp-Source: AHgI3IYR7+RAocTqdXxv/Eoay40bOk0PdJiUF9HY4lPSE2SaO+3AlhaYudtQYU24MTMzmCwTcW+Rrg==
X-Received: by 2002:ac8:26ea:: with SMTP id 39mr13812263qtp.351.1549572877448;
        Thu, 07 Feb 2019 12:54:37 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id g3sm22801qkc.54.2019.02.07.12.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:54:36 -0800 (PST)
Date:   Thu, 7 Feb 2019 15:54:36 -0500
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/dp_mst: Remove rebase-detritus in VCPI helper
 kernel-docs
Message-ID: <20190207205436.GC114153@art_vandelay>
References: <20190206183101.9867-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206183101.9867-1-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:31:01PM -0500, Lyude Paul wrote:
> Looks like when making the final revision of:
> 
> 022debad063e ("drm/atomic: Add drm_atomic_state->duplicated")
> 
> I forgot to remove some of the comments that I had added to
> drm_dp_atomic_find_vcpi_slots() and drm_dp_atomic_release_vcpi_slots()
> that were no longer valid due to us having removed the state->duplicated
> checks from each function. This also introduced an error while building
> the docs with sphinx:
> 
> ./drivers/gpu/drm/drm_dp_mst_topology.c:3100: WARNING: Inline literal
> start-string without end-string.
> 
> So, fix that by just removing the kerneldoc comments.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> Fixes: 022debad063e ("drm/atomic: Add drm_atomic_state->duplicated")
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 5a99135d39cd..dc7ac0c60547 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3097,10 +3097,6 @@ static int drm_dp_init_vcpi(struct drm_dp_mst_topology_mgr *mgr,
>   * @port as needed. It is not OK however, to call this function and
>   * drm_dp_atomic_release_vcpi_slots() in the same atomic check phase.
>   *
> - * When &drm_atomic_state.duplicated is set to %true%, this function will not
> - * perform any error checking and will instead simply return the previously
> - * recorded VCPI allocations.
> - *
>   * See also:
>   * drm_dp_atomic_release_vcpi_slots()
>   * drm_dp_mst_atomic_check()
> @@ -3185,11 +3181,6 @@ EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
>   * drm_dp_atomic_find_vcpi_slots() on the same @port in a single atomic check
>   * phase.
>   *
> - * When &drm_atomic_state.duplicated is set, this function will not
> - * modify the VCPI allocations in &drm_dp_mst_topology_state.vcpis, so that
> - * those VCPI allocations may be restored as-is from the duplicated state. In
> - * this scenario, this function will always return 0.
> - *
>   * See also:
>   * drm_dp_atomic_find_vcpi_slots()
>   * drm_dp_mst_atomic_check()
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
