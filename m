Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F7CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AEC21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548285173;
	bh=eUlux7236zRQGTNWkHWtzO3PQu6fP5caKEBP8oVHYKI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=C2tmLo+dPLoxLI1hGLldTqB9nl52CwWzgxKHRQ8BY3E1OB+MphnuZ0W6wVxLoozDI
	 ENu/XKl/y35ZEKOaIpIeTUiXyNQ88IgRuUFYjGZMDegmDXX+H3TNLu0Lxx6tVpCnBy
	 kxUqTu3Lc9KzEXDHqwTl41wtabtyU+OzILrtpJhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAWXMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:12:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:53524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbfAWXMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:12:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E373AF26;
        Wed, 23 Jan 2019 23:12:49 +0000 (UTC)
Date:   Thu, 24 Jan 2019 00:12:47 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
In-Reply-To: <CAHk-=wgy+1YT-Rhj5qWb_aCuBADhcq42GDKHB74sqrnOVPKzPg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1901240009560.6626@cbobk.fhfr.pm>
References: <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com> <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com> <20190110122442.GA21216@nautica>
 <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com> <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com> <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net>
 <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com> <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com> <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm>
 <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com> <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm> <CAHk-=wg+C65FJHB=Jx1OvuJP4kvpWdw+5G=XOXB6X_KB2XuofA@mail.gmail.com>
 <CAHk-=wgy+1YT-Rhj5qWb_aCuBADhcq42GDKHB74sqrnOVPKzPg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Linus Torvalds wrote:

> Side note: the inode_permission() addition to can_do_mincore() in that
> patch 0002, seems to be questionable. We do
> 
> +static inline bool can_do_mincore(struct vm_area_struct *vma)
> +{
> +       return vma_is_anonymous(vma)
> +               || (vma->vm_file && (vma->vm_file->f_mode & FMODE_WRITE))
> +               || inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
> +}
> 
> note how it tests whether vma->vm_file is NULL for the FMODE_WRITE
> test, but not for the inode_permission() test.
> 
> So either we test unnecessarily in the second line, or we don't
> properly test it in the third one.
> 
> I think the "test vm_file" thing may be unnecessary, because a
> non-anonymous mapping should always have a file pointer and an inode.
> But I could  imagine some odd case (vdso mapping, anyone?) that
> doesn't have a vm_file, but also isn't anonymous.

Hmm, good point.

So dropping the 'vma->vm_file' test and checking whether given vma is 
special mapping should hopefully provide the desired semantics, shouldn't 
it?

-- 
Jiri Kosina
SUSE Labs

