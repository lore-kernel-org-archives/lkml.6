Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF60C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C27C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PyoqxawH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C27C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeJEOYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:24:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45225 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeJEOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:24:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id v18-v6so9708171edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIMDmP0Lt+tsl8HV8fvPT4gsIWb6rH5O1sMK5wMxZrs=;
        b=PyoqxawHu4f6vaDG8TF3O6bq4gqZYMVgTBDXabvNC5gr4jWt6iY7XlHE2anMAWIl2b
         5LV+1Hf/lx2dUWBuaT1Q/l/SXKCQyj/ha4V7x7bwn09giHRhqrtC4Ch6HOxO7DxFBG/Z
         8gCZpYf3Umqxo75734vmIRH3mFf/U2fpBvqT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IIMDmP0Lt+tsl8HV8fvPT4gsIWb6rH5O1sMK5wMxZrs=;
        b=I1LMZbw8n0Ag9trqWGsQw2paqT6PtRnhrhyjpBHfVN5CtX94cONbQbj91nmy58rYa/
         kfZ4mbjnXq1R4sEVNEEvWA7KwRtlyErbIAqfiQaaSZqWiV2h+uEmJVLfN9me/tI0VKCv
         o8p9GPO2klobcirF61XQL1ihdoNHOikqzFZB4CN9KlkM+eoWfUPvlvATiByunx3CHHgz
         SEs2iC+xtY9I1xLP/GsVHiNJECSx3/4ZhAEnmS4JQPbaFAcRu+WW429PMRCLWt99pIBh
         69Hrczd2MpED7s0Lcve8K/BPKvt5omv5yGrUx4rYg7OyLw3kIO6T466v3PwIV7L23/3A
         3LNQ==
X-Gm-Message-State: ABuFfogTqQxZG9dRxUVXAz2CkfW4RMe2kdXBu8uDarlsZ0NHafsqtR1Y
        psyxYVVjs0q7gmNEUEULvRycjA==
X-Google-Smtp-Source: ACcGV61ft12Vw3t9Mcm4dVTihbkIojlcw3Ze4ca80LjC6qpRNIr2/4UJRymPwX2ZvtKCwoC1zBIS0w==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr12677576edm.276.1538724409638;
        Fri, 05 Oct 2018 00:26:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h34-v6sm2232339eda.58.2018.10.05.00.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 00:26:47 -0700 (PDT)
Date:   Fri, 5 Oct 2018 09:26:45 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] drm/i915: Skip vcpi allocation for MSTB ports
 that are gone
Message-ID: <20181005072645.GW31561@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>, stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20181005002956.7317-1-lyude@redhat.com>
 <20181005002956.7317-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005002956.7317-5-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 08:29:53PM -0400, Lyude Paul wrote:
> Since we need to be able to allow DPMS on->off prop changes after an MST
> port has disappeared from the system, we need to be able to make sure we
> can compute a config for the resulting atomic commit. Currently this is
> impossible when the port has disappeared, since the VCPI slot searching
> we try to do in intel_dp_mst_compute_config() will fail with -EINVAL.
> 
> Since the only commits we want to allow on no-longer-present MST ports
> are ones that shut off display hardware, we already know that no VCPI
> allocations are needed. So, hardcode the VCPI slot count to 0 when
> intel_dp_mst_compute_config() is called on an MST port that's gone.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/i915/intel_dp_mst.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
> index fcb9b87b9339..a366f32b048a 100644
> --- a/drivers/gpu/drm/i915/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/intel_dp_mst.c
> @@ -42,7 +42,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  		to_intel_connector(conn_state->connector);
>  	struct drm_atomic_state *state = pipe_config->base.state;
>  	int bpp;
> -	int lane_count, slots;
> +	int lane_count, slots = 0;
>  	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
>  	int mst_pbn;
>  	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
> @@ -76,11 +76,16 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
>  	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
>  	pipe_config->pbn = mst_pbn;
>  
> -	slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
> -					      connector->port, mst_pbn);
> -	if (slots < 0) {
> -		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n", slots);
> -		return false;
> +	if (!connector->mst_port_gone) {

Wondered why you don't need this for nouveau/amdgpu, but a bit of grepping
later says they don't even bother to check that in their atomic_check
functions. So if a multi-stream cable runs out of vcpi slots, they just
toss up their hands, atomic be damned :-(

With the s/mst_port_gone/READ_ONCE(!conn->registered)/ bikeshed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I wondered a bit whether ths fuction shouldn't just return 0 if the
connector is gone, but we'd need to audit/fix other drivers first.
-Daniel

> +		slots = drm_dp_atomic_find_vcpi_slots(state,
> +						      &intel_dp->mst_mgr,
> +						      connector->port,
> +						      mst_pbn);
> +		if (slots < 0) {
> +			DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
> +				      slots);
> +			return false;
> +		}
>  	}
>  
>  	intel_link_compute_m_n(bpp, lane_count,
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
