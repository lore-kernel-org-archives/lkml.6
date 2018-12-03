Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050B20661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8S90ZEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3050B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeLCQ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLCQ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:27:20 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92C0214DE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543854438;
        bh=qCSsx1ia05y4ES7b0cDduOEngAtMGWrVXunqUEXapJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8S90ZElQ9LfdNGJaukJN5Jwd534aDEzQWDypy4rb5LsZaImTJAeI5g720pRhkL3G
         TpbrScmX2nyywTRCPm8X7PlLFFg9qW1QaWoFAHH8FLYTyAvOgu7nzhZCX5XdFqt2mc
         bgkc0VAiaktGIWz21qPe4c3BzTqxnJqqe/Bm+aFc=
Received: by mail-wr1-f45.google.com with SMTP id q18so12829838wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:27:17 -0800 (PST)
X-Gm-Message-State: AA+aEWaMofl5X4gXmHMtDP6K6y75Lzgs2Vo7eLWgkN25y1z7lnyPyeRa
        mZNLBEmUaO2gUItMXgJfa4YbA24t+4W7P3Kr9RLolQ==
X-Google-Smtp-Source: AFSGD/UHg+Rgy6nW0S+kGUDaigts9RFTTI9lSVLk1wtwr1sI5Gf+vkTtl0wYMNx7Mjr/fOrUtrY7vaCYLjg7KDPVzq8=
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr15531587wrf.164.1543854434387;
 Mon, 03 Dec 2018 08:27:14 -0800 (PST)
MIME-Version: 1.0
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com> <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 Dec 2018 10:27:02 -0600
X-Gmail-Original-Message-ID: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Message-ID: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
To:     rppt@linux.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        davem@davemloft.net, gxt@pku.edu.cn,
        Greentime Hu <green.hu@gmail.com>, jonas@southpole.se,
        Michael Ellerman <mpe@ellerman.id.au>, mhocko@suse.com,
        Michal Simek <monstr@monstr.eu>, msalter@redhat.com,
        Paul Mackerras <paulus@samba.org>, dalias@libc.org,
        linux@armlinux.org.uk, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, deanbo422@gmail.com, ysato@users.sourceforge.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> oneliner wrappers for memblock_alloc.
>
> Replace their usage with direct call to memblock_alloc.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm/mm/mmu.c       | 11 +++--------
>  arch/unicore32/mm/mmu.c | 12 ++++--------
>  2 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 0a04c9a5..57de0dd 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>
>  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
>
> -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> -{
> -       return memblock_alloc(sz, align);
> -}
> -
>  static void __init *early_alloc(unsigned long sz)

Why not get rid of this wrapper like you do on unicore?

>  {
> -       return early_alloc_aligned(sz, sz);
> +       return memblock_alloc(sz, sz);
>  }
