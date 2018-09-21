Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ABECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71C020833
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71C020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbeIUUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:34:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:34:42 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2DD1FC3;
        Fri, 21 Sep 2018 14:45:29 +0000 (UTC)
Date:   Fri, 21 Sep 2018 16:45:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/bounds: Provide prototype for foo
Message-ID: <20180921144527.GB16316@kroah.com>
References: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180921142234.16882-1-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:22:33PM +0100, Kieran Bingham wrote:
> kernel/bounds.c is recompiled on every build, and shows the following
> warning when compiling with W=1:

Don't do that, you will get a lot of warnings that really don't make
much sense.  Like this one :)

> 
>   CC      kernel/bounds.s
> linux/kernel/bounds.c:16:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
>  void foo(void)
>       ^~~
> 
> Provide a prototype to satisfy the compiler.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: stable@vger.kernel.org
> 
> ---
> I compile all of my incremental builds with W=1, which allows me to know
> instantly if I add a new compiler warning in code I generate.
> 
> This warning always comes up and seems trivial to clean up.
> ---
>  kernel/bounds.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bounds.c b/kernel/bounds.c
> index c373e887c066..60136d937800 100644
> --- a/kernel/bounds.c
> +++ b/kernel/bounds.c
> @@ -13,6 +13,8 @@
>  #include <linux/log2.h>
>  #include <linux/spinlock_types.h>
>  
> +void foo(void);
> +
>  void foo(void)

This file is a userspace tool that is used to later generate the
include/generated/bounds.h file.

If you really want to track this down and fix it properly, put the
prototype in the .c file that ends up calling this function.  That's a
fun task to dig through the build system to find :)

good luck!

greg k-h
