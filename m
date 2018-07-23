Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5843ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7999120685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukPeC3e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7999120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbeGWVjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:39:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58230 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388022AbeGWVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JtEGvsljfhG34pEhaby5LTL0WEi9waFA2YPGquTe+YE=; b=ukPeC3e4XE+NktAG4x7dOFo1p
        q6IovBGM6CiXpUu38hws63caqrYKPJl6z+quo8Nhu/3b5fzzGpKS7j9g0NPjJJQbBzp8Ats5ampR/
        5N7jXLNs2IjGpCLY9Y/H3wDm9axn2FUTSN8UNJeRvvMutKvmGCquKVseSVW/vIUbrDu1+Io3FRjzu
        MuDPbE7xK8c5m6ybSLH9LznznU89n15/tU9dNyWtbmGF1BjPEYY2Rj/RygluUwkjPQaWzo48gt/Hy
        IY0nwDONATR5UgRAEm8Io3YsljVI7Kf65gqv5z1MeNs0gB6ooq2e0Ae4BYs61Me4xVENF0cbxanL5
        wrbfzZidg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhhZE-0003dG-AU; Mon, 23 Jul 2018 20:36:28 +0000
Date:   Mon, 23 Jul 2018 13:36:28 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+b8e0dfee3fd8c9012771@syzkaller.appspotmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at mm/shmem.c:LINE!
Message-ID: <20180723203628.GA18236@bombadil.infradead.org>
References: <000000000000d624c605705e9010@google.com>
 <20180709143610.GD2662@bombadil.infradead.org>
 <alpine.LSU.2.11.1807221856350.5536@eggly.anvils>
 <20180723140150.GA31843@bombadil.infradead.org>
 <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1807231111310.1698@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:14:41PM -0700, Hugh Dickins wrote:
> On Mon, 23 Jul 2018, Matthew Wilcox wrote:
> > On Sun, Jul 22, 2018 at 07:28:01PM -0700, Hugh Dickins wrote:
> > > Whether or not that fixed syzbot's kernel BUG at mm/shmem.c:815!
> > > I don't know, but I'm afraid it has not fixed linux-next breakage of
> > > huge tmpfs: I get a similar page_to_pgoff BUG at mm/filemap.c:1466!
> > > 
> > > Please try something like
> > > mount -o remount,huge=always /dev/shm
> > > cp /dev/zero /dev/shm
> > > 
> > > Writing soon crashes in find_lock_entry(), looking up offset 0x201
> > > but getting the page for offset 0x3c1 instead.
> > 
> > Hmm.  I don't see a crash while running that command,
> 
> Thanks for looking.
> 
> It is the VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page)
> in find_lock_entry(). Perhaps you didn't have CONFIG_DEBUG_VM=y
> on this occasion? Or you don't think of an oops as a kernel crash,
> and didn't notice it in dmesg? I see now that I've arranged for oops
> to crash, since I don't like to miss them myself; but it is a very
> clean oops, no locks held, so can just kill the process and continue.

Usually I run with that turned on, but somehow in my recent messing
with my test system, that got turned off.  Once I turned it back on,
it spots the bug instantly.

> Or is there something more mysterious stopping it from showing up for
> you? It's repeatable for me. When not crashing, that "cp" should fill
> up about half of RAM before it hits the implicit tmpfs volume limit;
> but I am assuming a not entirely fragmented machine - it does need
> to allocate two 2MB pages before hitting the VM_BUG_ON_PAGE().

I tried that too, before noticing that DEBUG_VM was off; raised my test
VM's memory from 2GB to 8GB.

> Are you sure that those pages are free, rather than most of them tails
> of one of the two compound pages involved? I think it's the same in your
> rewrite of struct page, the compound_head field (lru.next), with its low
> bit set, were how to recognize a tail page.

Yes, PageTail was set, and so was TAIL_MAPPING (0xdead0000000000400).
What was going on was the first 2MB page was being stored at indices
0-511, then the second 2MB page was being stored at indices 64-575
instead of 512-1023.

I figured out a fix and pushed it to the 'ida' branch in
git://git.infradead.org/users/willy/linux-dax.git

It won't be in linux-next tomorrow because the nvdimm people have
just dumped a pile of patches into their tree that conflict with
the XArray-DAX rewrite, so Stephen has pulled the XArray tree out
of linux-next temporarily.  I didn't have time to sort out the merge
conflict today because I judged your bug report more important.
