Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AF02080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gJgAPxLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AF02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeLNJiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:38:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44821 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:38:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so4390250edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRfi0KWLcGHZVVPGgayqxxr619k61nslHuAZq41+GDQ=;
        b=gJgAPxLFYKVJZvvuxWEJ+DfINtIKi8Py5za/iUIdKrEUnw+Vp1NHnj7tMAz9MOTwq2
         Phw0vJ53OuRhH3lkrufSy7K6oqOvi7iiIfVCQfrER0Om6NDh2Cxdjy3fYvrboQYQZ6CL
         1TqigX6cK7O4jtbOAkvryiHO6wvmTRTYx9QcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CRfi0KWLcGHZVVPGgayqxxr619k61nslHuAZq41+GDQ=;
        b=qqKRIbctAtbjMOCHTFDUhF7NodhOrlF8de5DpDVk1OdItp+9e3mMi6KVqdOZnIyxQo
         +AmcBiRVFwrLkViv3ypjgY8dP6jSLA5oS4383Q8NenFOuA6QY+OrA5pIVcBU6LJoV4ov
         K3YMhbg1PT3uke3y5pMhVRcHYVT0Q5T21CMlvrriXGbkAsgD3RcTbA0wCW+dwzLl7UAk
         PEeg0GuxQpyLhCpaNdbTUyIYosQqvrmzENP+h4E2b3ZCEadAlXWnElLLSS95cCyKp6El
         r99r5Comv1hmGzVVRxImVW7AyAltleT+DWh3e+jK+86NNPLXKqX2A74S37Hf1ys4O5dZ
         0PAw==
X-Gm-Message-State: AA+aEWZXw2nmwS43YDaFZtWi/iYM7WHOJY3MAgatoDV7L/vCs7AZUvHh
        631SEDlgk0hfMt9H8Cp7spKRhg==
X-Google-Smtp-Source: AFSGD/UH13i3Gsjs1kuKUsd1bG1prmsvTv9UFGrqpv3sf6rQQn4JRgba9TzemXalqVLkrrf3mhI1pg==
X-Received: by 2002:aa7:c248:: with SMTP id y8mr2341739edo.205.1544780329128;
        Fri, 14 Dec 2018 01:38:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n3-v6sm720259ejd.35.2018.12.14.01.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 01:38:48 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:38:46 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 05/15] drm/dp_mst: Fix payload deallocation on
 hotplugs using malloc refs
Message-ID: <20181214093845.GP21184@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20181214012604.13746-1-lyude@redhat.com>
 <20181214012604.13746-6-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-6-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:25:34PM -0500, Lyude Paul wrote:
> Up until now, freeing payloads on remote MST hubs that just had ports
> removed has almost never worked because we've been relying on port
> validation in order to stop us from accessing ports that have already
> been freed from memory, but ports which need their payloads released due
> to being removed will never be a valid part of the topology after
> they've been removed.
> 
> Since we've introduced malloc refs, we can replace all of the validation
> logic in payload helpers which are used for deallocation with some
> well-placed malloc krefs. This ensures that regardless of whether or not
> the ports are still valid and in the topology, any port which has an
> allocated payload will remain allocated in memory until it's payloads
> have been removed - finally allowing us to actually release said
> payloads correctly.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

I think with this we can also remove the int return value (that everyone
ignored except for some debug output) from drm_dp_update_payload_part1/2.
Follow-up cleanup patch ofc.

