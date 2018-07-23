Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBE220874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxVUBQZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBE220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeGWUR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:17:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46995 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbeGWUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:17:28 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so618038ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DkaMtM4DjnMoPDlWeHy7uwEJKVz8okbX+UW4YaZVHm8=;
        b=QxVUBQZJRZpgIZH/B+o5iWneNnlvsNQbfbd00GMJwaDGMc9hR/qsu9JPYjWMEzN4kJ
         W4sLHrSgllD6rOyEtm+bRS6uCkPWXXGEaRPmu4tUP0vsPJNIgL6Jsrj0bF/ncp/5a9lX
         B9CwginY7ets7qUJOr1wWWOfT96NktG6xTAuXnYUWwSkHYbmzzgxLxZsBO3wMJ/ZSA79
         6k0foBocyfZqyPiUe/vkSkSkTKJcfno/6cN18N1FaSKwtXr1I9PmGF1cu/aornK2JSMz
         T1CDrStl6/0boY32GXulo/R96PTDPnbR7aeqTOd8fEpoowzBnDFLRtijOlb04peiQccg
         znFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DkaMtM4DjnMoPDlWeHy7uwEJKVz8okbX+UW4YaZVHm8=;
        b=DvEEMFz/SjVzkh5IBZw9IGrbi0vUGfQY3LDRUANIfY6MOP4aw2VhhufGCRi1ReLrb7
         Sb5ygEiRM2OUKwRaofXhykHptHNyWCJc4OGvaBpyzOSOVzQ2RuolmnM5F0r/LpB9chvr
         dYpd09i4ukRBkry8FrVUSh9GUw1tT3JRpc65jvSwe0dip6RYmhkqy7ji6ho0KHfMJ888
         R1oXKWY/rnrazDHGfG20yy2wDcbgH8Q1Lkk786ktwuBhojJ2KEc0ETB0bD6HgXA3qN8J
         Y8xhdAF04u8siHRWggV9F9ymjWl5cufEQG3rYa8nW9kSXxuzD23b3cfBrZb5BTx32Bwl
         S72w==
X-Gm-Message-State: AOUpUlETNybW3Nc2isHtBw8g6Y55/d1dvLMbufC1xHSNBsdbTxl9v2M5
        0FWvpmfJZ01yaVd6rZ3pWAmIyg==
X-Google-Smtp-Source: AAOMgpdYGH8WCjf7+HUTbM4Pf9fD50h4OxzRzjUleLcQRoBlUbqCNrkCG1Nmdu0BGmVr5Z9tOrMbkQ==
X-Received: by 2002:a17:902:9695:: with SMTP id n21-v6mr14170414plp.6.1532373289708;
        Mon, 23 Jul 2018 12:14:49 -0700 (PDT)
Received: from [100.112.68.191] ([104.133.9.111])
        by smtp.gmail.com with ESMTPSA id n24-v6sm18787360pfi.161.2018.07.23.12.14.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 12:14:48 -0700 (PDT)
Date:   Mon, 23 Jul 2018 12:14:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
In-Reply-To: <20180723140150.GA31843@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
References: <000000000000d624c605705e9010@google.com> <20180709143610.GD2662@bombadil.infradead.org> <alpine.LSU.2.11.1807221856350.5536@eggly.anvils> <20180723140150.GA31843@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> On Sun, Jul 22, 2018 at 07:28:01PM -0700, Hugh Dickins wrote:
> > Whether or not that fixed syzbot's kernel BUG at mm/shmem.c:815!
> > I don't know, but I'm afraid it has not fixed linux-next breakage of
> > huge tmpfs: I get a similar page_to_pgoff BUG at mm/filemap.c:1466!
> > 
> > Please try something like
> > mount -o remount,huge=always /dev/shm
> > cp /dev/zero /dev/shm
> > 
> > Writing soon crashes in find_lock_entry(), looking up offset 0x201
> > but getting the page for offset 0x3c1 instead.
> 
> Hmm.  I don't see a crash while running that command,

Thanks for looking.

It is the VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page)
in find_lock_entry(). Perhaps you didn't have CONFIG_DEBUG_VM=y
on this occasion? Or you don't think of an oops as a kernel crash,
and didn't notice it in dmesg? I see now that I've arranged for oops
to crash, since I don't like to miss them myself; but it is a very
clean oops, no locks held, so can just kill the process and continue.

I recommend CONFIG_DEBUG_VM=y (for developers, not for distros), but
if you'd prefer to avoid it for now, just edit that VM_BUG_ON_PAGE()
in find_lock_entry() to a BUG_ON().

Or is there something more mysterious stopping it from showing up for
you? It's repeatable for me. When not crashing, that "cp" should fill
up about half of RAM before it hits the implicit tmpfs volume limit;
but I am assuming a not entirely fragmented machine - it does need
to allocate two 2MB pages before hitting the VM_BUG_ON_PAGE().

If you still can't see the crash, look to see how long /dev/shm/zero
is after the "cp": mine crashes a page or two over 2MB (I'm being
vague because I'm typing from the laptop I'd prefer not to reproduce
it on at the moment: I think it would be 1 page over, i_size not yet
updated for the page of index 0x201). But the xarray should by that
stage have been populated for two 2MB pages (by your "goto next" loop
in shmem_add_to_page_cache()).

> but I do see an RCU
> stall in find_get_entries() called from shmem_undo_range() when running
> 'cp' the second time -- ie while truncating the /dev/shm/zero file.

When I stopped oops crashing, I did indeed hang on that second attempt:
no "RCU stall" seen, but I've probably missed the relevant config option.

I wouldn't like to predict what happens if find_get_entry() returns the
wrong page when that VM_BUG_ON_PAGE() is compiled out, very confusing.
If it's compiled in, but just killed the process and dmesg was missed,
then there's an unlocked page lock which will indeed hang a subsequent
truncate (if the xarray yields the same wrong page again), though I
don't know if that would amount to an RCU stall.

> Maybe I'm seeing the same bug as you, and maybe I'm seeing a different
> one.  Do we have a shmem test suite somewhere?

Not as such. xfstests works on tmpfs, huge or not, but I'd have to write
up a few instructions, note one or two "-g auto" tests to patch out since
they take forever on tmpfs, and the few failures expected; and update my
snapshot of the tree to check that over first (I pulled it last mid-May).

I'd rather not get into that at present: a working "cp" will be a great
step forward, then I can easily run xfstests on the fixed kernel.

> 
> > I've spent a while on it, but better turn over to you, Matthew:
> > my guess is that xas_create_range() does not create the layout
> > you expect from it.
> 
> I've dumped the XArray tree on my machine and it actually looks fine
> *except* that the pages pointed to are free!  That indicates to me I
> screwed up somebody's reference count somewhere.

I don't actually know what a good xarray for two 2MB pages should look
like, since the best I can find seems to be a bad one!

Are you sure that those pages are free, rather than most of them tails
of one of the two compound pages involved? I think it's the same in your
rewrite of struct page, the compound_head field (lru.next), with its low
bit set, were how to recognize a tail page.

Hugh
