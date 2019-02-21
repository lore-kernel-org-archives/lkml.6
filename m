Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BF12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYu7+UJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfBUOnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:43:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45276 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfBUOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so14279127pls.12;
        Thu, 21 Feb 2019 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nz0WHoH41WI4V8H3ZG2qkDWrqBIjREO+Vld+w+Sj+cQ=;
        b=OYu7+UJjS1ccQCNT2/MCJIcNEldGKwBzg4MYB63a+z3qmPQ7A/9uM0WZvEGuobt3De
         9ln2kWXz3QD8gR+rYdQQ6/ByN9a8ZOa18NI3AbANrgmg8QDsd/JAhNS8dPwMNGBlS+eL
         9lg97rvtf8GJcU3y9bgLUgQVjtlTvnrGgc3fnFQpl2H0/Ms4aJMZ2e2SMjBNVXMK1+LY
         wor1IfwIH9rnHzcFeiWXlUQLfR7IVWQPz9+3lgkeFscIYT5IpvjP52AgI3u3PIqw/A8K
         /DcSHJZAox3gJ0hoPFFSpQ3J06Y1CqJJ+IjBMob8RagLCixfMB9njWcVilj7Kwuxre3/
         +6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=nz0WHoH41WI4V8H3ZG2qkDWrqBIjREO+Vld+w+Sj+cQ=;
        b=JDqRvXHy5QE22r/rp/H52Vrl1Mwvz+1iG2agms5Hdr8bOYqZVmetSbGEi5Wk1TfDXp
         OseCLuaYfax5UGiacwpnTGWWzPejTApg0cwf/Ov7ZnDfat3zWe9tsjtwZ+oTNo6nxVgl
         dwauTQd5Gjj0vF/8PVCJZhU1JhLh5R+PgfA3KIF2vRpXnT2TLcbA1RU9LVCot9f+0Q7G
         gcW2YmDwpDgcFocKBGRKmhNUnQChGwa4Bx4jdMjLtifnw9VoSgrWYYHRJnctBZZetkt0
         kXdNpHzJZnIn3+WyyUnyiBjmOFywx8+LyPo2MXJljskBSmHGDS4cFvoMoJPAE+ACFHwt
         ZvcA==
X-Gm-Message-State: AHQUAuZ0xcoW+oiyJFUdHUybrQdlyC3zqzhVM4x7AtfWPPYNN0NpBGnn
        zws2Dscgb7YSNNHrBMXpOH0=
X-Google-Smtp-Source: AHgI3Ia17aJP7gP68e/sz/6od9RL8fY8gz0OmdjLfJohz1SpVDCAD2a9cI1m4mkzeQpXy/t9QTPV6A==
X-Received: by 2002:a17:902:59c3:: with SMTP id d3mr32527138plj.214.1550760179397;
        Thu, 21 Feb 2019 06:42:59 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y133sm30647823pfb.107.2019.02.21.06.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 06:42:58 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:42:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpfilter: remove extra header search paths for
 bpfilter_umh
Message-ID: <20190221144257.GA12892@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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

This patch reintroduces the problem last fixed with commit ae40832e53c3
("bpfilter: fix a build err"). Seen (at least) with gcc 7.4.0, 8.2.0.
binutils version is 2.31.1. Reverting this patch fixes the problem.

Guenter

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  net/bpfilter/Makefile | 1 -
>  net/bpfilter/main.c   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> index 0947ee7f70d5..5d6c7760142d 100644
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
> index 1317f108df8a..61ce8454a88e 100644
> --- a/net/bpfilter/main.c
> +++ b/net/bpfilter/main.c
> @@ -6,7 +6,7 @@
>  #include <sys/socket.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> -#include "include/uapi/linux/bpf.h"
> +#include "../../include/uapi/linux/bpf.h"
>  #include <asm/unistd.h>
>  #include "msgfmt.h"
>  
> -- 
> 2.7.4
