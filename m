Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1253DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C794620870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C794620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeIJUkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:40:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59776 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbeIJUkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:40:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D5B18A;
        Mon, 10 Sep 2018 08:45:37 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6100D3F557;
        Mon, 10 Sep 2018 08:45:36 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:45:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] arm64: cpufeature: add feature for CRC32 instructions
Message-ID: <20180910154533.3yxh7iooqbbsp7nc@armageddon.cambridge.arm.com>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-3-ard.biesheuvel@linaro.org>
 <20180828170135.GC19825@arm.com>
 <CAKv+Gu-tM9aKZJ3ppt9yLVP_V5YA_yN8D1j_-NtM+qQCdnc6JA@mail.gmail.com>
 <20180904031855.mjpdndeh57lqziuk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904031855.mjpdndeh57lqziuk@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:18:55AM +0800, Herbert Xu wrote:
> On Tue, Aug 28, 2018 at 08:43:35PM +0200, Ard Biesheuvel wrote:
> > On 28 August 2018 at 19:01, Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, Aug 27, 2018 at 01:02:43PM +0200, Ard Biesheuvel wrote:
> > >> Add a CRC32 feature bit and wire it up to the CPU id register so we
> > >> will be able to use alternatives patching for CRC32 operations.
> > >>
> > >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >> ---
> > >>  arch/arm64/include/asm/cpucaps.h | 3 ++-
> > >>  arch/arm64/kernel/cpufeature.c   | 9 +++++++++
> > >>  2 files changed, 11 insertions(+), 1 deletion(-)
> > >
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > >
> > > With the minor caveat below...
> > >
> > >> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > >> index ae1f70450fb2..9932aca9704b 100644
> > >> --- a/arch/arm64/include/asm/cpucaps.h
> > >> +++ b/arch/arm64/include/asm/cpucaps.h
> > >> @@ -51,7 +51,8 @@
> > >>  #define ARM64_SSBD                           30
> > >>  #define ARM64_MISMATCHED_CACHE_TYPE          31
> > >>  #define ARM64_HAS_STAGE2_FWB                 32
> > >> +#define ARM64_HAS_CRC32                              33
> > >>
> > >> -#define ARM64_NCAPS                          33
> > >> +#define ARM64_NCAPS                          34
> > >
> > >
> > > ... if this goes via crypto, you'll almost certainly get a (trivial)
> > > conflict with arm64, since these numbers get bumped all the time.
> > >
> > 
> > I think the first three patches should go through the arm64 tree. The
> > last one just removes the now redundant crc32 SIMD driver, and Herbert
> > could pick that up separately, i.e., it should be totally independent.
> 
> Yes let's do that.

I queued the first 3 patches for 4.19. Thanks.

-- 
Catalin
