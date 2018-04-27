Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757936AbeD0KRO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:17:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757823AbeD0KRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:17:13 -0400
Date: Fri, 27 Apr 2018 06:17:12 -0400 (EDT)
From: Chunyu Hu <chuhu@redhat.com>
Reply-To: Chunyu Hu <chuhu@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Hocko <mhocko@kernel.org>, Chunyu Hu <chuhu.ncepu@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Message-ID: <1591480647.20311538.1524824232546.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180426125634.uybpbbk5puee7fsg@armageddon.cambridge.arm.com>
References: <1524243513-29118-1-git-send-email-chuhu@redhat.com> <CACT4Y+YWUgyzCBadg+Oe8wDkFCaBzmcKDgu3rKjQxim7NXNLpg@mail.gmail.com> <CABATaM6eWtssvuj3UW9LHLK3HWo8P9g0z9VzFnuqKPKO5KMJ3A@mail.gmail.com> <20180424132057.GE17484@dhcp22.suse.cz> <850575801.19606468.1524588530119.JavaMail.zimbra@redhat.com> <20180424170239.GP17484@dhcp22.suse.cz> <732114897.20075296.1524745398991.JavaMail.zimbra@redhat.com> <20180426125634.uybpbbk5puee7fsg@armageddon.cambridge.arm.com>
Subject: Re: [RFC] mm: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in
 gfp_kmemleak_mask
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.5]
Thread-Topic: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in gfp_kmemleak_mask
Thread-Index: 95TXp4Iul8QzeHq/kZJ7UDe+kvK3Dg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Catalin Marinas" <catalin.marinas@arm.com>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: "Michal Hocko" <mhocko@kernel.org>, "Chunyu Hu" <chuhu.ncepu@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>,
> "LKML" <linux-kernel@vger.kernel.org>, "Linux-MM" <linux-mm@kvack.org>
> Sent: Thursday, April 26, 2018 8:56:35 PM
> Subject: Re: [RFC] mm: kmemleak: replace __GFP_NOFAIL to GFP_NOWAIT in gfp_kmemleak_mask
> 
> On Thu, Apr 26, 2018 at 08:23:19AM -0400, Chunyu Hu wrote:
> > kmemleak is using kmem_cache to record every pointers returned from kernel
> > mem
> > allocation activities such as kmem_cache_alloc(). every time an object from
> > slab allocator is returned, a following new kmemleak object is allocated.
> > 
> > And when a slab object is freed, then the kmemleak object which contains
> > the ptr will also be freed.
> > 
> > and kmemleak scan thread will run in period to scan the kernel data, stack,
> > and per cpu areas to check that every pointers recorded by kmemleak has at
> > least
> > one reference in those areas beside the one recorded by kmemleak. If there
> > is no place in the memory acreas recording the ptr, then it's possible a
> > leak.
> > 
> > so once a kmemleak object allocation failed, it has to disable itself,
> > otherwise
> > it would lose track of some object pointers, and become less meaningful to
> > continue record and scan the kernel memory for the pointers. So disable
> > it forever. so this is why kmemleak can't tolerate a slab alloc fail (from
> > fault injection)
> > 
> > @Catalin,
> > 
> > Is this right? If something not so correct or precise, please correct me.
> 
> That's a good description, thanks.
> 
> > I'm thinking about, is it possible that make kmemleak don't disable itself
> > when fail_page_alloc is enabled?  I can't think clearly what would happen
> > if several memory allocation missed by kmelkeak trace, what's the bad
> > result?
> 
> Take for example a long linked list. If kmemleak doesn't track an object
> in such list (because the metadata allocation failed), such list_head is
> never scanned and the subsequent objects in the list (pointed at by
> 'next') will be reported as leaks. Kmemleak pretty much becomes unusable
> with a high number of false positives.

Thanks for the example, one object may contain many pointers, so loose one,
means many false reports. I'm clear now. 

> 
> --
> Catalin
> 

-- 
Regards,
Chunyu Hu
