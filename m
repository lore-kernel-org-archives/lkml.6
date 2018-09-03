Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C852054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C852054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeICOzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:55:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53612 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbeICOzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:55:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289E118A;
        Mon,  3 Sep 2018 03:35:58 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5FE23F614;
        Mon,  3 Sep 2018 03:35:57 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 951CC1AE3030; Mon,  3 Sep 2018 11:36:11 +0100 (BST)
Date:   Mon, 3 Sep 2018 11:36:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jiri Kosina <jikos@kernel.org>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Access to non-RAM pages
Message-ID: <20180903103610.GA11055@arm.com>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com>
 <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm>
 <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com>
 <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org>
 <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org>
 <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com>
 <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
 <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org>
 <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 07:10:46PM -0700, Linus Torvalds wrote:
> On Sun, Sep 2, 2018 at 7:01 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > Still, I can potentially see an issue with DEBUG_PAGEALLOC
> 
> An unmapped page isn't a problem. That's what the whole
> load_unaligned_zeropad() is about: it's ok to take a fault on the part
> that crosses a page, and we'll just fill the value with zeroes (that's
> the "zeropad" part).
> 
> So as long as it's rare (and it is), it's all fine.
> 
> That said, I think we turn off for DEBUG_PAGEALLOC simply because it's
> not rare _enough_.
> 
> And vmalloc() should actually be safe too, simply because I think we
> strive for a guard page between vmalloc areas.
> 
> So only a *mapped* page after the page that matters, and only if it's
> something you can't read without side effects.
> 
> Which basically doesn't happen on x86 in reality. BIOSes just don't
> put MMIO right after the last page of RAM. I think this is why it only
> triggered on Xen, due to some crazy "Xen reacts badly" case where we
> do the speculation into a balloon address.
> 
> So _practically_ this is just a Xen bug, nothing more.
> 
> But since in _theory_ you could have MMIO abut regular RAM directly,
> it's worth maybe making sure it's purely theory.

On arm64, ioremap() gives you a guard page because it allocates out of
the vmalloc area. The only way I think we could get MMIO in the middle
of the linear map would be if firmware has reserved something there. In
this case, the region should be treated as NOMAP, meaning we won't map
the area at all in the kernel and our pfn_valid() implementation will
return false for the corresponding memmap entries.

For userspace, we did consider putting out a guard page for non-fixed
mmap() calls, but it's not something we've really looked into.

Will
