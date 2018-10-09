Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0357EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF31213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF31213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJIURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:17:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeJIURa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:17:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9FC1AFC2;
        Tue,  9 Oct 2018 13:00:38 +0000 (UTC)
Date:   Tue, 9 Oct 2018 14:00:34 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181009130034.GD6931@suse.de>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-2-mhocko@kernel.org>
 <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com>
 <20181005073854.GB6931@suse.de>
 <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
 <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
 <20181009094825.GC6931@suse.de>
 <20181009122745.GN8528@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181009122745.GN8528@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:27:45PM +0200, Michal Hocko wrote:
> [Sorry for being slow in responding but I was mostly offline last few
>  days]
> 
> On Tue 09-10-18 10:48:25, Mel Gorman wrote:
> [...]
> > This goes back to my point that the MADV_HUGEPAGE hint should not make
> > promises about locality and that introducing MADV_LOCAL for specialised
> > libraries may be more appropriate with the initial semantic being how it
> > treats MADV_HUGEPAGE regions.
> 
> I agree with your other points and not going to repeat them. I am not
> sure madvise s the best API for the purpose though. We are talking about
> memory policy here and there is an existing api for that so I would
> _prefer_ to reuse it for this purpose.
> 

I flip-flopped on that one in my head multiple times on the basis of
how strict it should be. Memory policies tend to be black or white --
bind here, interleave there, etc. It wasn't clear to me what the best
policy would be to describe "allocate local as best as you can but allow
fallbacks if necessary". Hence, I started leaning towards advise as it is
really about advice that the kernel can ignore if necessary. That said,
I don't feel as strongly about the "how" as I do about the fact that
applications and libraries should not depend on side-effects of the
MADV_HUGEPAGE implementation that relate to locality.

-- 
Mel Gorman
SUSE Labs
