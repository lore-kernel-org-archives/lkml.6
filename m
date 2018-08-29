Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B338120647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLzD/3tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B338120647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeH2Tn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:43:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbeH2Tn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:43:59 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C6CF20673
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535557586;
        bh=PK9WGLLrJeNyMLG6hPcbdroEOeNk5PB0RPmiM6roK7M=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GLzD/3tqmaXhPuVr0UfXmQ1HrW0x9RyYWWNCIUEub6kk7qZ3XAD2+8VWIGrrhcxIF
         Bln71pp2uMBSwAEi1XNTk+2Z/WP1ID8vKIM9ceyBu0dBw0jVZLwbFesOHayEiJlqMk
         3TyA46bWh3Huub5uy/cQWDDzP1ir2EiABEyVb4Zc=
Received: by mail-wr1-f42.google.com with SMTP id a108-v6so5264572wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:46:26 -0700 (PDT)
X-Gm-Message-State: APzg51BK84t6Dvne0QQX6GMva3VX5BpMrrXRsto3eUU08p9GhVfiloQW
        eAzr7FxE31p9/cu5m21SKU23a4oHSFTW353oOpTaSQ==
X-Google-Smtp-Source: ANB0VdZ5t8jzMg9QEcyX4cqRKnKUG65i1biY1EEDTRIktmmx0NB4KsvULHejEjE2gNYEKLbzrgPMgEpICA6e0GJOzXs=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr4909235wrh.148.1535557584952;
 Wed, 29 Aug 2018 08:46:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 08:46:04 -0700 (PDT)
In-Reply-To: <20180829092839.GP24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 29 Aug 2018 08:46:04 -0700
X-Gmail-Original-Message-ID: <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
Message-ID: <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text poking
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:

>> +     pte_clear(poking_mm, poking_addr, ptep);
>> +
>> +     /*
>> +      * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
>> +      * as it also flushes the corresponding "user" address spaces, which
>> +      * does not exist.
>> +      *
>> +      * Poking, however, is already very inefficient since it does not try to
>> +      * batch updates, so we ignore this problem for the time being.
>> +      *
>> +      * Since the PTEs do not exist in other kernel address-spaces, we do
>> +      * not use __flush_tlb_one_kernel(), which when PTI is on would cause
>> +      * more unwarranted TLB flushes.
>> +      */
>
> yuck :-), but yeah.

I'm sure we covered this ad nauseum when PTI was being developed, but
we were kind of in a rush, so:

Why do we do INVPCID at all?  The fallback path for non-INVPCID
systems uses invalidate_user_asid(), which should be faster than the
invpcid path.  And doesn't do a redundant flush in this case.

Can we just drop the INVPCID?  While we're at it, we could drop
X86_FEATURE_INVPCID_SINGLE entirely, since that's the only user.

--Andy
