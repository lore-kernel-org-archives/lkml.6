Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F926C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DEA20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c462RHqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DEA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLIOyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:54:49 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44075 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:54:49 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so7013340oig.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8q3h34D+ijHUeMnXl1JgT1WVE0pSvnjtsDGTiKr2glA=;
        b=c462RHqaFAiIp6tR/25rD6U3kKPR4EQ4TrilxO8vggdlc9UBw2QaMC1j+54WQyOVhZ
         BWvpjE/INDonXdYnB0jXLc207GVjhScWe6BzhTuLwbBseclGB7tN/7TinEU3UHwWpgke
         DG1fpEVM45X3tvh0EZqZ2SB3/G04zNvpk4mvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8q3h34D+ijHUeMnXl1JgT1WVE0pSvnjtsDGTiKr2glA=;
        b=E8lJaQVerdATdhvA15BA7/mXSLAUk67yBseQGVjoESNBDn22sdLRrjuMC70aZT7gjx
         xF3Neym7Uf6aTxzl/AnXvVx1lfXmA+xjxle31zhETjvFHyc+cKA3ZXEoH4a1wXJ25P6h
         LLzm0Mn6n8+E8r7AtpgslwmE/x69sB1NU+tEZ7Jy7+dN71JHsCbG4oPa/sxLK5FSxlNV
         EYasFMB2W3rWI+xyn8Bs2GG4DSXGrKqXsDb3ArAArtRIEKMSuKsu7D4JyW7UN3J1wefh
         xMTyzhDFRjaR4fp9UmgyCIL+EHjWhYrz3jhYxIOQc3IqZH7pq7HApqDAsOZ/qJlD8F8g
         WwWA==
X-Gm-Message-State: AA+aEWZrYV15FN7s7wmgnvwZpimNGj7F+KNGiFOQA3C8Lsp9kseR90iu
        DTAIC90oqzWjLg+mJHhsieK/1OTBBxcQxg==
X-Google-Smtp-Source: AFSGD/WzLU+vINFNDjFJJGJkNgWs2B3+yXn0+sW8yHrtF0s6e+ofa422lrsI0mwHNNGwcxRUtk7MKQ==
X-Received: by 2002:aca:5641:: with SMTP id k62mr5722322oib.339.1544367287779;
        Sun, 09 Dec 2018 06:54:47 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id z191sm5933824oig.3.2018.12.09.06.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:54:47 -0800 (PST)
Subject: Re: [PATCH v6 05/13] arm64: Don't trap host pointer auth use to EL2
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-6-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f2518d44-3435-394a-02d4-278a6907b96d@linaro.org>
Date:   Sun, 9 Dec 2018 08:54:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-6-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> To allow EL0 (and/or EL1) to use pointer authentication functionality,
> we must ensure that pointer authentication instructions and accesses to
> pointer authentication keys are not trapped to EL2.
> 
> This patch ensures that HCR_EL2 is configured appropriately when the
> kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
> ensuring that EL1 can access keys and permit EL0 use of instructions.
> For VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
> and it doesn't matter how we configure HCR_EL2.{API,APK}, so we don't
> bother setting them.
> 
> This does not enable support for KVM guests, since KVM manages HCR_EL2
> itself when running VMs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm64/include/asm/kvm_arm.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
