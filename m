Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42570C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AC420831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzW+2FAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AC420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLIO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:58:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46827 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:58:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so8052538otm.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 06:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ltVeZ/P0fjNFoHs2uLxtUuxFtbSdGvlCvYAVu+C1jHQ=;
        b=kzW+2FAOszZhqRq21zKhBEN9yDSNxY2sefaEGTxs1W8np3y3DWg6hmnowQQATcpog9
         JLtPr1OsGWKif3CDX5741vAxicE+Hdt/4NQih1VgqVXfrFCnCKDsfgGh4pSEU/hccJEA
         Pl6MIdldNNqQNOQ/badZuT2D0iS/b5tA8uhZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ltVeZ/P0fjNFoHs2uLxtUuxFtbSdGvlCvYAVu+C1jHQ=;
        b=W+9ygM/eC5O9RtsDhTm8XZblK3mOfYg+0Civ7lsotgx9zG8nIbvK/DZTihogAONjWp
         1ZMgeBcQzdbSiCJ3aifUNtOkFIJLmEWsk0M1b/GKM76iI+MdaGU2MebapA9I18V196gn
         NxH9toEznNKzuRi/jXdmdhzqTONHB+4dpMbGFJ2d+HPYs4YWn39EPMhwX2UMoV6xEy/p
         vU/7MEOrZ7hj+pjflz1MVbrvF+nwY4wr2LOYCYy74MURRKiQ/gipx1D6jHXxVsa87Zyd
         soFZBMhYwfVpMhXIAqawKlIctqbTT0+2XSEURqjoR3QH4pMQRFUE++DYLGXnJMn1uxnL
         rd/A==
X-Gm-Message-State: AA+aEWb7r1GavCtszG717ZZj0Y5l4e3gsOMh4aldc5YeXjGG8HNfiAG1
        cItkXshwLnsIFae1AgF7TIHUVLr9FUjrNw==
X-Google-Smtp-Source: AFSGD/VdxKTolqnSzuBHpTys/odbEWXjAVQbXfqpD3xsp+21suaHSQlCcI4wkzE1zjio1lBVBEIzUQ==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr6731220otl.343.1544367491069;
        Sun, 09 Dec 2018 06:58:11 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id l204sm4570498oia.54.2018.12.09.06.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:58:10 -0800 (PST)
Subject: Re: [PATCH v6 06/13] arm64/cpufeature: detect pointer authentication
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
 <20181207183931.4285-7-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <12e20237-a6a7-bb4c-ad34-7b645a50e680@linaro.org>
Date:   Sun, 9 Dec 2018 08:58:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-7-kristina.martsenko@arm.com>
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
> So that we can dynamically handle the presence of pointer authentication
> functionality, wire up probing code in cpufeature.c.
> 
> From ARMv8.3 onwards, ID_AA64ISAR1 is no longer entirely RES0, and now
> has four fields describing the presence of pointer authentication
> functionality:
> 
> * APA - address authentication present, using an architected algorithm
> * API - address authentication present, using an IMP DEF algorithm
> * GPA - generic authentication present, using an architected algorithm
> * GPI - generic authentication present, using an IMP DEF algorithm
> 
> This patch checks for both address and generic authentication,
> separately. It is assumed that if all CPUs support an IMP DEF algorithm,
> the same algorithm is used across all CPUs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h    |  8 +++-
>  arch/arm64/include/asm/cpufeature.h | 12 +++++
>  arch/arm64/kernel/cpufeature.c      | 90 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

