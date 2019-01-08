Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E96DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E5A218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="k2GjItR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfAHIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:06:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46406 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfAHIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:06:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so3231945edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YULOM3KvdKdk9rUr+AHooOYFdLMyqKv40ZrfrFK476k=;
        b=k2GjItR6Wu/SOeSheocdtFID6t3wvTMEw5fC+m/rpO0L99I2ZM4WY98LIyisWC/GOW
         7OlG800nF7eg0MolQ6XLo+KTOZRFHoxemqsr1ntbbz/KSNq+AFpkD3jSTEMBZViV924x
         ykYVFSk74MIlNN5yQF4sXzJ0Tl9hj3zfwnFQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YULOM3KvdKdk9rUr+AHooOYFdLMyqKv40ZrfrFK476k=;
        b=KY+xDtv/zyqaiBTZebaS3aXecyHpR/AcobSv5lregS8SWIZjJbTJVmJsOYOZBPOIAs
         fbjwDm9tKXlJZinkZgKdh/iF+yCGY1mffZ6Wjn+5HdKHgloHG1xltpL0upCUGriC+aDO
         2NuobVBD3AFsk7dlNdCZdWPDlJiSzMiiAutUQix/2OjEPgkUwyRfTil8ZNVI0eCAdJS8
         8lXGc2czGqU3K4pugFfUJ6Szaa00m74+6thmuTxpW3kf1B0bzk8r+KWgf+30ps03TGmC
         RPRaiKCaT+WfcqSYNYHWkv5VApk3bdtDhae7KBcTZpE+6PsSdjBJInuHMRx5V8ZePgkW
         pZSA==
X-Gm-Message-State: AJcUukdzE1cXDRfidKGZAkYCNXiEDxIosfcwtpaONi1P2+u3r+CxSy4H
        sUD31gDhSJOF+SN3+v9+v6WqcQ==
X-Google-Smtp-Source: ALg8bN4df3cTkpsdbY/acULXhNlhlNDIXeXXhbnfo7hNTF6cjyOiQxUXjat4qCLrnu8YMNu6BZbUbA==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr1132063edy.92.1546934797903;
        Tue, 08 Jan 2019 00:06:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b14sm26508348edt.6.2019.01.08.00.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 00:06:37 -0800 (PST)
Date:   Tue, 8 Jan 2019 09:06:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jerry Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/dp_mst: Add __must_check to
 drm_dp_mst_topology_mgr_resume()
Message-ID: <20190108080635.GO21184@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20190108005651.25967-1-lyude@redhat.com>
 <20190108005651.25967-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108005651.25967-4-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:56:47PM -0500, Lyude Paul wrote:
> Since I've had to fix two cases of drivers not checking the return code
> from this function, let's make the compiler complain so this doesn't
> come up again in the future.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 3 ++-
>  include/drm/drm_dp_mst_helper.h       | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 2ab16c9e6243..13a7e497bfe2 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2226,7 +2226,8 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
>   * if the device fails this returns -1, and the driver should do
>   * a full MST reprobe, in case we were undocked.
>   */
> -int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
> +int __must_check

I think you need the must_check only in the header. With that fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
>  {
>  	int ret = 0;
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 371cc2816477..4355b55d0081 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -614,7 +614,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>  			      struct drm_dp_mst_topology_mgr *mgr);
>  
>  void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
> -int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
> +int __must_check
> +drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
>  struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
>  								    struct drm_dp_mst_topology_mgr *mgr);
>  int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
