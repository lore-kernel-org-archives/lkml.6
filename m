Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D16FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D97B21710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D97B21710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeI1AwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:52:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbeI1AwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:52:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85CC3B02B;
        Thu, 27 Sep 2018 18:32:38 +0000 (UTC)
Date:   Thu, 27 Sep 2018 20:32:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        riel@redhat.com, willy@infradead.org, minchan@kernel.org,
        peterz@infradead.org, ying.huang@intel.com, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net, arnd@arndb.de,
        mcgrof@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20180927183236.GJ6278@dhcp22.suse.cz>
References: <20180927175123.GA16367@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927175123.GA16367@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-09-18 23:21:23, Souptick Joarder wrote:
> vm_insert_kmem_page is similar to vm_insert_page and will
> be used by drivers to map kernel (kmalloc/vmalloc/pages)
> allocated memory to user vma.
> 
> Previously vm_insert_page is used for both page fault
> handlers and outside page fault handlers context. When
> vm_insert_page is used in page fault handlers context,
> each driver have to map errno to VM_FAULT_CODE in their
> own way. But as part of vm_fault_t migration all the
> page fault handlers are cleaned up by using new vmf_insert_page.
> Going forward, vm_insert_page will be removed by converting
> it to vmf_insert_page.
>  
> But their are places where vm_insert_page is used outside
> page fault handlers context and converting those to
> vmf_insert_page is not a good approach as drivers will end
> up with new VM_FAULT_CODE to errno conversion code and it will
> make each user more complex.
> 
> So this new vm_insert_kmem_page can be used to map kernel
> memory to user vma outside page fault handler context.
> 
> In short, vmf_insert_page will be used in page fault handlers
> context and vm_insert_kmem_page will be used to map kernel
> memory to user vma outside page fault handlers context.
> 
> We will slowly convert all the user of vm_insert_page to
> vm_insert_kmem_page after this API be available in linus tree.

In general I do not like patches adding a new exports/functionality
without any user added at the same time. I am not going to look at the
implementation right now but the above opens more questions than it
gives answers. Why do we have to distinguish #PF from other paths?
-- 
Michal Hocko
SUSE Labs
