Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF81C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3016420843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3016420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeIDOCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:02:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbeIDOCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:02:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC80E7A9;
        Tue,  4 Sep 2018 02:38:31 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD5B93F5BC;
        Tue,  4 Sep 2018 02:38:31 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id AFD881AE3546; Tue,  4 Sep 2018 10:38:45 +0100 (BST)
Date:   Tue, 4 Sep 2018 10:38:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] arm64: cpufeature: add feature for CRC32 instructions
Message-ID: <20180904093844.GA12148@arm.com>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-3-ard.biesheuvel@linaro.org>
 <20180828170135.GC19825@arm.com>
 <CAKv+Gu-tM9aKZJ3ppt9yLVP_V5YA_yN8D1j_-NtM+qQCdnc6JA@mail.gmail.com>
 <20180904031855.mjpdndeh57lqziuk@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904031855.mjpdndeh57lqziuk@gondor.apana.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
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

Okey doke! In which case, please can we have your Ack on the first patch?

Cheers,

Will
