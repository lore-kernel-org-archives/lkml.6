Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02992214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBNd+Hy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfBAX72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:59:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39306 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBAX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:59:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so4010605pld.6;
        Fri, 01 Feb 2019 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OUcN6UkiqSgM9ZcXrDck3yg1kJA2QiHQnQx3w4vvZi4=;
        b=eBNd+Hy6kj03BXH2ccvXv6T+XdOBppmLIsjZaJTScNybIR9sdgtEicYGBisNCW1scN
         WiGFxknRSweBaK1ayZVdXO8ZsY+nHCB9S6NrVekT2OdLJhmIsd2HWhhiRifnFCIZPZpc
         JfiidYv9S2Edwuo7nP66KmD1gpYDmX0e9pHFX1Z7JJnbE8XjR0Rx7e4lBgS6/GON8vGx
         YajcGHUt74xSb/1QPyhk8Cuqu1d0AlUMgMdb1beJ4JRMPt+NfJlUJVAkSmWIjFvXWghv
         1y2FtadBXmOhOictb4a3VA1rA+Q0EWSQPdEQSsA9UBDLcVgVlfeSkl9SPVZsWTijSnhR
         JElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OUcN6UkiqSgM9ZcXrDck3yg1kJA2QiHQnQx3w4vvZi4=;
        b=KnFyqp8mUmnGSxaEevOu00XRR5VgJ4x/gO0uhwe1gzUbOrAXopp0SE0aZzP15giQ3K
         fcnlYECjHipPuHWKS98aR3YxQPJ63Haoqyk2yjaXtcnVkW65U47HVvXnbfwWle8m9Ow0
         lswKCtUxPfc+OtdTOho69ezZ/rAUdZmfddqIah8XvJkOu3a2t9eMIzGxrXzljOXli+Xg
         rYO40b0WTTQwvatJVBtbcZXbXddwROXzBbwF1dzbTay5N+z3dfoaA79Ppw9y5jKZArXx
         ke5F6cBUsXQaJzgP/aggp+BWJ5ofxHzUrANlDkLJQrTpCkXqTqQAZqDxuGPAlO6R3UX4
         10vw==
X-Gm-Message-State: AJcUukcqILTqvq17nq3hgtmwHvdEWDkNRZZL5nxoC8Kf1jeawtDgPHoW
        ch79zKtRUviAtcHl0gVXo3g=
X-Google-Smtp-Source: ALg8bN70HbBuuNJ2YZwIvtyH8sjwcbf4DdNwW/iISFv59S+OIeynE27S/WotuVlg7/I7gCHQQJzZ2Q==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr41784732pld.236.1549065566761;
        Fri, 01 Feb 2019 15:59:26 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::5:85d3])
        by smtp.gmail.com with ESMTPSA id w3sm11176760pge.8.2019.02.01.15.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 15:59:26 -0800 (PST)
Date:   Fri, 1 Feb 2019 15:59:24 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        Matteo Croce <mcroce@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Laura Abbott <labbott@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] bpfilter: remove extra header search paths for
 bpfilter_umh
Message-ID: <20190201235852.l7tlw5jkcpkwivsd@ast-mbp>
References: <1548904535-9853-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548904535-9853-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:15:35PM +0900, Masahiro Yamada wrote:
> Currently, the header search paths -Itools/include and
> -Itools/include/uapi are not used. Let's drop the unused code.
> 
> We can remove -I. too by fixing up one C file.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Perhaps, are these extra header search paths for
> more upstreaming in the future?
> 
> If this patch is rejected, I will send an alternative one.
> 
> To clean up the Kbuild core,
> I want to drop as many unused header search paths as possible.
> 
> 
>  net/bpfilter/Makefile | 1 -
>  net/bpfilter/main.c   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index 0947ee7..5d6c776 100644
> --- a/net/bpfilter/Makefile
> +++ b/net/bpfilter/Makefile
> @@ -5,7 +5,6 @@
>  
>  hostprogs-y := bpfilter_umh
>  bpfilter_umh-objs := main.o
> -KBUILD_HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
>  HOSTCC := $(CC)
>  
>  ifeq ($(CONFIG_BPFILTER_UMH), y)
> diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> index 1317f10..61ce845 100644
> --- a/net/bpfilter/main.c
> +++ b/net/bpfilter/main.c
> @@ -6,7 +6,7 @@
>  #include <sys/socket.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> -#include "include/uapi/linux/bpf.h"
> +#include "../../include/uapi/linux/bpf.h"

argh. that's not pretty.
I would prefer to keep -I in a makefile

