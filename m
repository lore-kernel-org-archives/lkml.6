Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0816CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB3B2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JRLybqwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfBUVu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:50:59 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40852 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1550785854; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HBpaBF/AxOE2d1d6D+kIlVE9vLNXo5LOaqGhO54/UcE=;
        b=JRLybqwooDCDDwsaX8ttlQ+ZbVwzBInFMUkuJ3uQ/UDTSZHAPo5fub/FYyWJULhY6gabxi
        dNowz0Xt+Q00k2klShTK5XU81vcWfaQKcy78MITkie7baxtR4mxT7wTR4+urfUFZN0amt9
        nUv0SH5fJd7n75sOPkr+PKPeJPzDzCY=
Date:   Thu, 21 Feb 2019 18:50:43 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] MIPS: ingenic: Add support for appended devicetree
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1550785843.28751.0@crapouillou.net>
In-Reply-To: <CAOiHx=k--4gOnERK4qJ6QfMyqqeAn4CQfYFeBZYRieWAa19cDw@mail.gmail.com>
References: <20190221203820.7044-1-paul@crapouillou.net>
        <CAOiHx=k--4gOnERK4qJ6QfMyqqeAn4CQfYFeBZYRieWAa19cDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Thu, 21 Feb 2019 at 21:39, Jonas Gorski <jonas.gorski@gmail.com> 
wrote:
> On Thu, 21 Feb 2019 at 21:39, Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>>  Add support for booting the kernel from an externally-appended
>>  devicetree, if no devicetree was built-in.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   arch/mips/Kconfig        |  2 +-
>>   arch/mips/jz4740/setup.c | 14 +++++++++++---
>>   2 files changed, 12 insertions(+), 4 deletions(-)
>> 
>>  diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>  index a84c24d894aa..8b7ea9062198 100644
>>  --- a/arch/mips/Kconfig
>>  +++ b/arch/mips/Kconfig
>>  @@ -391,7 +391,7 @@ config MACH_INGENIC
>>          select GPIOLIB
>>          select COMMON_CLK
>>          select GENERIC_IRQ_CHIP
>>  -       select BUILTIN_DTB
>>  +       select BUILTIN_DTB if MIPS_NO_APPENDED_DTB
>>          select USE_OF
>>          select LIBFDT
>> 
>>  diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
>>  index afb40f8bce96..5c00064937c4 100644
>>  --- a/arch/mips/jz4740/setup.c
>>  +++ b/arch/mips/jz4740/setup.c
>>  @@ -31,6 +31,7 @@
>> 
>>   #define JZ4740_EMC_SDRAM_CTRL 0x80
>> 
>>  +extern const char __appended_dtb;
> 
> Does this build/link with MIPS_NO_APPENDED_DTB? I would assume it
> won't be able to resolve the symbol in that case.

Oops. You're right.

> You can also just use fw_passed_dtb from asm/bootinfo.h, which will be
> populated automatically from fw_args (if UHI) or __appended_dtb (if
> present and valid)[1], without having to care where it came from.

Thanks, I will.

Regards,
-Paul

