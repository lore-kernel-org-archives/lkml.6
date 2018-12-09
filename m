Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F77AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070AC20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNxikBmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070AC20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLIOfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:35:23 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38414 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:35:23 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so7022314oii.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2YYL6SdlsnS8LvEcJiSWWic8y/Sq1+/soioBhtb8wzs=;
        b=YNxikBmUhzEUB88TlmfQ/ifjusKNul17kgrueqVDEBpj+bnexNXVRXxIqvewwhFW8l
         rjBrv77NC3Ydn93q1mz4cmDvGG1HhYEulOY4Y735hY7fiU46fAeGpmYMBpmlAibJgKXA
         MaXvr1twFp5iQ0G6ZG8RVk66huqvAaYQc5/o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2YYL6SdlsnS8LvEcJiSWWic8y/Sq1+/soioBhtb8wzs=;
        b=SAJrRhPQk6VRda+KzViXFe2kYsTRPWgg+OVNZBzg1Qnp7kDZeLaoMXTxsoNaP7nwNO
         QeNdnkeacTOUnveGD5D0ZicNqZVMjyQgpLkEyW6jzTwdb0nFfdj1JFm4WEClCqhO0j71
         aX1qYhzb6zav/ETWs6KmMhTvmMwihu8NopcXuXySQVQbwq1xAdkkSi4flo0k01BRvXEG
         z2XaxGPCcU3FkrER1I6zJe09PKdG7+v/6AanOxVr5Zm8REqhy1NL0u9cgF36e0O/4vH1
         nxz5+D4fMnYDmEIEW/dBhZjEzdSpN4B98Gexzn39YY1TJU2QW3PsBqwPxVg9kFK/FQzt
         FS5A==
X-Gm-Message-State: AA+aEWb9XfLmj3jS7GxqhzwMHZ/aicEBUo8vFxnLlszlgJ+u1FHXLU7q
        dSS2sJRrN4xtaY5fNr74hHzqTocwaWUJsg==
X-Google-Smtp-Source: AFSGD/XEvgvnC0VECDHYmfCQwoDqN7YbQFj57c68xIgFtqvMJaXUykYI7patCGVchQbXqViQpWoJZg==
X-Received: by 2002:aca:4fc5:: with SMTP id d188mr5225860oib.138.1544366121805;
        Sun, 09 Dec 2018 06:35:21 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id r9sm5001224otq.81.2018.12.09.06.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:35:21 -0800 (PST)
Subject: Re: [PATCH v6 03/13] arm64/kvm: consistently handle host HCR_EL2
 flags
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
 <20181207183931.4285-4-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <78a88508-7145-d58e-6275-937e1b23baa5@linaro.org>
Date:   Sun, 9 Dec 2018 08:35:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-4-kristina.martsenko@arm.com>
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
> In KVM we define the configuration of HCR_EL2 for a VHE HOST in
> HCR_HOST_VHE_FLAGS, but we don't have a similar definition for the
> non-VHE host flags, and open-code HCR_RW. Further, in head.S we
> open-code the flags for VHE and non-VHE configurations.
> 
> In future, we're going to want to configure more flags for the host, so
> lets add a HCR_HOST_NVHE_FLAGS defintion, and consistently use both
> HCR_HOST_VHE_FLAGS and HCR_HOST_NVHE_FLAGS in the kvm code and head.S.
> 
> We now use mov_q to generate the HCR_EL2 value, as we use when
> configuring other registers in head.S.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm64/include/asm/kvm_arm.h | 1 +
>  arch/arm64/kernel/head.S         | 5 ++---
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

