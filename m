Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E93321527
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="geACDdyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E93321527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbeHPMaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:30:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeHPMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:30:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so962092wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HuTfP9BMmzMFsrSla6nm+FKruglPuVH/SWNeJAqBHdU=;
        b=geACDdyDVBFn6xiHie7nofeKG8RJTv6ugrNkAole6q/FaCCt06nWnLrb2JPn79AYWi
         uPjkBCDZJ7j+15tLFSP/ye0ASseoXP+3c3Hb5c6cdlKTpCroAAspEvFj5vSWsvBJ7Zwr
         XxiUhJvxXIjOaysx2eEcHOfpe0TeS1EvoixMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HuTfP9BMmzMFsrSla6nm+FKruglPuVH/SWNeJAqBHdU=;
        b=UMD+WCaIVrUOtJem66mWJyAYwaHcze7Z7Pt2fRXd0ZTYU7ZiTw3acFgrjrLh1X8xHy
         J7kz0fm6Ka9bgp3wjAbCBZUbjia0khkvCBv8pDDHGBd+fIG72/s7ozLcZJK8/kH7gbIA
         EsslJ37fndRuZstQWVFg5/bh6/8Hpd8wFIdjniAYeGJYwGMhIn7TjawOAJNgAn75zy6i
         ncy29sRWl2+1GkOOHYabhm6p2hgchBfs9TnSBRROTANoRviOlPTKzH9gN+93+L19IRhY
         34m90HjyR2notnzE/u1f4szM2OzHYykpnL0Kl2sfCxbyP3rPXng1uPphHsC8f6enV6ha
         Bp2g==
X-Gm-Message-State: AOUpUlEQWb/p+rLY6/z79IOAIuQoDjPXFY1Pre8E6kBbWggz0VOXZsiM
        ZbBdTHmF7q/NQHgJEdy0ETk6jw==
X-Google-Smtp-Source: AA+uWPyk6DWUJksBbJwL+qVYGljGBiCMZiJnGwvUNuGnkKmxT+jHeIWz3oPc1LT93rONWQ3TqhmwJQ==
X-Received: by 2002:adf:9404:: with SMTP id 4-v6mr211661wrq.129.1534411974934;
        Thu, 16 Aug 2018 02:32:54 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id w9-v6sm35411582wrk.28.2018.08.16.02.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:32:53 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:32:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: kdb_main: refactor code in kdb_md_line
Message-ID: <20180816093251.jc5tvmzqrpgtyqms@holly.lan>
References: <20180815150616.GA31173@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815150616.GA31173@embeddedor.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:06:16AM -0500, Gustavo A. R. Silva wrote:
> Replace the whole switch statement with a for loop.
> This makes the code much clear and easy to read.
> 
> This also addresses the following Coverity warnings:
> 
> Addresses-Coverity-ID: 115090 ("Missing break in switch")
> Addresses-Coverity-ID: 115091 ("Missing break in switch")
> Addresses-Coverity-ID: 114700 ("Missing break in switch")
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/debug/kdb/kdb_main.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 2ddfce8..4b896a6 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1538,25 +1538,9 @@ static void kdb_md_line(const char *fmtstr, unsigned long addr,
>  			wc.word = word;
>  #define printable_char(c) \
>  	({unsigned char __c = c; isascii(__c) && isprint(__c) ? __c : '.'; })
> -			switch (bytesperword) {
> -			case 8:
> +			for (i = 0; i < bytesperword; i++)

i already a control variable for the outer loop. It is not safe to reuse
it here.


Daniel.

>  				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				addr += 4;
> -			case 4:
> -				*c++ = printable_char(*cp++);
> -				*c++ = printable_char(*cp++);
> -				addr += 2;
> -			case 2:
> -				*c++ = printable_char(*cp++);
> -				addr++;
> -			case 1:
> -				*c++ = printable_char(*cp++);
> -				addr++;
> -				break;
> -			}
> +			addr += bytesperword;
>  #undef printable_char
>  		}
>  	}
> -- 
> 2.7.4
> 
