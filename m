Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07332C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B89208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="W1ez3wtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B89208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755289AbeFRQHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:07:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53547 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeFRQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:07:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so14987250wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NnaW0rtbWHGoQLrkYxMBTwU30bx/UShD/Uk0hY8cqmg=;
        b=W1ez3wtLmogV5TXjM5rOs+FyE9Jwp9NSgRVcCU7gBDxblb3vJNrUXSjvG2cxSoR9GI
         JEJCQ1Cf7bG4GbhGPVkoJycf3Mhjbh8JKpEJQ6ZLcnY0qm2zGrKGaK46+ZKC1RNqbNkx
         0gr7QAoI8fpCGpw8olLAfGLskXvtz2tdaO6MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NnaW0rtbWHGoQLrkYxMBTwU30bx/UShD/Uk0hY8cqmg=;
        b=NtGIImbeXOIMar8E9s+8LLUdGDH+bQHApXGwu/Qwmz8iKhyz1PalFOMTjucCBMsnCG
         mI2xAbFM7X0n9rqsr8ht/7O59EpTWvsxxcc7KI87BHUZ9WV1n65gxb7qAnAFIiJfTWdH
         1oRLtDv6jnt+Escng/CRwGptNr8YuRtxr+wreXpx2T6hkL+JxEbgiQ9mL/xf0Z33NdtL
         l4SfyHsItXV//pUDwmw2/ON4Eso4KrBDZbbPTjDkwRfBDu92CJeQu7DM10NCFXnDXhus
         PzZROjWl54CihWr8Zx38ieQ2mPMZyzLWUPOJBgTkn2+6xdgYgrE5Uc6qRFClTTe5scQc
         fZLw==
X-Gm-Message-State: APt69E2eeYcVubJs6OxhxHidttZdmzKBk+M02Ppvck21HbSntturoom+
        WsI1hHOKplC2Kt3wW8a+7PT8uA==
X-Google-Smtp-Source: ADUXVKKIJb6+tIhxSwWjvsb6BmlQNW7JrprDm8gI93opakCl2qDSOJNf8kCRTaJc9J5P7SVq/WvorA==
X-Received: by 2002:a50:cd96:: with SMTP id p22-v6mr11527418edi.159.1529338058259;
        Mon, 18 Jun 2018 09:07:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:d0c7:bcda:eea:9e5d])
        by smtp.gmail.com with ESMTPSA id d7-v6sm4739199edi.79.2018.06.18.09.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 09:07:37 -0700 (PDT)
Date:   Mon, 18 Jun 2018 18:07:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, y2038@lists.linaro.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] i915: remove timespec_to_jiffies_timeout
Message-ID: <20180618160735.GL22478@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, y2038@lists.linaro.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180618153855.2126048-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618153855.2126048-1-arnd@arndb.de>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 05:38:43PM +0200, Arnd Bergmann wrote:
> This function has been unused since commit 5ed0bdf21a85 ("drm: i915:
> Use nsec based interfaces"). Let's remove the definition as well now
> to help get rid of all uses of 'timespec'.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks for the patch.
-Daniel

> ---
>  drivers/gpu/drm/i915/i915_drv.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 34c125e2d90c..5f61676e8fb8 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -3673,14 +3673,6 @@ static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
>          return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(n) + 1);
>  }
>  
> -static inline unsigned long
> -timespec_to_jiffies_timeout(const struct timespec *value)
> -{
> -	unsigned long j = timespec_to_jiffies(value);
> -
> -	return min_t(unsigned long, MAX_JIFFY_OFFSET, j + 1);
> -}
> -
>  /*
>   * If you need to wait X milliseconds between events A and B, but event B
>   * doesn't happen exactly after event A, you record the timestamp (jiffies) of
> -- 
> 2.9.0
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
