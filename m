Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60F92173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfBZHwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:52:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfBZHwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:52:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F5E3308FF29;
        Tue, 26 Feb 2019 07:52:45 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEAD2600C0;
        Tue, 26 Feb 2019 07:52:36 +0000 (UTC)
Date:   Tue, 26 Feb 2019 15:52:34 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 26/26] userfaultfd: selftests: add write-protect test
Message-ID: <20190226075234.GN13653@xz-x1>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-27-peterx@redhat.com>
 <20190226065836.GD5873@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226065836.GD5873@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 26 Feb 2019 07:52:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:58:36AM +0200, Mike Rapoport wrote:
> On Tue, Feb 12, 2019 at 10:56:32AM +0800, Peter Xu wrote:
> > This patch adds uffd tests for write protection.
> > 
> > Instead of introducing new tests for it, let's simply squashing uffd-wp
> > tests into existing uffd-missing test cases.  Changes are:
> > 
> > (1) Bouncing tests
> > 
> >   We do the write-protection in two ways during the bouncing test:
> > 
> >   - By using UFFDIO_COPY_MODE_WP when resolving MISSING pages: then
> >     we'll make sure for each bounce process every single page will be
> >     at least fault twice: once for MISSING, once for WP.
> > 
> >   - By direct call UFFDIO_WRITEPROTECT on existing faulted memories:
> >     To further torture the explicit page protection procedures of
> >     uffd-wp, we split each bounce procedure into two halves (in the
> >     background thread): the first half will be MISSING+WP for each
> >     page as explained above.  After the first half, we write protect
> >     the faulted region in the background thread to make sure at least
> >     half of the pages will be write protected again which is the first
> >     half to test the new UFFDIO_WRITEPROTECT call.  Then we continue
> >     with the 2nd half, which will contain both MISSING and WP faulting
> >     tests for the 2nd half and WP-only faults from the 1st half.
> > 
> > (2) Event/Signal test
> > 
> >   Mostly previous tests but will do MISSING+WP for each page.  For
> >   sigbus-mode test we'll need to provide standalone path to handle the
> >   write protection faults.
> > 
> > For all tests, do statistics as well for uffd-wp pages.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tools/testing/selftests/vm/userfaultfd.c | 154 ++++++++++++++++++-----
> >  1 file changed, 126 insertions(+), 28 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> > index e5d12c209e09..57b5ac02080a 100644
> > --- a/tools/testing/selftests/vm/userfaultfd.c
> > +++ b/tools/testing/selftests/vm/userfaultfd.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/userfaultfd.h>
> >  #include <setjmp.h>
> >  #include <stdbool.h>
> > +#include <assert.h>
> > 
> >  #include "../kselftest.h"
> > 
> > @@ -78,6 +79,8 @@ static int test_type;
> >  #define ALARM_INTERVAL_SECS 10
> >  static volatile bool test_uffdio_copy_eexist = true;
> >  static volatile bool test_uffdio_zeropage_eexist = true;
> > +/* Whether to test uffd write-protection */
> > +static bool test_uffdio_wp = false;
> > 
> >  static bool map_shared;
> >  static int huge_fd;
> > @@ -92,6 +95,7 @@ pthread_attr_t attr;
> >  struct uffd_stats {
> >  	int cpu;
> >  	unsigned long missing_faults;
> > +	unsigned long wp_faults;
> >  };
> > 
> >  /* pthread_mutex_t starts at page offset 0 */
> > @@ -141,9 +145,29 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
> >  	for (i = 0; i < n_cpus; i++) {
> >  		uffd_stats[i].cpu = i;
> >  		uffd_stats[i].missing_faults = 0;
> > +		uffd_stats[i].wp_faults = 0;
> >  	}
> >  }
> > 
> > +static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
> > +{
> > +	int i;
> > +	unsigned long long miss_total = 0, wp_total = 0;
> > +
> > +	for (i = 0; i < n_cpus; i++) {
> > +		miss_total += stats[i].missing_faults;
> > +		wp_total += stats[i].wp_faults;
> > +	}
> > +
> > +	printf("userfaults: %llu missing (", miss_total);
> > +	for (i = 0; i < n_cpus; i++)
> > +		printf("%lu+", stats[i].missing_faults);
> > +	printf("\b), %llu wp (", wp_total);
> > +	for (i = 0; i < n_cpus; i++)
> > +		printf("%lu+", stats[i].wp_faults);
> > +	printf("\b)\n");
> > +}
> > +
> >  static int anon_release_pages(char *rel_area)
> >  {
> >  	int ret = 0;
> > @@ -264,19 +288,15 @@ struct uffd_test_ops {
> >  	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
> >  };
> > 
> > -#define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
> > -					 (1 << _UFFDIO_COPY) | \
> > -					 (1 << _UFFDIO_ZEROPAGE))
> > -
> >  static struct uffd_test_ops anon_uffd_test_ops = {
> > -	.expected_ioctls = ANON_EXPECTED_IOCTLS,
> > +	.expected_ioctls = UFFD_API_RANGE_IOCTLS,
> >  	.allocate_area	= anon_allocate_area,
> >  	.release_pages	= anon_release_pages,
> >  	.alias_mapping = noop_alias_mapping,
> >  };
> > 
> >  static struct uffd_test_ops shmem_uffd_test_ops = {
> > -	.expected_ioctls = ANON_EXPECTED_IOCTLS,
> > +	.expected_ioctls = UFFD_API_RANGE_IOCTLS,
> 
> Isn't UFFD_API_RANGE_IOCTLS includes UFFDIO_WP which is not supported for
> shmem?

Yes it didn't fail the test case probably because the test case only
registers the shmem region with UFFDIO_REGISTER_MODE_MISSING, and for
now we'll simply blindly return the _UFFDIO_WRITEPROTECT capability if
the register ioctl succeeded.  However it'll still fail the
UFFDIO_REGISTER ioctl directly if someone requests with
UFFDIO_REGISTER_MODE_WP mode upon shmem.

So maybe I should explicitly remove the _UFFDIO_WRITEPROTECT bit in
userfaultfd_register() if I detected any non-anonymous regions?  Then
here I will revert to ANON_EXPECTED_IOCTLS for shmem_uffd_test_ops in
the tests.

> 
> >  	.allocate_area	= shmem_allocate_area,
> >  	.release_pages	= shmem_release_pages,
> >  	.alias_mapping = noop_alias_mapping,
> 
> ...
> 
> -- 
> Sincerely yours,
> Mike.
> 

Regards,

-- 
Peter Xu
