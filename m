Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5A4ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394A220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394A220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeGTT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:59:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45006 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbeGTT7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:59:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id b15-v6so11200762qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 12:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YxorLe+wFgUlAny5yA/oHfafNHB8KjwNGsNl49Zr5B4=;
        b=svXajCJAigvBa+uzpxl2V0yX6++9nHVvmnbxnlpPAw86iLY/YynZrnjCN0y4JUScF+
         0NzwnKSsw1y55epXjnzf+GCiOsZM/djmfs9ijjmwPDGih6tEUgcjRffj6w56H5/1yCd9
         01KJHAt3EfJgfSTRpIpe5QKjwn41ru5nadkfBTMf6Vr0oADm+kjhE3OewUAtLSyJwX6e
         Atq4xylbcTp9CBx/FioiXp3XtmZit40TmSYpUgDifx/oNa0cUvHNziRZyUFwfS84kSuh
         bH7cZEy4xouZik2XnfACucLT3zUNv1vUvjAIRpjMvbPHDuVN21h68L6OfjRpoxznYdBi
         4CVg==
X-Gm-Message-State: AOUpUlHO3HkQgOmo2A64UMtHwArzUhRkKG0DYkDDGdM/uhNDMxMJHMDH
        0X6E0wmHV+LPp7M7iIieb53TqpOMWlY=
X-Google-Smtp-Source: AAOMgpfoUPd77An5nSJgyRuz+eZRzVnajcenJ89E4C3y72GYfRKEQyZylyyELEMDcBSae1sKFmZ3Eg==
X-Received: by 2002:a0c:814e:: with SMTP id 72-v6mr2930715qvc.29.1532113808956;
        Fri, 20 Jul 2018 12:10:08 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0? ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id p5-v6sm1695888qkd.81.2018.07.20.12.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 12:10:07 -0700 (PDT)
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
To:     Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
References: <20180718014344.1309-1-tytso@mit.edu>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fee11b5d-e2cd-9a82-c84a-bedecba2a17b@redhat.com>
Date:   Fri, 20 Jul 2018 12:09:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180718014344.1309-1-tytso@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 06:43 PM, Theodore Ts'o wrote:
> This gives the user building their own kernel (or a Linux
> distribution) the option of deciding whether or not to trust the CPU's
> hardware random number generator (e.g., RDRAND for x86 CPU's) as being
> correctly implemented and not having a back door introduced (perhaps
> courtesy of a Nation State's law enforcement or intelligence
> agencies).
> 
> This will prevent getrandom(2) from blocking, if there is a
> willingness to trust the CPU manufacturer.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> 
>   I'm not sure Linux distro's will thank us for this.  The problem is
>   trusting the CPU manfuacturer can be an emotional / political issue.
> 

So I went to test this patch and was pleasantly surprised to find
that the hang from the degenerate case had been fixed in rawhide.
This means future Fedora versions should actually just boot properly.

That said, I do think this is a beneficial option to have available
because it actually fixes the underlying problem instead of hoping
nobody else decides to block early in the bootup process.

Thanks,
Laura

>   For example, assume that China has decided that as a result of the
>   "death sentence" that the US government threatened to impose on ZTE
>   after they were caught introducing privacy violating malware on US
>   comsumers, that they needed to be self-sufficient in their technology
>   sector, and so they decided the needed to produce their own CPU.
> 
>   Even if I were convinced that Intel hadn't backdoored RDRAND (or an
>   NSA agent backdoored RDRAND for them) such that the NSA had a NOBUS
>   (nobody but us) capability to crack RDRAND generated numbers, if we
>   made a change to unconditionally trust RDRAND, then I didn't want the
>   upstream kernel developers to have to answer the question, "why are
>   you willing to trust Intel, but you aren't willing to trust a company
>   owned and controlled by a PLA general?"  (Or a company owned and
>   controlled by one of Putin's Oligarchs, if that makes you feel
>   better.)
> 
>   With this patch, we don't put ourselves in this position --- but we
>   do put the Linux distro's in this position intead.  The upside is it
>   gives the choice to each person building their own Linux kernel to
>   decide whether trusting RDRAND is worth it to avoid hangs due to
>   userspace trying to get cryptographic-grade entropy early in the boot
>   process.  (Note: I trust RDRAND more than I do Jitter Entropy.)
> 
>   drivers/char/Kconfig  | 14 ++++++++++++++
>   drivers/char/random.c | 11 ++++++++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 212f447938ae..fe2930c4ecf0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -554,3 +554,17 @@ config ADI
>   
>   endmenu
>   
> +config RANDOM_TRUST_CPU
> +       bool "Trust the CPU manufacturer to initialize Linux's CRNG"
> +       depends on (X86 || X86_64 || X86_32 || S390 || PPC)
> +       default n
> +       help
> +	Assume that CPU manufacurer (e.g., Intel or AMD for RDSEED or
> +	RDRAND, IBM for the S390 and Power PC architectures) is trustworthy
> +	for the purposes of initializing Linux's CRNG.  Since this is not
> +	something that can be indepedently audited, this amounts to trusting
> +	that CPU manufacturer (perhaps with the insistance or requirement
> +	of a Nation State's intelligence or law enforcement agencies)
> +	has not installed a hidden back door to compromise the CPU's
> +	random number generation facilities.
> +
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 34ddfd57419b..f4013b8a711b 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -782,6 +782,7 @@ static void invalidate_batched_entropy(void);
>   static void crng_initialize(struct crng_state *crng)
>   {
>   	int		i;
> +	int		arch_init = 1;
>   	unsigned long	rv;
>   
>   	memcpy(&crng->state[0], "expand 32-byte k", 16);
> @@ -792,10 +793,18 @@ static void crng_initialize(struct crng_state *crng)
>   		_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
>   	for (i = 4; i < 16; i++) {
>   		if (!arch_get_random_seed_long(&rv) &&
> -		    !arch_get_random_long(&rv))
> +		    !arch_get_random_long(&rv)) {
>   			rv = random_get_entropy();
> +			arch_init = 0;
> +		}
>   		crng->state[i] ^= rv;
>   	}
> +#ifdef CONFIG_RANDOM_TRUST_CPU
> +	if (arch_init) {
> +		crng_init = 2;
> +		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
> +	}
> +#endif
>   	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
>   }
>   
> 

