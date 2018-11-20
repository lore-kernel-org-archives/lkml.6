Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B27C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1081420671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oAW/EUTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1081420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeKTT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:56:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36566 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbeKTTz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:55:59 -0500
Received: from zn.tnic (p200300EC2BCDE000F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e000:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 419691EC06A7;
        Tue, 20 Nov 2018 10:27:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542706069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bqG5rKU8OP/7UNSw79MXWSB+keieO1Y3ECah6bo5zM8=;
        b=oAW/EUTLel/81CeqZ5CSIhaSSnDGvPNAXHRo0St+Y1vBdxeBANgg8+YUpi0apETKpys8F3
        H7eub+nEJ1ufHxWa/3E/DzAFhYFmtfWnAWO0XORst7aPsb3FAxlxf8Y/ym1IFR097o3aa4
        UNwCGg/zpJDN/oxZkbOxWk1IzoC2Qu4=
Date:   Tue, 20 Nov 2018 10:27:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 03/13] arch/resctrl: Re-arrange RDT init code
Message-ID: <20181120092740.GA2527@zn.tnic>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-4-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116205407.10457-4-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:54:26PM +0000, Moger, Babu wrote:
> Separate the call sequence for rdt_quirks and MBA feature.
> This is in preparation to handle vendor differences in these
> call sequences.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl.c b/arch/x86/kernel/cpu/resctrl.c
> index 5d526dc45751..4cea275c7c57 100644
> --- a/arch/x86/kernel/cpu/resctrl.c
> +++ b/arch/x86/kernel/cpu/resctrl.c
> @@ -794,6 +794,14 @@ static bool __init rdt_cpu_has(int flag)
>  	return ret;
>  }

Just nitpicks:

> +static __init bool rdt_mba_config(void)

That function doesn't have a verb in its name but it needs to have one
stating what it does. You could do

mv rdt_get_mem_config() -> __rdt_get_mem_config()
mv rdt_mba_config() -> rdt_get_mem_config()

to have the hierarchy of what calls what. And then the AMD variant will
be called __rdt_get_mem_config_amd().

Also, those are all static functions so you can just as well drop the
"rdt" prefix, I'd say.

> +{
> +	if (rdt_cpu_has(X86_FEATURE_MBA))
> +		return rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]);
> +
> +	return false;
> +}
> +
>  static __init bool get_rdt_alloc_resources(void)
>  {
>  	bool ret = false;
> @@ -818,10 +826,9 @@ static __init bool get_rdt_alloc_resources(void)
>  		ret = true;
>  	}
>  
> -	if (rdt_cpu_has(X86_FEATURE_MBA)) {
> -		if (rdt_get_mem_config(&rdt_resources_all[RDT_RESOURCE_MBA]))
> -			ret = true;
> -	}
> +	if (rdt_mba_config())
> +		ret = true;
> +
>  	return ret;
>  }
>  
> @@ -840,7 +847,7 @@ static __init bool get_rdt_mon_resources(void)
>  	return !rdt_get_mon_l3_config(&rdt_resources_all[RDT_RESOURCE_L3]);
>  }
>  
> -static __init void rdt_quirks(void)
> +static __init void rdt_quirks_intel(void)
>  {
>  	switch (boot_cpu_data.x86_model) {
>  	case INTEL_FAM6_HASWELL_X:
> @@ -855,9 +862,14 @@ static __init void rdt_quirks(void)
>  	}
>  }
>  
> +static __init void rdt_quirks(void)

Those functions also need to have a verb in the name stating what they
do.

> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		rdt_quirks_intel();
> +}
> +
>  static __init bool get_rdt_resources(void)
>  {
> -	rdt_quirks();
>  	rdt_alloc_capable = get_rdt_alloc_resources();
>  	rdt_mon_capable = get_rdt_mon_resources();
>  
> @@ -871,6 +883,9 @@ static int __init resctrl_late_init(void)
>  	struct rdt_resource *r;
>  	int state, ret;
>  
> +	/* Run quirks first */
> +	rdt_quirks();

If the comment wasn't there, seeing "rdt_quirks();" doesn't say much and
makes me go look at what that function does.

> +
>  	if (!get_rdt_resources())

Unlike here, where it is clear that this gets the rdt resources.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
