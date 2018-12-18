Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDA420874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeLRWC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:02:27 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36648 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:02:27 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so10491826qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 14:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=EsojUI9QDJJ/V+WS2VaONbvCwzMWLBaQYZDQtJ82Bms=;
        b=Q1VuxznnFsMVXQvLCF55dWIhhA08MYmnvUOkf450i6Ne9HV+g9iT4rMBT6cqg/B26B
         aljgu4QO7zvoh+YE/U+giqOaglJ4FiIQ/Wyf+oxh+mR7Lb0a3SEGBdhTVpVLidJ1NhSk
         BG1pWSPO1cykwbYeOHo3byY48t34uGXM4b2VmiNhZwpj0tAsPnFEE0IelxaHQwrBoHL3
         7IJe28nmiib6iky+zkT0A2zm+Jv8CKD1kfYHJkv3PUCHWAEZKEXFwjgiSwO3oMKPMMEg
         7Q2W5H7omi9aOFDdhCy83EOqMlo6+FNP7pVUNyCzJU/3cQCbU/oP1gPKDZZUUC/x/yeU
         28NQ==
X-Gm-Message-State: AA+aEWYzN8QQKhrAmuA4xu+JnBNYUJUa30D4TX6sSoIFSj0oMgV+rg7Q
        5QZpS/qgUqOz4vSyp1fDhM4jUA==
X-Google-Smtp-Source: AFSGD/XEqY1jfVb9+miHoVuC68zCxyZVBYEtxVN9dbnpLAM5w7Ac3G2r+ZO2rT6FyGndoBEuIGs13Q==
X-Received: by 2002:a37:9e0d:: with SMTP id h13mr13290700qke.260.1545170545691;
        Tue, 18 Dec 2018 14:02:25 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id u4sm490709qkk.51.2018.12.18.14.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 14:02:24 -0800 (PST)
Message-ID: <a678fe870b682a0f2ec466a62f1862cb9633893b.camel@redhat.com>
Subject: Re: [WIP PATCH 05/15] drm/dp_mst: Fix payload deallocation on
 hotplugs using malloc refs
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Dec 2018 17:02:23 -0500
In-Reply-To: <20181214093845.GP21184@phenom.ffwll.local>
References: <20181214012604.13746-1-lyude@redhat.com>
         <20181214012604.13746-6-lyude@redhat.com>
         <20181214093845.GP21184@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 10:38 +0100, Daniel Vetter wrote:
