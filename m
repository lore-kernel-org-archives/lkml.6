Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A102AE9C645
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E51D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BvmQu1+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E51D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeGLRsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:48:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55084 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:48:15 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so7943327itb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBM2NblqMwSzoXHXighsXPUKbnETTHf8UrNOpUUqdRk=;
        b=BvmQu1+L+WHnvlSIWhO+1vGHQoR0cTTrEnzTrF/QvxBjZX9KiYQAgDMGuSAS1/hyJa
         mT0cfrfepHWe6bOeR3AmVI8eZl8xfgTWKYeMvqIRx7yMJjGgiMiAJ+8P68lFpFeeKoqj
         Zp2tcgj/adyR2Ag8SDk3cPkA/roag/jiafn6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBM2NblqMwSzoXHXighsXPUKbnETTHf8UrNOpUUqdRk=;
        b=AfizjgLMH8YhMtc1/zugZaH4VHL/eV6CP3WrNCVcgYJQB3I8w8vJF9S77n1dxjM0x9
         2FCwMJ2bUUeMYV0w22cDgagzMGn9+wepoggPokLYJ1OUOyRTtHn0t8qwGeW2KJ1mZT8A
         dvSb1vgLm1PnmOhokhWmpWBxOblfWDgQXmIVL1FY7eHn6LSHbrOJMh83i1914Rhqj7GA
         f9AL5fFBwn2ZfhY1azfn4/PbtTUVxIivnqopUbYUN3k492/mEFMwJMSrtBCWyNf1oOPf
         n3hOaEdTtdyvekcatX3cmVBkFi4fpEK0bBFm0HTzfpqRJu7Vf1d2X9KkNuIdWRJE8qgb
         /8/g==
X-Gm-Message-State: AOUpUlFP1+il0OfAjNehbr3oM38IxFoZRsDQ11oIOottWl9tdN373f7K
        t90EceRJ5hy7BSKCUq2pPd7qA/xRErmaj0nlYUmzyg==
X-Google-Smtp-Source: AAOMgpchCDafx7BLfnvCrLEZYvjdhjdMWUh92SyyitU4DIXfzX/4PHqeu08M14EXGkwzRYM4m3fcSZWmdNq40ORzpok=
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr2434150jaa.127.1531417061477;
 Thu, 12 Jul 2018 10:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180712172942.10094-1-hannes@cmpxchg.org>
In-Reply-To: <20180712172942.10094-1-hannes@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 10:37:30 -0700
Message-ID: <CAADWXX_ADRyY+HDyw_2Ofa4b9g1fpCNe8xO3xMf20jfWsyCnQg@mail.gmail.com>
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory, and
 IO v2
To:     hannes@cmpxchg.org
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        surenb@google.com, Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>, shakeelb@google.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> PSI aggregates and reports the overall wallclock time in which the
> tasks in a system (or cgroup) wait for contended hardware resources.

No comments on the patches themselves (the concept looks sane, and I'm
finding it more intriguing for non-oom uses than for oom), but just a
note to say that gmail hates you and marked every single patch as spam
for some reason.

I have no idea why. All the headers look fine, DKIM passes, nothing
bad stands out.

So it must be personal.

             Linus
