Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC55C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F13320672
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PMSOIdvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeLNJku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:40:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38999 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:40:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so4416240edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 01:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJbJ3b1s6OtzxlrIrNWzya1v/WchMlr8EY6HlXyl5SY=;
        b=PMSOIdvcKQHVHgd1cDT13zzOLNah5lUY7MK+S3Zv3crrMZROCrzBv8P5rtsaNNfxwH
         nZyaBTR8/dGmN6KomQH+pTrB1IEsGm4AdepKne61+t8+d9AGdtdyKmYoXbtT8pw2D+3d
         d7ZbDM2HWz9NPggOxj8ktNLBdMrB+62LhMQVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CJbJ3b1s6OtzxlrIrNWzya1v/WchMlr8EY6HlXyl5SY=;
        b=gpsGpLv13EDQVX3Bona8EihONRnhBjcqztSXmcxzfh6vnHQ8zjeg7b/VezIzllouD7
         6TwCqAoWT5V9Vu2rlj1+VuwOOOQkcLna/e8Ia6le42mTCjWJ2ie0J5o+G3qhLYna+4Vx
         8pBFoZx6zR6Nr1yRP7ocwMoOzoXD3NAt1eVS+k2sTx2nwyZlWSbwKo9TLM8YKTNKUiDG
         Pje5yJIpLBiXzDQE9MgGHbJdvYfLIP3n1HvIphQ30SxkMHZWa4H+sg0NbaOt6rvfKOt3
         tlVfXAfWfJ9djzFEqXsUEP5E+Hlrqyk2GogQ77LE/mbjXswuxmhYZnN4JyX7boIYfSt0
         fp/Q==
X-Gm-Message-State: AA+aEWauCXCXaROEk2EsHMxjc+HsUFLF/8Ra6u+HkOnxIy72RNRUbViJ
        s8Q29MPAcdBPJV58RsbCPjJq2w==
X-Google-Smtp-Source: AFSGD/XZDwzvLsptoakb9l+2CLM9fVxNQNm+32u2DNgjAHvHfTBa2iPNe84csjU3c+sKarQdZqx1SA==
X-Received: by 2002:a17:906:340a:: with SMTP id c10-v6mr1978123ejb.130.1544780447871;
        Fri, 14 Dec 2018 01:40:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b9sm1474111ede.12.2018.12.14.01.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 01:40:47 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:40:44 +0100
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
Subject: Re: [WIP PATCH 04/15] drm/dp_mst: Stop releasing VCPI when removing
 ports from topology
Message-ID: <20181214094044.GQ21184@phenom.ffwll.local>
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
 <20181214012604.13746-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-5-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:25:33PM -0500, Lyude Paul wrote:
> This has never actually worked, and isn't needed anyway: the driver's
> always going to try to deallocate VCPI when it tears down the display
> that the VCPI belongs to.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index c196fb580beb..ae9d019af9f2 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1084,8 +1084,6 @@ static void drm_dp_destroy_port(struct kref *kref)
>  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
>  
>  	if (!port->input) {
> -		port->vcpi.num_slots = 0;
> -
>  		kfree(port->cached_edid);
>  
>  		/*
> @@ -3381,12 +3379,6 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
>  		drm_dp_port_teardown_pdt(port, port->pdt);
>  		port->pdt = DP_PEER_DEVICE_NONE;
>  
> -		if (!port->input && port->vcpi.vcpi > 0) {
> -			drm_dp_mst_reset_vcpi_slots(mgr, port);
> -			drm_dp_update_payload_part1(mgr);
> -			drm_dp_mst_put_payload_id(mgr, port->vcpi.vcpi);
> -		}
> -
>  		drm_dp_mst_put_port_malloc(port);
>  		send_hotplug = true;
>  	}
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
