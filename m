Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFB62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="MMwy3GBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFB62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIRAgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:36:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42943 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeIRAgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:36:51 -0400
Received: by mail-yb1-f193.google.com with SMTP id 13-v6so1189430ybn.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rc+1Bs9wjVh5MUBkh4AvK8huxzW8uL2UCu3751Pk+50=;
        b=MMwy3GBwLOXYM/kLWpFEjNu19rC+CzAfZsj8xQmk7fpgv2xVv1aLY2ZWj7Q8F97tf5
         nzW0NCqCm18qlUsaJ1f3kFWQrHUP2niAaG/pHNGFTAFyaJMFeauNC0rwJMVAywK/ZGso
         ee9AgD50BNgSloILL8aBQ1JACYSUAJGWRByNNI4RCZCO9aytBXbllW6RX8SzWs+3UClZ
         lXNxfEozafv/P1hR+VZmMAqYnBnVSXnzQLAx4TuvHYsATeGJM/bUq7NNdblDeJyGMsM0
         AeWqIgQmSFndy/R371n28AXPE4auAW5a1h8Knbgg0Taa/HKWQ4A5U4zEQofJ0RlEaQyG
         KLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rc+1Bs9wjVh5MUBkh4AvK8huxzW8uL2UCu3751Pk+50=;
        b=nuwJ/wBVyi9PkFv8lEn7bmzT118Qh7dWXKXp95Po9dSVHIoKcLNtAwpsY6jlEBzsfd
         rI3iLFPa285u3hor3SH9+AcIeZElrpYxghs2r7JxnbQdYbV+id0xG7uQAc2YStxQ48rB
         jYvbOzpIQkLGzyb0ChI0SslBWxiaf1Pv24lwxnpIQXF1/uk5pZjDDeWqcG7DbQ6D4I21
         HEkMsozNLZe7Nxp1qT9mr3P5e/u+8TFrkBDkzjENxLwNRaZB6glVaX2E6p7yV2+OorB6
         AOIRrtJqTepDfU6rfOe7fpOXkt5IILp92oZK1qQVuPIw1ic96QUklkRv2bmrChgSQMxH
         nQiA==
X-Gm-Message-State: APzg51Djb6/mCYMfRC/U53vY8Nw3j+rYbbJvq0gTytwXgivbw6TW2mMN
        xzOvjQguzKzkTohlZHrEQDiauQ==
X-Google-Smtp-Source: ANB0Vdb+HO5tEGbSbhdLffS5g7N9hOUrcAecFYrn8dw/jQqSawYjBAThQGziEXPCcrh98gkT1tiDAQ==
X-Received: by 2002:a25:8b88:: with SMTP id j8-v6mr641110ybl.183.1537211291448;
        Mon, 17 Sep 2018 12:08:11 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id x133-v6sm9132782ywg.49.2018.09.17.12.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:08:10 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:08:10 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atomic: Use drm_drv_uses_atomic_modeset() for
 debugfs creation
Message-ID: <20180917190810.GO188300@art_vandelay>
References: <20180917173733.21293-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917173733.21293-1-lyude@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 01:37:33PM -0400, Lyude Paul wrote:
> As pointed out by Daniel Vetter, we should be usinng
> drm_drv_uses_atomic_modeset() for determining whether or not we want to
> make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
> the former isn't an accurate representation of whether or not the driver
> is actually using atomic modesetting internally (even though it might
> not be exposing atomic capabilities).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_atomic.c  | 2 +-
>  drivers/gpu/drm/drm_debugfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3eb061e11e2e..018fcdb353d2 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -2067,7 +2067,7 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
>  	struct drm_connector *connector;
>  	struct drm_connector_list_iter conn_iter;
>  
> -	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
> +	if (!drm_drv_uses_atomic_modeset(dev))
>  		return;
>  
>  	list_for_each_entry(plane, &config->plane_list, head) {
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index 6f28fe58f169..373bd4c2b698 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -151,7 +151,7 @@ int drm_debugfs_init(struct drm_minor *minor, int minor_id,
>  		return ret;
>  	}
>  
> -	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
> +	if (drm_drv_uses_atomic_modeset(dev)) {
>  		ret = drm_atomic_debugfs_init(minor);
>  		if (ret) {
>  			DRM_ERROR("Failed to create atomic debugfs files\n");
> -- 
> 2.17.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
