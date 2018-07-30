Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E95616256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9BD204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JAV+u6BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9BD204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeG3TJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:09:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35833 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3TJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:09:08 -0400
Received: by mail-it0-f68.google.com with SMTP id q20-v6so380562ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4MB+Avo3ZXsHaKW3JB8ArpePPlFBMuC7LaL9vhQl9k=;
        b=JAV+u6BQ0hY8Lc9i8qk1omfMCpI9YZwcUykn60VYA80vIqlTUu53N0jaKjH9hQiBCK
         GFQvkOeBeIXZhmLpYy6yRWQ/Z4H1WrQSrdeq7Cv1BA7cjE9SAYxGcFq5LNg/cYkH+Y50
         OZkwQZ+gvSJhtFsL+H17Wrt3zQcFdxQTzKDmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4MB+Avo3ZXsHaKW3JB8ArpePPlFBMuC7LaL9vhQl9k=;
        b=BNZc4/RjHt82hTk3rITydLRv2RdZxt6TlbMeK2E9c/meB4VAKnDIaogj2L5ZT9TS5X
         /dEgegCy4B57DY95rtGhi5cw0fdURYUVDwQH1YRn7fiXPAkNciBSyfc7R77GNrbxYxED
         paInGxX08iy1QBq8fSkrRKu3LzQFWxUFVj8ObCgEv2kyjrsUYBdlVT33908rBOPSncT4
         Pgj79M3R3sPOOpVg7Lu99mVeCs/lq9hPWfLUWDIaxkLZh6XO6HUNARJMLRW3kUfyCGHh
         joPY+05sobOr+2Tm09Sjd4uagWH0YL3TG+mqExCs5TOmDGHhoREl7xYa1D6CGYBg5ZJa
         4Zkw==
X-Gm-Message-State: AOUpUlGn3NFs22Mmyay6mUdGmTvZGzf4d6X1MSVozgCwd9w39xdJADmh
        qT8dhqjQcNqFLkWn+ygm4U8Mh1xp5LBamwBdYKk=
X-Google-Smtp-Source: AAOMgpfBtYlpefvBOl6xvq1nKzSloBc78VpBSPzzYilTm6Y1uCktT4wQ4kO9NaCxJ5EA8vPYD8hRYTK76nfmNofxQpg=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr197510itm.113.1532971986742;
 Mon, 30 Jul 2018 10:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com> <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
In-Reply-To: <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Jul 2018 10:32:55 -0700
Message-ID: <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling257@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 6:01 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I think I missed vma_set_anonymous() somewhere, but I fail to see where.

Honestly, by now we just need to revert that commit.

It's not even clear that it was a good idea to begin with. The rest of
the commits were cleanups, this one was driven by a incorrect
VM_BUG_ON() that triggered, and that checked "vma_is_anonymous(vma)"
without any explanations of wht it should matter.

I think the biggest problem with vma_is_anonymous() may be its name,
not what it does.

What the code historically *did* (and what vma_is_anonymous() checks)
is not "is this anonymous", but rather "does this have any special
operations associated with it".

The two are similar. But people have grown opinions about exactly what
"anonymous" means. If we had named it just "no_vm_ops()", we wouldn't
have random crazy checks for "vma_is_anonymous()" in places where it
makes no sense.

So what I think we want a real explanation for is why people who use
"vma_is_anonymous()" care. Instead of trying to change its very
historical meaning, we should look at the users, and perhaps change
its name.

In this case, for example, I think the *real* problem was described by
commit 684283988f70 ("huge pagecache: mmap_sem is unlocked when
truncation splits pmd"), and the problem is that an existing check
that required that mmap_sem was held was changed to say "only for
anonymous mappings".

But the fact is, you can truncate mappings that don't have any ops just *fine*.

So maybe that original BUG() was entirely bogus to begin with, and it
shouldn't exist at all?

Or maybe the code should test "do I have a vm_file" instead of testing
"do I have vm_ops"?

What's the problem with just doing split_huge_pmd() there when it's a
pmd_trans_huge or pmd_devmap pmd? Why is that VM_BUG_ON_VMA() there in
the first place? Why are allegedly "anonymous" mappings so special
here for locking?

Adding a few more people to the cc, they were involved the last that
time VM_BUG_ON_VMA() was modified.

New people: see commit bfd40eaff5ab ("mm: fix vma_is_anonymous()
false-positives") for details. Right now I think it's getting
reverted, but the oops explanation in the commit is about that

            kernel BUG at mm/memory.c:1422!

which was/is debatable and seems to make no sense (and definitely is
still triggerable despite that commit 684283988f70 ("huge pagecache:
mmap_sem is unlocked when truncation splits pmd") that limited it a
bit - but I think it didn't limit it enough.

               Linus
