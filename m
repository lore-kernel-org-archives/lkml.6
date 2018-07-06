Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EAEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B682241F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B682241F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeGFPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:23:48 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34335 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753638AbeGFPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:23:47 -0400
Received: by mail-ua0-f196.google.com with SMTP id r10-v6so7782811uao.1;
        Fri, 06 Jul 2018 08:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfF0oqJu8UQukSs/0/9IaSSIgQb23K9A7NNnmtNgim0=;
        b=O/dI/ETVjw03BcnyKISURLXQK0cR+EALDcPMJ5UAQuF1sjiaMRddq+FaG1jeS5hjLc
         69xQAkxj1dq/apjeAimafkFy5c4SvfDmfEc5q2glRVyW6ScFke1fPJPAB6iMFgYjEJV7
         ETn7x4lJr4CFuxOUFsDIWLRsFTfXfcICuwtAloWm/sNBALMB8iQC9metu+jtyb4wMg2f
         E/6WN6J/cZC3uEFbd0Nybo0edxFzkr1OKr0B0DdkdBztTAoKYJp9QfwsQKmHZFUAVuUA
         +iJqLGYnkCevBWwWl7bBAymTZPlQRnKai2rdN8iPVXnykQSBxXs/mY1kLQkw+lFT8bl/
         YkJg==
X-Gm-Message-State: APt69E0FH9oTrK/0lMr3QKZ3IOC668wyWYLKbXMXIuWR6XgFcIf867Tb
        EIM5mrC20GtYyp753/XIC9LnS5YGrQU0W+9mDq8=
X-Google-Smtp-Source: AAOMgpfe4t8JJtnXYBMi6ecRYIy8QwnupEG/9cgUGrv2GMHhyifHQKGQxGEKIvPgNXKNOCg4kN6gzQlAOcMAt8rw5JM=
X-Received: by 2002:ab0:1b6c:: with SMTP id n44-v6mr6387124uai.4.1530890626145;
 Fri, 06 Jul 2018 08:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180706151610.3783638-1-arnd@arndb.de>
In-Reply-To: <20180706151610.3783638-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jul 2018 17:23:35 +0200
Message-ID: <CAMuHMdXTF=Zfm7Dm1+_q6yhccQXYsPc=wQaHDBSsq4X7ujg4sQ@mail.gmail.com>
Subject: Re: [PATCH] soc: r9a06g032: don't build SMP fiiles for non-SMP config
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Jul 6, 2018 at 5:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Without CONFIG_SMP, we get a build failure:
>
> In file included from include/linux/byteorder/little_endian.h:5,
>                  from arch/arm/include/uapi/asm/byteorder.h:22,
>                  from include/asm-generic/bitops/le.h:6,
>                  from arch/arm/include/asm/bitops.h:342,
>                  from include/linux/bitops.h:18,
>                  from include/linux/kernel.h:11,
>                  from include/asm-generic/bug.h:18,
>                  from arch/arm/include/asm/bug.h:60,
>                  from include/linux/bug.h:5,
>                  from include/linux/io.h:23,
>                  from drivers/soc/renesas/r9a06g032-smp.c:11:
> drivers/soc/renesas/r9a06g032-smp.c: In function 'r9a06g032_smp_boot_secondary':
> drivers/soc/renesas/r9a06g032-smp.c:43:21: error: 'secondary_startup' undeclared (first use in this function)
>   writel(__pa_symbol(secondary_startup), cpu_bootaddr);
>                      ^~~~~~~~~~~~~~~~~
>
> This makes the compilation of that file conditional on SMP support.
> It would probably be better for consistency to leave that file
> in arch/arm/mach-shmobile/, matching what we do for all other smp
> operations.

Shouldn't that comment be moved below the "---"? ;-)

I thought the (10Y ;-) plan was to have no more code under arch/arm/mach-*/?
Note that the suport for the new RZ/N1D SoC doesn't use any other code in
mach-shmobile.

> Fixes: cde4f86f9249 ("arm: shmobile: Add the R9A06G032 SMP enabler driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
