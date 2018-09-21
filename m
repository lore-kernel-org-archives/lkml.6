Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01BEECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3D521568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TmgWEPZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3D521568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391301AbeIVBCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:02:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45349 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVBCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:02:49 -0400
Received: by mail-yw1-f66.google.com with SMTP id p206-v6so5601016ywg.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yQn0zHFpqULn0bK3B6Gan6jnMfKsWdjQXBQ05cqv1M8=;
        b=TmgWEPZbBcXXtNjYBoE2BnYl5edbUEi1H6ZGvgPeSwjsMn6Ti187tHHt+1u+/nt85j
         QwJdROG6zbNzAWnf7O3ap1zkFrFd3Di/A8S2GaROh+akNdjHC6XRjSaKquZI4fF+bDtw
         a1ljNbtR55IWGiFIT6+BnTPxMROSub9Xsq8Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yQn0zHFpqULn0bK3B6Gan6jnMfKsWdjQXBQ05cqv1M8=;
        b=fDr4ZJXkze2d6CnLT+bqym1Y7Fs1jTLuhtcwlYbxyZFXFnzajd8bPNYqQq0uscbkvt
         pz2A2XInp4wQxy6RuamULzcJEy0iKkFjdrx4HQ0i8YCchFg6Ehg7PTuBT4Zg7pbvNJkO
         23Qa9vcD+DomsiCfYa2+xAIw801n50u6EuNMeCN+dXx2AygA6RpZmUYO5xuY7i3AmEpr
         q2uYMgzgTPTEWl3RK0+FIWsQXGNeHvmpZUvF44RKnVN1qLKO9CUVqhOdBhh6Bwsdlr/c
         0wT0Ev1IDcM8mmKzkSqGrfCLmYYvxIPOH6fgaxZU/cGwi5QkPhoWo6wZplLnE14IQ+ho
         3P5A==
X-Gm-Message-State: APzg51CI2YAqKTShtlqXyQLz1yFCr+Tg/lqsUqzh+gB/eCil99on8Xb0
        Zh+sQ9avXNmbQxnOLDCYf9Uj3NYAPEk=
X-Google-Smtp-Source: ANB0VdY23TVloHcN+b/CLEO9cpFMB3o5iQQafhWZKjGjIxVoJ/zn+Jbw2zQL+yVPZQao3rN+XBtlQw==
X-Received: by 2002:a0d:cfc2:: with SMTP id r185-v6mr21599178ywd.337.1537557153514;
        Fri, 21 Sep 2018 12:12:33 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id m82-v6sm16494902ywm.19.2018.09.21.12.12.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:12:32 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w7-v6so5872138ybm.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:12:32 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr21581913ybz.410.1537557151666;
 Fri, 21 Sep 2018 12:12:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 12:12:30
 -0700 (PDT)
In-Reply-To: <20180917161245.c4bb8546d2c6069b0506c5dd@linux-foundation.org>
References: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180917161245.c4bb8546d2c6069b0506c5dd@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 12:12:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLRuWOMPTfXAFFiVSb6CUKaa_TD4gncef+MT84pcazW6w@mail.gmail.com>
Message-ID: <CAGXu5jLRuWOMPTfXAFFiVSb6CUKaa_TD4gncef+MT84pcazW6w@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: Randomize free memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:12 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 15 Sep 2018 09:23:02 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
>> Data exfiltration attacks via speculative execution and
>> return-oriented-programming attacks rely on the ability to infer the
>> location of sensitive data objects. The kernel page allocator, has
>> predictable first-in-first-out behavior for physical pages. Pages are
>> freed in physical address order when first onlined. There are also
>> mechanisms like CMA that can free large contiguous areas at once
>> increasing the predictability of allocations in physical memory.
>>
>> In addition to the security implications this randomization also
>> stabilizes the average performance of direct-mapped memory-side caches.
>> This includes memory-side caches like the one on the Knights Landing
>> processor and those generally described by the ACPI HMAT (Heterogeneous
>> Memory Attributes Table [1]). Cache conflicts are spread over a random
>> distribution rather than localized.
>>
>> Given the performance sensitivity of the page allocator this
>> randomization is only performed for MAX_ORDER (4MB by default) pages. A
>> kernel parameter, page_alloc.shuffle_page_order, is included to change
>> the page size where randomization occurs.
>>
>> [1]: See ACPI 6.2 Section 5.2.27.5 Memory Side Cache Information Structure
>
> I'm struggling to understand the justification of all of this.  Are
> such attacks known to exist?  Or reasonably expected to exist in the
> future?  What is the likelihood and what is their cost?  Or is this all
> academic and speculative and possibly pointless?

While we already have a base-address randomization
(CONFIG_RANDOMIZE_MEMORY), attacks against the same hardware and
memory layouts would certainly be using the predictability of
allocation ordering (i.e. for attacks where the base address isn't
important: only the relative positions between allocated memory). This
is common in lots of heap-style attacks. They try to gain control over
ordering by spraying allocations, etc.

I'd really like to see this because it gives us something similar to
CONFIG_SLAB_FREELIST_RANDOM but for the page allocator. (This may be
worth mentioning in the series, especially as a comparison to its
behavior and this.)

> ie, something must have motivated you to do this work rather than
> <something-else>.  Please spell out that motivation.

I'd be curious to hear more about the mentioned cache performance
improvements. I love it when a security feature actually _improves_
performance. :)

Thanks for working on this!

-Kees

-- 
Kees Cook
Pixel Security
