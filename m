Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73F5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6280020893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt1M3mqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280020893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeGZIZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:25:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37737 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeGZIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:25:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so1192368oib.4;
        Thu, 26 Jul 2018 00:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gkiVH0VLeH1j/I2g5Qytpx0pEzRUsYjHuez1P/sr6iM=;
        b=kt1M3mqX77bTZTsntXrqBOboZGd8GikOVJcJeeQdvI3AVXDhcpFvwS1rqdEgj0hacw
         shiPuaCRXB1/RmJ+IencdsX3RVeOmtHn5yiwEut4S4lYQHb7RC6xuDcmWS7fVsD3zKS9
         v52WhSnlprfjGaVoSblPJ9rpL3YIu2klQOwqRo7t7tRlIVDnh79hk3z3S6IWNblI0YOq
         SSHyNaGlCuce6rsagekIrZTXhl4zm+zb46w6ONCt1L35wJ2Bm9CZ7DRVLj1o79r7M2F/
         wBWVcZQKwguLNx25VlJwIwn5z6Mzskr8D2gdy614bHUevwsjpdk3e5bw5XDb1YdnhzLG
         qLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gkiVH0VLeH1j/I2g5Qytpx0pEzRUsYjHuez1P/sr6iM=;
        b=nawpSb97BmQDAH0U8HcKATqMy2NY4pNnCVNf+6pCoQhC3VlaM1eHmJq8wvls8iEP2x
         qdqpgqvB3cd5neJjm3VyXI9lbfhnS6TPkg/qNVlGE9Py68Ma4+IWqbgpxc+kuOdrfd6J
         jmFfpHU7QHmHkmwdgGmflLi6la9Rmp0cl/YqDCyLEAT9e+vKy83YmBGJybbqHKUA/apv
         +8KvLYCEnMNxdzvqzNLYbvl3dWrfC5aw0zCGsfrJ2hC6RAFoDxbxn9CNBH0lilNoCYBU
         h2tJArVwz6ynpqCRzNMspUOaLaq7bWz/yFjonTZ4RGaTFX5Q9vvjTWBWt7LSh558aef2
         wRug==
X-Gm-Message-State: AOUpUlFfG46P4KCMfXJMIEy1iso813JUJGTwtq3L7yyKGnedC3w+7+7z
        q5/ZalVuZcaxWz9R9hDTtlv5z+aqoTWqIsRuA/U=
X-Google-Smtp-Source: AAOMgpfqBk69BcKvLcWXkWEWs5TKuNUfYH4qHFyzaU7XcaTncVdRolKl7YUlHV4P0Hpq+3bCheM/ftPAfut9M7/hEx8=
X-Received: by 2002:aca:3805:: with SMTP id f5-v6mr710912oia.310.1532589020256;
 Thu, 26 Jul 2018 00:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 00:09:59
 -0700 (PDT)
In-Reply-To: <CAJKOXPc1csipQsmtJ77uZOwUgchPwGoA_+xxzmCjx97dLU5cyg@mail.gmail.com>
References: <20180724164946.6274-1-krzk@kernel.org> <20180724164946.6274-4-krzk@kernel.org>
 <CANAwSgSChhEzDf5oSqZ2Srt62n16Z+ppFnupT=0pGkaSCv90vw@mail.gmail.com> <CAJKOXPc1csipQsmtJ77uZOwUgchPwGoA_+xxzmCjx97dLU5cyg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 26 Jul 2018 12:39:59 +0530
Message-ID: <CANAwSgS+JNAbiX3=c+OtDBMXgrKcwgC4uRukHG90oCiJcrOxwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: exynos: Fix imprecise abort during Exynos5422
 suspend to RAM
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 26 July 2018 at 12:10, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 26 July 2018 at 08:22, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof,
>>
>> On 24 July 2018 at 22:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
>>> imprecise abort:
>>>
>>>         PM: Syncing filesystems ... done.
>>>         Freezing user space processes ... (elapsed 0.003 seconds) done.
>>>         OOM killer disabled.
>>>         Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
>>>         wake enabled for irq 139
>>>         Disabling non-boot CPUs ...
>>>         IRQ51 no longer affine to CPU1
>>>         IRQ52 no longer affine to CPU2
>>>         IRQ53 no longer affine to CPU3
>>>         IRQ54 no longer affine to CPU4
>>>         IRQ55 no longer affine to CPU5
>>>         IRQ56 no longer affine to CPU6
>>>         cpu cpu4: Dropping the link to regulator.40
>>>         IRQ57 no longer affine to CPU7
>>>         Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
>>>         Internal error: : 1008 [#1] PREEMPT SMP ARM
>>>
>>> with last call trace in exynos_suspend_enter().
>>>
>>> The abort is caused by writing to register in secure part of sysram.
>>> Boards booted under secure firmware (e.g. Hardkernel Odroid boards)
>>> should access non-secure sysram.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>
>> I could not get the suspend to ram working on my Odroid-XU4.
>
> Correct, resuming from suspend to RAM does not work on Exynos5422
> (yet). The patch does not add support for it. I did not write that it
> works. The only thing patch does, is fixing the imprecise abort during
> suspend.
>
> Best regards,
> Krzysztof

Ok thanks for the input.

Best Regards
-Anand
