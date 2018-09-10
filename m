Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6297EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C08420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C08420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeIJMcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:32:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeIJMcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:32:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90C46AEF6;
        Mon, 10 Sep 2018 07:39:40 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:39:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings
Message-ID: <20180910073938.GA16723@dhcp22.suse.cz>
References: <20180907130550.11885-1-mhocko@kernel.org>
 <f7ed71c1-d599-5257-fd8f-041eb24d9f29@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ed71c1-d599-5257-fd8f-041eb24d9f29@profihost.ag>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Vlastimil. The full report is http://lkml.kernel.org/r/f7ed71c1-d599-5257-fd8f-041eb24d9f29@profihost.ag]
On Sat 08-09-18 20:52:35, Stefan Priebe - Profihost AG wrote:
> [305146.987742] khugepaged: page allocation stalls for 224236ms, order:9,
> mode:0x4740ca(__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|__GFP_MOVABLE|__GFP_DIRECT_RECLAIM), nodemask=(null)

This is certainly not a result of this patch AFAICS. khugepaged does add
__GFP_THISNODE regardless of what alloc_hugepage_khugepaged_gfpmask
thinks about that flag. Something to look into as well I guess.

Anyway, I guess we want to look closer at what compaction is doing here
because such a long stall is really not acceptable at all. Maybe this is
something 4.12 kernel related. This is hard to tell. Unfortunatelly,
upstream has lost the stall warning so you wouldn't know this is the
case with newer kernels.

Anyway, running with compaction tracepoints might tell us more.
Vlastimil will surely help to tell you which of them to enable.
-- 
Michal Hocko
SUSE Labs
