Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CC1ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383321480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XPyftwHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F383321480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeIYCHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:07:30 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33473 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeIYCH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:07:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id x67-v6so8406043ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7obrhOknSO0z+TtuHbi9CgTMLfuA0uKVVPflkzhn8Nc=;
        b=XPyftwHJZ3283UUy0alfGNgWfYwAA0ZphXv/OhgOw/uhrbqNB9mXGkFVR1lOsIWp6V
         sZWPdKvf/wxkjGPXtZ4VSrgtkpG35sZx61D0vxHplPKdaQ25V9V8Fjj5N3WmQ4Ou8BzJ
         +KxzRF1WJv7rRbzQavwoL2pfLOc4VmVR4yJFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7obrhOknSO0z+TtuHbi9CgTMLfuA0uKVVPflkzhn8Nc=;
        b=lQo7k7ETR7Y+aMCo91l8xmGlEKVwDSbU5uaq8Ijxv9jOsgjsLf6DBfRyzsHDy2dUcJ
         cdKL1+yd5S2Wdv2U4vj79GIYmHNpWi/h14Jx9o3nW/Pt4C15vesrEJsnQJYB9FK4NbSG
         /Tn/TOAw/9L8Lml8dDHrYnVOg+sEUb9X/Gy+3P0w3k2wUfBz/Bi4hTK5+EgSSicYL93j
         d7SmDB4HakIBlHUDAWrxVHwDN/uBmWVK4lNBzsB00HV1oCI3yvOi/AYAJzzYyTWZlYLx
         0j3YZEnZkMK1fIW2tE7PSrSIjjl0G1F4qS3ePMzxIgEBWnxR3ox6MdpZpXTZAzdkJ2L2
         YRZQ==
X-Gm-Message-State: ABuFfoiNzct4yxz1PrAgcWcMmz5pSszY6IyYh4HCbv1cefCfayFdpZhu
        xOuYGlgxNXtt2zTVTU03UnvEps8sk2c=
X-Google-Smtp-Source: ACcGV600elnWDh6FvHfKUhnabAC+xneu7HBXyInsU8N6seVCewWIYeg76zgia7A7arSJrh23pCagCg==
X-Received: by 2002:a0d:f284:: with SMTP id b126-v6mr186371ywf.469.1537819416541;
        Mon, 24 Sep 2018 13:03:36 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id i126-v6sm97413ywc.19.2018.09.24.13.03.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:03:35 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id o8-v6so598427ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 13:03:34 -0700 (PDT)
X-Received: by 2002:a25:249:: with SMTP id 70-v6mr207185ybc.421.1537819414591;
 Mon, 24 Sep 2018 13:03:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 13:03:33
 -0700 (PDT)
In-Reply-To: <1537815554.19013.49.camel@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
 <1536874298-23492-4-git-send-email-rick.p.edgecombe@intel.com>
 <CAGXu5jJj+08J9UeyQs5ku8CziYWA72iJ+hxMR2Z2tLiVwvU8MA@mail.gmail.com> <1537815554.19013.49.camel@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 13:03:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+w0mHMSjcwRcQuyvfRa+XSy2zs7kLYj+qNpnokfSwb3A@mail.gmail.com>
Message-ID: <CAGXu5j+w0mHMSjcwRcQuyvfRa+XSy2zs7kLYj+qNpnokfSwb3A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] vmalloc: Add debugfs modfraginfo
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:58 AM, Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Fri, 2018-09-21 at 11:56 -0700, Kees Cook wrote:
>> On Thu, Sep 13, 2018 at 2:31 PM, Rick Edgecombe
>> <rick.p.edgecombe@intel.com> wrote:
>> > +done:
>> > +       gap = (MODULES_END - last_end);
>> > +       if (gap > largest_free)
>> > +               largest_free = gap;
>> > +       total_free += gap;
>> > +
>> > +       spin_unlock(&vmap_area_lock);
>> > +
>> > +       seq_printf(m, "\tLargest free space:\t%lu kB\n", largest_free /
>> > 1024);
>> > +       seq_printf(m, "\t  Total free space:\t%lu kB\n", total_free / 1024);
>> > +
>> > +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_enabled())
>> > +               seq_printf(m, "Allocations in backup area:\t%lu\n",
>> > backup_cnt);
>> I don't think the IS_ENABLED is needed here?
> The reason for this is that for ARCH=um, CONFIG_X86_64 is defined but
> kaslr_enabled is not. kaslr_enabled is declared above to protect against a
> compiler error.
>
> So IS_ENABLED(CONFIG_RANDOMIZE_BASE) is protecting kaslr_enabled from causing a
> linker error. It gets constant evaluated to 0 and the compiler optimizes out the
> kaslr_enabled call. Thought it was better to guard with CONFIG_RANDOMIZE_BASE
> than with CONFIG_UM, to try to catch the broader situation. I guess I could move
> it to a helper inside ifdefs instead. Was trying to keep the ifdef-ed code down.

Ah yes, UM. Perhaps kaslr_enabled() could be defined somewhere so that
it would link sanely? (Maybe in module.h?)

>> I wonder if there is a better way to arrange this code that uses fewer
>> ifdefs, etc. Maybe a single CONFIG that capture whether or not
>> fine-grained module randomization is built in, like:
>>
>> config RANDOMIZE_FINE_MODULE
>>     def_bool y if RANDOMIZE_BASE && X86_64
>>
>> #ifdef CONFIG_RANDOMIZE_FINE_MODULE
>> ...
>> #endif
>>
>> But that doesn't capture the DEBUG_FS and PROC_FS bits ... so ...
>> maybe not worth it. I guess, either way:
> Hmmm, didn't know about that. Would clean it up some at least.
>
> I wish the debugfs info could be in module.c to help with this IFDEFs, but it
> needs vmalloc internals. MODULES_VADDR is not standardized across the ARCH's as
> well, so this was my best attempt to implement this without having to make
> changes in other architectures.

Yeah, I've long wanted to try to sandardize the module+vmalloc guts,
but it's just different enough in each architecture that it eludes
people.

-Kees

-- 
Kees Cook
Pixel Security
