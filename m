Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A445C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5446221477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5446221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJMBbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:31:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeJMBbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:31:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D490C04FF85;
        Fri, 12 Oct 2018 17:58:02 +0000 (UTC)
Received: from sky.random (ovpn-120-22.rdu2.redhat.com [10.10.120.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51AB66CA52;
        Fri, 12 Oct 2018 17:58:01 +0000 (UTC)
Date:   Fri, 12 Oct 2018 13:58:00 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Nellans <dnellans@nvidia.com>,
        Ingo Molnar <mingo@elte.hu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/thp: fix call to mmu_notifier in
 set_pmd_migration_entry()
Message-ID: <20181012175800.GD7395@redhat.com>
References: <20181012160953.5841-1-jglisse@redhat.com>
 <DB07F115-B404-4AB0-9D54-BC20C3A3F2B0@cs.rutgers.edu>
 <20181012172422.GA7395@redhat.com>
 <20181012173518.GD6593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012173518.GD6593@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Oct 2018 17:58:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 01:35:19PM -0400, Jerome Glisse wrote:
> On Fri, Oct 12, 2018 at 01:24:22PM -0400, Andrea Arcangeli wrote:
> > Hello,
> > 
> > On Fri, Oct 12, 2018 at 12:20:54PM -0400, Zi Yan wrote:
> > > On 12 Oct 2018, at 12:09, jglisse@redhat.com wrote:
> > > 
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > >
> > > > Inside set_pmd_migration_entry() we are holding page table locks and
> > > > thus we can not sleep so we can not call invalidate_range_start/end()
> > > >
> > > > So remove call to mmu_notifier_invalidate_range_start/end() and add
> > > > call to mmu_notifier_invalidate_range(). Note that we are already
> > 
> > Why the call to mmu_notifier_invalidate_range if we're under
> > range_start and followed by range_end? (it's not _range_only_end, if
> > it was _range_only_end the above would be needed)
> 
> I wanted to be extra safe and accept to over invalidate. You are right
> that it is not strictly necessary. I am fine with removing it.

If it's superfluous, I'd generally prefer strict code unless there's a
very explicit comment about it that says it's actually superfluous.
Otherwise after a while we don't know why it was added there.

> We can remove it. Should i post a v2 without it ?

That's fine with me yes.

Thanks,
Andrea
