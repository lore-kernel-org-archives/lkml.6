Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD4C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33BF20893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/SrXhiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33BF20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeG2E0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeG2E0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:26:32 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2DCF2089A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532833067;
        bh=KuY/RUOAmyKUARhAzh/dGfss/Dszo4StMbKmpqDHvus=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=l/SrXhiC9yxGpUC8v2EpTKfAAQEDWTpdVGJ4T5SIl/QadPyAmZo6d20GB5J7zKXFk
         ptmzzma4ZqSjjERrqjXz55OUEk3S6+dEQatRNmk5Q5U1cNBuxT1C5IRRg3SUAuYTNm
         0nFnDUxv9rrb+hxdksMPIgxd6eCKEu4ahlGlrzYw=
Received: by mail-wm0-f50.google.com with SMTP id h20-v6so9733142wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 19:57:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlE0gLia7uWTw4qSLV0bZpg9Zh+lK6FauaZTwRlCDt3hoSqJ+buq
        9cjGOHVBL6ugeHo61iSuD+prpNKRFGcVOdXSsdw+1A==
X-Google-Smtp-Source: AAOMgpf0dmDMyxrlHK8MqGZaFM8CCFKY0D2zjVbDsdWf/wvh/D+jd6cNl3Km4nIH2UdfZPK+//hcfR3ogo78IIdJN/c=
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr9498136wmd.144.1532833065281;
 Sat, 28 Jul 2018 19:57:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 19:57:24 -0700 (PDT)
In-Reply-To: <20180728215357.3249-4-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-4-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 28 Jul 2018 19:57:24 -0700
X-Gmail-Original-Message-ID: <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com>
Message-ID: <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com>
Subject: Re: [PATCH 03/10] smp,cpumask: introduce on_each_cpu_cond_mask
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
> Introduce a variant of on_each_cpu_cond that iterates only over the
> CPUs in a cpumask, in order to avoid making callbacks for every single
> CPU in the system when we only need to test a subset.

Nice.

Although, if you want to be really fancy, you could optimize this (or
add a variant) that does the callback on the local CPU in parallel
with the remote ones.  That would give a small boost to TLB flushes.
