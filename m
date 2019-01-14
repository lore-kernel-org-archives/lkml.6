Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568BC20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dwd5flFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfANLId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:08:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58826 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfANLIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:08:32 -0500
Received: from zn.tnic (p200300EC2BC4CA00C95BD7F0398E53C6.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:c95b:d7f0:398e:53c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B22911EC0573;
        Mon, 14 Jan 2019 12:08:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547464110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nCkhHqfkn9uWwLuOG4OAs8PmmQu9oQgY9Kk7VS0XIhA=;
        b=Dwd5flFZ6xO/r2bH5X7DCe2DHGBJHMMgiowilOMu0ljteaNLNNg0w6MO+ckc+oBId7NVoq
        wdxN/0jUFUei1C36KCev+xFyxsHOcjzOTccEunZ02qDkrNQqII8Zg/MpjoW3sfcLPZ3yOT
        qYfF5M1Qxc8eJZx+xusVhVoiNSSb71w=
Date:   Mon, 14 Jan 2019 12:08:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper
 macros
Message-ID: <20190114110825.GJ2773@zn.tnic>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:57:52PM +0200, Andy Shevchenko wrote:
> These macros are often used by the drivers and we have already a lot of
> duplication as ICPU() macro across them.
> 
> Provide a generic x86 macro for users.
> 
> This adds no driver data variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/intel-family.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
> index 25b28760fada..afd70055a750 100644
> --- a/arch/x86/include/asm/intel-family.h
> +++ b/arch/x86/include/asm/intel-family.h
> @@ -86,10 +86,16 @@
>  	.family		= _family,				\
>  	.model		= _model,				\
>  	.feature	= X86_FEATURE_ANY,			\
> -	.driver_data	= (kernel_ulong_t)&_driver_data		\
> +	.driver_data	= (kernel_ulong_t)_driver_data		\
>  }
>  
>  #define INTEL_CPU_FAM6(_model, _driver_data)			\
> -	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
> +	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
> +
> +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)		\

"ANY_NODATA" is confusing IMO, as I have no clue what that means. ICPU()
and the full model define was fine.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
