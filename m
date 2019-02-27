Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7B8218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="LULeXagi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfB0Dh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:37:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36134 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfB0Dh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:37:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so7240812pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 19:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RohVq4bk3hD+d+lcDfCqs9wP1nmCmAOw6y3x+VzbeoM=;
        b=LULeXagikwvRNczIlgV8is8M/5t9TjJ556NKvdVrcFxdsZFDCLQos5vAaL/vi22rOG
         ZY1dAM8gFfpBtqhusmOXkI4KqXeCoh/SsaheplzbV4/tI7WwL36/WNEOSHLo5wNe6jJv
         utrh6TjTfrGLwngpA+2QgojFdPSyQZp7Jm3SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RohVq4bk3hD+d+lcDfCqs9wP1nmCmAOw6y3x+VzbeoM=;
        b=QTgbn8WNGfXIIfon4tSvzfOGHevExfhN/8D91KLNsWoNQJmwlVLptoVY3yA4E/hida
         NlB2EJFQGtOgbLwGQfU3OXjs/KrHLZ8fDKTYqtWbKXHBICaCPJ2QOP1eVIdRkWJqSeD7
         ziY4uuzkI2wUPrNVKo4lWEMI/XoGou9pJtLhivQ2A9/nD/zXKafts9aXZryGO/vj1OY1
         TnUDqs4o2EYNSnyEIi7eoLdFElXFMVdDZ7f/S+Cysm5iACzg4pF2uyLnvatXXZvnAywH
         VaJCKKtm97eBdnhuEvcuMFaS16iFP4kOt4/KL/AqBd8W/f50GwtQUotiFgMlPJgamIo0
         rqxw==
X-Gm-Message-State: AHQUAubtU21+cHV1ca5El+fFObe0Sd6eLPRdb99IIwThq8Vt6+C1axt/
        b9s6MCyekoZQ9xGTpR566BDrGQ==
X-Google-Smtp-Source: AHgI3IYewvpddpw0tBhHi3csYSbtpmZK4HjwqNKYW62ahfIllUELirdtKTH32eSPlfxgcdLao5xK7Q==
X-Received: by 2002:a63:1c02:: with SMTP id c2mr878392pgc.351.1551238646314;
        Tue, 26 Feb 2019 19:37:26 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
        by smtp.gmail.com with ESMTPSA id 10sm32339346pfq.146.2019.02.26.19.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 19:37:24 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Diana Craciun <diana.craciun@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/fsl: Fix the flush of branch predictor.
In-Reply-To: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
References: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
Date:   Wed, 27 Feb 2019 14:37:20 +1100
Message-ID: <878sy1aolr.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The commit identified below adds MC_BTB_FLUSH macro only when
> CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
> on some configs (seen several times with kisskb randconfig_defconfig)
>
> arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
> make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
> make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
> make[1]: *** [Makefile:1043: arch/powerpc] Error 2
> make: *** [Makefile:152: sub-make] Error 2
>
> This patch adds a blank definition of MC_BTB_FLUSH for other cases.
>
> Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/exceptions-64e.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4549ce8d4637..49381f32b374 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -338,6 +338,7 @@ ret_from_mc_except:
>  #define GEN_BTB_FLUSH
>  #define CRIT_BTB_FLUSH
>  #define DBG_BTB_FLUSH
> +#define MC_BTB_FLUSH
>  #define GDBELL_BTB_FLUSH

This seems correct to me:

 - MC_BTB_FLUSH gets a definition in the CONFIG_PPC_FSL_BOOK3E case.

 - other things that are defined in the FSL_BOOK3E case get empty
   definitions in the #else branch, but MC_BTB_FLUSH doesn't.

 - this patch just adds that empty definition.

 - there are no other definitions of MC_BTB_FLUSH that should be used
   instead.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

>  #endif
>  
> -- 
> 2.13.3
