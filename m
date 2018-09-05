Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7333D206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7333D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeIENwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:52:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54576 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeIENwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:52:12 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u76rXynZHu_d; Wed,  5 Sep 2018 11:22:34 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A19301EC01AF;
        Wed,  5 Sep 2018 11:22:34 +0200 (CEST)
Date:   Wed, 5 Sep 2018 11:22:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
Message-ID: <20180905092234.GC2237@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:44:54PM +0800, Pu Wen wrote:
> Hygon machine check arch is similar to AMD family 17h. To enable the MCE
> infrastructure support, add CPU vendor check for Hygon to share the code
> path of AMD.
> 
> Add hygon mce init function mce_hygon_feature_init() to minimize further
> maintenance effort.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/mce.h                |  5 +++++
>  arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
>  arch/x86/kernel/cpu/mcheck/mce.c          | 21 +++++++++++++++------
>  3 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 3a17107..12357aa 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -214,6 +214,11 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
>  static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr) { return -EINVAL; };
>  #endif
>  
> +static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)
> +{
> +	return mce_amd_feature_init(c);
> +}
> +

What happens if CONFIG_X86_MCE_AMD=n ?

In general, since you're using AMD code, you need to make CPU_SUP_HYGON
depend on a bunch of AMD config items like CONFIG_X86_MCE_AMD,
CONFIG_CPU_SUP_AMD, CONFIG_AMD_NB,... Audit your code and see what other
config items need to be selected.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
