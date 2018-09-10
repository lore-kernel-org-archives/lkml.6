Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCADDC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78002206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78002206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeIJSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:00:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57216 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeIJSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:00:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E7780D;
        Mon, 10 Sep 2018 06:06:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 571893F575;
        Mon, 10 Sep 2018 06:06:15 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8B1D31AE33B8; Mon, 10 Sep 2018 14:06:31 +0100 (BST)
Date:   Mon, 10 Sep 2018 14:06:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: lib: use C string functions with KASAN enabled.
Message-ID: <20180910130631.GB24619@arm.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
 <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
 <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
 <20180910125303.dlysg3jba4wv7bhg@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910125303.dlysg3jba4wv7bhg@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 01:53:03PM +0100, Mark Rutland wrote:
> On Mon, Sep 10, 2018 at 12:33:22PM +0100, Mark Rutland wrote:
> > On Fri, Sep 07, 2018 at 06:48:10PM +0300, Andrey Ryabinin wrote:
> > > On 09/07/2018 05:56 PM, Will Deacon wrote:
> > > > I don't understand this bit: efistub uses the __pi_ prefixed
> > > > versions of the routines, so why do we need to declare them as weak?
> > > 
> > > Weak needed because we can't have two non-weak functions with the same
> > > name.
> > > 
> > > Alternative approach would be to never use e.g. "strlen" name for asm
> > > implementation of strlen() under CONFIG_KASAN=y.  But that would
> > > require adding some special ENDPIPROC_KASAN() macro since we want
> > > __pi_strlen() to point to the asm_strlen().
> > 
> > Somehow, what we have today works with CONFIG_FORTIFY_SOURCE, which
> > AFAICT would suffer from texactly the same problem with things like
> > memcpy.
> > 
> > So either we're getting away with that by chance already (and should fix
> > that regardless of this patch), or this is not actually a problem.
> 
> I now see those functions are marked weak in the assembly
> implementation; sorry for the noise.
> 
> Regardless, I still think it's preferable to avoid weak wherever
> possible.

I was thinking along the same lines, but having played around with the code,
I agree with Andrey that this appears to be the cleanest solution.

Andrey -- could you respin using WEAK instead of .weak, removing any
redundant uses of ENTRY in the process? We might also need to throw an
ALIGN directive into the WEAK definition.

Will
