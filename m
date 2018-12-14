Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528F2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD622080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PLMvc1oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD622080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeLNIrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:47:48 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45097 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:47:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so4265492edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=N/x1QJua7CUAnyrcnvFWJwm3HvcMW/4AYkZOcxlxDKE=;
        b=PLMvc1ocGDFep2u5UAL03lM/Svo2UgGQ8eDtSeBMkDBGoV50EcaIzalp0JqMliONZs
         Mb7hyxgYyjdpUdtSduU4Xue1ApxSFYQFzlI28iktagJuo/04jJKpIw369Jm9fBsM63hZ
         s6qsJImuZY0bnG9D9v7xjo2ZZop4vPNN4+d6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=N/x1QJua7CUAnyrcnvFWJwm3HvcMW/4AYkZOcxlxDKE=;
        b=idk/KYyo11LBxI457QsnxaYEy+sifqrZepeKD5DrRBPjZ16ROGBQMmOBieOqAmDnmv
         6hYZLBiFruoir8GOc7KZEHIBSfgxekdFkUavEk+sTcUdgQ/vKp9XHqWWcWaABOfX0jmq
         3AUYbduTNjiuxjjzO89wrgdqRCHmKkGpEItoy57nRUIAg+UIZsSHbBHwsvWa4oAZu+vz
         u3D8SwK1TYkBij0mhGQ51xzKAH9nnCXZQ/dGTuHQJaH5vkq6uat5BTsnFN2QxUJGsWFy
         3sAGDkwXy/TmaFa6/UD5g9Yr3boepjn06VVlSv/Z01qFPPzrRx9Kv5+LzzeltVVThlP5
         kEFA==
X-Gm-Message-State: AA+aEWbV1VtZOENtOQLPx46J7M8mrB9yts3WTs1OQZG5tva0tENFx12S
        3dafyKQfot3/RoQUBLuG+iCePw==
X-Google-Smtp-Source: AFSGD/Wnx7lCwIuYec7cs93dNgs2nNkjV5iXd1iqDlkaVCKspMTa+AbLd5pDG8c3PzTxmpxUr+XKGw==
X-Received: by 2002:aa7:d8d3:: with SMTP id k19mr2299628eds.64.1544777266040;
        Fri, 14 Dec 2018 00:47:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k26-v6sm707627ejv.59.2018.12.14.00.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 00:47:45 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:47:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 02/15] drm/dp_mst: Refactor
 drm_dp_update_payload_part1()
Message-ID: <20181214084743.GM21184@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-3-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:25:31PM -0500, Lyude Paul wrote:
> There should be no functional changes here

