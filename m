Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41961C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C2C20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkwNnTPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C2C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLIO7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:59:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43611 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeLIO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:59:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so8089225otr.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 06:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNDhZFMf/+5Sbma1vzSzIDHZ8WGRRV+Q1JX55LNm8NU=;
        b=QkwNnTPW7guKA6TNhaSpmx5XBNdLO9Tvl2Ihnn9dEn7DMEPOjDoAH5kBI5p/gEU+z+
         qwLFSx4c9ztkQaABHSRZ/m3KDz7RvGZoaT+cMjKOegI/ViayN3vN1uDJyd9HtsM5TosX
         EeZx/s1nhUahsgkzxAs56Vq92fEWUEOCFoV00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNDhZFMf/+5Sbma1vzSzIDHZ8WGRRV+Q1JX55LNm8NU=;
        b=DVrqtbLrMvJ4jpaKdL0cHc8o1N2xUGpIxfy2nTsRkx55X4GGP4L4rd+VmBvMEMEjSC
         OJMjCFd6LsJgtQEwVL9eEgPK9b+id0XQNSefUgk1qFGWgPN9FwRymplQcTh0XXD90vYv
         knWYvyEJHo/QfCJAavtEbmvn/3mdJ3ZhKxLOEknIJ5kwV4v1LEiflkI7ElXo6m6qQ2ql
         XMd+2dyjck9AKU+SaiKNYUl/E8IOu9i6e+6FeLgFJ0GBpUElBiy6OYjizXctMjff/hH0
         hpwsMDL8ZptKAQVK4ngWyM+BYcvx1Nm2WF8aTNe8CQ3Q2pkULPI85MdTssRe07sYgYUY
         2UQw==
X-Gm-Message-State: AA+aEWZ9s2YlOh0yp/ZLjuLMkEG2d+c+pQ6Bgzvj9aerQBVfGgE+cDe3
        FJZMxTYmqaMqvOVEol0hgwQEarkXvFJIcQ==
X-Google-Smtp-Source: AFSGD/WKa/GERQKFIJs5Uxt7J2h8aSHjXtJ/MN5F3cnq1fK3q9qywU91Uh/JaobsBM2PhkDzCbWqXw==
X-Received: by 2002:a9d:72a:: with SMTP id 39mr6888134ote.134.1544367586327;
        Sun, 09 Dec 2018 06:59:46 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id h24sm6360742otm.72.2018.12.09.06.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:59:45 -0800 (PST)
Subject: Re: [PATCH v6 07/13] arm64: add basic pointer authentication support
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
 <20181207183931.4285-8-kristina.martsenko@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0cd3ea5e-c705-7e14-bac0-900a4ca7782c@linaro.org>
Date:   Sun, 9 Dec 2018 08:59:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-8-kristina.martsenko@arm.com>
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
> This patch adds basic support for pointer authentication, allowing
> userspace to make use of APIAKey, APIBKey, APDAKey, APDBKey, and
> APGAKey. The kernel maintains key values for each process (shared by all
> threads within), which are initialised to random values at exec() time.
> 
> The ID_AA64ISAR1_EL1.{APA,API,GPA,GPI} fields are exposed to userspace,
> to describe that pointer authentication instructions are available and
> that the kernel is managing the keys. Two new hwcaps are added for the
> same reason: PACA (for address authentication) and PACG (for generic
> authentication).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Tested-by: Adam Wallis <awallis@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pointer_auth.h | 75 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/thread_info.h  |  4 ++
>  arch/arm64/include/uapi/asm/hwcap.h   |  2 +
>  arch/arm64/kernel/cpufeature.c        | 13 ++++++
>  arch/arm64/kernel/cpuinfo.c           |  2 +
>  arch/arm64/kernel/process.c           |  4 ++
>  6 files changed, 100 insertions(+)
>  create mode 100644 arch/arm64/include/asm/pointer_auth.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

