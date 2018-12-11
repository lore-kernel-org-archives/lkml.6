Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4CCC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7372086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TTsn3w2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7372086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeLKXjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:39:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeLKXjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:39:10 -0500
Received: from zn.tnic (p200300EC2BCD2B002DC08A63FFF8C6E5.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:2dc0:8a63:fff8:c6e5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E320F1EC0BC5;
        Wed, 12 Dec 2018 00:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544571549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xm4Id4SaDx5pWNmf51GHmJrj64kOKzugh2n3epQICKQ=;
        b=TTsn3w2wwE6YaYH3TQS4s1gk760VidlPKaNOsa6FuymDia2fj3z0ML3MXIfexBBU4od0De
        DNN/mN9RCtPeRGkDrNYcHFuvWm0c6u1p3n15EOzzCXOkl0HBbS5b41hifMy9p+HWro70T9
        4tkqERZNcibXACZs1arLv1RnnfhreiQ=
Date:   Wed, 12 Dec 2018 00:39:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181211233901.GV27375@zn.tnic>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:12:41PM +0000, Lendacky, Thomas wrote:
> It does seem overloaded in that sense, but the feature means that LFENCE
> is serializing and so can be used in rdtsc_ordered. In the same sense,
> barrier_nospec is looking for whether LFENCE is serializing and preferring
> that over MFENCE since it is lighter weight.
> 
> In light of how they're being used now, they could probably stand to be
> renamed in some way.

Actually, come to think of it, what really matters here is whether
LFENCE is serializing or not. Because if so, you wanna replace with LFENCE
as it is lighter. And in that case a single alternative() - not _2() -
should suffice.

BUT(!), that still is not good enough if you do some qemu CPU models
like pentium or so which don't even have MFENCE and cause stuff like
this:

https://lkml.kernel.org/r/20181123200307.GA6223@roeck-us.net

Which means, that you *do* have to alternate between

* no insn at all
* MFENCE
* LFENCE, if it is serializing

so barrier_nospec() does the right thing, AFAICS. And this is why we
need an ALTERNATIVE_3() to add RDTSCP into the mix too.

WRT renaming, I guess we can do something like:

* X86_FEATURE_MFENCE_RDTSC -> X86_FEATURE_MFENCE - to mean that CPU has
MFENCE support.

and

* X86_FEATURE_LFENCE_RDTSC -> X86_FEATURE_LFENCE_SERIALIZING

Or something to that effect.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
