Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFBEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F58420658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F58420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeICKXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:23:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbeICKXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:23:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D92CAF74;
        Mon,  3 Sep 2018 06:05:13 +0000 (UTC)
Date:   Mon, 3 Sep 2018 08:05:12 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?ISO-8859-15?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: Access to non-RAM pages
In-Reply-To: <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1809030801550.25787@cbobk.fhfr.pm>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com> <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <CA+55aFyqpg_e8dXZWhdyVLa0xSYcK6iuRTKDXxnFLaFEcqZHkQ@mail.gmail.com> <CA+55aFyOSLEbiNvPoHkHe8WXae_aJiS+jsnubG8Xk0CYw8U4uw@mail.gmail.com>
 <a1980256cf3d2ea8e91707fcda7cf141b27a212d.camel@kernel.crashing.org> <fd389fc96692e38c318f14f0da840cdecda8fbe5.camel@kernel.crashing.org> <CA+55aFz_Kbu2PDjqvmgqCFcFSsoRPD=a8vAtPY=--t61X454Jg@mail.gmail.com> <CA+55aFwSfXu1LXjLZe4gddY2VybEGLbPpx-PWinF19LjbevEgQ@mail.gmail.com>
 <a2b20fc447e0b2cd208dc82081cb24e38bf71f68.camel@kernel.crashing.org> <CA+55aFyhq23ce94Vq_XdCJSOKvo8oYnb2UOdjf-KVaaOFngr+g@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Sep 2018, Linus Torvalds wrote:

> Which basically doesn't happen on x86 in reality. BIOSes just don't put 
> MMIO right after the last page of RAM. I think this is why it only 
> triggered on Xen, due to some crazy "Xen reacts badly" case where we do 
> the speculation into a balloon address.
> 
> So _practically_ this is just a Xen bug, nothing more.

Yeah, and Xen guys are already working on fixing that AFAIK.

> But since in _theory_ you could have MMIO abut regular RAM directly, 
> it's worth maybe making sure it's purely theory.

Well, we've been hit by similar/related issue in practice, on x86 machines 
where GART aperture is being mapped over physical RAM. For the curious -- 
see commit 2a3e83c6f ("x86/gart: Exclude GART aperture from vmcore").

Thanks,

-- 
Jiri Kosina
SUSE Labs

