Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C448C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37912084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="As3SXsaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37912084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeLLUAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:00:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32964 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLUAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:00:16 -0500
Received: from zn.tnic (p200300EC2BCDD8007CFD4A6887308591.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d800:7cfd:4a68:8730:8591])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1B191EC0B89;
        Wed, 12 Dec 2018 21:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544644814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0sTvYlXu7v0gxztiS6M0w+P207TXjeReekhtCXgqiaU=;
        b=As3SXsaJ6zw/tRa5mkEL2GEH6Z7XNSgQRy0FkBXyYxXv2a15FEnLsx9h6+k15W5s2vNxEp
        HGkh0CgF/oa8Dz82VJARsz7F/0Q7xvr7bwnwPAGejRJtX5Z7JWd1nS10Vkd0DGl7z8+zjO
        QLZQ4l0uRCvT0Ef+GaD0aRkwKYjKHKg=
Date:   Wed, 12 Dec 2018 21:00:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Message-ID: <20181212200005.GF6653@zn.tnic>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic>
 <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
 <20181212184459.GE6653@zn.tnic>
 <CALCETrXcBa3eUN2okedig+sECnQ8zuSWojahqWLR4vWqD8mEhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXcBa3eUN2okedig+sECnQ8zuSWojahqWLR4vWqD8mEhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:50:30AM -0800, Andy Lutomirski wrote:
> As far as I know, RDTSCP gets the job done, as does LFENCE, RDTSC on
> Intel.

Same on AMD when LFENCE has been made dispatch-serializing.

> There was a big discussion a few years ago where we changed it
> from LFENCE;RDTSC;LFENCE to just LFENCE;RDTSC after everyone was
> reasonably convinced that the uarch would not dispatch two RDTSCs
> backwards if the first one was immediately preceeded by LFENCE.

Yeah, the second one won't pass the LFENCE so you won't see time going
backwards, sure.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
