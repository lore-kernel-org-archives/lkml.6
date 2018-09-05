Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FDF20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qSOmkZKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FDF20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIERZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:25:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33897 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIERZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:25:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so3459631pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZg8raJ7r688tTuKnt57q17VC8oTw5jtp2q0T7gCjuI=;
        b=qSOmkZKFbi3HLzBnlzxiTADXk/OWkcmylawlPyIhFH5GUyxXdvPPfE1j/BhX6e2EKX
         pFX3iRC723cIMivIAfBMN3AsuB19SJGWwRLPpb+q2yJXqzlPHttFvEtabzgwnkII7OM0
         Ftx3E1nfKcQNAZ02rIaa8bhIJ5mq5R+53RI5njqo5jlliXM9OB5X6CVSg38UGqbxo9CN
         6vWqMj74hzuzeLF0hGgenaMxK1+EdjhQcAbw+bN0J2D74W/NQSdSt7FVmvTPegAsninD
         +6gq5bIJocomYxIC7p4H1q1k86FzZ2vO6xWDps1So5pCjCz5ZCH8ws7+nl0PmTV24LM0
         q5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZg8raJ7r688tTuKnt57q17VC8oTw5jtp2q0T7gCjuI=;
        b=fLQNQGAEGTVHUg5ZuwOR/biZJxMKLOHdWd8DiV/zJwxF5tOech712u16l2ZpqA1Jun
         kukjUwmZJ1Kb5KrGJYp6IUL+SGc7OLpiKfgimDYSWArWvCVzKFRBcwkQQJhzfCilTjMI
         h4k0pLF0Ojsn9AtAvAS42Jd0xLBPTDK41PfKudK+VyGN6ZpYg51O5iI1IC4nrHfny4SG
         cz2vZkM6AIupyNJCKQ0S3osry9yp0cncLX+oN6YuGeaF3PKm65w9fXHTerw5CXC4j1vF
         u3u2gY5oEaKKCxPr81JbakNZCQT/0+qS+nfb4sDey8NotwfThpG5kEQx/5Jsq+ECgPoc
         bhTA==
X-Gm-Message-State: APzg51A5cOdvDEmed2NA3WETBgcih1PhtPJrH6gpXUhCCZ+PjPXncCGz
        LhwtibduV+ySUZ3lDPeeICf7uQ==
X-Google-Smtp-Source: ANB0VdanKY+LSji4ec2hwVr99undYiiNMJL907QNClBZkjH37Dl9eqCZ23Yd6avxQpsX/dz4VKOkfg==
X-Received: by 2002:a62:2744:: with SMTP id n65-v6mr40652858pfn.125.1536152127541;
        Wed, 05 Sep 2018 05:55:27 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id c20-v6sm6557914pfh.143.2018.09.05.05.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:55:26 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id A427B300D96; Wed,  5 Sep 2018 15:55:22 +0300 (+03)
Date:   Wed, 5 Sep 2018 15:55:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Xu <peterx@redhat.com>
Cc:     Zi Yan <zi.yan@cs.rutgers.edu>, linux-kernel@vger.kernel.org,
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
Message-ID: <20180905125522.x2puwfn5sr2zo3go@kshutemo-mobl1>
References: <20180904075510.22338-1-peterx@redhat.com>
 <20180904080115.o2zj4mlo7yzjdqfl@kshutemo-mobl1>
 <D3B32B41-61D5-47B3-B1FC-77B0F71ADA47@cs.rutgers.edu>
 <20180905073037.GA23021@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905073037.GA23021@xz-x1>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 03:30:37PM +0800, Peter Xu wrote:
> On Tue, Sep 04, 2018 at 10:00:28AM -0400, Zi Yan wrote:
> > On 4 Sep 2018, at 4:01, Kirill A. Shutemov wrote:
> > 
> > > On Tue, Sep 04, 2018 at 03:55:10PM +0800, Peter Xu wrote:
> > >> When splitting a huge page, we should set all small pages as dirty if
> > >> the original huge page has the dirty bit set before.  Otherwise we'll
> > >> lose the original dirty bit.
> > >
> > > We don't lose it. It got transfered to struct page flag:
> > >
> > > 	if (pmd_dirty(old_pmd))
> > > 		SetPageDirty(page);
> > >
> > 
> > Plus, when split_huge_page_to_list() splits a THP, its subroutine __split_huge_page()
> > propagates the dirty bit in the head page flag to all subpages in __split_huge_page_tail().
> 
> Hi, Kirill, Zi,
> 
> Thanks for your responses!
> 
> Though in my test the huge page seems to be splitted not by
> split_huge_page_to_list() but by explicit calls to
> change_protection().  The stack looks like this (again, this is a
> customized kernel, and I added an explicit dump_stack() there):
> 
>   kernel:  dump_stack+0x5c/0x7b
>   kernel:  __split_huge_pmd+0x192/0xdc0
>   kernel:  ? update_load_avg+0x8b/0x550
>   kernel:  ? update_load_avg+0x8b/0x550
>   kernel:  ? account_entity_enqueue+0xc5/0xf0
>   kernel:  ? enqueue_entity+0x112/0x650
>   kernel:  change_protection+0x3a2/0xab0
>   kernel:  mwriteprotect_range+0xdd/0x110
>   kernel:  userfaultfd_ioctl+0x50b/0x1210
>   kernel:  ? do_futex+0x2cf/0xb20
>   kernel:  ? tty_write+0x1d2/0x2f0
>   kernel:  ? do_vfs_ioctl+0x9f/0x610
>   kernel:  do_vfs_ioctl+0x9f/0x610
>   kernel:  ? __x64_sys_futex+0x88/0x180
>   kernel:  ksys_ioctl+0x70/0x80
>   kernel:  __x64_sys_ioctl+0x16/0x20
>   kernel:  do_syscall_64+0x55/0x150
>   kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> At the very time the userspace is sending an UFFDIO_WRITEPROTECT ioctl
> to kernel space, which is handled by mwriteprotect_range().  In case
> you'd like to refer to the kernel, it's basically this one from
> Andrea's (with very trivial changes):
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git userfault
> 
> So... do we have two paths to split the huge pages separately?

We have two entiries that can be split: page table enties and underlying
compound page.

split_huge_pmd() (and variants of it) split the PMD entry into a PTE page
table. It doens't touch underlying compound page. The page still can be
mapped in other place as huge.

split_huge_page() (and ivariants of it) split compound page into a number
of 4k (or whatever PAGE_SIZE is). The operation requires splitting all
PMD, but not other way around.

> 
> Another (possibly very naive) question is: could any of you hint me
> how the page dirty bit is finally applied to the PTEs?  These two
> dirty flags confused me for a few days already (the SetPageDirty() one
> which sets the page dirty flag, and the pte_mkdirty() which sets that
> onto the real PTEs).

Dirty bit from page table entries transferes to sturct page flug and used
for decision making in reclaim path.

-- 
 Kirill A. Shutemov
