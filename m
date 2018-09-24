Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E03ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6392145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6392145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeIXWzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:55:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:35788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729808AbeIXWzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:55:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C12C4AE6B;
        Mon, 24 Sep 2018 16:52:43 +0000 (UTC)
Date:   Mon, 24 Sep 2018 18:52:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/migrate: Split only transparent huge pages when
 allocation fails
Message-ID: <20180924164733.GG18685@dhcp22.suse.cz>
References: <1537798495-4996-1-git-send-email-anshuman.khandual@arm.com>
 <20180924143027.GE18685@dhcp22.suse.cz>
 <421f9b78-cb0f-01ce-dca0-93ff6eae0816@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421f9b78-cb0f-01ce-dca0-93ff6eae0816@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-09-18 22:10:30, Anshuman Khandual wrote:
> 
> 
> On 09/24/2018 08:00 PM, Michal Hocko wrote:
> > On Mon 24-09-18 19:44:55, Anshuman Khandual wrote:
> >> When unmap_and_move[_huge_page] function fails due to lack of memory, the
> >> splitting should happen only for transparent huge pages not for HugeTLB
> >> pages. PageTransHuge() returns true for both THP and HugeTLB pages. Hence
> >> the conditonal check should test PagesHuge() flag to make sure that given
> >> pages is not a HugeTLB one.
> > 
> > Well spotted! Have you actually seen this happening or this is review
> > driven? I am wondering what would be the real effect of this mismatch?
> > I have tried to follow to code path but I suspect
> > split_huge_page_to_list would fail for hugetlbfs pages. If there is a
> > more serious effect then we should mark the patch for stable as well.
> 
> split_huge_page_to_list() fails on HugeTLB pages. I was experimenting around
> moving 32MB contig HugeTLB pages on arm64 (with a debug patch applied) hit
> the following stack trace when the kernel crashed.
> 
> [ 3732.462797] Call trace:
> [ 3732.462835]  split_huge_page_to_list+0x3b0/0x858
> [ 3732.462913]  migrate_pages+0x728/0xc20
> [ 3732.462999]  soft_offline_page+0x448/0x8b0
> [ 3732.463097]  __arm64_sys_madvise+0x724/0x850
> [ 3732.463197]  el0_svc_handler+0x74/0x110
> [ 3732.463297]  el0_svc+0x8/0xc
> [ 3732.463347] Code: d1000400 f90b0e60 f2fbd5a2 a94982a1 (f9000420)

Please make sure this makes it to the changelog and mark the patch for
stable.

-- 
Michal Hocko
SUSE Labs
