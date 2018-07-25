Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7F3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA3020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LK5Buoeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA3020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeGYGcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:32:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55866 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeGYGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:32:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so4636153wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xmBehj3++Bf8c4xWsg0sQCIbto8gy5/8bznLBjD7bGA=;
        b=LK5Buoeq8MfNoN1zA1HDDClT4syg0kntB7Z0ip9xU1/XT6cBMof8KClc4tKWDa25v0
         kTZnh4Hy8P6luCKuaphAVZ876J+7go3gYCy1py9IiMZkVZnI5Blg7ErbUxx3DYrhbUCE
         Bcfwq4wpdMR85wAO9cfg4TUH5D8xPKfJ7vqpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xmBehj3++Bf8c4xWsg0sQCIbto8gy5/8bznLBjD7bGA=;
        b=F3W/tr17/aW6ZZncoj2lRMvdGoE34Pp5q700DfKMf2qt86xik3dUOgjLU89KRMj+rJ
         4Nn9DkiGCFQT8rv2fMhvlh9Et3KIv5T6Ru7jZvbfjX7lqQYDywWgK5ouSw25aXIDSF+T
         kUN7tKM3VWiEChEjbc+0Fy1OhJph+ummrz6O/xbQAImfD7oeBYEdJMP6YFybaqoml565
         H2pgn6CdfOObxKz48teAoabRIs1C9TFp+rfXx8eqrHru7JouJigEgHM3lJF61WftGboI
         8r14b/OMaRmDmQXY0WIkA/zEatWYmx/Gf9sXQ+1QG2RO0eqzVDLyBYvhQ7FBFffIAdmn
         JCYg==
X-Gm-Message-State: AOUpUlElmSWCcI1ByMuQGYHk781QxjjxGHY/cR3pJdb6cOCKcXjdjlXN
        qVuLxGaepST5p2CVLotcExyL/Q==
X-Google-Smtp-Source: AAOMgpeJ/o/H0/j7s1ZQL4xJEkXoiFfKOpXHAvYfcGfPFH+QMLgI3kmTh4AXVPvG/OByaIu2yYS5kw==
X-Received: by 2002:a1c:7d47:: with SMTP id y68-v6mr3402088wmc.62.1532496133806;
        Tue, 24 Jul 2018 22:22:13 -0700 (PDT)
Received: from dell ([95.149.164.105])
        by smtp.gmail.com with ESMTPSA id t186-v6sm825443wmf.14.2018.07.24.22.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 22:22:12 -0700 (PDT)
Date:   Wed, 25 Jul 2018 06:22:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix uninitialized variable
Message-ID: <20180725052211.GA5835@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180724071223.18901-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724071223.18901-1-daniel.thompson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Daniel Thompson wrote:

> Currently, if the DT does not define num-interpolated-steps then
> num_steps is undefined and the interpolation code will deploy randomly.
> Fix with a simple initialize to zero.
> 
> Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
> brightness-levels")
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
> Notes:
>     v3:
>      - Switch to the simplest fix and zero the uninitialized variable. git
>        grep indicates that ~25% of calls to of_property_read_u32() use this
>        pattern (pre-initialize optional properties with sane values and
>        ignore the return code).
>     
>     v2:
>      - Simplify SoB chain (with Marcel's permission)
>      - Separate complex if statement and make other similar calls use same
>        return code checking approach
>      - Tidy up comment formatting and fix pre-existing grammar error
> 
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Once the 'Fixes:' line has been repaired:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
