Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C898ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D340208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BItbCi6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D340208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPRgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:36:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WCGa7c1t0EyEXbit66J/dj0OIeOylXFor/XL/ys8KUc=; b=BItbCi6Uhc2lmcK2Gracg2SL+C
        PCKRS3qPAbleCTB16hkhNqKaow7p0eGAvdW2S4XeKOkl7DDygILla4rBVV0gwPjLJZLdBpCWtaLPh
        D01wEnaa8phtXoUtEZIpnsGsn2ZQnko/W1XjKcFKw5wqtKE2zP5BxNYjWY/no7UAZDwxJnWXopNWr
        XjwgFx+9lg4A7vlYBsLLzMAWyHUfsy71aXjGf4nf9WQnmb5s7sUA7uzXqz7UsQLiUuttDqWBl9D2Q
        H2op6uN3QcP9uGaHSlrkoWaGhSC+OheP0u0yVYxtpjBehx0kxwUPQxku/OgzQcdYEfWFv8dNBZiOO
        i+QFJipg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff6yy-0003SN-4S; Mon, 16 Jul 2018 17:08:20 +0000
Subject: Re: [PATCH] [RFC] initrd/initramfs: extracted common code to
 init_rootfs.c file
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1531728723-11992-1-git-send-email-vvavrychuk@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7464d5bb-504a-20e8-ea42-821297efe502@infradead.org>
Date:   Mon, 16 Jul 2018 10:08:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531728723-11992-1-git-send-email-vvavrychuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 01:12 AM, Vasyl Vavrychuk wrote:
> Extracted from initramfs to common place code that sits on top of
> iniramfs and initrd and initializes one or another depending on
> configuration.
> 
> Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>

Just nits here...

> ---
>  init/Makefile           |   5 +-
>  init/default_rootfs.c   |  52 ++++++++++++++++
>  init/do_mounts_initrd.c |   2 -
>  init/init_rootfs.c      | 162 ++++++++++++++++++++++++++++++++++++++++++++++++
>  init/initramfs.c        | 156 +---------------------------------------------
>  init/initramfs.h        |   4 ++
>  init/noinitramfs.c      |  52 ----------------
>  7 files changed, 222 insertions(+), 211 deletions(-)

Does this change save us anything?  More source code.  How about
object code?


>  create mode 100644 init/default_rootfs.c
>  create mode 100644 init/init_rootfs.c
>  create mode 100644 init/initramfs.h
>  delete mode 100644 init/noinitramfs.c
> 

> diff --git a/init/default_rootfs.c b/init/default_rootfs.c
> new file mode 100644
> index 0000000..f4bad84
> --- /dev/null
> +++ b/init/default_rootfs.c
> @@ -0,0 +1,52 @@
> +/*
> + * init/noinitramfs.c

wrong source file name.


> diff --git a/init/initramfs.h b/init/initramfs.h
> new file mode 100644
> index 0000000..3ecad6f
> --- /dev/null
> +++ b/init/initramfs.h
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/init.h>
> +
> +char * __init initramfs_unpack_to_rootfs(char *buf, unsigned long len);

Unfortunately, the format for SPDX identifiers in C header files is thus:

/* SPDX-License-Identifier: <SPDX License Expression> */

according to Documentation/process/license-rules.rst.


thanks,
-- 
~Randy
