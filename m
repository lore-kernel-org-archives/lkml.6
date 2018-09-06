Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287EBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE7C20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE7C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeIFQTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:19:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728132AbeIFQTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51D93804BAAD;
        Thu,  6 Sep 2018 11:43:58 +0000 (UTC)
Received: from xz-x1 (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 440942027EA0;
        Thu,  6 Sep 2018 11:43:52 +0000 (UTC)
Date:   Thu, 6 Sep 2018 19:43:50 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugepage: mark splitted page dirty when needed
Message-ID: <20180906114350.GH16937@xz-x1>
References: <20180904075510.22338-1-peterx@redhat.com>
 <20180904080115.o2zj4mlo7yzjdqfl@kshutemo-mobl1>
 <D3B32B41-61D5-47B3-B1FC-77B0F71ADA47@cs.rutgers.edu>
 <20180905073037.GA23021@xz-x1>
 <BB56C67D-BDA0-4C14-B787-77504EC989C6@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BB56C67D-BDA0-4C14-B787-77504EC989C6@cs.rutgers.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 11:43:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 11:43:58 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:49:20AM -0400, Zi Yan wrote:
> On 5 Sep 2018, at 3:30, Peter Xu wrote:
> 
> > On Tue, Sep 04, 2018 at 10:00:28AM -0400, Zi Yan wrote:
> >> On 4 Sep 2018, at 4:01, Kirill A. Shutemov wrote:
> >>
> >>> On Tue, Sep 04, 2018 at 03:55:10PM +0800, Peter Xu wrote:
> >>>> When splitting a huge page, we should set all small pages as dirty if
> >>>> the original huge page has the dirty bit set before.  Otherwise we'll
> >>>> lose the original dirty bit.
> >>>
> >>> We don't lose it. It got transfered to struct page flag:
> >>>
> >>> 	if (pmd_dirty(old_pmd))
> >>> 		SetPageDirty(page);
> >>>
> >>
> >> Plus, when split_huge_page_to_list() splits a THP, its subroutine __split_huge_page()
> >> propagates the dirty bit in the head page flag to all subpages in __split_huge_page_tail().
> >
> > Hi, Kirill, Zi,
> >
> > Thanks for your responses!
> >
> > Though in my test the huge page seems to be splitted not by
> > split_huge_page_to_list() but by explicit calls to
> > change_protection().  The stack looks like this (again, this is a
> > customized kernel, and I added an explicit dump_stack() there):
> >
> >   kernel:  dump_stack+0x5c/0x7b
> >   kernel:  __split_huge_pmd+0x192/0xdc0
> >   kernel:  ? update_load_avg+0x8b/0x550
> >   kernel:  ? update_load_avg+0x8b/0x550
> >   kernel:  ? account_entity_enqueue+0xc5/0xf0
> >   kernel:  ? enqueue_entity+0x112/0x650
> >   kernel:  change_protection+0x3a2/0xab0
> >   kernel:  mwriteprotect_range+0xdd/0x110
> >   kernel:  userfaultfd_ioctl+0x50b/0x1210
> >   kernel:  ? do_futex+0x2cf/0xb20
> >   kernel:  ? tty_write+0x1d2/0x2f0
> >   kernel:  ? do_vfs_ioctl+0x9f/0x610
> >   kernel:  do_vfs_ioctl+0x9f/0x610
> >   kernel:  ? __x64_sys_futex+0x88/0x180
> >   kernel:  ksys_ioctl+0x70/0x80
> >   kernel:  __x64_sys_ioctl+0x16/0x20
> >   kernel:  do_syscall_64+0x55/0x150
> >   kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > At the very time the userspace is sending an UFFDIO_WRITEPROTECT ioctl
> > to kernel space, which is handled by mwriteprotect_range().  In case
> > you'd like to refer to the kernel, it's basically this one from
> > Andrea's (with very trivial changes):
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git userfault
> >
> > So... do we have two paths to split the huge pages separately?
> >
> > Another (possibly very naive) question is: could any of you hint me
> > how the page dirty bit is finally applied to the PTEs?  These two
> > dirty flags confused me for a few days already (the SetPageDirty() one
> > which sets the page dirty flag, and the pte_mkdirty() which sets that
> > onto the real PTEs).
> 
> change_protection() only causes splitting a PMD entry into multiple PTEs
> but not the physical compound page, so my answer does not apply to your case.
> It is unclear how the dirty bit makes your QEMU get a SIGBUS. I think you
> need to describe your problem with more details.

Hi, Zi,

I explained with some more details on my problem in my other reply to
Kirill.  Please have a look.

> 
> AFAIK, the PageDirty bit will not apply back to any PTEs. So for your case,
> when reporting a page’s dirty bit information, some function in the kernel only checks
> the PTE’s dirty bit but not the dirty bit in the struct page flags, which
> might provide a wrong answer.

Are you suggesting that we should always check both places (the PTE
dirty bit) and also the page flag to know whether a page is dirty
(hence, either of the bit set should mean the page is dirty)?

Thanks,

-- 
Peter Xu
