Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59306C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E4120684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FzypqOBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E4120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeKUUkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:40:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39818 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbeKUUkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:40:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so4388446edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L3SfubptszjR4FSgRA5FdTuEHXMuRj7XPo7KLJ2fiRA=;
        b=FzypqOBJtjszYYLxrTmNqt51JCUpcyp2TLdHl365qVISvHz2ZKwyBc6k5EPzv5zarb
         CEXN+0EZWLS4cxoGK1+7FRiZgSTCZTTe8xK5vMbdS94I+gqUY+V+9nvao3XBTdvJJG13
         HJvjDpIiYpaIzYK996YugaLcfEc+R6GKuCTi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L3SfubptszjR4FSgRA5FdTuEHXMuRj7XPo7KLJ2fiRA=;
        b=YZechdMFARno4Z4kcbcxFUr+GNxWhsBzIBVJFtiaZX2qLbs12gPofelBfmE3aMi0Lh
         jKF8+bYG0k0UV4IYPRhuoKvVEoVA4qC39VGN8ANWJfxA9YnqbjSfYm96WvcdFPGX1R/v
         04DsCzzoyZmD7pqS6YcAd/1trDrQlxv3Uj31CrzwNoETPVVKDld7H9Y+EQfLoSuk2E2b
         FvUiNpnamY9HYc0PIIhTUV3vHOZ8J6qvN6fnKccZ9auN2zwyxhrN9RjEI59AO6dQMPY6
         av8AsPZ9U7NPnUIM/BfD2SYwHqOjUKX3hkLDkbSvXjFai4STcIkawB+ZER4SRS2EQGFw
         cBBQ==
X-Gm-Message-State: AGRZ1gLGR7OyaQmKGgTVWKXiZs+qX9UFka56MRUt54AOkQ+GULYygbt5
        wtlJuD5xV/PPx1exVWXHD91PoQ==
X-Google-Smtp-Source: AJdET5fvnXtBQDz8xsmwEfmgkoZ7psE+2x5BEiOJmAPrNtO5FTPQS8RVy9jurD/eDN/mpplsooyHAw==
X-Received: by 2002:a17:906:394e:: with SMTP id g14-v6mr4648793eje.0.1542794779374;
        Wed, 21 Nov 2018 02:06:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c30sm8990547edc.70.2018.11.21.02.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 02:06:18 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:06:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] drm/i915: Synchronize hpd work in
 i915_hpd_storm_ctl_show()
Message-ID: <20181121100616.GR4266@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20181121003718.17704-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181121003718.17704-1-lyude@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:37:17PM -0500, Lyude Paul wrote:
> While trying to add a chamelium test for short HPD IRQs, I ran into
> issues where a hotplug storm would be triggered, but the point at which
> it would be reported by the kernel would be after igt actually finished
> checking i915_hpd_storm_ctl's status. So, fix this by simply
> synchronizing our IRQ work, dig_port_work, and hotplug_work before
> printing out the HPD storm status in i915_hpd_storm_ctl_show().
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

Makes sense.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 69447c68b9af..af4268a6d2d9 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -4592,6 +4592,13 @@ static int i915_hpd_storm_ctl_show(struct seq_file *m, void *data)
>  	struct drm_i915_private *dev_priv = m->private;
>  	struct i915_hotplug *hotplug = &dev_priv->hotplug;
>  
> +	/* Synchronize with everything first in case there's been an HPD
> +	 * storm, but we haven't finished handling it in the kernel yet
> +	 */
> +	synchronize_irq(dev_priv->drm.irq);
> +	flush_work(&dev_priv->hotplug.dig_port_work);
> +	flush_work(&dev_priv->hotplug.hotplug_work);
> +
>  	seq_printf(m, "Threshold: %d\n", hotplug->hpd_storm_threshold);
>  	seq_printf(m, "Detected: %s\n",
>  		   yesno(delayed_work_pending(&hotplug->reenable_work)));
> -- 
> 2.19.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
