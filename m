Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430F7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EDF20866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 22:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeL2Wpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 17:45:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36569 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeL2Wpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 17:45:53 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so14255887qkf.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 14:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cipite4SASv4S47KCGjGODYzIep4IrLd8iZmBANvLtM=;
        b=Y7rUWrW64W9sH4M9hSfuGS2oKipXDsVjL/1A/o0eG7z5x7UfdY3xtJ8HMyOhOvWFG9
         v9iEBn4ShEBnJ6pJ9YsuzDM9IMvvll4z1zWfMGCFUwW3/GFcD+JMo8imRGHNxrCSQmy4
         HprEwV3GbsGba088pDFRilhb3G59Po6vpGw3o8sdWcvY7VPmKdObQURvZh2i7s4zPaUy
         aiR5ykLcmRwk/p6rMoEbT4EhhqHMLURx/3d8+41+5fJX5J0rRwSouHKTYL+5eijB2lx9
         UJtg+dUSnnAiQJA4IN4t3Ownuy0QAH5UyZdIfu0/3h09AA9bfne6/MaTUsSEw6ZU8cYR
         1OPw==
X-Gm-Message-State: AJcUukf9sndDHZNPEf7c2EJIAYsv8VZfC5VM9kO2V6D3YZHv1sXIn1pj
        /aI6zjKp/f36pFZemRQtzy66BGGfOLGTSq9LT2I=
X-Google-Smtp-Source: ALg8bN7Qa7hr2XNmtq4+tGYa+nhueZodgl0jMtR5EIShVYb6Jn/qFpQpxOm30S4ounHRU2fY5CS5KtIHH+PSevPuUIo=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr29881024qke.173.1546123552154;
 Sat, 29 Dec 2018 14:45:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 Dec 2018 23:45:36 +0100
Message-ID: <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> This allows for removal of drivers/char/generic_nvram.c as well as some
> duplicated code in arch/powerpc/kernel/nvram_64.c. By reducing the number
> of /dev/nvram char misc device implementations, the number of bugs and
> inconsistencies is also reduced.
>
> This patch series reduces inconsistencies between PPC32 and PPC64, and
> between PPC_PMAC and MAC. A uniform API has benefits for userspace.
> For example, some error codes for some ioctl calls become consistent
> across PowerPC platforms. The uniform API can potentially benefit
> bootloaders that work across different platforms which all have XPRAM
> (e.g. Emile).
>
> I think there are two reasonable merge strategies for this patch series.
> The char misc maintainer could take the entire series. Alternatively the
> m68k maintainer could take patches 1 thru 14, and after those patches
> reach mainline the powerpc maintainer could take 15 thru 25 (even though
> patch 21 is not powerpc-related).

I had a look at the complete series now, and I think this is a great cleanup.
I replied with a couple of minor comments that you may or may not want
to address first.

The one thing I would like to see resolved (I hope this doesn't bring
back an old discussion you had already concluded) is regarding
the use of a global exported structure of function pointers, as opposed
to using either directly exported functions (with a consistent interface)
or a boot-time selectable structure like dma_map_ops or ppc_md.

    Arnd
