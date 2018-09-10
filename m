Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA7EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A12A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A12A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeIJRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:47:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57060 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeIJRrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:47:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4087580D;
        Mon, 10 Sep 2018 05:53:08 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517B63F575;
        Mon, 10 Sep 2018 05:53:06 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:53:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kyeongdon Kim <kyeongdon.kim@lge.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: lib: use C string functions with KASAN enabled.
Message-ID: <20180910125303.dlysg3jba4wv7bhg@lakrids.cambridge.arm.com>
References: <20180906170534.20726-1-aryabinin@virtuozzo.com>
 <20180907145605.GE12788@arm.com>
 <9634affa-b210-d931-e40b-6e8a20f105fc@virtuozzo.com>
 <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910113257.7rjj5qseu3m2tj6y@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:33:22PM +0100, Mark Rutland wrote:
> On Fri, Sep 07, 2018 at 06:48:10PM +0300, Andrey Ryabinin wrote:
> > On 09/07/2018 05:56 PM, Will Deacon wrote:
> > > I don't understand this bit: efistub uses the __pi_ prefixed
> > > versions of the routines, so why do we need to declare them as weak?
> > 
> > Weak needed because we can't have two non-weak functions with the same
> > name.
> > 
> > Alternative approach would be to never use e.g. "strlen" name for asm
> > implementation of strlen() under CONFIG_KASAN=y.  But that would
> > require adding some special ENDPIPROC_KASAN() macro since we want
> > __pi_strlen() to point to the asm_strlen().
> 
> Somehow, what we have today works with CONFIG_FORTIFY_SOURCE, which
> AFAICT would suffer from texactly the same problem with things like
> memcpy.
> 
> So either we're getting away with that by chance already (and should fix
> that regardless of this patch), or this is not actually a problem.

I now see those functions are marked weak in the assembly
implementation; sorry for the noise.

Regardless, I still think it's preferable to avoid weak wherever
possible.

I have a couple of local patches to do that for KASAN, though it's not
clear to me how that should interact with FORTIFY_SOURCE.

Thanks,
Mark.
