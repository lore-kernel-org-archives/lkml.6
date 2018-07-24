Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1D8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CF920875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z58zmPeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CF920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbeGXHie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbeGXHie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:38:34 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C7A20881;
        Tue, 24 Jul 2018 06:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532414021;
        bh=35c/fzYC/Wtw9RxH17Dg7SJ8wBlK/ZRXQ97HRqICH1w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Z58zmPeq3bdGzJtIDerdKXC/OO2t4hYweR2dx3BIV4TTCgoJg+Qc2HdueKYQ1XWnk
         8NVbmOmsbXF4+4yoJFTC2Aj3T1C8bBMYup/2MhoYQHx+gglk+USd9KiJygRVT3q9S/
         SoZGchX7r/LG2L+hHkPnpg3nrMTrxdlXvoc/GR4s=
Received: by mail-wm0-f42.google.com with SMTP id l2-v6so11401417wme.1;
        Mon, 23 Jul 2018 23:33:40 -0700 (PDT)
X-Gm-Message-State: AOUpUlGuyvZu4qwxL/pkOeio8Q74F9yJi7A2FQTHvUsNPBkxiDbKcELl
        2fFri90p0ZgSacWcw947Mjv9opT2/5P0tPs5xUQ=
X-Google-Smtp-Source: AAOMgpcJU2pr04YC3kWGV1buttngkUSqx9uZZUEIEaGpi0Zm77a2udXC/Dw7KgCJxEgjUh7+eSA8rlyyXFSVXyd3lpQ=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr1129257wma.72.1532414019340;
 Mon, 23 Jul 2018 23:33:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 23:33:38
 -0700 (PDT)
In-Reply-To: <20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2~EBZNDRgPc2952429524eucas1p2C@eucas1p2.samsung.com>
References: <CGME20180718200005epcas1p1cb2568c593276849c066b3a53f1e971b@epcas1p1.samsung.com>
 <20180718195929.5852-1-krzk@kernel.org> <20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2~EBZNDRgPc2952429524eucas1p2C@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 24 Jul 2018 08:33:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc=3-q4CXDqcHXgXfhMKvKLJWBzuH1JvXiV5m04TW_qig@mail.gmail.com>
Message-ID: <CAJKOXPc=3-q4CXDqcHXgXfhMKvKLJWBzuH1JvXiV5m04TW_qig@mail.gmail.com>
Subject: Re: [RFC] ARM: exynos: Fix imprecise abort during Exynos5422 suspend
 to RAM
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 16:24, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi Krzysztof,
>
> On 2018-07-18 21:59, Krzysztof Kozlowski wrote:
>> Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
>> imprecise abort:
>>
>>       PM: Syncing filesystems ... done.
>>       Freezing user space processes ... (elapsed 0.003 seconds) done.
>>       OOM killer disabled.
>>       Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
>>       wake enabled for irq 139
>>       Disabling non-boot CPUs ...
>>       IRQ51 no longer affine to CPU1
>>       IRQ52 no longer affine to CPU2
>>       IRQ53 no longer affine to CPU3
>>       IRQ54 no longer affine to CPU4
>>       IRQ55 no longer affine to CPU5
>>       IRQ56 no longer affine to CPU6
>>       cpu cpu4: Dropping the link to regulator.40
>>       IRQ57 no longer affine to CPU7
>>       Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
>>       Internal error: : 1008 [#1] PREEMPT SMP ARM
>>
>> with last call trace in exynos_suspend_enter().
>>
>> The abort is caused by writing to register in secure part of sysram.
>> All Exynos5422 devices, including Hardkernel Odroid boards, boot with
>> TrustZone in non-secure mode therefore they should access non-secure
>> sysram.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> Comments, whether my understanding is correct, are welcomed!
>
> The decision, weather to use secure or non-secure sysram depends on the
> enabled TrustZone interface IMHO. Exynos5420 PeachPIT and Exynos5800 PeachPI
> don't use TrustZone and don't have 'firmware' node in dts, thus they should
> keep existing code.

Ah, you are right. SMDK5420 also would be affected. I'll fix the patch.

Thanks for feedback!

Best regards,
Krzysztof
