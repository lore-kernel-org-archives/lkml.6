Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B592320878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeLEPyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:54:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEPyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:54:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AD7A307D915;
        Wed,  5 Dec 2018 15:54:08 +0000 (UTC)
Received: from redhat.com (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C257B827B6;
        Wed,  5 Dec 2018 15:53:59 +0000 (UTC)
Date:   Wed, 5 Dec 2018 10:53:57 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end calls
Message-ID: <20181205155357.GA3536@redhat.com>
References: <20181203201817.10759-1-jglisse@redhat.com>
 <20181203201817.10759-3-jglisse@redhat.com>
 <20181205110416.GE22304@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205110416.GE22304@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 05 Dec 2018 15:54:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:04:16PM +0100, Jan Kara wrote:
> Hi Jerome!
> 
> On Mon 03-12-18 15:18:16, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > To avoid having to change many call sites everytime we want to add a
> > parameter use a structure to group all parameters for the mmu_notifier
> > invalidate_range_start/end cakks. No functional changes with this
> > patch.
> 
> Two suggestions for the patch below:
> 
> > @@ -772,7 +775,8 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
> >  		 * call mmu_notifier_invalidate_range_start() on our behalf
> >  		 * before taking any lock.
> >  		 */
> > -		if (follow_pte_pmd(vma->vm_mm, address, &start, &end, &ptep, &pmdp, &ptl))
> > +		if (follow_pte_pmd(vma->vm_mm, address, &range,
> > +				   &ptep, &pmdp, &ptl))
> >  			continue;
> 
> The change of follow_pte_pmd() arguments looks unexpected. Why should that
> care about mmu notifier range? I see it may be convenient but it doesn't look
> like a good API to me.

Saddly i do not see a way around that one this is because of fs/dax.c
which does the mmu_notifier_invalidate_range_end while follow_pte_pmd
do the mmu_notifier_invalidate_range_start

follow_pte_pmd does adjust the start and end address so that the dax
function does not have the logic to find those address. So instead of
duplicating that follow_pte_pmd inside the dax code i rather passed
around the range struct to follow_pte_pmd.

> 
> > @@ -1139,11 +1140,15 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
> >  				downgrade_write(&mm->mmap_sem);
> >  				break;
> >  			}
> > -			mmu_notifier_invalidate_range_start(mm, 0, -1);
> > +
> > +			range.start = 0;
> > +			range.end = -1UL;
> > +			range.mm = mm;
> > +			mmu_notifier_invalidate_range_start(&range);
> 
> Also how about providing initializer for struct mmu_notifier_range? Or
> something like DECLARE_MMU_NOTIFIER_RANGE? That will make sure that
> unused arguments for particular notification places have defined values and
> also if you add another mandatory argument (like you do in your third
> patch), you just add another argument to the initializer and that way
> the compiler makes sure you haven't missed any place. Finally the code will
> remain more compact that way (less lines needed to initialize the struct).

That is what i do in v2 :)

Thank you for looking to all this.

Cheers,
Jérôme
