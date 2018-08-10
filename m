Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FE521CCE
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FE521CCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeHJO3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:29:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:40086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeHJO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:29:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9748ADB0;
        Fri, 10 Aug 2018 11:59:37 +0000 (UTC)
Date:   Fri, 10 Aug 2018 13:59:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, kirill@shutemov.name,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v7 PATCH 4/4] mm: unmap special vmas with regular
 do_munmap()
Message-ID: <20180810115937.GB1644@dhcp22.suse.cz>
References: <1533857763-43527-1-git-send-email-yang.shi@linux.alibaba.com>
 <1533857763-43527-5-git-send-email-yang.shi@linux.alibaba.com>
 <521a7d54-efdb-2401-c677-3f5fcbad557b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521a7d54-efdb-2401-c677-3f5fcbad557b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-08-18 11:51:54, Vlastimil Babka wrote:
> On 08/10/2018 01:36 AM, Yang Shi wrote:
> > Unmapping vmas, which have VM_HUGETLB | VM_PFNMAP flag set or
> > have uprobes set, need get done with write mmap_sem held since
> > they may update vm_flags.
> > 
> > So, it might be not safe enough to deal with these kind of special
> > mappings with read mmap_sem. Deal with such mappings with regular
> > do_munmap() call.
> > 
> > Michal suggested to make this as a separate patch for safer and more
> > bisectable sake.
> 
> Hm I believe Michal meant the opposite "evolution" though. Patch 2/4
> should be done in a way that special mappings keep using the regular
> path, and this patch would convert them to the new path. Possibly even
> each special case separately.

yes, that is what I meant. Each of the special case should have its own
patch and changelog explaining why it is safe.
-- 
Michal Hocko
SUSE Labs
