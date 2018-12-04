Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A1EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7903214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CBpAX5YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7903214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeLDMN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:13:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38285 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:13:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so13733473ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjSBotlwPXIdOSz3cx3MyeIiqni03SjzQng+PW93z8I=;
        b=CBpAX5YTOicQ88aIzbVM3Ros8aZ1Ipeu1CwRf/ejI1jnaP9ABzZ6HPpAxsVLrro8yz
         ihvm4KwEuH4OoqM6VEnh+Egb19kD/j93N83lxdKzhlPeBB30qVKBMhY1LSbkBHTzyBx6
         I0TsHqPTsWN2FNMbte56NqDhGCPQGiUBw0A+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cjSBotlwPXIdOSz3cx3MyeIiqni03SjzQng+PW93z8I=;
        b=O8Pj0WblTE1nu1x6ydoAx1g4XbbAF0M2zGHKa6MOtsi3AcpzIR8UKyyC7gAKQQydNE
         cawiPyMp6hYJApmOvcg5PuZ5dLDw9zlBaNPBXpYwrd1gaJLYYEcrbxJNw74Lg1RWbhDS
         IHGy4Qw38U3DCg1kvAupJu8kJ+5l1K9aciOuB3IoNtwDf93oOVceMooHdKBwM89DcXRY
         pXe3W1VCJNSwDMe11R0xP40a80778znlE0Cv1Km9MI9BX8YC1qdhScfXkfx5tL6g9NDl
         D+TFD+W0VIwAuIJvtMzd/PVT2XRHn9TLy4rd7EaqDCSxUVRoWyk6gJCMF76QIL0HUdBW
         oyvw==
X-Gm-Message-State: AA+aEWZFPz5RoYvw7p8diTQ8KF1SIpqw6BmeSeyqAsY35x83WJAfjpAl
        PwPoFnKAGrDuNiGEje3S/ED5Jw==
X-Google-Smtp-Source: AFSGD/WCFH5i7k5FCv+tA2CISlpSzFnZwA2qLN47NhIs/VaC+l648DHQzc8rh8ADOQ7V9z9hNbgFxw==
X-Received: by 2002:a17:906:655:: with SMTP id t21-v6mr15057458ejb.81.1543925606253;
        Tue, 04 Dec 2018 04:13:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a38sm4802328edd.44.2018.12.04.04.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 04:13:25 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:13:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Bobroff <sbobroff@linux.ibm.com>
Cc:     daniel@ffwll.ch, airlied@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/ast: Fix connector leak during driver unload
Message-ID: <20181204121323.GC21184@phenom.ffwll.local>
Mail-Followup-To: Sam Bobroff <sbobroff@linux.ibm.com>, airlied@redhat.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1543798395.git.sbobroff@linux.ibm.com>
 <1e613f3c630c7bbc72e04a44b178259b9164d2f6.1543798395.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e613f3c630c7bbc72e04a44b178259b9164d2f6.1543798395.git.sbobroff@linux.ibm.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:53:21AM +1100, Sam Bobroff wrote:
> When unloading the ast driver, a warning message is printed by
> drm_mode_config_cleanup() because a reference is still held to one of
> the drm_connector structs.
> 
> Correct this by calling drm_crtc_force_disable_all() in
> ast_fbdev_destroy().
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
> v2 * Changed to use drm_crtc_force_disable_all().

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
>  drivers/gpu/drm/ast/ast_fb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> index 0cd827e11fa2..de26df0c6044 100644
> --- a/drivers/gpu/drm/ast/ast_fb.c
> +++ b/drivers/gpu/drm/ast/ast_fb.c
> @@ -263,6 +263,7 @@ static void ast_fbdev_destroy(struct drm_device *dev,
>  {
>  	struct ast_framebuffer *afb = &afbdev->afb;
>  
> +	drm_crtc_force_disable_all(dev);
>  	drm_fb_helper_unregister_fbi(&afbdev->helper);
>  
>  	if (afb->obj) {
> -- 
> 2.19.0.2.gcad72f5712
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
