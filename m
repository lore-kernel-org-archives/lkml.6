Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E78D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfBSChJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfBSChI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:37:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 572CBBDFA;
        Tue, 19 Feb 2019 02:37:08 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C3515D706;
        Tue, 19 Feb 2019 02:37:03 +0000 (UTC)
Date:   Tue, 19 Feb 2019 10:37:01 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Restore change_pte optimization to its former
 glory
Message-ID: <20190219023701.GA3223@xz-x1>
References: <20190131183706.20980-1-jglisse@redhat.com>
 <20190201235738.GA12463@redhat.com>
 <20190211190931.GA3908@redhat.com>
 <20190211200200.GA30128@redhat.com>
 <20190218160411.GA3142@redhat.com>
 <20190218174505.GD30645@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190218174505.GD30645@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 19 Feb 2019 02:37:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:45:05PM -0500, Andrea Arcangeli wrote:
> On Mon, Feb 18, 2019 at 11:04:13AM -0500, Jerome Glisse wrote:
> > So i run 2 exact same VMs side by side (copy of same COW image) and
> > built the same kernel tree inside each (that is the only important
> > workload that exist ;)) but the change_pte did not have any impact:
> > 
> > before  mean  {real: 1358.250977, user: 16650.880859, sys: 839.199524, npages: 76855.390625}
> > before  stdev {real:    6.744010, user:   108.863762, sys:   6.840437, npages:  1868.071899}
> > after   mean  {real: 1357.833740, user: 16685.849609, sys: 839.646973, npages: 76210.601562}
> > after   stdev {real:    5.124797, user:    78.469360, sys:   7.009164, npages:  2468.017578}
> > without mean  {real: 1358.501343, user: 16674.478516, sys: 837.791992, npages: 76225.203125}
> > without stdev {real:    5.541104, user:    97.998367, sys:   6.715869, npages:  1682.392578}
> > 
> > Above is time taken by make inside each VM for all yes config. npages
> > is the number of page shared reported on the host at the end of the
> > build.
> 
> Did you set /sys/kernel/mm/ksm/sleep_millisecs to 0?
> 
> It would also help to remove the checksum check from mm/ksm.c:
> 
> -	if (rmap_item->oldchecksum != checksum) {
> -		rmap_item->oldchecksum = checksum;
> -		return;
> -	}
> 
> One way or another, /sys/kernel/mm/ksm/pages_shared and/or
> pages_sharing need to change significantly to be sure we're exercising
> the COW/merging code that uses change_pte. KSM is smart enough to
> merge only not frequently changing pages, and with the default KSM
> code this probably works too well for a kernel build.

Would it also make sense to track how many pages are really affected
by change_pte (say, in kvm_set_pte_rmapp, count avaliable SPTEs that
are correctly rebuilt)?  I'm thinking even if many pages are merged by
KSM it's still possible that these pages are not actively shadowed by
KVM MMU, meanwhile change_pte should only affect actively shadowed
SPTEs.  In other words, IMHO we might not be able to observe obvious
performance differeneces if the pages we are accessing are not merged
by KSM.  In our case (building the kernel), IIUC the mostly possible
shared pages are system image pages, however when building the kernel
I'm thinking whether these pages will be frequently accesses, and
whether this could lead to similar performance numbers.

Thanks,

-- 
Peter Xu
