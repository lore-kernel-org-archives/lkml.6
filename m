Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB45C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790FC2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbDKymrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790FC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeJXCRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:17:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJXCRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:17:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so2674788wrw.11;
        Tue, 23 Oct 2018 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rsr6kWFxshtSDKTHDJjgUMqmFn0X+KJfful3PMnADA=;
        b=fbDKymrIJNgFiazDqxdV+MGl4cGUBnO3RfvkTr7J2dAnpXOXMRBBcVsmuyWdemBi6x
         XWqrJnE2OWNBOny0nxFVEG35+sP2Vi8FpOHIvwbF+Tlp/GAeGe4RQ9qWmbgNyVL845mZ
         AvT7+AYWjQPWXm3aF3gMJS7dx0zCiv90nbHEKPXwi+z4vwdDOnzkFRfNayq5sZ0uUV4P
         Nft4VW81/ik2QWY2PeDrRQZD8AhVdHmEm1CA8zdIW5Ed705YBi18zczuGLyGGR09mGjo
         9xQiE/2RICG4BkbgJaFCdR+glhmRRU7qv0COMd9ffqGSpGWxl65kW/8yDynhdTg6NKkw
         N1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rsr6kWFxshtSDKTHDJjgUMqmFn0X+KJfful3PMnADA=;
        b=GK9i+WhnmHQmV+kvkJJT64aVKkaclid/OFLEe7jH/hyBQXb80uW61wuEDTBfYvA1Zc
         tdNHofy2AdQcEpOYXruUvlMggaqvCA5FuS/gGMt7V72RBuhDbToyWucUuz8nMCdZ3WP3
         /YeiMGXMrdWfeIRUhH0JCmWUYDvBrYhIEJ7R8ppNfWFDuIT7iEuHMciQqnW9tssHHMxC
         9g/hf+FKhqn9ZH3Nqvbg54P3yzzfxQsgB0eZK+RM3Hf4vfIOgaXABJG2i3IUdXahyfp1
         7wDW9EOhrlfARYxLekBLuHwwtp2L6FKA6PruykGKB+ApfJn4KLSR935nKOWNckPJvpXR
         YSPg==
X-Gm-Message-State: ABuFfogWWLRPOqTBqmuDY+cet5vls2LzD1DxMDpCQxTMH2AFguszEsDH
        MjzuKRDBUxj8YO6euBpePX0=
X-Google-Smtp-Source: ACcGV61oYV5VkYqnA5HZ95sWNWsOTuN2WZYaPvmEfOZcyHe9NcUKF0Xwt+Mnl5fWbtGCWmDZKU1HOg==
X-Received: by 2002:a5d:52ce:: with SMTP id r14-v6mr50030642wrv.123.1540317191925;
        Tue, 23 Oct 2018 10:53:11 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x8-v6sm4005152wrd.54.2018.10.23.10.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 10:53:11 -0700 (PDT)
Date:   Tue, 23 Oct 2018 10:53:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
Message-ID: <20181023175309.GA3384@flashbox>
References: <20181013010348.6740-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013010348.6740-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 06:03:49PM -0700, Nathan Chancellor wrote:
> When building the kernel with Clang, some disabled warnings appear
> because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
> this list so that the build is clean again.
> 
> -Wpointer-sign was disabled for the whole kernel before the beginning
> of git history.
> 
> -Waddress-of-packed-member was disabled for the whole kernel in
> commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
> warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
> Disable the address-of-packed-member compiler warning").
> 
> -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
> LLVMLinux: Add Kbuild support for building kernel with Clang") and for
> x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
> warnings about GNU extensions").
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/112
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
> and suggested potentially rewriting the x86 portion of this Makefile to
> behave like the arm/arm64 one where problematic flags are filtered out.
> While that comes to fruition, it would be nice for this folder to behave
> like the rest of the kernel when it comes to this warnings so that the
> build is cleaner, thus this patch.
> 
>  drivers/firmware/efi/libstub/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index c51627660dbb..d9845099635e 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)		:= -march=i386
>  cflags-$(CONFIG_X86_64)		:= -mcmodel=small
>  cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
>  				   -fPIC -fno-strict-aliasing -mno-red-zone \
> -				   -mno-mmx -mno-sse -fshort-wchar
> +				   -mno-mmx -mno-sse -fshort-wchar \
> +				   -Wno-pointer-sign \
> +				   $(call cc-disable-warning, address-of-packed-member) \
> +				   $(call cc-disable-warning, gnu)
>  
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> -- 
> 2.19.1
> 

+ Sedat for review/testing.
