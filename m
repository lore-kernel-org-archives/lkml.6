Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841D1C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19B620684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19B620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeKUDeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:34:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeKUDeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:34:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92258308213E;
        Tue, 20 Nov 2018 17:04:08 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47EBF1001F57;
        Tue, 20 Nov 2018 17:04:08 +0000 (UTC)
Date:   Tue, 20 Nov 2018 12:04:07 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mhocko@kernel.org, minchan@kernel.org, peterz@infradead.org,
        rientjes@google.com, vbabka@suse.cz, willy@infradead.org,
        ying.huang@intel.com, nitingupta910@gmail.com
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
Message-ID: <20181120170407.GM29258@redhat.com>
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109195150.GA24747@redhat.com>
 <20181110132249.GH23260@techsingularity.net>
 <20181110164412.GB22642@redhat.com>
 <20181120091122.3dxlgff3vivwilrg@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120091122.3dxlgff3vivwilrg@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 20 Nov 2018 17:04:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:11:22PM +0300, Kirill A. Shutemov wrote:
> On Sat, Nov 10, 2018 at 11:44:12AM -0500, Andrea Arcangeli wrote:
> > I would prefer to add intelligence to detect when COWs after fork
> > should be done at 2m or 4k granularity (in the latter case by
> > splitting the pmd before the actual COW while leaving the transhuge
> > pmd intact in the other mm), because that would save CPU (and it'd
> > automatically optimize redis). The snapshot process especially would
> > run faster as it will read with THP performance.
> 
> I would argue we should switch to 4k COW everywhere. But it requires some

We could do that if MADV_HUGEPAGE is not set for example. So there
would still be a way to force the 2M cows if something benefits from
them.

For example with binaries executed in tmpfs one could want 2M cows on
MAP_PRIVATE to keep all the executable in 2MB tlbs despite the memory
loss (but then there are those libs that apparently aren't released to
load the binaries into THP anon too for the same reason and with even
higher memory waste risk as unlike tmpfs nothing can be shared if you
run multiple copies of a go large binary or something).

Certainly it would help whenever fork() is used for snapshotting
purposes, but then fork() used for snapshotting purposes doesn't look
the best mechanism possible for atomic snapshots.

It would be interesting to know which other common workloads will
benefit, for workloads that unlike fork()-for-snapshot, are already as
optimal as it can get.

> work on khugepaged side to be able to recover THP back after multiple 4k
> COW in the range. Currently khugepaged is not able to collapse PTE entires
> backed by compound page back to PMD.

Yes this is also answering Anthony question about what shall happen
after to the 4k cows on the doublemap.

The thing is, by the time khugepaged comes around, the child will
hopefully already have quit, so it would be ideal if it can understand
the anon page isn't even shared anymore, it's fully private to the
process after holding the mmap_sem for writing, so if it's not-shared
anymore and mapcount is 1, khugepaged doesn't need to do the 2M cow of
the doublemap THP at all, it just needs to flush the 4k fragment back
to the THP and drop the doublemap and convert the readonly pte entries
to a writable pmd_trans_huge (if VM_WRITE is still set).

> I have this on my todo list for long time, but...

We're also slowly making progress on the uffd-wp to offer a hopefully
way more efficient way to do the snapshot than using fork(), then the
whole fork thing won't be an issue because there will be no fork.
