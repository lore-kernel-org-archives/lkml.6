Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16047C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE392084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE392084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbeKFFxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:53:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38014 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:53:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id v83-v6so8719281oia.5;
        Mon, 05 Nov 2018 12:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Hq9PgAFFArsdakpURE96LBrL+CEHp4MbLqgjkh8kc8=;
        b=f6FDzoa2RyDtEEQGzBazszSULxC4wJtkSF9stsAdBGsXOyO41aH9D636YPIHvSyQ1i
         uJJGJGU1NZ2VsNwMsHZSHv+0wdv7Rx2Joaaj2YJ5Yt+ESVqDxLGRp+byNaySBh3QkIqN
         8p/ELKshDPwKR52kpxMJ4Z0ohH12539jJqg133i5PiFFa/YT9Xx1FZ2if96fOLeXzUUJ
         nStyukBt2ono1vzV5AGy0eJI1wgGczjHlROgqAIrB1+wvHwu/hS7FHu02yPFrOB674Wy
         9O53LrRWPMPxdFq2dilmO2Cs/X5dNPFIdWZnUY+LUBXRyCNdMRIHN+2yzDPttruTXsKB
         sctA==
X-Gm-Message-State: AGRZ1gI/QOnJGOjJg2WzbHwZr9AEyZnHgNwBgl54VWPAYrX5qtE5ze1n
        rhpQSqTD2OCO4pByhpwFpQ==
X-Google-Smtp-Source: AJdET5cApgGrgEWReqTaijraTrNB29c9j10GiVo6JDpD23KUa5x0umJhuM3Z4gvtKo91PWrS2uqykQ==
X-Received: by 2002:aca:c4cf:: with SMTP id u198-v6mr13014524oif.209.1541449901227;
        Mon, 05 Nov 2018 12:31:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s13sm2188639otc.40.2018.11.05.12.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:31:40 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:31:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, rppt@linux.ibm.com,
        linux@armlinux.org.uk, green.hu@gmail.com, deanbo422@gmail.com,
        gxt@pku.edu.cn, ard.biesheuvel@linaro.org,
        linux-snps-arc@lists.infradead.org, vgupta@synopsys.com
Subject: Re: [PATCH v3 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
Message-ID: <20181105203139.GA21852@bogus>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:28:37PM -0700, Florian Fainelli wrote:
> Hi all,
> 
> Changes in v3:
> 
> - use C conditionals in drivers/of/fdt.c
> - added check on phys_initrd_size in arch/arm64/mm/init.c to determine
>   whether initrd_start must be populated
> - fixed a build warning with ARC that was just missing an (unsigned
>   long) cast
> 
> Changes in v2:
> 
> - get rid of ARCH_HAS_PHYS_INITRD and instead define
>   phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c
> 
> - make __early_init_dt_declare_initrd() account for ARM64 specific
>   behavior with __va() when having CONFIG_DEBUG_VM enabled
> 
> - consolidate early_initrd() command line parsing into
>   init/do_mounts_initrd.c
> 
> Because phys_initrd_start/phys_initrd_size are now compiled in
> ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
> we need to be a bit careful about the uses throughout architecture
> specific code.
> 
> Previous discussions/submissions list here:
> 
> v3:
> https://www.spinics.net/lists/arm-kernel/msg683566.html
> v2:
> https://lkml.org/lkml/2018/10/25/4
> 
> Florian Fainelli (6):
>   nds32: Remove phys_initrd_start and phys_initrd_size
>   arch: Make phys_initrd_start and phys_initrd_size global variables
>   of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
>   arm64: Utilize phys_initrd_start/phys_initrd_size
>   of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
>   arch: Move initrd= parsing into do_mounts_initrd.c

This all looks good to me. I can take it via the DT if you want. I'll 
give folks some more time to review though.

Rob

> 
>  arch/arc/mm/init.c              | 25 +++++--------------------
>  arch/arm/mm/init.c              | 28 ++--------------------------
>  arch/arm64/include/asm/memory.h |  8 --------
>  arch/arm64/mm/init.c            | 33 +++++++--------------------------
>  arch/nds32/mm/init.c            |  2 --
>  arch/unicore32/mm/init.c        | 24 +++++-------------------
>  drivers/of/fdt.c                | 17 ++++++++++++-----
>  include/linux/initrd.h          |  3 +++
>  init/do_mounts_initrd.c         | 20 ++++++++++++++++++++
>  9 files changed, 54 insertions(+), 106 deletions(-)
> 
> -- 
> 2.17.1
> 
