Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E7FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0512081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0512081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeLELEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:04:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:55804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLELET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:04:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 243A5AFD0;
        Wed,  5 Dec 2018 11:04:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2441B1E0DBB; Wed,  5 Dec 2018 12:04:16 +0100 (CET)
Date:   Wed, 5 Dec 2018 12:04:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20181205110416.GE22304@quack2.suse.cz>
References: <20181203201817.10759-1-jglisse@redhat.com>
 <20181203201817.10759-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203201817.10759-3-jglisse@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome!

On Mon 03-12-18 15:18:16, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> To avoid having to change many call sites everytime we want to add a
> parameter use a structure to group all parameters for the mmu_notifier
> invalidate_range_start/end cakks. No functional changes with this
> patch.

Two suggestions for the patch below:

> @@ -772,7 +775,8 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
>  		 * call mmu_notifier_invalidate_range_start() on our behalf
>  		 * before taking any lock.
>  		 */
> -		if (follow_pte_pmd(vma->vm_mm, address, &start, &end, &ptep, &pmdp, &ptl))
> +		if (follow_pte_pmd(vma->vm_mm, address, &range,
> +				   &ptep, &pmdp, &ptl))
>  			continue;

The change of follow_pte_pmd() arguments looks unexpected. Why should that
care about mmu notifier range? I see it may be convenient but it doesn't look
like a good API to me.

> @@ -1139,11 +1140,15 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  				downgrade_write(&mm->mmap_sem);
>  				break;
>  			}
> -			mmu_notifier_invalidate_range_start(mm, 0, -1);
> +
> +			range.start = 0;
> +			range.end = -1UL;
> +			range.mm = mm;
> +			mmu_notifier_invalidate_range_start(&range);

Also how about providing initializer for struct mmu_notifier_range? Or
something like DECLARE_MMU_NOTIFIER_RANGE? That will make sure that
unused arguments for particular notification places have defined values and
also if you add another mandatory argument (like you do in your third
patch), you just add another argument to the initializer and that way
the compiler makes sure you haven't missed any place. Finally the code will
remain more compact that way (less lines needed to initialize the struct).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
