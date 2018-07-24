Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2635C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FF320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOnDcdOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FF320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbeGXKwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:52:02 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38744 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbeGXKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:52:02 -0400
Received: by mail-qk0-f195.google.com with SMTP id 126-v6so2200717qke.5;
        Tue, 24 Jul 2018 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YnarkYakNs/4RGIIBrgcHyk1IJKYNWN27W2AGCCfIgQ=;
        b=MOnDcdOvGYn3eE+50DPoW1j+unEMv14EqQAzWV4jJarzVoCom+NO5hd/bPE5IgtNsl
         fJu5XdiDxr0ErXvFGT20G35PLM7qPdlVOTfiUGGsDwrr+wo122geS+p5NvAzSwh2uNsy
         jMPiJRdMEh/p+rD0im9WHVU6E7L8xm9MKtVLYUESnr8d3WL2sxrraBTyh/b5/pn0IxGZ
         uyPCu0BmqJexnqCL11BjTYDG9pUlkaW2AAMLLZjomcrnma9ToI5BPHM4XzTzvMJzrLIO
         YeozZkwwi6S+O5QJt8xmwuoe7BzYsQHozks8WwcZ8qDU5E4HZ1hDMwxCrjJlzQxfXnu3
         kn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YnarkYakNs/4RGIIBrgcHyk1IJKYNWN27W2AGCCfIgQ=;
        b=dkqfaOkRd6gSNnusLMwPITuGPqLAQTdhWxfPwe7/fG12YSb74w3Ty5lCCl0YlhRdhl
         W63xJfRdzKCJtRmbvXj7W1RU+5i0ah4+FhUjIdCR3s2wGllvki5Yc2ZvDEVe8DyjbWZl
         X+MG7kdrtQCjvS6Y6T8mo+wF/6oz9IXXqndup4RJTI9gUtzYZXQGmoK9W8goYPbBy6xH
         h94ETMp0iQGJn+OqwZVEtG5c6N/93eqYQsU/F0BtNGY6CVQtHaDoI4qutJDsiVopwRij
         9IEQ6+/swe1d/Y+8Ic06Ex7Y/1wRL6OFchYTa3w7iqGDBsIlnBHXU0fSYs7aUu9xO6CP
         4BKQ==
X-Gm-Message-State: AOUpUlFKXhH5f77XzkL8zfrPyw2KmESR4Zc2wo4qGTJrZEt2D/m2xDQF
        t5zX5fN0onx8xGb+eX3oHK+wjxnQfgiHj5eyA1KHVQ==
X-Google-Smtp-Source: AAOMgpcAbnwNnZALrIRZUVt5Vw6cYCMBe44zobl8cSrvRlaVomLTyLwtIWqADpUOASJF18wtDCjKmkYGyTPgGQEzND8=
X-Received: by 2002:a37:5e46:: with SMTP id s67-v6mr14456252qkb.202.1532425584389;
 Tue, 24 Jul 2018 02:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:46:23
 -0700 (PDT)
In-Reply-To: <20180724094406.GF19324@arm.com>
References: <20180724093345.1575921-1-arnd@arndb.de> <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
 <20180724094406.GF19324@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 11:46:23 +0200
X-Google-Sender-Auth: K5pTzqBdtrmWuWjA-hID9yWwSck
Message-ID: <CAK8P3a12WfW9GmUW+=cW+2ZfUzSw3c-71KkiT_1UxxxivgFedw@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix ACPI dependencies
To:     Will Deacon <will.deacon@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:44 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 24, 2018 at 11:37:10AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 24, 2018 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:

>
> How about something along the lines of what Ard suggested? Untested diff
> below.
>
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 303809c6..ec78d4d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -56,6 +56,7 @@ config ARM64
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USE_QUEUED_SPINLOCKS
> +       select ARCH_SUPPORTS_ACPI
>         select ARCH_SUPPORTS_MEMORY_FAILURE
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG

I'd prefer Rafael's suggestion of just leaving out the architecture names from
the dependency, and making all three 'select ARCH_SUPPORTS_ACPI'.

I'll send a v2.

      Arnd