This looks good.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 54 +++++++++++++++------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ae9d019af9f2..93f08bfd2ab3 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1989,10 +1989,6 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>  	int i;
>  
> -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> -	if (!port)
> -		return -EINVAL;
> -
>  	port_num = port->port_num;
>  	mstb = drm_dp_mst_topology_get_mstb_validated(mgr, port->parent);
>  	if (!mstb) {
> @@ -2000,10 +1996,8 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  							       port->parent,
>  							       &port_num);
>  
> -		if (!mstb) {
> -			drm_dp_mst_topology_put_port(port);
> +		if (!mstb)
>  			return -EINVAL;
> -		}
>  	}
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2032,7 +2026,6 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  	kfree(txmsg);
>  fail_put:
>  	drm_dp_mst_topology_put_mstb(mstb);
> -	drm_dp_mst_topology_put_port(port);
>  	return ret;
>  }
>  
> @@ -2137,15 +2130,16 @@ static int drm_dp_destroy_payload_step2(struct drm_dp_mst_topology_mgr *mgr,
>   */
>  int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  {
> -	int i, j;
> -	int cur_slots = 1;
>  	struct drm_dp_payload req_payload;
>  	struct drm_dp_mst_port *port;
> +	int i, j;
> +	int cur_slots = 1;
>  
>  	mutex_lock(&mgr->payload_lock);
>  	for (i = 0; i < mgr->max_payloads; i++) {
>  		struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
>  		struct drm_dp_payload *payload = &mgr->payloads[i];
> +		bool put_port = false;
>  
>  		/* solve the current payloads - compare to the hw ones
>  		   - update the hw view */
> @@ -2153,12 +2147,20 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  		if (vcpi) {
>  			port = container_of(vcpi, struct drm_dp_mst_port,
>  					    vcpi);
> -			port = drm_dp_mst_topology_get_port_validated(mgr,
> -								      port);
> -			if (!port) {
> -				mutex_unlock(&mgr->payload_lock);
> -				return -EINVAL;
> +
> +			/* Validated ports don't matter if we're releasing
> +			 * VCPI
> +			 */
> +			if (vcpi->num_slots) {
> +				port = drm_dp_mst_topology_get_port_validated(
> +				    mgr, port);
> +				if (!port) {
> +					mutex_unlock(&mgr->payload_lock);
> +					return -EINVAL;
> +				}
> +				put_port = true;
>  			}
> +
>  			req_payload.num_slots = vcpi->num_slots;
>  			req_payload.vcpi = vcpi->vcpi;
>  		} else {
> @@ -2190,7 +2192,7 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  		}
>  		cur_slots += req_payload.num_slots;
>  
> -		if (port)
> +		if (put_port)
>  			drm_dp_mst_topology_put_port(port);
>  	}
>  
> @@ -3005,6 +3007,8 @@ bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
>  	DRM_DEBUG_KMS("initing vcpi for pbn=%d slots=%d\n",
>  		      pbn, port->vcpi.num_slots);
>  
> +	/* Keep port allocated until it's payload has been removed */
> +	drm_dp_mst_get_port_malloc(port);
>  	drm_dp_mst_topology_put_port(port);
>  	return true;
>  out:
> @@ -3034,11 +3038,12 @@ EXPORT_SYMBOL(drm_dp_mst_get_vcpi_slots);
>   */
>  void drm_dp_mst_reset_vcpi_slots(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port)
>  {
> -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> -	if (!port)
> -		return;
> +	/*
> +	 * A port with VCPI will remain allocated until it's VCPI is
> +	 * released, no verified ref needed
> +	 */
> +
>  	port->vcpi.num_slots = 0;
> -	drm_dp_mst_topology_put_port(port);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
>  
> @@ -3050,16 +3055,17 @@ EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
>  void drm_dp_mst_deallocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
>  				struct drm_dp_mst_port *port)
>  {
> -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> -	if (!port)
> -		return;
> +	/*
> +	 * A port with VCPI will remain allocated until it's VCPI is
> +	 * released, no verified ref needed
> +	 */
>  
>  	drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
>  	port->vcpi.num_slots = 0;
>  	port->vcpi.pbn = 0;
>  	port->vcpi.aligned_pbn = 0;
>  	port->vcpi.vcpi = 0;
> -	drm_dp_mst_topology_put_port(port);
> +	drm_dp_mst_put_port_malloc(port);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_deallocate_vcpi);
>  
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
