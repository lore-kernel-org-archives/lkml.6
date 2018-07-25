Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E13AC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF20E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mcSxAW1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF20E2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeGYFlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:41:10 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:38807 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeGYFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:41:10 -0400
Received: from mail-vk0-f41.google.com (mail-vk0-f41.google.com [209.85.213.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w6P4V5L5008965;
        Wed, 25 Jul 2018 13:31:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w6P4V5L5008965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532493066;
        bh=jvFK3xB/gVN4HHdWf+8x3pthV+SqE4+zYi4XcciAIbg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mcSxAW1dfwdv9WtVINh4Nlm4fuaeSM8jqVldWCss9y7XuBfm6NtbAlSoMElctHsYW
         2UvE5RPTKPSSKEZsOgLgOqvyFY4iQ6y60kHRROU3ENziyIXwBUxdffis1WqsigIefB
         7Xs7ITUXEYiKmQZcDRFEL2DgDSYCsTdYvPtGaTU+lAEsB3QaAR+tPWodUoZsI4u0cS
         qyQYS8COPtQHxqeW5Ax0dNaJx3Y18Yo9BfMEvcU7yzhb0rGiL1B+uQzkWmd23vcMYy
         oTMezuZ1SzpyOznLhdcXj2TS4VaT3DLvzvh/FiILpHo1fVyYH/X4hcuVAKgmpk9EI9
         BpEoXX24/uOtA==
X-Nifty-SrcIP: [209.85.213.41]
Received: by mail-vk0-f41.google.com with SMTP id y70-v6so3158474vkc.0;
        Tue, 24 Jul 2018 21:31:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlEXLdQXVVrSWBO6K1GHBbbln/F7zY1MYBE9FWmprQZvQ7Ao0mNJ
        4PoYoS9L1Fye+0VicaK89tRBjy6YzaMgYGEfbdI=
X-Google-Smtp-Source: AAOMgpdTrdPkoMqTxi3/Sw20sM6O5W61sEZShzMO6HTymnOvLc1T3ResQm046GQXFerCzR1tfdUMJwtdBe1XYK1P5xw=
X-Received: by 2002:a1f:968f:: with SMTP id y137-v6mr11951655vkd.55.1532493064877;
 Tue, 24 Jul 2018 21:31:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 21:30:24
 -0700 (PDT)
In-Reply-To: <20180724175646.3621-1-hch@lst.de>
References: <20180724175646.3621-1-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 25 Jul 2018 13:30:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
Message-ID: <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org, linux-arch@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-25 2:56 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Hi Masahiro,
>
> what do you think about the series below, which moves the includes
> of all the architecture independ Kconfig files to the top-level
> Kconfig instead of duplicating the includes in all architectures?
>
> Note that this only handles the low-hanging fruite, there are a lot
> of other bits that should probably be cleaned up to be common,
> but those will be not entirely trivial.
>
> Changes since v2:
>  - fix the missing sh conversion
>  - handle the lack of CONFIG_SWAP support in microblaze and nios2 properly
>
> Changes since v1:
>  - add back a remove source statement from arch/arm/Kconfig
>  - various fixes from Randy
>  - various UML patches to be able to use the common Kconfig
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


This version passed my tests.


Could you check the difference of CONFIG_PREEMPT_COUNT, please?


For alpha, hexagon, um,
CONFIG_PREEMPT_COUNT was previously never enabled
because kernel/Kconfig.preempt was not included.

Now, CONFIG_PREEMPT_COUNT can be enabled
if it is select'ed by someone.

I guess this change will be OK, but
I'd like you and Randy to double-check it just in case.



-- 
Best Regards
Masahiro Yamada
