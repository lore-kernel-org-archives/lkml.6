Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730D20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gk7mDOZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730D20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeLNIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:42:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33456 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:42:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so4313655eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 00:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cg21H/AtVx9QxM/1n8CvwJ2h0vn+1NQPTIfibFvaUHQ=;
        b=gk7mDOZgloQ5cZrhH8hwWqgodfgjgb9REhpsItpV1k/mxwtyOiearzAkc/r+W9cTdy
         tcG3kdMPzWG1MNfc4iMAbbuXU9uyIBTLbEBLx1PyvGCY0VWpr8d+GBUOWp5OjFM9Lkcm
         JdeGoc8QEr/2IOhvnuds/wR8PgTOw1D7op5ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Cg21H/AtVx9QxM/1n8CvwJ2h0vn+1NQPTIfibFvaUHQ=;
        b=KqVH+SE6Pkaj/ad69VHdQyOfjpGY4ryX5ebR3PZcphcDJ67oSjgFP/YpdK2SQo7SWt
         qwbaEG+bHe6wdMD0NS4mDyZW2Da+zWMmwXUM+r/wFCXaYkNx73u6jPlRz5lJUNdF1v6R
         1y7KyF5Vyt5PVLGMtrrbdJ9ATmVsfU+JsQqv5FWfUyxuXAeSTaXlisrWlJIm1iqRJhU4
         Rdnr57703XdNZnrLLh+MBuJRc6Z1u98SJIaw7RSJTVOUx4gXhLu0geh3xpkPzqABIZuZ
         rrhXiDAJrA/lRwOl4bieIRaHs4mr1rT3rSxGmSitRmvkva9cpBBTSLQSwab54ReGZWQe
         LvIg==
X-Gm-Message-State: AA+aEWard8WXGOn5reswNHELfS731GpM96BWOlBg+uZAtmQoB9dCnHLj
        1d2/9UD6Ptc1/bELDHuJA0MXNA==
X-Google-Smtp-Source: AFSGD/WHoL4e8xusTFaL5pqgPUKTEcs2jZ71yyOf7anO+0ouSVz14mtCRm9FpRPifCM9DnzOET+35A==
X-Received: by 2002:a50:f014:: with SMTP id r20mr2274508edl.144.1544776945647;
        Fri, 14 Dec 2018 00:42:25 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r18-v6sm701934eja.19.2018.12.14.00.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 00:42:23 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:42:21 +0100
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
Subject: Re: [WIP PATCH 01/15] drm/dp_mst: Remove bogus conditional in
 drm_dp_update_payload_part1()
Message-ID: <20181214084220.GL21184@phenom.ffwll.local>
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
 <20181214012604.13746-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214012604.13746-2-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:25:30PM -0500, Lyude Paul wrote:
> There's no reason we need this, it's just confusing looking.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Juston Li <juston.li@intel.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ad0fb6d003be..9b1b5c9b1fa0 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1896,9 +1896,7 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
>  			req_payload.num_slots = 0;
>  		}
>  
> -		if (mgr->payloads[i].start_slot != req_payload.start_slot) {
> -			mgr->payloads[i].start_slot = req_payload.start_slot;
> -		}
> +		mgr->payloads[i].start_slot = req_payload.start_slot;

Entertaining!

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  		/* work out what is required to happen with this payload */
>  		if (mgr->payloads[i].num_slots != req_payload.num_slots) {
>  
> -- 
> 2.19.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