Would be good to explain what you did refactor here, instead of me trying
to reconstruct it from the patch. Especially pre-coffee that helps :-)
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Juston Li <juston.li@intel.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 71 ++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 9b1b5c9b1fa0..2ab16c9e6243 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1879,39 +1879,48 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  
>  	mutex_lock(&mgr->payload_lock);
>  	for (i = 0; i < mgr->max_payloads; i++) {
> +		struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
> +		struct drm_dp_payload *payload = &mgr->payloads[i];
> +
>  		/* solve the current payloads - compare to the hw ones
>  		   - update the hw view */
>  		req_payload.start_slot = cur_slots;
> -		if (mgr->proposed_vcpis[i]) {
> -			port = container_of(mgr->proposed_vcpis[i], struct drm_dp_mst_port, vcpi);
> +		if (vcpi) {
> +			port = container_of(vcpi, struct drm_dp_mst_port,
> +					    vcpi);
>  			port = drm_dp_get_validated_port_ref(mgr, port);
>  			if (!port) {
>  				mutex_unlock(&mgr->payload_lock);
>  				return -EINVAL;
>  			}
> -			req_payload.num_slots = mgr->proposed_vcpis[i]->num_slots;
> -			req_payload.vcpi = mgr->proposed_vcpis[i]->vcpi;
> +			req_payload.num_slots = vcpi->num_slots;
> +			req_payload.vcpi = vcpi->vcpi;
>  		} else {
>  			port = NULL;
>  			req_payload.num_slots = 0;
>  		}
>  
> -		mgr->payloads[i].start_slot = req_payload.start_slot;
> +		payload->start_slot = req_payload.start_slot;
>  		/* work out what is required to happen with this payload */
> -		if (mgr->payloads[i].num_slots != req_payload.num_slots) {
> +		if (payload->num_slots != req_payload.num_slots) {
>  
>  			/* need to push an update for this payload */
>  			if (req_payload.num_slots) {
> -				drm_dp_create_payload_step1(mgr, mgr->proposed_vcpis[i]->vcpi, &req_payload);
> -				mgr->payloads[i].num_slots = req_payload.num_slots;
> -				mgr->payloads[i].vcpi = req_payload.vcpi;
> -			} else if (mgr->payloads[i].num_slots) {
> -				mgr->payloads[i].num_slots = 0;
> -				drm_dp_destroy_payload_step1(mgr, port, mgr->payloads[i].vcpi, &mgr->payloads[i]);
> -				req_payload.payload_state = mgr->payloads[i].payload_state;
> -				mgr->payloads[i].start_slot = 0;
> +				drm_dp_create_payload_step1(mgr, vcpi->vcpi,
> +							    &req_payload);
> +				payload->num_slots = req_payload.num_slots;
> +				payload->vcpi = req_payload.vcpi;
> +
> +			} else if (payload->num_slots) {
> +				payload->num_slots = 0;
> +				drm_dp_destroy_payload_step1(mgr, port,
> +							     payload->vcpi,
> +							     payload);
> +				req_payload.payload_state =
> +					payload->payload_state;
> +				payload->start_slot = 0;
>  			}
> -			mgr->payloads[i].payload_state = req_payload.payload_state;
> +			payload->payload_state = req_payload.payload_state;
>  		}
>  		cur_slots += req_payload.num_slots;
>  
> @@ -1920,22 +1929,26 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  	}
>  
>  	for (i = 0; i < mgr->max_payloads; i++) {
> -		if (mgr->payloads[i].payload_state == DP_PAYLOAD_DELETE_LOCAL) {
> -			DRM_DEBUG_KMS("removing payload %d\n", i);
> -			for (j = i; j < mgr->max_payloads - 1; j++) {
> -				memcpy(&mgr->payloads[j], &mgr->payloads[j + 1], sizeof(struct drm_dp_payload));
> -				mgr->proposed_vcpis[j] = mgr->proposed_vcpis[j + 1];
> -				if (mgr->proposed_vcpis[j] && mgr->proposed_vcpis[j]->num_slots) {
> -					set_bit(j + 1, &mgr->payload_mask);
> -				} else {
> -					clear_bit(j + 1, &mgr->payload_mask);
> -				}
> -			}
> -			memset(&mgr->payloads[mgr->max_payloads - 1], 0, sizeof(struct drm_dp_payload));
> -			mgr->proposed_vcpis[mgr->max_payloads - 1] = NULL;
> -			clear_bit(mgr->max_payloads, &mgr->payload_mask);
> +		if (mgr->payloads[i].payload_state != DP_PAYLOAD_DELETE_LOCAL)
> +			continue;
> +
> +		DRM_DEBUG_KMS("removing payload %d\n", i);
> +		for (j = i; j < mgr->max_payloads - 1; j++) {
> +			mgr->payloads[j] = mgr->payloads[j + 1];
> +			mgr->proposed_vcpis[j] = mgr->proposed_vcpis[j + 1];
>  
> +			if (mgr->proposed_vcpis[j] &&
> +			    mgr->proposed_vcpis[j]->num_slots) {
> +				set_bit(j + 1, &mgr->payload_mask);
> +			} else {
> +				clear_bit(j + 1, &mgr->payload_mask);
> +			}
>  		}
> +
> +		memset(&mgr->payloads[mgr->max_payloads - 1], 0,
> +		       sizeof(struct drm_dp_payload));
> +		mgr->proposed_vcpis[mgr->max_payloads - 1] = NULL;
> +		clear_bit(mgr->max_payloads, &mgr->payload_mask);

With the commit message improved to mention
- Add local variables in the first loop
- Early continue to reduce 1 indent in the 2nd loop

this is Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	}
>  	mutex_unlock(&mgr->payload_lock);
>  
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
