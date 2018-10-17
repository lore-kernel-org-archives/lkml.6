Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED1AECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B08214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B08214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJQO7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:59:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbeJQO7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:59:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5547DAD25;
        Wed, 17 Oct 2018 07:05:32 +0000 (UTC)
Date:   Wed, 17 Oct 2018 09:05:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181017070531.GC18839@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com>
 <20181004055842.GA22173@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com>
 <20181004094637.GG22173@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com>
 <20181009083326.GG8528@dhcp22.suse.cz>
 <20181015150325.GN18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com>
 <20181016104855.GQ18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-10-18 14:24:19, David Rientjes wrote:
> On Tue, 16 Oct 2018, Michal Hocko wrote:
> 
> > > I don't understand the point of extending smaps with yet another line.  
> > 
> > Because abusing a vma flag part is just wrong. What are you going to do
> > when a next bug report states that the flag is set even though no
> > userspace has set it and that leads to some malfunctioning? Can you rule
> > that out? Even your abuse of the flag is surprising so why others
> > wouldn't be?
> > 
> 
> The flag has taken on the meaning of "thp disabled for this vma", how it 
> is set is not the scope of the flag.  If a thp is explicitly disabled from 
> being eligible for thp, whether by madvise, prctl, or any future 
> mechanism, it should use VM_NOHUGEPAGE or show_smap_vma_flags() needs to 
> be modified.

No, this is not the meaning which is documented

nh  - no-huge page advise flag

and as far as I know it is only you who has complained so far.
 
> > As I've said there are two things. Exporting PR_SET_THP_DISABLE to
> > userspace so that a 3rd party process can query it. I've already
> > explained why that might be useful. If you really insist on having
> > a per-vma field then let's do it properly now. Are you going to agree on
> > that? If yes, I am willing to spend my time on that but I am not going
> > to bother if this will lead to "I want my vma field abuse anyway".
> 
> I think what you and I want is largely irrelevant :)  What's important is 
> that there are userspace implementations that query this today so 
> continuing to support it as the way to determine if a vma has been thp 
> disabled doesn't seem problematic and guarantees that userspace doesn't 
> break.

Do you know of any other userspace except your usecase? Is there
anything fundamental that would prevent a proper API adoption for you?

-- 
Michal Hocko
SUSE Labs
