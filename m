Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60F8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7CB20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="CpnN0wRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7CB20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966163AbeFSNns (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:43:48 -0400
Received: from one.firstfloor.org ([193.170.194.197]:49022 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965592AbeFSNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:43:47 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id A4F1D86A14; Tue, 19 Jun 2018 15:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1529415825;
        bh=nuQDLgGjxKu45EcS7NtZh99w1D4uHyFdhzZDlIw9GsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpnN0wRFV/Xk8a+a1COkGtX+Q2oi9BpN6AW9/XTcKZmmnfz00k7COjOlsHKzajG2G
         R6PQClk30cuFTaS65dnAJjHxnjPShAWztqzNW6UP/cy1mHnKpnS0pzds1wq7+YP2sH
         qOVM29BnqNdfrg3aRHUlfPd5ga4zd3vl1EMotoLY=
Date:   Tue, 19 Jun 2018 06:43:45 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [RFC PATCH] x86/arch_prctl: Add ARCH_SET_XCR0 to mask XCR0
 per-thread
Message-ID: <20180619134345.azpifnsmgd5dprhu@two.firstfloor.org>
References: <1529195582-64207-1-git-send-email-keno@alumni.harvard.edu>
 <20180617163530.rvwf7fcukmoletgo@two.firstfloor.org>
 <CABV8kRyf2R=a2zezgovByK9Lc8HhDXyfZ4OPE_DHfKKg34bNfw@mail.gmail.com>
 <20180618165840.gikljqhaxtiiw27x@two.firstfloor.org>
 <CABV8kRxqAjCDsQL7M2OLm8Tircsx7Xb2bdgDJ5XPJ3Ff=EjzUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRxqAjCDsQL7M2OLm8Tircsx7Xb2bdgDJ5XPJ3Ff=EjzUQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In particular 1) means that any extra instructions executed/not executed
> will cause a replay divergence (in practice rr uses retired conditional
> branches rather than instructions, because the instruction counter is
> not accurate, while the branch one is). This alone causes a problem
> for the present case, because glibc branches on the xcr0 value before
> it branches on the cpuid value for AVX512. Glibc does check for the
> correct cpuid before calling xgetbv, so one possible thing to do is to
> completely disable xsave during recording by disabling it in CPUID, but
> that would make rr quite a bit less useful, since it wouldn't be able to

Ah I see it now. This problem was introduced with the changes
for glibc to save AVX registers using XSAVE instead of manually.

It still seems this has a straight forward fix in glibc though.

It could always allocate the worst case buffer, and also
verify XGETBV against CPUID first. I'm sure this can be
done in a way that executed branches don't differ.

AFAIK manual use of XSAVE is not that common, so hopefully
these problems are not wide spread in other programs.

Of course longer term you'll just need to have matching
ISAs in record and replay. Trying to patch around this
is likely always difficult.

-Andi

