Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5402C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F7520659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUUVoZk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F7520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeLELeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:34:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLELeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:34:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id u3so19291984wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YmHaGIPxY1tfpbD+zdd+RqND3LYS9/eZjfEx34T06uc=;
        b=NUUVoZk/GK+5WVQKYn5PxqGDlj6T63xPFTPUQF4Sky/SvP6+a4nzHSp5Uahf07QGHG
         GtaXYdfG+AT/c5mXRGcd1pwznJ9PTI3Yctv/L/EcPYsgElWyLDKEnGaqUpD/FuJ9o3oD
         AdX04txD7dnHDoGUsQf0RpPLFJhe6XR1oGsgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YmHaGIPxY1tfpbD+zdd+RqND3LYS9/eZjfEx34T06uc=;
        b=qubJKWUV83cKzmkE0fFnwkvQGOZgkBJ2fAiXX4c20yyRTvBj0NoCHeaLeVfUjIQaJc
         Hl8Sq5vg6NVBF/RygMFz3qxzeMx7pHtOyaJmf6IS+UD9UoBADN0Xj2mhmN5xAnyo2ytW
         MOk1a3psqTNK/Wg/cgyTGHAz6VvtfNUvT8+Mv5yjXnd5J4oUtByppVnlH8tFSs/dTJ/Q
         Z6dmiIKXvBvFRgOG4ow/ZYB31KC2w8hZSpeS/E1vcsOxuVApJqZZ6haNMUGTPrUwyf+3
         acbPLLgMRXtmaaWYjX7RFPxJmjGQgbB4AdFkMsw+7/KVIDeFWR16LDZz9t0JFB23kdhN
         Kljw==
X-Gm-Message-State: AA+aEWb32ODY6WvGGbQ5W50208ArPyEKj38UqnZy1hyOGFG45ZszWd9r
        foZmq/fA6m3wq8N8TPiDxkdOsA==
X-Google-Smtp-Source: AFSGD/XBgz2lxx+lv071fqnLPvC5KZ3hFtLz0NkCFfvWVIIc0KZmh2mBuuZp223HD3yT3JEUroDgBQ==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr22177497wrs.272.1544009649126;
        Wed, 05 Dec 2018 03:34:09 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id o64sm6388639wmo.47.2018.12.05.03.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 03:34:08 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:34:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>,
        tzungbi@chromium.org, rohitkr@codeaurora.org
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Message-ID: <20181205113406.GE26661@dell>
References: <20181127120041.90759-1-cychiang@chromium.org>
 <20181128093411.GC4272@dell>
 <20181203111919.GL26661@dell>
 <CAFv8NwLEQ7EUSTRfAf42w2BY0aEPi_pjcMkPzzCNb=17pfzQXw@mail.gmail.com>
 <CAFv8NwLZc7YmCbFi-4nCOG5GUwrRbc+JdXLBKv2JA8d6eC3SDg@mail.gmail.com>
 <20181205113045.GD26661@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205113045.GD26661@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018, Lee Jones wrote:

> On Wed, 05 Dec 2018, Cheng-yi Chiang wrote:
> 
> > Hi Lee,
> > 
> > I tried to apply this patch based on
> > for-mfd-next branch of mfd tree (
> > git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git )
> > Then, I tried to compile all modules by
> > 
> >  ARCH=x86_64 make allyesconfig
> >  ARCH=x86_64 make -j64
> > 
> > There was no error.
> > Could you please let me know what was the error when you failed to
> > apply this patch ?
> 
> Doesn't work for me.
> 
> lee@host:~/projects/kernel [for-mfd-next]$ formfdnext
> Applying: mfd: cros_ec: Add commands to control codec
> error: sha1 information is lacking or useless (include/linux/mfd/cros_ec_commands.h).
> error: could not build fake ancestor
> Patch failed at 0001 mfd: cros_ec: Add commands to control codec
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

Not that the following lines (as seen in your patch) are not present
in the Mainline kernel.

> @@ -4077,6 +4077,100 @@ struct __ec_align1 ec_response_i2c_passthru_protect {
>  	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
>  };

Do you have other patches applied to your tree?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
