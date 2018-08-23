Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3725AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D754F208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D754F208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeHWLwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:52:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36062 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHWLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id r69-v6so7290372oie.3;
        Thu, 23 Aug 2018 01:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcLf0SKcXuv02S7PJ6BuiFbo7nC5AuXrSZH1n8TdK4c=;
        b=QQ6Xp7r11rNpRgmHrcTD2PlQKEGK1CBKg7T7X/y0TluNO/CMD5I8jILyQ3pR+J9BMz
         ajBceVnDaHPdCcCqWMdO0b7Er0gDP3L+x/dLjvACTwkBx1vepnu4kzL3pTaouecDDocA
         Ww//6Oq1/M2sQwhvKc2I0CQqIldxpB2HX2f2/JJvpypdFDkuJRTMERnI6OJdVL4m3WRo
         JVQu0AMD+DG/QJZq2vlt1pc+PfBEN0ckGiHy6WSf6Y00an5XgKjD8Wd70hT7386VKC4o
         3at0LLKkD/+Y1zHCCPUA0+7Q+NsDQ/7qnVUVJJWgGdNWIZL2KVvnyH/arMI6r7ZXqDuu
         zLsA==
X-Gm-Message-State: APzg51AsPzUFX5AQTj8m4Gl8J2QlndE5Gagu1RMFJWLXNLBijsIZ3Y3g
        O4CRIjr+yEhoZFR5Xzl1iLJFCmsusOxvfXqkS0A=
X-Google-Smtp-Source: ANB0VdYgnfS0bJ6DZgG9yxeSr298UHazEtrhuHf3xhC8ugYmKGvHCk3kpMt7elI5W0UhnQ0ls1t8djetHUQ7zeqfHZo=
X-Received: by 2002:aca:37c2:: with SMTP id e185-v6mr7784866oia.326.1535012609510;
 Thu, 23 Aug 2018 01:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180821203750.2394352-1-arnd@arndb.de>
In-Reply-To: <20180821203750.2394352-1-arnd@arndb.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Aug 2018 10:23:17 +0200
Message-ID: <CAJZ5v0gaWhTZFL+MP1D9tGsPAe0R6cqH1RiEjQ37mXE4P7g5Ng@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fix menuconfig presentation of ACPI submenu
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 10:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> My fix for a recursive Kconfig dependency caused another issue where the
> ACPI specific options end up in the top-level menu in 'menuconfig'. This
> was an unintended side-effect of having a silent option between
> 'menuconfig ACPI' and 'if ACPI'.
>
> Moving the ARCH_SUPPORTS_ACPI symbol ahead of the ACPI menu solves that
> problem and restores the previous presentation.
>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Fixes: 2c870e61132c ("arm64: fix ACPI dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

I'll push this to Linus tomorrow.

> ---
>  drivers/acpi/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1edca05ee0ae..e92eab1e960c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -3,6 +3,9 @@
>  # ACPI Configuration
>  #
>
> +config ARCH_SUPPORTS_ACPI
> +       bool
> +
>  menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
> @@ -40,9 +43,6 @@ menuconfig ACPI
>           <http://www.acpi.info>
>           <http://www.uefi.org/acpi/specs>
>
> -config ARCH_SUPPORTS_ACPI
> -       bool
> -
>  if ACPI
>
>  config ACPI_LEGACY_TABLES_LOOKUP
> --
> 2.18.0
>
