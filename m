Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D750CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F4320823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfBUUlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:41:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUUlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:41:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE5A6882EF;
        Thu, 21 Feb 2019 20:41:43 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 378C65C28F;
        Thu, 21 Feb 2019 20:41:43 +0000 (UTC)
Date:   Thu, 21 Feb 2019 15:41:41 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: question about page tables in DAX/FS/PMEM case
Message-ID: <20190221204141.GB5201@redhat.com>
References: <20190220230622.GI19341@ubuette>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190220230622.GI19341@ubuette>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 20:41:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:06:22PM -0800, Larry Bassel wrote:
> I'm working on sharing page tables in the DAX/XFS/PMEM/PMD case.
> 
> If multiple processes would use the identical page of PMDs corresponding
> to a 1 GiB address range of DAX/XFS/PMEM/PMDs, presumably one can instead
> of populating a new PUD, just atomically increment a refcount and point
> to the same PUD in the next level above.

I think page table sharing was discuss several time in the past and
the complexity involve versus the benefit were not clear. For 1GB
of virtual address you need:
    #pte pages = 1G/(512 * 2^12)       = 512 pte pages
    #pmd pages = 1G/(512 * 512 * 2^12) = 1   pmd pages

So if we were to share the pmd directory page we would be saving a
total of 513 pages for every page table or ~2MB. This goes up with
the number of process that map the same range ie if 10 process map
the same range and share the same pmd than you are saving 9 * 2MB
18MB of memory. This seems relatively modest saving.

AFAIK there is no hardware benefit from sharing the page table
directory within different page table. So the only benefit is the
amount of memory we save.

See below for comments on complexity to achieve this.

> 
> i.e.
> 
> OLD:
> process 1:
> VA -> levels of page tables -> PUD1 -> page of PMDs1
> process 2:
> VA -> levels of page tables -> PUD2 -> page of PMDs2
> 
> NEW:
> process 1:
> VA -> levels of page tables -> PUD1 -> page of PMDs1
> process 2:
> VA -> levels of page tables -> PUD1 -> page of PMDs1 (refcount 2)
> 
> There are several cases to consider:
> 
> 1. New mapping
> OLD:
> make a new PUD, populate the associated page of PMDs
> (at least partially) with PMD entries.
> NEW:
> same
> 
> 2. Mapping by a process same (same VA->PA and size and protections, etc.)
> as one that already exists
> OLD:
> make a new PUD, populate the associated page of PMDs
> (at least partially) with PMD entries.
> NEW:
> use same PUD, increase refcount (potentially even if this mapping is private
> in which case there may eventually be a copy-on-write -- see #5 below)
> 
> 3. Unmapping of a mapping which is the same as that from another process
> OLD:
> destroy the process's copy of mapping, free PUD, etc.
> NEW:
> decrease refcount, only if now 0 do we destroy mapping, etc.
> 
> 4. Unmapping of a mapping which is unique (refcount 1)
> OLD:
> destroy the process's copy of mapping, free PUD, etc.
> NEW:
> same
> 
> 5. Mapping was private (but same as another process), process writes
> OLD:
> break the PMD into PTEs, destroy PMD mapping, free PUD, etc..
> NEW:
> decrease refcount, only if now 0 do we destroy mapping, etc.
> we still break the PMD into PTEs.
> 
> If I have a mmap of a DAX/FS/PMEM file and I take
> a page (either pte or PMD sized) fault on access to this file,
> the page table(s) are set up in dax_iomap_fault() in fs/dax.c (correct?).

Not exactly the page table are allocated long before dax_iomap_fault()
get calls. They are allocated by the handle_mm_fault() and its childs
functions.

> 
> If the process later munmaps this file or exits but there are still
> other users of the shared page of PMDs, I would need to
> detect that this has happened and act accordingly (#3 above)
> 
> Where will these page table entries be torn down?
> In the same code where any other page table is torn down?
> If this is the case, what would the cleanest way of telling that these
> page tables (PMDs, etc.) correspond to a DAX/FS/PMEM mapping
> (look at the physical address pointed to?) so that
> I could do the right thing here.
> 
> I understand that I may have missed something obvious here.
> 

They are many issues here are the one i can think of:
    - finding a pmd/pud to share, you need to walk the reverse mapping
      of the range you are mapping and to find if any process or other
      virtual address already as a pud or pmd you can reuse. This can
      take more time than allocating page directory pages.
    - if one process munmap some portion of a share pud you need to
      break the sharing this means that munmap (or mremap) would need
      to handle this page table directory sharing case first
    - many code path in the kernel might need update to understand this
      share page table thing (mprotect, userfaultfd, ...)
    - the locking rules is bound to be painfull
    - this might not work on all architecture as some architecture do
      associate information with page table directory and that can not
      always be share (it would need to be enabled arch by arch)

The nice thing:
    - unmapping for migration, when you unmap a share pud/pmd you can
      decrement mapcount by share pud/pmd count this could speedup
      migration

This is what i could think of on the top of my head but there might be
other thing. I believe the question is really a benefit versus cost and
to me at least the complexity cost outweight the benefit one for now.
Kirill Shutemov proposed rework on how we do page table and this kind of
rework might tip the balance the other way. So my suggestion would be to
look into how the page table management can be change in a beneficial
way that could also achieve the page table sharing.

Cheers,
Jérôme
