Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1403A208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="RRNWLvky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1403A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeLJN2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:28:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeLJN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:28:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so5408790pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t1tnI3RYCtsLsKaoQCJcqtyCZuE0YAMU0pLzWQcZG40=;
        b=RRNWLvkycupW1BVlNbXjYarKjosI1PePNW3vb0oLgsNP7kiQwln01FeSxpZLW6un1A
         wZ/6Ae58bRzaDMSJAjKOe1CaBwQImgEyEfRHNV62gTqetkGiR4VbQPgKo17oSaSpyTTZ
         C1qGzgVwzxt2x1du42h8WDppAWhKKepwBN41edkCBMVb5qggBkM5TZJs4S7QIzpZ7Xyr
         DDOAFG8QywNYVJsM7qeJFwtM0I87hi2RGg+0j4H3eImbJoIGkxLFZX6e+SQp07OlTzOl
         QTVUD/W1wdWw5huxEXAB1FJLlPjDNgWWefRrqOWXeR5Eg/U/WKSTTnEogOH59OUSGm0f
         oJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1tnI3RYCtsLsKaoQCJcqtyCZuE0YAMU0pLzWQcZG40=;
        b=oTNTh5GP2Sb4xqWqWu7m6ezfmONP6xsSCHekJYY4OjpmacSJjOyFjr/qzZZgZY05TU
         CQDjwLh/VMMBK0MV4cLQjaN9z5RIlrkuYn8NSkxUkYZHCJsqaA4HSaNNh8hZLKBq5tuo
         9KhtjH0CxqsQD00kemdkfZFub85iwRnnFLnxJljWpR2LEhv6EerNt0XiZWNGmneOgSJo
         bQdm4G5AYb57zVNXeLU072kv9ez30JCXDxhgXJTf8q1hCurbg6AyN31rmPR+OvcQEemn
         byRYV5u7vWOVXoemGTaW09mKJPrdh9HjHWuJHAlJPfqAgJ7XxSrVtE5pUHGfkAdjAOcn
         o3eg==
X-Gm-Message-State: AA+aEWae2seDSgbBuxyWJRhBaEOasJ8k0/qIMCjJU0RpNU6KE8F/Qg6n
        tleVt+wEXsKKQneuWx5BobsUxLDtgZk=
X-Google-Smtp-Source: AFSGD/XcqRD/Tmtf04o/O6QbKSp3qrYJPMU9668oCPgeK0FBFlhqTxVVfkFyN/YgjNHci/1MuxKIsQ==
X-Received: by 2002:a62:7a8b:: with SMTP id v133mr12632388pfc.159.1544448487294;
        Mon, 10 Dec 2018 05:28:07 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id h124sm14915319pfg.143.2018.12.10.05.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 05:28:06 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 98EB530155D; Mon, 10 Dec 2018 16:28:01 +0300 (+03)
Date:   Mon, 10 Dec 2018 16:28:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch for-4.20] Revert "mm, thp: consolidate THP gfp handling
 into alloc_hugepage_direct_gfpmask"
Message-ID: <20181210132801.mawxoqinwfjr65uz@kshutemo-mobl1>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1812061343240.144733@chino.kir.corp.google.com>
 <20181207080515.GT1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812071450270.173448@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812071450270.173448@chino.kir.corp.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 03:05:28PM -0800, David Rientjes wrote:
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

I do not have much experience with page_alloc/compaction/reclaim paths and
I don't feel that my opinion should have much weight here. Do not gate it
on me.

(I do follow the discussion, but I don't have anything meaningful to
contribute so far.)

-- 
 Kirill A. Shutemov
