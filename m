Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DFC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497D621736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545677472;
	bh=CA6lm7zfVPzLfZ29Ef/YdFILpnXpni6xFLxmrlnACAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kduj1y7BCtEp3JGUg3y0aus8hSb4vCGpgWpSLFSMRuDUPxh/CeIamqPf42InGNm+A
	 qX6JdZUiqrJYpIfVWdlbSI5lVyDpOuI4AXhystw9mIpsUPiRdlUfhcTUrGQgvSKr0u
	 RqTBxW6zEmh+yUTHeItKBpsigIZurw4qLryzSuRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLXSvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:51:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49334 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbeLXSvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:51:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F018CAF53;
        Mon, 24 Dec 2018 18:51:08 +0000 (UTC)
Date:   Mon, 24 Dec 2018 19:51:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Paul Oppenheimer <bepvte@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug with report THP eligibility for each vma
Message-ID: <20181224185106.GC16738@dhcp22.suse.cz>
References: <CALouPAi8KEuPw_Ly5W=MkYi8Yw3J6vr8mVezYaxxVyKCxH1x_g@mail.gmail.com>
 <20181224074916.GB9063@dhcp22.suse.cz>
 <20181224121250.GA2070@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224121250.GA2070@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-12-18 14:12:51, Mike Rapoport wrote:
> On Mon, Dec 24, 2018 at 08:49:16AM +0100, Michal Hocko wrote:
> > [Cc-ing mailing list and people involved in the original patch]
> > 
> > On Fri 21-12-18 13:42:24, Paul Oppenheimer wrote:
> > > Hello! I've never reported a kernel bug before, and since its on the
> > > "next" tree I was told to email the author of the relevant commit.
> > > Please redirect me to the correct place if I've made a mistake.
> > > 
> > > When opening firefox or chrome, and using it for a good 7 seconds, it
> > > hangs in "uninterruptible sleep" and I recieve a "BUG" in dmesg. This
> > > doesn't occur when reverting this commit:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=48cf516f8c.
> > > Ive attached the output of decode_stacktrace.sh and the relevant dmesg
> > > log to this email.
> > > 
> > > Thanks
> > 
> > > BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
> > 
> > Thanks for the bug report! This is offset 232 and that matches
> > file->f_mapping as per pahole
> > pahole -C file ./vmlinux | grep f_mapping
> >         struct address_space *     f_mapping;            /*   232     8 */
> > 
> > I thought that each file really has to have a mapping. But the following
> > should heal the issue and add an extra care.
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index f64733c23067..fc9d70a9fbd1 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -66,6 +66,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> >  {
> >  	if (vma_is_anonymous(vma))
> >  		return __transparent_hugepage_enabled(vma);
> > +	if (!vma->vm_file || !vma->vm_file->f_mapping)
> > +		return false;
> >  	if (shmem_mapping(vma->vm_file->f_mapping) && shmem_huge_enabled(vma))
> >  		return __transparent_hugepage_enabled(vma);
> 
> We have vma_is_shmem(), it can be used to replace shmem_mapping() without
> adding the check for !vma->vm_file

Yes, this looks like a much better choice. Thanks! Andrew, could you
fold this in instead.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f64733c23067..e093cf5e4640 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -66,7 +66,7 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	if (vma_is_anonymous(vma))
 		return __transparent_hugepage_enabled(vma);
-	if (shmem_mapping(vma->vm_file->f_mapping) && shmem_huge_enabled(vma))
+	if (vma_is_shmem(vma) && shmem_huge_enabled(vma))
 		return __transparent_hugepage_enabled(vma);
 
 	return false;
-- 
Michal Hocko
SUSE Labs
