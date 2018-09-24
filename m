Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78370C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20440214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mv0T4HOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20440214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeIYDlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:41:16 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46140 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbeIYDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:41:15 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so715947ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FpaTAMospcomgfm7B+G0RKSCuoXuh8rcR4wA77ILae0=;
        b=mv0T4HOpd3FL4dNnugqQCB9wjA2W7RhEruZrDXvHbVjcqxmv6evAPVWA1qJbOnPQ+1
         naO5xRsaHngjZfW5jgydhloEWgM4xkeqnqxoeo7Lht3d3yTH6LH/nmOKavbIx5QXujNB
         e1IJm7RAB/sCq3OGo7h5C+oZKXTciZsrnTWng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FpaTAMospcomgfm7B+G0RKSCuoXuh8rcR4wA77ILae0=;
        b=pTmeteVcBQILANVLH+dJ1n0RmQlP0Zp/Fs3cQap+4ryPkVeXK6hhX1XcxUPLdptMXA
         qrcb5sqNDOkCDRwjS7lyo1pov3RZnwdegz2bKFtmtRkdQxkKZl7JfmiA+TVd4blSKEv1
         Eq118JGXeUxbdzCxwhPCKr+7AB/dKcwkrmOTpsL/dIBpIkTmgaoz8+Wz9/kBDVoJD/R2
         pWM18GzCcrJCpYJUChNBREXZvpK1r7cItuJpYJ0o2WJFXZO2ek0AMvgk5JEc1hWsJdHU
         jp9oE+uei1ftbvwqMezdGuWkzOhEfd7iPIlC2UPgycCOHMAOIGheFp+J8qbqC8n3xg0p
         9erg==
X-Gm-Message-State: ABuFfohnddAHOp+hGMXWQz1IT8OQnIKM1+HE0UXZEZXlJiRk1nV3aEk8
        crJRiQREq27lQRBxRXlYQAer3yxDy68=
X-Google-Smtp-Source: ACcGV60UK3b8sirzXB6tJq+68vy3CiTivbr29x47RJyNjSj9JNPCUUWduvYfQAnS6Ns1n5qk9rdXLg==
X-Received: by 2002:a25:a1a5:: with SMTP id a34-v6mr389581ybi.75.1537825021792;
        Mon, 24 Sep 2018 14:37:01 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id q30-v6sm130487ywa.56.2018.09.24.14.37.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:37:01 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id e190-v6so8900264ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:37:01 -0700 (PDT)
X-Received: by 2002:a25:238d:: with SMTP id j135-v6mr369560ybj.137.1537824594883;
 Mon, 24 Sep 2018 14:29:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 14:29:54
 -0700 (PDT)
In-Reply-To: <1537824509.19013.63.camel@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
 <1536874298-23492-3-git-send-email-rick.p.edgecombe@intel.com>
 <CAGXu5jJ9nZYbVn5xdi7nsMJRD6ScLeWP2DWjrD8yEfwi-XXcRw@mail.gmail.com>
 <1537815484.19013.48.camel@intel.com> <CAGXu5jKho6Ui0sP6-4FN=i6zZ1+gXcd9Zyctqhvg+4r1cz-Mqw@mail.gmail.com>
 <1537824509.19013.63.camel@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 14:29:54 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJENPaYsYvVdKRESK43Rc04jmAa=mgyV_S61oFLm3xt_A@mail.gmail.com>
Message-ID: <CAGXu5jJENPaYsYvVdKRESK43Rc04jmAa=mgyV_S61oFLm3xt_A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] x86/modules: Increase randomization for modules
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
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

On Mon, Sep 24, 2018 at 2:27 PM, Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> On Mon, 2018-09-24 at 12:58 -0700, Kees Cook wrote:
>> On Mon, Sep 24, 2018 at 11:57 AM, Edgecombe, Rick P
>> <rick.p.edgecombe@intel.com> wrote:
>> > > Instead of having two open-coded __vmalloc_node_range() calls left in
>> > > this after the change, can this be done in terms of a call to
>> > > try_module_alloc() instead? I see they're slightly different, but it
>> > > might be nice for making the two paths share more code.
>> > Not sure what you mean. Across the whole change, there is one call
>> > to __vmalloc_node_range, and one to __vmalloc_node_try_addr.
>> I guess I meant the vmalloc calls -- one for node_range and one for
>> node_try_addr. I was wondering if the logic could be combined in some
>> way so that the __vmalloc_node_range() could be made in terms of the
>> the helper that try_module_randomize_each() uses. But this could just
>> be me hoping for nice-to-read changes. ;)
>>
>> -Kees
> One thing I had been considering was to move the whole "try random locations,
> then use backup" logic to vmalloc.c, and just have parameters for random area
> size, number of tries, etc. This way it could be possibly be re-used for other
> architectures for modules. Also on our list is to look at randomizing vmalloc
> space (especially stacks), which may or may not involve using a similar method.
>
> So maybe bit pre-mature refactoring, but would also clean up the code in
> module.c. Do you think it would be worth it?

I'd love to hear thoughts from -mm folks. Andrew, Matthew?

-Kees

-- 
Kees Cook
Pixel Security
