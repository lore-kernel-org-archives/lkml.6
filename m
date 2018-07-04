Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69B32086A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BpfChDTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934085AbeGDIbj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:31:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39759 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbeGDIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:31:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so3451655eds.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKOw8UG//PrPTTwWsEfjdCmipjTUNOZBk/FudXMexQc=;
        b=BpfChDTDeuKanOOO6JPc3AG3hv2vy5AvloR3ethkbGllqkAFOscRZyxwsqkGpa2E7j
         S7NuEdRWSyaQq5pOy90hp7ngznSHA0SN3vY+0Jf3J/is5CFaKdpXe7gBut8/N1oLtkAL
         aUL4dNqiI7FUW8SXP3pdbAlNlpp3+/tPnVCzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qKOw8UG//PrPTTwWsEfjdCmipjTUNOZBk/FudXMexQc=;
        b=k5JWfYrKcvzvDQsVKpgR3wjrZt+ZqKMp8Oizkt14ZvZaWXxVnz5nFcnlp+ZUWrQLxK
         3/kI1jobT2j93OvedL5igiGqZ3KJZbltSOH6Txfe4i5kqKYf1URYrncWe+oCXB5ks6FY
         fo6Oab6oWD0bT0nWjzAjNDkRIwdIIKmt+LBUrGCcQwjw3P9EBjGpf6f+0WEWOSUe6Lm2
         SBs8aSmMSYL/LQUgkHNwigJzREU9AUfSrR4nv0jWE67ikXOXMUGZ6x7vWM5v7BisI9h+
         fqAD5OUqFpIhQi8R7Z07211veqDf/OshDx2pTh0gFuqfH8wMYcR5QcZh/I2ZPkIUtflB
         a09g==
X-Gm-Message-State: APt69E3xLnHBwwyGrkDCdnD2/xC220TOirFPDjaXyWYmRsXUd+uWoHRC
        SUmYZuGb3MRX32VwNUq5YfPBYaqO
X-Google-Smtp-Source: AAOMgpeig6WotnxGAq7xKnpvmqjC6O0T760z+lfK4vuYy6jm7GFmA0fcj2GP/Zl+WRxho2P8AGKz3w==
X-Received: by 2002:a50:9154:: with SMTP id f20-v6mr1653775eda.29.1530693094691;
        Wed, 04 Jul 2018 01:31:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id d25-v6sm1440959edp.89.2018.07.04.01.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 01:31:33 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:31:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/v3d: Delay the scheduler timeout if we're still
 making progress.
Message-ID: <20180704083132.GL3891@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180703170515.6298-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703170515.6298-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.16.0-2-amd64
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:05:12AM -0700, Eric Anholt wrote:
> GTF-GLES2.gtf.GL.acos.acos_float_vert_xvary submits jobs that take 4
> seconds at maximum resolution, but we still want to reset quickly if a
> job is really hung.  Sample the CL's current address and the return
> address (since we call into tile lists repeatedly) and if either has
> changed then assume we've made progress.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/v3d/v3d_drv.h   |  2 ++
>  drivers/gpu/drm/v3d/v3d_regs.h  |  1 +
>  drivers/gpu/drm/v3d/v3d_sched.c | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index f546e0ab9562..a5d96d823416 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -189,6 +189,8 @@ struct v3d_job {
>  
>  	/* GPU virtual addresses of the start/end of the CL job. */
>  	u32 start, end;
> +
> +	u32 timedout_ctca, timedout_ctra;
>  };
>  
>  struct v3d_exec_info {
> diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
> index fc13282dfc2f..854046565989 100644
> --- a/drivers/gpu/drm/v3d/v3d_regs.h
> +++ b/drivers/gpu/drm/v3d/v3d_regs.h
> @@ -222,6 +222,7 @@
>  #define V3D_CLE_CTNCA(n) (V3D_CLE_CT0CA + 4 * n)
>  #define V3D_CLE_CT0RA                                  0x00118
>  #define V3D_CLE_CT1RA                                  0x0011c
> +#define V3D_CLE_CTNRA(n) (V3D_CLE_CT0RA + 4 * n)
>  #define V3D_CLE_CT0LC                                  0x00120
>  #define V3D_CLE_CT1LC                                  0x00124
>  #define V3D_CLE_CT0PC                                  0x00128
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 808bc901f567..00667c733dca 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -153,7 +153,25 @@ v3d_job_timedout(struct drm_sched_job *sched_job)
>  	struct v3d_job *job = to_v3d_job(sched_job);
>  	struct v3d_exec_info *exec = job->exec;
>  	struct v3d_dev *v3d = exec->v3d;
> +	enum v3d_queue job_q = job == &exec->bin ? V3D_BIN : V3D_RENDER;
>  	enum v3d_queue q;
> +	u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(job_q));
> +	u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(job_q));
> +
> +	/* If the current address or return address have changed, then
> +	 * the GPU has probably made progress and we should delay the
> +	 * reset.  This could fail if the GPU got in an infinite loop
> +	 * in the CL, but that is pretty unlikely outside of an i-g-t
> +	 * testcase.
> +	 */

In i915 we have a credit system that allows only a limited amount of
postponing the timeout. That would block the fairly easy DOS. Otoh I have
no idea how robust v3d is against DOS attacks at the ioctl level and
whether that's worth it.

From your description I'm assuming that a loop in the shaders won't trick
this, so ARB_robustness/WebGL should still be happy.

Anyway, Ack on the entire pile.
-Daniel
> +	if (job->timedout_ctca != ctca || job->timedout_ctra != ctra) {
> +		job->timedout_ctca = ctca;
> +		job->timedout_ctra = ctra;
> +
> +		schedule_delayed_work(&job->base.work_tdr,
> +				      job->base.sched->timeout);
> +		return;
> +	}
>  
>  	mutex_lock(&v3d->reset_lock);
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
