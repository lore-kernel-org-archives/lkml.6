Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22B720866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22B720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbeKFCSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:18:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:57240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387773AbeKFCSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:18:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DE8FB089;
        Mon,  5 Nov 2018 16:57:32 +0000 (UTC)
Date:   Mon, 5 Nov 2018 17:57:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2] mm/kvmalloc: do not call kmalloc for size >
 KMALLOC_MAX_SIZE
Message-ID: <20181105165730.GN4361@dhcp22.suse.cz>
References: <154106356066.887821.4649178319705436373.stgit@buzz>
 <154106695670.898059.5301435081426064314.stgit@buzz>
 <80074d2a-2f8d-a9db-892b-105c0ad7cd47@suse.cz>
 <d033db53-129d-c031-db78-ba7f9fed5bf4@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d033db53-129d-c031-db78-ba7f9fed5bf4@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 19:19:28, Konstantin Khlebnikov wrote:
> 
> 
> On 05.11.2018 16:03, Vlastimil Babka wrote:
> > On 11/1/18 11:09 AM, Konstantin Khlebnikov wrote:
> > > Allocations over KMALLOC_MAX_SIZE could be served only by vmalloc.
> > > 
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > 
> > Makes sense regardless of warnings stuff.
> > 
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > But it must be moved below the GFP_KERNEL check!
> 
> But kmalloc cannot handle it regardless of GFP.
> 
> Ok maybe write something like this
> 
> if (size > KMALLOC_MAX_SIZE) {
> 	if (WARN_ON_ONCE((flags & GFP_KERNEL) != GFP_KERNEL)
> 		return NULL;
> 	goto do_vmalloc;
> }

Do we really have to be so defensive? I agree with Vlastimil that the
check should be done after GFP_KERNEL check (I should have noticed that).
kmalloc should already complain on the allocation size request.

> or fix that uncertainty right in vmalloc
> 
> For now comment in vmalloc declares
> 
>  *	Any use of gfp flags outside of GFP_KERNEL should be consulted
>  *	with mm people.

Which is what we want. There are some exceptional cases where using a
subset of GFP_KERNEL works fine (e.g. scope nofs/noio context).

-- 
Michal Hocko
SUSE Labs
