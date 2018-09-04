Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0892BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0522086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0522086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIDHmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:42:12 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38728 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:42:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx1rm-0007Br-CA; Tue, 04 Sep 2018 11:18:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx1rj-0001k7-RY; Tue, 04 Sep 2018 11:18:55 +0800
Date:   Tue, 4 Sep 2018 11:18:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] arm64: cpufeature: add feature for CRC32 instructions
Message-ID: <20180904031855.mjpdndeh57lqziuk@gondor.apana.org.au>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
 <20180827110245.14812-3-ard.biesheuvel@linaro.org>
 <20180828170135.GC19825@arm.com>
 <CAKv+Gu-tM9aKZJ3ppt9yLVP_V5YA_yN8D1j_-NtM+qQCdnc6JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-tM9aKZJ3ppt9yLVP_V5YA_yN8D1j_-NtM+qQCdnc6JA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 08:43:35PM +0200, Ard Biesheuvel wrote:
> On 28 August 2018 at 19:01, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Aug 27, 2018 at 01:02:43PM +0200, Ard Biesheuvel wrote:
> >> Add a CRC32 feature bit and wire it up to the CPU id register so we
> >> will be able to use alternatives patching for CRC32 operations.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/cpucaps.h | 3 ++-
> >>  arch/arm64/kernel/cpufeature.c   | 9 +++++++++
> >>  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > With the minor caveat below...
> >
> >> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> >> index ae1f70450fb2..9932aca9704b 100644
> >> --- a/arch/arm64/include/asm/cpucaps.h
> >> +++ b/arch/arm64/include/asm/cpucaps.h
> >> @@ -51,7 +51,8 @@
> >>  #define ARM64_SSBD                           30
> >>  #define ARM64_MISMATCHED_CACHE_TYPE          31
> >>  #define ARM64_HAS_STAGE2_FWB                 32
> >> +#define ARM64_HAS_CRC32                              33
> >>
> >> -#define ARM64_NCAPS                          33
> >> +#define ARM64_NCAPS                          34
> >
> >
> > ... if this goes via crypto, you'll almost certainly get a (trivial)
> > conflict with arm64, since these numbers get bumped all the time.
> >
> 
> I think the first three patches should go through the arm64 tree. The
> last one just removes the now redundant crc32 SIMD driver, and Herbert
> could pick that up separately, i.e., it should be totally independent.

Yes let's do that.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
