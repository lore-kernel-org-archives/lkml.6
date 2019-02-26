Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D68C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53A8218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551218672;
	bh=+FbU0LFLyZCGAWVEwYslXiIvPsGWX5FiDHPU2QaDJTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nDUaOUidtfftIZuWW0JjCOUnAVG2C2d3tIETYI6oCASLJVcaONSUbQ6ryoW2LtUd6
	 5l0Grw6k83Ttl7o1/mubzdXfpKkK7ab13xK9wLgTH8ETllxDPY7nGka6eOdZWaGQuC
	 Dhq6Xgz6AOQ/9ZSL0fXWikcRPpgI1fII5I+u6xiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfBZWEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:04:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:04:31 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8645D8251;
        Tue, 26 Feb 2019 22:04:30 +0000 (UTC)
Date:   Tue, 26 Feb 2019 14:04:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, hughd@google.com, kirill@shutemov.name,
        vbabka@suse.cz, joel@joelfernandes.org, jglisse@redhat.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net
Subject: Re: [PATCH] mm,mremap: Bail out earlier in mremap_to under map
 pressure
Message-Id: <20190226140428.3e7c8188eda6a54f9da08c43@linux-foundation.org>
In-Reply-To: <20190226091314.18446-1-osalvador@suse.de>
References: <20190226091314.18446-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 10:13:14 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> When using mremap() syscall in addition to MREMAP_FIXED flag,
> mremap() calls mremap_to() which does the following:
> 
> 1) unmaps the destination region where we are going to move the map
> 2) If the new region is going to be smaller, we unmap the last part
>    of the old region
> 
> Then, we will eventually call move_vma() to do the actual move.
> 
> move_vma() checks whether we are at least 4 maps below max_map_count
> before going further, otherwise it bails out with -ENOMEM.
> The problem is that we might have already unmapped the vma's in steps
> 1) and 2), so it is not possible for userspace to figure out the state
> of the vma's after it gets -ENOMEM, and it gets tricky for userspace
> to clean up properly on error path.
> 
> While it is true that we can return -ENOMEM for more reasons
> (e.g: see may_expand_vm() or move_page_tables()), I think that we can
> avoid this scenario in concret if we check early in mremap_to() if the
> operation has high chances to succeed map-wise.
> 
> Should not be that the case, we can bail out before we even try to unmap
> anything, so we make sure the vma's are left untouched in case we are likely
> to be short of maps.
> 
> The thumb-rule now is to rely on the worst-scenario case we can have.
> That is when both vma's (old region and new region) are going to be split
> in 3, so we get two more maps to the ones we already hold (one per each).
> If current map count + 2 maps still leads us to 4 maps below the threshold,
> we are going to pass the check in move_vma().
> 
> Of course, this is not free, as it might generate false positives when it is
> true that we are tight map-wise, but the unmap operation can release several
> vma's leading us to a good state.
> 
> Another approach was also investigated [1], but it may be too much hassle
> for what it brings.
> 

How is this going to affect existing userspace which is aware of the
current behaviour?

And how does it affect your existing cleanup code, come to that?  Does
it work as well or better after this change?
