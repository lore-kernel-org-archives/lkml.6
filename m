Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED902147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NpFLjnc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED902147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeGLUMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:12:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40289 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbeGLUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:12:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so22798699edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fAwgq7QivYAgvcdovXeBJWdfWW1SKzK+SP1JtfBcnes=;
        b=NpFLjnc7y0YntCQVOUHJHLe8bY+LvETloPkQqTJ9BzxhlF/Nebo+oQHRhmfL8jtgHB
         V2HRr4HDFT4Hi4hfmQLbKAkqCnHm020CQMRhc3bktKv02p38NUH9tYrmA2PIJ8mq2O6y
         pv1jBcW1OQPwdzfZgkBC1LxIxzsgiZTATe55o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fAwgq7QivYAgvcdovXeBJWdfWW1SKzK+SP1JtfBcnes=;
        b=atXz+t4xfzGdm8BTTgmSikeNtwrHpfhBH9c1iUb8rnNpMz04Boi6fe6E++81rO6UDs
         l//2Vp/JJYqXBSC+wtyMuxI4NLBtd2X7p5tmVrEL524XttXJs6V6kXiAFvr0vM2C6QRG
         k79R/eXDF9AWWuzVvwEGAiNEqZlarlEseSHqwV/xF7LbPqDcdjs9AJgsQw6WG2CW4C6A
         QJcefmLxCLKnwGRxHqluRbg6KTfFDwITJSqk8hTs9rWl/+NXO09Ipmo3MmmLuWdXppMI
         pqPe+GZDeIs77WWcCAO3Up9hDvzgV0Lkr/T/NebNgwddS51SwXwt6/E2+1ZwVfQ7D6be
         JxgQ==
X-Gm-Message-State: AOUpUlHXR8n0hycgLozb8/aVJmWO/vk6F7CfFO7WnDEdHPhH5okj+vsR
        sdf15v0Xms3Sqrxw8k4wEZXYuP44
X-Google-Smtp-Source: AAOMgpd0u+B+lc/uariRI4syTj42MQnO7hiLkP165Ok/FW6MJ0x0visy3vVuUPyECTShrNVuDX7erQ==
X-Received: by 2002:a50:fd0f:: with SMTP id i15-v6mr4173729eds.83.1531425693597;
        Thu, 12 Jul 2018 13:01:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id l89-v6sm2680706ede.13.2018.07.12.13.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:01:32 -0700 (PDT)
