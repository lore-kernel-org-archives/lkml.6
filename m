Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A50520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A50520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIOAGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:06:53 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:47513 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeIOAGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:06:53 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 045483C00C3;
        Fri, 14 Sep 2018 20:51:05 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2dmFelDm2gQ6; Fri, 14 Sep 2018 20:50:56 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 147043C00C2;
        Fri, 14 Sep 2018 20:50:56 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 14 Sep
 2018 20:50:55 +0200
Date:   Fri, 14 Sep 2018 20:50:51 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jia He <hejianet@gmail.com>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jia He <jia.he@hxt-semitech.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Andy Lowe <andy_lowe@mentor.com>,
        <linux-renesas-soc@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
Message-ID: <20180914185051.GA22530@vmlxhi-102.adit-jv.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
 <20180907144447.GD12788@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180907144447.GD12788@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Renesas people

Hello Will, hello Ard, 

On Fri, Sep 07, 2018 at 03:44:47PM +0100, Will Deacon wrote:
> On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
> > OK so we can summarize the benefits of this series as follows:
> > - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
> > - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
> > *milliseconds*
> > 
> > Google was not very helpful in figuring out what a Samurai CPU is and
> > why we should care about the boot time of Linux running on a virtual
> > model of it, and the 15 ms speedup is not that compelling either.
> > 
> > Apologies to Jia that it took 11 revisions to reach this conclusion,
> > but in /my/ opinion, tweaking the fragile memblock/pfn handling code
> > for this reason is totally unjustified, and we're better off
> > disregarding these patches.
> 
> Oh, we're talking about a *simulator* for the significant boot time
> improvement here? I didn't realise that, so I agree that the premise of
> this patch set looks pretty questionable given how much "fun" we've had
> with the memmap on arm and arm64.
> 
> Will

Similar to https://lkml.org/lkml/2018/1/24/420, my measurements show that
the boot time of R-Car H3-ES2.0 Salvator-X (having 4GiB RAM) is decreased
by ~135-140ms with this patch-set applied on top of v4.19-rc3.

I agree that in the Desktop realm you would barely perceive the 140ms
difference, but saving 140ms on the automotive SoC (designed for products
which must comply with 2s-to-rear-view-camera NHTSA US regulations) *is*
significant.

FWIW, cppcheck and `checkpatch --strict` report style issues for
patches #2 and #3. I hope these can be fixed and the review process
can go on? From functional standpoint, I did some dynamic testing on
H3-Salvator-X with UBSAN/KASAN=y and didn't observe any regressions, so:

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Best regards,
Eugeniu.
