Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C03F20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C03F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeIYL4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:56:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeIYL4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:56:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35198B0AB;
        Tue, 25 Sep 2018 05:50:23 +0000 (UTC)
Date:   Tue, 25 Sep 2018 07:50:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in smaps
Message-ID: <20180925055022.GL18685@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com>
 <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
 <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz>
 <20180924200258.GK18685@dhcp22.suse.cz>
 <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-09-18 22:43:49, Vlastimil Babka wrote:
> On 9/24/18 10:02 PM, Michal Hocko wrote:
> > On Mon 24-09-18 21:56:03, Michal Hocko wrote:
[...]
> >> That being said, I do not object to the patch, I am just trying to
> >> understand what is the intended usage for the flag that does try to say
> >> more than the madvise status.
> > 
> > And moreover, how is the PR_SET_THP_DISABLE any different from the
> > global THP disabled case. Do we want to set all vmas to nh as well?
> 
> Probably not. It's easy to check the global status, but is it possible
> to query for the prctl flags of a process?

Dunno but I suspect there is no way to check for this.

> We are looking at process or
> even vma-specific flags here. If the prctl was historically implemented
> via VM_NOHUGEPAGE and thus reported as such in smaps, it makes sense to
> do so even with the MMF_ flag IMHO?

Yes if this breaks some userspace which relied on the previous behavior.
But if nothing really broke then I guess it would be better to have the
semantic as clear as possible. Go and check the global status to make
the whole picture doesn't look very sound to me. On the other hand this
VMA has a madvise flag on it sounds quite clear and you know what to
expect at least. Sure the hint might be ignored in the end but well,
these are hints they do not guarantee anything after all.
-- 
Michal Hocko
SUSE Labs