Date:   Thu, 12 Jul 2018 22:01:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/dp_helper: Add DP aux channel tracing
Message-ID: <20180712200131.GW3008@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20180712172419.790-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712172419.790-1-lyude@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:24:19PM -0400, Lyude Paul wrote:
> This is something we've needed for a very long time now, as it makes
> debugging issues with faulty MST hubs along with debugging issues
> regarding us interfacing with hubs correctly vastly easier to debug.
> Currently this can actually be done if you trace the i2c devices for DP
> using ftrace but that's significantly less useful for a couple of
> reasons:
> 
> - Tracing the i2c devices through ftrace means all of the traces are
>   going to contain a lot of "garbage" output that we're sending over the
>   i2c line. Most of this garbage comes from retrying transactions, DRM's
>   helper library adding extra transactions to work around bad hubs, etc.
> - Having a user set up ftrace so that they can provide debugging
>   information is a lot more difficult then being able to say "just boot
>   with drm.debug=0x100"
> - We can potentially expand upon this tracing in the future to print
>   debugging information in regards to other DP transactions like MST
>   sideband transactions
> 
> This is inspired by a patch Rob Clark sent to do this a long time back.
> Neither of us could find the patch however, so we both assumed it would
> probably just be easier to rewrite it anyway.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 34 ++++++++++++++++++++++++++++-----
>  drivers/gpu/drm/drm_drv.c       | 15 ++++++++-------
>  include/drm/drm_print.h         |  6 ++++++
>  3 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index a7ba602a43a8..6fa5a59aa17c 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -185,6 +185,21 @@ EXPORT_SYMBOL(drm_dp_bw_code_to_link_rate);
>  
>  #define AUX_RETRY_INTERVAL 500 /* us */
>  
> +static inline void
> +drm_dp_dump_access(const struct drm_dp_aux *aux,
> +		   u8 request, uint offset, void *buffer, int ret)
> +{
> +	const char *arrow = request == DP_AUX_NATIVE_READ ? "->" : "<-";
> +
> +	if (ret > 0)
> +		drm_dbg(DRM_UT_DP, "%s: 0x%08x AUX %s (ret=%3d) %*ph%s\n",
> +			aux->name, offset, arrow, ret, min(ret, 64),
> +			buffer, ret > 64 ? "..." : "");

Afaik dp spec limits transfers to 20 bytes max. We should probably update
the docs about this in drm_dp_aux_msg. i915 definitely throws a E2BIG at
you if you try something else.

Similar with addresses, they're only 20 bits afaiui. Again should probably
update the docs of drm_dp_aux_msg.

Otherwise lgtm and I guess we can figure out how to report i2c stuff at a
different time, or delegate that to the i2c core.

With the pretty printing adjusted to follow the dp limits:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

btw, want drm-misc commit rights for stuff like this? If yes just ask
seanpaul/mlankhorst/padovan on irc for ack and then poke daniels or
another fdo admin.

Cheers, Daniel

> +	else
> +		drm_dbg(DRM_UT_DP, "%s: 0x%08x AUX %s (ret=%3d)\n",
> +			aux->name, offset, arrow, ret);
> +}
> +
>  /**
>   * DOC: dp helpers
>   *
> @@ -288,10 +303,14 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
>  	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV, buffer,
>  				 1);
>  	if (ret != 1)
> -		return ret;
> +		goto out;
>  
> -	return drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, offset, buffer,
> -				  size);
> +	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, offset, buffer,
> +				 size);
> +
> +out:
> +	drm_dp_dump_access(aux, DP_AUX_NATIVE_READ, offset, buffer, ret);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_dp_dpcd_read);
>  
> @@ -312,8 +331,13 @@ EXPORT_SYMBOL(drm_dp_dpcd_read);
>  ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
>  			  void *buffer, size_t size)
>  {
> -	return drm_dp_dpcd_access(aux, DP_AUX_NATIVE_WRITE, offset, buffer,
> -				  size);
> +	int ret;
> +
> +
> +	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_WRITE, offset, buffer,
> +				 size);
> +	drm_dp_dump_access(aux, DP_AUX_NATIVE_WRITE, offset, buffer, ret);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_dp_dpcd_write);
>  
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 7af748ed1c58..e555eb5de275 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -53,13 +53,14 @@ MODULE_AUTHOR("Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl");
>  MODULE_DESCRIPTION("DRM shared core routines");
>  MODULE_LICENSE("GPL and additional rights");
>  MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
> -"\t\tBit 0 (0x01) will enable CORE messages (drm core code)\n"
> -"\t\tBit 1 (0x02) will enable DRIVER messages (drm controller code)\n"
> -"\t\tBit 2 (0x04) will enable KMS messages (modesetting code)\n"
> -"\t\tBit 3 (0x08) will enable PRIME messages (prime code)\n"
> -"\t\tBit 4 (0x10) will enable ATOMIC messages (atomic code)\n"
> -"\t\tBit 5 (0x20) will enable VBL messages (vblank code)\n"
> -"\t\tBit 7 (0x80) will enable LEASE messages (leasing code)");
> +"\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
> +"\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
> +"\t\tBit 2 (0x04)  will enable KMS messages (modesetting code)\n"
> +"\t\tBit 3 (0x08)  will enable PRIME messages (prime code)\n"
> +"\t\tBit 4 (0x10)  will enable ATOMIC messages (atomic code)\n"
> +"\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
> +"\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
> +"\t\tBit 8 (0x100) will enable DP messages (displayport code)");
>  module_param_named(debug, drm_debug, int, 0600);
>  
>  static DEFINE_SPINLOCK(drm_minor_lock);
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index e1a46e9991cc..767c90b654c5 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -195,6 +195,7 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
>  #define DRM_UT_VBL		0x20
>  #define DRM_UT_STATE		0x40
>  #define DRM_UT_LEASE		0x80
> +#define DRM_UT_DP		0x100
>  
>  __printf(3, 4)
>  void drm_dev_printk(const struct device *dev, const char *level,
> @@ -307,6 +308,11 @@ void drm_err(const char *format, ...);
>  #define DRM_DEBUG_LEASE(fmt, ...)					\
>  	drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
>  
> +#define	DRM_DEV_DEBUG_DP(dev, fmt, ...)					\
> +	drm_dev_dbg(dev, DRM_UT_DP, fmt, ## __VA_ARGS__)
> +#define DRM_DEBUG_DP(dev, fmt, ...)					\
> +	drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
> +
>  #define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, category, fmt, ...)	\
>  ({									\
>  	static DEFINE_RATELIMIT_STATE(_rs,				\
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
