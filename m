Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B03C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9D021727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RxiRsntu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9D021727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbeHNVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:48:17 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54688 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbeHNVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:48:16 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so19771531itb.4;
        Tue, 14 Aug 2018 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAciN08GksjRwmvswkzkb40qlMwoQ//tTWMILMIILZk=;
        b=RxiRsntuAvraa5Rka329cBIZvkghCrk3eRUjarS1oyFr/14WVlUkav13+VVNnufqfC
         rpvW/2t+Wl38yJ87AHPI5KHiU+B9ERFj5mHUY6WJKKub88z+msZogtPcpthldKSbr16+
         UEX8dLWGc9c6YeYGSUs1bwNb0MTxC1yigTGho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAciN08GksjRwmvswkzkb40qlMwoQ//tTWMILMIILZk=;
        b=LUos7mlJYaVvE/XDt2IwX31EMQDYiM0AHEV2czw3tjF8TTIxbhvUXUhPWDwFDtCsI7
         zBNtkB6/cnHG3VJyjVONnMmtSQj85OpQzbrYWQm85qpiGvq1PQP/UpcW+lDQhvXgXpnP
         DDS3BBsUh8FXMHSVoOhxT3XyiVQJUVuixarYUrbx1BBtw1jO3tAeqBn/9FpzsuseB4wy
         FgCDSee+C4bw5/yJbrwVVkGUaDyWvWBECmxPC+CxiehBQtE5pPqfE1UBTZxMbPzobu8u
         /iOQBQ5Ur9XMTys+KvWTxfWqhgNp/gpfVHCVk5LczJxn5esmQQjB68JzGnHsJHfgP4OI
         osyg==
X-Gm-Message-State: AOUpUlE3pGeLzeEwcOV70ycR7ZNkd0POb5tjkEBUJks3FxoXr2famSrs
        aO6CjQYrzzf3d+MdwTZThgoLWG3MwP0v2xWj/PY=
X-Google-Smtp-Source: AA+uWPx6a4NP2pDkjXlsgu2wfXpv2gUTs0qxZU2xUFgKv8W7Bejb8lz5safU65H2/37+55nCqE6GGo/J6xE4XskSsaw=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr20335392jaa.10.1534273182162;
 Tue, 14 Aug 2018 11:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180814185047.21139-1-vbabka@suse.cz>
In-Reply-To: <20180814185047.21139-1-vbabka@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Aug 2018 11:59:31 -0700
Message-ID: <CA+55aFzbnAiRz-Gnyc97sgn_-uk+GDMd_fxSCwYqWC1ZBuOCkA@mail.gmail.com>
Subject: Re: [PATCH] x86/init: fix build with CONFIG_SWAP=n
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, pruzinat@gmail.com,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 11:51 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> The introduction of generic_max_swapfile_size and arch-specific versions has
> broken linking on x86 with CONFIG_SWAP=n due to undefined reference to
> 'generic_max_swapfile_size'. Fix it by compiling the x86-specific
> max_swapfile_size() only with CONFIG_SWAP=y.

Pretty much all the x86 people are on vacation this week, so I just
took this directly.

             Linus
