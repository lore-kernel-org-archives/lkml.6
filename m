Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59226C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B1B2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oO8zKJVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B1B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbeKPUGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:06:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbeKPUGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:06:02 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542362065; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOP5n2sUg1i/EuAyNmCtg3kk6tgoURv1R+AffpMCuXY=;
        b=oO8zKJVOw6gaYCkz2MKTyQYiiI0qOt3LvKDL9drOBKmn+prcT6Km7GLVA7/VPFL9FZAAaI
        j/X12gizzEHUbN1G/j75UxdIfIKVb5V6JftfqVJZ59ClyL0EqwuQUa7DTrbUuJCwykSP1Q
        xs/oDq7KUCf9TJAg5Qor/8RbyuAGV90=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HqnmQ_ByZc_x; Fri, 16 Nov 2018 10:54:25 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0FE004D130AD2F34E6DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:fe00:4d13:ad2:f34e:6de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C8E21EC0198;
        Fri, 16 Nov 2018 10:54:25 +0100 (CET)
Date:   Fri, 16 Nov 2018 10:54:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, sherry.hurwitz@amd.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu/AMD: Fix CPB bit for more processors
Message-ID: <20181116095424.GA20313@zn.tnic>
References: <20181116053106.11571-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116053106.11571-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 01:31:06PM +0800, Jiaxun Yang wrote:
> CPUID Fn8000_0007_EDX[CPB] is wrongly 0 on Model 17,
> Stepping 0, but revision guide has not been released for
> newer Family 17h models.
> 
> Tesed on AMD "Ryzen 7 2700U with Radeon Vega Mobile Gfx"
> and "AMD Ryzen 5 2500U with Radeon Vega Mobile Gfx",
> their CPUID Fn0000_0001_EAX is 0x00810f10 and should have
> CPB feature according AMD product specifications, however
> their Fn8000_0007_EDX is 0x00006599, indicating they don't
> support CPB feature.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index eeea634bee0a..7db43ef8e97e 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -821,8 +821,12 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
>  	/*
>  	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
>  	 * all up to and including B1.
> +	 *
> +	 * Revision guide for Family 17h, Model 17 has not been released, but
> +	 * Model 17, Stepping 0 have the same issue.
>  	 */
> -	if (c->x86_model <= 1 && c->x86_stepping <= 1)
> +	if ((c->x86_model <= 1 && c->x86_stepping <= 1) ||	\
> +		(c->x86_model == 17 && c->x86_stepping == 0))
>  		set_cpu_cap(c, X86_FEATURE_CPB);
>  }

Actually, I'd prefer if we stopped doing all the checks and simply do
this:

	if (!cpu_has(c, X86_FEATURE_CPB))
		set_cpu_cap(c, X86_FEATURE_CPB);

for all F17h as it is a safe assumption that family 0x17 has CPB -
regardless of CPUID bit setting.

Sherry?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
