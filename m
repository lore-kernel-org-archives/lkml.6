Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B8C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20392087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqatag9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfAEQFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:05:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35414 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAEQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:05:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so23193778qka.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 08:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DofsYHGlHReMdEjck/lc0c31k6QtolUTRKj3J6/OETU=;
        b=kqatag9Jn3wzz5RHgcpAWsulW5XfTUGkR/B1pNtmyDojwEzx5rIkiIIg/qLaxm77zv
         nKPfgjpOIosNHB7IY7K748m+XoVrpW4laoU2zbllNLH1qBHACkH7/ZL4EgRT/Mqmy4IW
         5U05/jvmBNY+oSbd/YqoBbFbBqRw9NU3Pj8kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DofsYHGlHReMdEjck/lc0c31k6QtolUTRKj3J6/OETU=;
        b=FMMFvrX/O5XJ2zSDsxLTFO9IS+N7O0Rq3vOZnFFT0TeGH4ZkkLx4OI5TLb80baKjl9
         1gusBU/CueXPp1L9eyCpmeND4aWorJ+AaDhaRCoeqBs4z+MdQqBorvxm+GgIqGO82fR/
         ZAeUBp6lfGxG86OfnpqhqWan+tBJ4Q3b0Wjtx/q+doCWHAW+63UZC6pK+0lytnHLDoPG
         S+J/gyLn87Kj3+8nvN95RAAyOA8G8iYLhU8qrj8Uf5TrNnYLsM3z+Nj1SaqHuPBfymMA
         gh4v3zLQEzTYUiU8CjXpNQNLjTxgSXoBLhANIVUKt7O/YadLXiXj5/XTKPpOxNRE0NCr
         XgvQ==
X-Gm-Message-State: AJcUukf/CP3BPBiSvk24PF1gFE+0L9dJFwYwUwpeQwj/P1PJq/KAF0qw
        jAL5plCTeaf1uZSmuR4C4B3Fzg==
X-Google-Smtp-Source: ALg8bN6BTLnd5jbcD82FI1pfk/Z5cUa8xhspCc2lJfNwXw4R/f/xIFojEa3s8aKT+aPsqGlSJg34tQ==
X-Received: by 2002:a37:5189:: with SMTP id f131mr50513248qkb.309.1546704332160;
        Sat, 05 Jan 2019 08:05:32 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id v2sm26664205qte.75.2019.01.05.08.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 08:05:30 -0800 (PST)
Date:   Sat, 5 Jan 2019 11:05:24 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] ARM: fix argument count to match macro
 definition
In-Reply-To: <591c1d362838b8a83e1fdfea37f7b48fd85dbf44.1546551693.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1901051104550.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch> <591c1d362838b8a83e1fdfea37f7b48fd85dbf44.1546551693.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Stefan Agner wrote:

> The macro str8w takes 10 arguments, abort being the 10th. In this
> particular instantiation the abort argument is passed as 11th
> argument leading to an error when using LLVM's integrated
> assembler:
>   <instantiation>:46:47: error: too many positional arguments
>     str8w r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
>                                                 ^
>   arch/arm/lib/copy_template.S:277:5: note: while in macro instantiation
>   18: forward_copy_shift pull=24 push=8
>       ^
> 
> The argument is not used in the macro hence this does not change
> code generation.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/lib/copy_template.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/lib/copy_template.S b/arch/arm/lib/copy_template.S
> index 652e4d98cd47..2d54491b0e22 100644
> --- a/arch/arm/lib/copy_template.S
> +++ b/arch/arm/lib/copy_template.S
> @@ -241,7 +241,7 @@
>  		orr	r9, r9, ip, lspush #\push
>  		mov	ip, ip, lspull #\pull
>  		orr	ip, ip, lr, lspush #\push
> -		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, , abort=19f
> +		str8w	r0, r3, r4, r5, r6, r7, r8, r9, ip, abort=19f
>  		bge	12b
>  	PLD(	cmn	r2, #96			)
>  	PLD(	bge	13b			)
> -- 
> 2.20.1
> 
> 
