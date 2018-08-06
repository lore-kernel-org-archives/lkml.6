Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0DA219E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DvCzq+IW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0DA219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeHFKjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:39:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39160 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeHFKjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:39:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so4722681edi.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y7eFs2EADbfBpjWdaLKFsPipUILblwKinF/nxAh4n7E=;
        b=DvCzq+IWfW753RQeDBU3lMpJBNSRW6ANGC+ixh+cziN1i1mkXgqGmvbNMZLjA3X/zu
         XxHBEs4c/Yd45y8Ozqx9Xlv1Vs1aPEdoSAt5YJJ5HK6E+YZe0Ry7mwjjAg+7/vr8WHg0
         sg+Z3yWBvsRCgXNFza4YnXIPcKGZlVBBv7qXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=y7eFs2EADbfBpjWdaLKFsPipUILblwKinF/nxAh4n7E=;
        b=oGSDTar/ndiqt1ehcu3Z7LZVl+eRsLP66obRMpUhYn4C1MI6QJDGtcqZWpB7QiBxGK
         rR/4VLG5PqusAmK3bOJlc9m2nbRHi4nlWfVHnhEqmgNIpyu/TPtJkN1B/M+8s9bxgN1q
         Td/fCtUdJXnTl2T+x7hjjVqTUCgSHjtBHBTguJgj+p2dvSdWLgrXE7xNQoy0LeLpmNoz
         I5u1hbubngqxAzKhChwIAkM7Ibb6obtiiuktsRcKMAiYa2UQYWYMvXtNFSKqO9u6Gney
         KkOBlYYiJxvOgTsg+6U2SDniuW+FGNizQ0dSlCg36qCbF0+S/z86Tt3Jn0+pksDiiBmR
         /iPg==
X-Gm-Message-State: AOUpUlFVsTj4dmJ6qoKAK3l6PFltOvi4F4cHfLs33l/aMsFDKBt0sSZP
        USBbpNQWERw1dHmGr7zLeZ9V+g==
X-Google-Smtp-Source: AAOMgpfV2Whfg5BkjMLBuDRsV1sfLG+Yxm2VqqrPBYAtbq8p28LY3cq79VZi30xqRMmLCx+6tSQmKQ==
X-Received: by 2002:a50:bec2:: with SMTP id e2-v6mr17367493edk.283.1533544304436;
        Mon, 06 Aug 2018 01:31:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id v56-v6sm8543482edm.97.2018.08.06.01.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 01:31:43 -0700 (PDT)
Date:   Mon, 6 Aug 2018 10:31:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 0/2] Fix connector probing deadlocks from RPM bugs
Message-ID: <20180806083141.GH3008@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
References: <20180718205645.25924-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718205645.25924-1-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:56:38PM -0400, Lyude Paul wrote:
> This is a trimmed down version of
> 
> https://patchwork.freedesktop.org/series/46637/
> 
> with all of the review comments addressed.
> 
> The last version of this series had fixes for the i2c and DP aux busses
> to ensure that the GPU would be turned on whenever anything tried to
> access the i2c/aux busses. Unfortunately: one of the fixes apparently
> contained some very incorrect usage of Linux's runtime PM interface in
> order to prevent runtime suspend/resume requests coming from within
> nouveau's suspend/resume callbacks from deadlocking the system.
> 
> Turns out: fixing the i2c/dp aux problem is a lot harder then I
> originally anticipated. We either need to come up with helpers for DRM
> that work around the PM core, which is really not ideal, or come up with
> a new feature for the RPM core that allows us to inhibit suspend/resume
> callbacks. The former seems to be somewhat trivial to implement, but
> coming up with a decent interface for that is going to take a bit more
> time and I'd much rather have issues causing deadlocks get fixed first.
> This means that drm_dp_aux_dev is going to be broken on nouveau for
> laptops with hybrid GPUs using RPM, but it was already broken before
> anyhow.
> 
> So: this just contains the seriously important fixes that will stop
> people's machines from crashing very hard. Hopefully I can come up with
> a solution to the i2c/aux problem soon after fixing some other glaring
> MST bugs nouveau currently has.

Why do we need all this? i915 has full rpm support, including i2c and dp
aux correctly working, and everything else too. Why is nouveau special?

Also, there's a metric pile of other drivers using the existing helpers an
infrastructure, with full rpm support, all seemingly being happy too.

Given all that it smells a bit like nouveau has it's rpm design backwards,
which would indicate that these new helpers should be nouveau-specific
wrappers and not generic. If that's not the case, then I'd like to first
understand why nouveau needs them and why no one else seems to need these.
-Daniel

> 
> Lyude Paul (2):
>   drm/fb_helper: Add drm_fb_helper_output_poll_changed_with_rpm()
>   drm/probe_helper: Add
>     drm_helper_probe_single_connector_modes_with_rpm()
> 
>  drivers/gpu/drm/drm_fb_helper.c             | 23 +++++++++++++++
>  drivers/gpu/drm/drm_probe_helper.c          | 31 +++++++++++++++++++++
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  4 +--
>  drivers/gpu/drm/nouveau/nouveau_connector.c |  4 +--
>  include/drm/drm_crtc_helper.h               |  7 +++--
>  include/drm/drm_fb_helper.h                 |  5 ++++
>  6 files changed, 67 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
