Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB25C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6120F20856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fiwx4b64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6120F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJZT3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:29:04 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40967 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeJZT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:29:04 -0400
Received: by mail-yb1-f196.google.com with SMTP id e16-v6so267171ybk.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c/WqbMWHMcD/8iKow4AF4NNyb4XgPQah5Hm7QPT62b4=;
        b=Fiwx4b64jA9UIjAnt67rUn29Okv8mTMVOXlacT/zJC0Fyc31MoUNJOmWONxOshbuXb
         f3wd3Rz2GsP+FCCCkRCA7Dz+krUmhdZ+CuiwtprfAFKcxKl6capY3iQ/TZcOSg5pHpGa
         hGLe1qRsPKYDAuDncrv5cScHAY3lJBmr8Id2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c/WqbMWHMcD/8iKow4AF4NNyb4XgPQah5Hm7QPT62b4=;
        b=dCdSE0E0mQWtbTDb4xSJqRTWTaUhKPSrPYd66BZvSwjbnfZJR2MwnYQ0CySILIDlmR
         nIZjygw1/TH1n2jurndbWaOIqdm6gipGtbJiwsHxn47EURNaHcNu93XrxInO7UEZjAFq
         +jnSO7S2ZtFgp+PJ0XzIr//nbwqGwCHXtWfryT+aoMHSoyrc8PIJeat0UGdrWUgol2Fs
         lPckGp0hXXpggEor2UPu6zYDX+Gz6LLIBs8GtjRl2kUZWm8toxUeK1deSysMBFP5HcqM
         Q8GKpsX27Uwhmki40Vv8w8rLD1lzZ2Njd7Wch6zuoBmhkfbrcsnedLfE/Az/X6xtSmQz
         D4Bw==
X-Gm-Message-State: AGRZ1gImL+82VazUaIYV65AxBvGNnMwdIDi00nEiANJbdpuH/yFGHmxq
        boom3Axzg8Df4vVZZczfCvUsY89TKZoSCQ==
X-Google-Smtp-Source: AJdET5dgiu6EMfgeJJV1cYgueGeG6Vm+UMvtw9M5pD9Higsn1u3IYiT6Q1YVNVaAAMPXUsPeD0jVew==
X-Received: by 2002:a25:764d:: with SMTP id r74-v6mr2843712ybc.461.1540551146994;
        Fri, 26 Oct 2018 03:52:26 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id k85-v6sm2732794ywa.76.2018.10.26.03.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 03:52:26 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id j202-v6so253447ywa.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 03:52:26 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr2804635ywg.47.1540550790136;
 Fri, 26 Oct 2018 03:46:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 03:46:28
 -0700 (PDT)
In-Reply-To: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com> <20181026092609.GB3159@worktop.c.hoisthospitality.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 11:46:28 +0100
X-Gmail-Original-Message-ID: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
Message-ID: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:26 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> I still don't really understand the whole write-rare thing; how does it
> really help? If we can write in kernel memory, we can write to
> page-tables too.

I can speak to the general goal. The specific implementation here may
not fit all the needs, but it's a good starting point for discussion.

One aspect of hardening the kernel against attack is reducing the
internal attack surface. Not all flaws are created equal, so there is
variation in what limitations an attacker may have when exploiting
flaws (not many flaws end up being a fully controlled "write anything,
anywhere, at any time"). By making the more sensitive data structures
of the kernel read-only, we reduce the risk of an attacker finding a
path to manipulating the kernel's behavior in a significant way.

Examples of typical sensitive targets are function pointers, security
policy, and page tables. Having these "read only at rest" makes them
much harder to control by an attacker using memory integrity flaws. We
already have the .rodata section for "const" things. Those are
trivially read-only. For example there is a long history of making
sure that function pointer tables are marked "const". However, some
things need to stay writable. Some of those in .data aren't changed
after __init, so we added the __ro_after_init which made them
read-only for the life of the system after __init. However, we're
still left with a lot of sensitive structures either in .data or
dynamically allocated, that need a way to be made read-only for most
of the time, but get written to during very specific times.

The "write rarely" name itself may not sufficiently describe what is
wanted either (I'll take the blame for the inaccurate name), so I'm
open to new ideas there. The implementation requirements for the
"sensitive data read-only at rest" feature are rather tricky:

- allow writes only from specific places in the kernel
- keep those locations inline to avoid making them trivial ROP targets
- keep the writeability window open only to a single uninterruptable CPU
- fast enough to deal with page table updates

The proposal I made a while back only covered .data things (and used
x86-specific features). Igor's proposal builds on this by including a
way to do this with dynamic allocation too, which greatly expands the
scope of structures that can be protected. Given that the x86-only
method of write-window creation was firmly rejected, this is a new
proposal for how to do it (vmap window). Using switch_mm() has also
been suggested, etc.

We need to find a good way to do the write-windowing that works well
for static and dynamic structures _and_ for the page tables... this
continues to be tricky.

Making it resilient against ROP-style targets makes it difficult to
deal with certain data structures (like list manipulation). In my
earlier RFC, I tried to provide enough examples of where this could
get used to let people see some of the complexity[1]. Igor's series
expands this to even more examples using dynamic allocation.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/write-rarely

-- 
Kees Cook
