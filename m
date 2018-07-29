Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF3FD21E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BA120892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yLXJlAIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BA120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeG2Fui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 01:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeG2Fui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 01:50:38 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5D2208A6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 04:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532838099;
        bh=lUf9A+GB2sd/heiAH3nlexp90t4NRbznnCXyMTWFDTU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yLXJlAIiZn4iDazIclJlNKTuv1QXqOBAZfy3kzL80fa5TrKenPyTZ63Nttu5RUBIn
         GHSdg4+XrXK3KikbvA0ijc27zVK1wNTDGQCjJpTe+fG+/lvCzyC9qPAhVVPkCLqERL
         XLZv30DuHxcJUDB6MzGDQdQRyZntS/BSkjJPcIRk=
Received: by mail-wm0-f51.google.com with SMTP id s9-v6so9416854wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 21:21:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlGStRLABty6A2t6lG7oiKTYE62AVYPIGW9NC+xrX4ULtVvwiC18
        JIRYBaGhWSU3GsoQfBjly3VJEt+wbWlvInlNaa+TVg==
X-Google-Smtp-Source: AAOMgpcrXsNcD3q2n4tN+7BBcbqh2sqFWl233SWIY/WPYRVFd+ctHKJLERInjk9r7fU6JeBXLNnWbcUKH7p3hO7YanU=
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr9706620wmq.36.1532838097968;
 Sat, 28 Jul 2018 21:21:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 21:21:17 -0700 (PDT)
In-Reply-To: <20180728215357.3249-11-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-11-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Jul 2018 21:21:17 -0700
X-Gmail-Original-Message-ID: <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
Message-ID: <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
Subject: Re: [PATCH 10/10] mm,sched: conditionally skip lazy TLB mm refcounting
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com> wrote:
> Conditionally skip lazy TLB mm refcounting. When an architecture has
> CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> lazy TLB mode anywhere will get shot down from exit_mmap, and there
> in no need to incur the cache line bouncing overhead of refcounting
> a lazy TLB mm.

Unless I've misunderstood something, this patch results in idle tasks
whose active_mm has been freed still having active_mm pointing at
freed memory.  This isn't strictly speaking a bug, but it's extremely
confusing and risks all kinds of nasty errors.  That's why I prefer
the approach of actually removing the active_mm field on x86 rather
than merely removing the refcount.

I realize that this will add more ifdeffery and make the patch a bit
bigger, but I think it'll be much more robust.  Not to mention that it
will save a pointer an a refcount per mm_struct, but that barely
matters.
