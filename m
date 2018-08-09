Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0821DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGASaN5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0821DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeHIO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43862 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:27 -0400
Received: by mail-ua0-f194.google.com with SMTP id f4-v6so6017973uao.10;
        Thu, 09 Aug 2018 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dLp+Zcex97sVCYSrENupZ35cO84WQ1kNXk5zWuFNd2U=;
        b=PGASaN5jn3I/toyjoF3Ez6fTzt4FPfP1TZYFBj0CJ32oHSS/mZLl+TgDbc5BumDcFc
         xFPK2QH0Gs28LEXx1vcHbDb7MLyWc69BYaty/HpFQgMZ6yqOgTDmjkuNJQBhqT+MhSFE
         vSDaOOsp0dR0ZdfUOvA9Q9TV40FZqiSuqFoUOdj7yb48M3IYy5ribKGOm1kLczK7sY9O
         5M9fU97edXMpEUj+uD15oglzvGE+hAW+pFeao6nUEtDB69TxtwjbLi/BAcuSaPM85S5H
         bWTE4yi4e+rACt6a04m2EpZarhdHqZU+//HteEgc9BsaNIuMTuWgtnpGEPgoNEADZKyh
         XVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dLp+Zcex97sVCYSrENupZ35cO84WQ1kNXk5zWuFNd2U=;
        b=sr9L3mnB2TJbRKwMHkoS8b9cqCIyGLvoj3KP+stYw0zODy35ioRp4u2wJv+vZ8xvxJ
         VycJRfdx2Flro3gHSVKttCnZeG4jkhyXtlzq/Zpnt+wWRlFST5K6UQtqI2jDVUrtpzZV
         WNhCAdjwDtPJukMp8O9wHJX4SspKiJrvT7mzg2l9WCqclNEcKYy8rtH8aNRkczt7InVq
         ro2c7kdeq1W3ehwsFN4tVdYVyaQa0hi+GqWmPChpn03/1x0HoaWedVfLyqeKijiGogS0
         N1og9nyfCZ132DuREVvlzv3E+4W4BhffaanRCa2DbvpKMiwSFSGneVis5gYD9PKYDIol
         H1Jg==
X-Gm-Message-State: AOUpUlG3DTbBDODkREM4IBHkauyj+ssnYy/ts7b9YFCW2C0UuKDnL6fN
        ksy1CCSNRP9dtwWfBRZVylHM4A9PgSmk15o2at0=
X-Google-Smtp-Source: AA+uWPwECHWkxuWIALUPXVFaqstZx45cDCchj7OrkTNBNBqOlHRISNeNs1MKrEoeAyIXb4dHGNkWk4Q5wf+6FOuV/zo=
X-Received: by 2002:ab0:4853:: with SMTP id c19-v6mr1232517uad.157.1533817965820;
 Thu, 09 Aug 2018 05:32:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:3f0f:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 05:32:45 -0700 (PDT)
In-Reply-To: <1533659175-47076-1-git-send-email-gengdongjiu@huawei.com>
References: <1533659175-47076-1-git-send-email-gengdongjiu@huawei.com>
From:   gengdongjiu <gengdj.1984@gmail.com>
Date:   Thu, 9 Aug 2018 20:32:45 +0800
Message-ID: <CAMj-D2Arv-ZxUMTB_zKKy58CghWsZJbTOcNdiD3KVzxJ-v973g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] arm64: clean the additional checks before
 calling ghes_notify_sea()
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     Borislav Petkov <bp@suse.de>, Will Deacon <will.deacon@arm.com>,
        rafael.j.wysocki@intel.com, James Morse <james.morse@arm.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Borislav


2018-08-08 0:26 GMT+08:00 Dongjiu Geng <gengdongjiu@huawei.com>:
> In order to remove the additional check before calling the
> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
>
> After this cleanup, we can simply call the ghes_notify_sea() to let
> APEI driver handle the SEA notification.
>
> CC: Tyler Baicar <tbaicar@codeaurora.org>
> CC: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
> This cleanup is ever mentioned by Mark Rutland in [1]
>
> [1]:
> https://lkml.org/lkml/2018/5/31/289
>
> Change since v1:
> 1. Update the commit messages
> 2. CC Tyler and James
> 3. Add Acked-by of Will
> ---
>  arch/arm64/mm/fault.c | 7 +------
>  include/acpi/ghes.h   | 4 ++++
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index b8eecc7..9ffe01d 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>
>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
>  {
> -       int ret = -ENOENT;
> -
> -       if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
> -               ret = ghes_notify_sea();
> -
> -       return ret;
> +       return ghes_notify_sea();
>  }
>
>  asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 1624e2b..82cb4eb 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
>              (void *)section - (void *)(estatus + 1) < estatus->data_length; \
>              section = acpi_hest_get_next(section))
>
> +#ifdef CONFIG_ACPI_APEI_SEA
>  int ghes_notify_sea(void);
> +#else
> +static inline int ghes_notify_sea(void) { return -ENOENT; }
> +#endif
>
>  #endif /* GHES_H */
> --
> 1.9.1
>
