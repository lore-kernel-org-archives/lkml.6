Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71082081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544430853;
	bh=aVifK2kxtOs86Ua+9PYLk503errWF7w4ACy8S7TvXzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ltlz7RaHN+fjeq/vCe0DLl7B55mLn/m3J6lIOCERqsqX7GXhzst+u6469eIoww5i2
	 fzpJD4wDl0PLCvI8Gq+XOUfTy2J1wn3hYbKyUUmTiGBTNAMOsIQNeaIXJ6uAPjbao7
	 quNf0NqJWfat68m8uTnm5QobsEXqWdyOmBdSWouw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71082081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLJIeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:34:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbeLJIeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:34:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E81F5AD75;
        Mon, 10 Dec 2018 08:34:09 +0000 (UTC)
Date:   Mon, 10 Dec 2018 09:34:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch for-4.20] Revert "mm, thp: consolidate THP gfp handling
 into alloc_hugepage_direct_gfpmask"
Message-ID: <20181210083409.GJ1286@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812061343240.144733@chino.kir.corp.google.com>
 <20181207080515.GT1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812071450270.173448@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812071450270.173448@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-12-18 15:05:28, David Rientjes wrote:
> On Fri, 7 Dec 2018, Michal Hocko wrote:
[...]
> > > Secondly, prior to 89c83fb539f9, alloc_pages_vma() implemented a somewhat 
> > > different policy for hugepage allocations, which were allocated through 
> > > alloc_hugepage_vma().  For hugepage allocations, if the allocating 
> > > process's node is in the set of allowed nodes, allocate with 
> > > __GFP_THISNODE for that node (for MPOL_PREFERRED, use that node with 
> > > __GFP_THISNODE instead).
> > 
> > Why is it wrong to fallback to an explicitly configured mbind mask?
> > 
> 
> The new_page() case is similar to the shmem_alloc_hugepage() case.  Prior 
> to 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into 
> alloc_hugepage_direct_gfpmask"), shmem_alloc_hugepage() did 
> alloc_pages_vma() with hugepage == true, which effected a different 
> allocation policy: if the node current is running on is allowed by the 
> policy, use __GFP_THISNODE (considering ac5b2c18911ff is reverted, which 
> it is in Linus's tree).
> 
> After 89c83fb539f9, we lose that and can fallback to remote memory.  Since 
> the discussion is on-going wrt the NUMA aspects of hugepage allocations, 
> it's better to have a stable 4.20 tree while that is being worked out and 
> likely deserves separate patches for both new_page() and 
> shmem_alloc_hugepage().  For the latter specifically, I assume it would be 
> nice to get an Acked-by by Kirill who implemented shmem_alloc_hugepage() 
> with hugepage == true back in 4.8 that also had the __GFP_THISNODE 
> behavior before the allocation policy is suddenly changed.

This should be a part of the changelog.

-- 
Michal Hocko
SUSE Labs
