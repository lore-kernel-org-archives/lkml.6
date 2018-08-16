Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD81C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D21214DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RYCOUH9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D21214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbeHPK3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:29:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43624 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeHPK3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:29:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id j21-v6so2114967edp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zyqHAnQ2Fd+vX/Fx0Bz8n9Mo/rrGY4bponelCsbdu0=;
        b=RYCOUH9vVDsB6x7ZQv0g6Le8p4rjj+fFOy12M69Ui5XDvzzvL2vd+aj5GTYwscypmp
         AYNhI41ujgMWVT6VSQWzHoSWkbBZRZDua9hN+ho+GGGPlaETZq1FoJdRWmTzKpTwSSt9
         9JPjWho6aSnvXQVL3PgeHGNkh3nXNT5/rZDDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5zyqHAnQ2Fd+vX/Fx0Bz8n9Mo/rrGY4bponelCsbdu0=;
        b=ZAu+VdJV7B6sjXvY90RTKFXlYK9eJ5EoeA6Fnj1GFkp7mk4R0BR3+Ccg5HAodjspQK
         AxH3kbzFx6X/+uJM/PUXw1ZAMsVg0i4F1JTd3AOyGJxhTpsLFAW1y66Rjwx15JyzfoCd
         bauv2wTmX6W7dZEUWvqzWTSqpH43gVvw2gcIucVpH3/pNREH9Z5CCbWwlZaaGiqK2ory
         F93KCAI501TJ7OwjVP8HvDJ5S/3bhW9p9VagkFXogs7Ri4k0/mpUrNsCgcK/UBTrdbYX
         DvSmI5dfuhE5f5UiTsY9E1JSxXUeK+t7E9VU/Ufk6+Zmknbbg62wpouLkMIDvmfWTo8X
         vYhg==
X-Gm-Message-State: AOUpUlEGa889ZIyO9pLUASRlAv3LVaGywvptZpjc0/x9nEROc7rXE4hq
        rZpxm6Y8jQmZxqjggRsF1h+igg==
X-Google-Smtp-Source: AA+uWPwLOoz9ZziWoS/ROmBQHV9EKT5XZoDU68aZJZRJxu8MZDRMn72OG3KUFdH9bUi4/Md08xQSzA==
X-Received: by 2002:aa7:d40a:: with SMTP id z10-v6mr35448363edq.203.1534404770983;
        Thu, 16 Aug 2018 00:32:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id o27-v6sm248124edc.77.2018.08.16.00.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 00:32:50 -0700 (PDT)
Date:   Thu, 16 Aug 2018 09:32:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drm-misc: Change seanpaul's email address
Message-ID: <20180816073248.GZ21634@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20180815153604.90152-1-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815153604.90152-1-sean@poorly.run>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:35:29AM -0400, Sean Paul wrote:
> Since chromium.org is now enforcing DMARC, my mails are going to
> people's spam folders. While this development might be desirable
> for people I communicate with, it's undesirable for me :-)
> 
> Cc: Dave Airlie <airlied@linux.ie>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Sean Paul <sean@poorly.run>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93f189f0d60d..5eaa1c91d4a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4662,7 +4662,7 @@ F:	include/linux/vga*
>  DRM DRIVERS AND MISC GPU PATCHES
>  M:	Gustavo Padovan <gustavo@padovan.org>
>  M:	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> -M:	Sean Paul <seanpaul@chromium.org>
> +M:	Sean Paul <sean@poorly.run>

Glorious domain :-)

Aside: ffwll.ch has been running with dkim since a while, seems to work
correctly. You just need non-strict dkim enforcement, which at least for
gapps is the default.

But even then Linus' gmail inbox throws my mails away every once in a
while, so email clearly doesn't work.

</rant>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>  W:	https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-misc.html
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