> On Thu, Dec 13, 2018 at 08:25:34PM -0500, Lyude Paul wrote:
> > Up until now, freeing payloads on remote MST hubs that just had ports
> > removed has almost never worked because we've been relying on port
> > validation in order to stop us from accessing ports that have already
> > been freed from memory, but ports which need their payloads released due
> > to being removed will never be a valid part of the topology after
> > they've been removed.
> > 
> > Since we've introduced malloc refs, we can replace all of the validation
> > logic in payload helpers which are used for deallocation with some
> > well-placed malloc krefs. This ensures that regardless of whether or not
> > the ports are still valid and in the topology, any port which has an
> > allocated payload will remain allocated in memory until it's payloads
> > have been removed - finally allowing us to actually release said
> > payloads correctly.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> I think with this we can also remove the int return value (that everyone
> ignored except for some debug output) from drm_dp_update_payload_part1/2.
> Follow-up cleanup patch ofc.
A note as well-I'm not sure we want to remove that yet, it might actually be a
better idea to just teach drivers to actually look at the return values so
they can take action if it fails. Of course, such actions wouldn't involve
actually changing the atomic state that userspace set, but moreso knowing
which parts of updating the payload succeeded or not so if a downstream branch
was disconnected mid-atomic commit we have enough information to know what
steps we need to skip when userspace later unsets the mode on said branch.
> 
> This looks good.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 54 +++++++++++++++------------
> >  1 file changed, 30 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index ae9d019af9f2..93f08bfd2ab3 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1989,10 +1989,6 @@ static int drm_dp_payload_send_msg(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
> >  	int i;
> >  
> > -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> > -	if (!port)
> > -		return -EINVAL;
> > -
> >  	port_num = port->port_num;
> >  	mstb = drm_dp_mst_topology_get_mstb_validated(mgr, port->parent);
> >  	if (!mstb) {
> > @@ -2000,10 +1996,8 @@ static int drm_dp_payload_send_msg(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  							       port->parent,
> >  							       &port_num);
> >  
> > -		if (!mstb) {
> > -			drm_dp_mst_topology_put_port(port);
> > +		if (!mstb)
> >  			return -EINVAL;
> > -		}
> >  	}
> >  
> >  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> > @@ -2032,7 +2026,6 @@ static int drm_dp_payload_send_msg(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  	kfree(txmsg);
> >  fail_put:
> >  	drm_dp_mst_topology_put_mstb(mstb);
> > -	drm_dp_mst_topology_put_port(port);
> >  	return ret;
> >  }
> >  
> > @@ -2137,15 +2130,16 @@ static int drm_dp_destroy_payload_step2(struct
> > drm_dp_mst_topology_mgr *mgr,
> >   */
> >  int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
> >  {
> > -	int i, j;
> > -	int cur_slots = 1;
> >  	struct drm_dp_payload req_payload;
> >  	struct drm_dp_mst_port *port;
> > +	int i, j;
> > +	int cur_slots = 1;
> >  
> >  	mutex_lock(&mgr->payload_lock);
> >  	for (i = 0; i < mgr->max_payloads; i++) {
> >  		struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
> >  		struct drm_dp_payload *payload = &mgr->payloads[i];
> > +		bool put_port = false;
> >  
> >  		/* solve the current payloads - compare to the hw ones
> >  		   - update the hw view */
> > @@ -2153,12 +2147,20 @@ int drm_dp_update_payload_part1(struct
> > drm_dp_mst_topology_mgr *mgr)
> >  		if (vcpi) {
> >  			port = container_of(vcpi, struct drm_dp_mst_port,
> >  					    vcpi);
> > -			port = drm_dp_mst_topology_get_port_validated(mgr,
> > -								      port);
> > -			if (!port) {
> > -				mutex_unlock(&mgr->payload_lock);
> > -				return -EINVAL;
> > +
> > +			/* Validated ports don't matter if we're releasing
> > +			 * VCPI
> > +			 */
> > +			if (vcpi->num_slots) {
> > +				port = drm_dp_mst_topology_get_port_validated(
> > +				    mgr, port);
> > +				if (!port) {
> > +					mutex_unlock(&mgr->payload_lock);
> > +					return -EINVAL;
> > +				}
> > +				put_port = true;
> >  			}
> > +
> >  			req_payload.num_slots = vcpi->num_slots;
> >  			req_payload.vcpi = vcpi->vcpi;
> >  		} else {
> > @@ -2190,7 +2192,7 @@ int drm_dp_update_payload_part1(struct
> > drm_dp_mst_topology_mgr *mgr)
> >  		}
> >  		cur_slots += req_payload.num_slots;
> >  
> > -		if (port)
> > +		if (put_port)
> >  			drm_dp_mst_topology_put_port(port);
> >  	}
> >  
> > @@ -3005,6 +3007,8 @@ bool drm_dp_mst_allocate_vcpi(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  	DRM_DEBUG_KMS("initing vcpi for pbn=%d slots=%d\n",
> >  		      pbn, port->vcpi.num_slots);
> >  
> > +	/* Keep port allocated until it's payload has been removed */
> > +	drm_dp_mst_get_port_malloc(port);
> >  	drm_dp_mst_topology_put_port(port);
> >  	return true;
> >  out:
> > @@ -3034,11 +3038,12 @@ EXPORT_SYMBOL(drm_dp_mst_get_vcpi_slots);
> >   */
> >  void drm_dp_mst_reset_vcpi_slots(struct drm_dp_mst_topology_mgr *mgr,
> > struct drm_dp_mst_port *port)
> >  {
> > -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> > -	if (!port)
> > -		return;
> > +	/*
> > +	 * A port with VCPI will remain allocated until it's VCPI is
> > +	 * released, no verified ref needed
> > +	 */
> > +
> >  	port->vcpi.num_slots = 0;
> > -	drm_dp_mst_topology_put_port(port);
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
> >  
> > @@ -3050,16 +3055,17 @@ EXPORT_SYMBOL(drm_dp_mst_reset_vcpi_slots);
> >  void drm_dp_mst_deallocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
> >  				struct drm_dp_mst_port *port)
> >  {
> > -	port = drm_dp_mst_topology_get_port_validated(mgr, port);
> > -	if (!port)
> > -		return;
> > +	/*
> > +	 * A port with VCPI will remain allocated until it's VCPI is
> > +	 * released, no verified ref needed
> > +	 */
> >  
> >  	drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
> >  	port->vcpi.num_slots = 0;
> >  	port->vcpi.pbn = 0;
> >  	port->vcpi.aligned_pbn = 0;
> >  	port->vcpi.vcpi = 0;
> > -	drm_dp_mst_topology_put_port(port);
> > +	drm_dp_mst_put_port_malloc(port);
> >  }
> >  EXPORT_SYMBOL(drm_dp_mst_deallocate_vcpi);
> >  
> > -- 
> > 2.19.2
> > 
-- 
Cheers,
	Lyude Paul

