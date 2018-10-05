Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB415C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A35A2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A35A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeJEVyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbeJEVyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC462C0624CB;
        Fri,  5 Oct 2018 14:55:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BA6743FDE;
        Fri,  5 Oct 2018 14:55:47 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] fs/dcache: Track # of negative dentries
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1536773742-32687-1-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7054d7fe-5385-c743-b2ea-595e5988799f@redhat.com>
Date:   Fri, 5 Oct 2018 10:55:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1536773742-32687-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 05 Oct 2018 14:55:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 01:35 PM, Waiman Long wrote:
>  v3->v4:
>   - Drop patch 4 as it is just a minor optimization.
>   - Add a cc:stable tag to patch 1.
>   - Clean up some comments in patch 3.
>
>  v2->v3:
>   - With confirmation that the dummy array in dentry_stat structure
>     was never a replacement of a previously used field, patch 3 is now
>     reverted back to use one of dummy field as the negative dentry count
>     instead of adding a new field.
>
>  v1->v2:
>   - Clarify what the new nr_dentry_negative per-cpu counter is tracking
>     and open-code the increment and decrement as suggested by Dave Chinner.
>   - Append the new nr_dentry_negative count as the 7th element of dentry-state
>     instead of replacing one of the dummy entries.
>   - Remove patch "fs/dcache: Make negative dentries easier to be
>     reclaimed" for now as I need more time to think about what
>     to do with it.
>   - Add 2 more patches to address issues found while reviewing the
>     dentry code.
>   - Add another patch to change the conditional branch of
>     nr_dentry_negative accounting to conditional move so as to reduce
>     the performance impact of the accounting code.
>
> This patchset addresses 2 issues found in the dentry code and adds a
> new nr_dentry_negative per-cpu counter to track the total number of
> negative dentries in all the LRU lists.
>
> Patch 1 fixes a bug in the accounting of nr_dentry_unused in
> shrink_dcache_sb().
>
> Patch 2 removes the ____cacheline_aligned_in_smp tag from super_block
> LRU lists.
>
> Patch 3 adds the new nr_dentry_negative per-cpu counter.
>
> Various filesystem related tests were run and no statistically
> significant changes in performance outside of the possible noise range
> was observed.
>
> Waiman Long (3):
>   fs/dcache: Fix incorrect nr_dentry_unused accounting in
>     shrink_dcache_sb()
>   fs: Don't need to put list_lru into its own cacheline
>   fs/dcache: Track & report number of negative dentries
>
>  Documentation/sysctl/fs.txt | 26 ++++++++++++++++----------
>  fs/dcache.c                 | 38 +++++++++++++++++++++++++++++++++-----
>  include/linux/dcache.h      |  7 ++++---
>  include/linux/fs.h          |  9 +++++----
>  4 files changed, 58 insertions(+), 22 deletions(-)
>
Any comments on these patches. The first one actually is a bug fix.

Cheers,
Longman

