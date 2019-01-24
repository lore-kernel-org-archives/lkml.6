Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ED8C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC952184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfAXFg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:36:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbfAXFg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:36:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83321356E5;
        Thu, 24 Jan 2019 05:36:55 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B30775D6A6;
        Thu, 24 Jan 2019 05:36:49 +0000 (UTC)
Date:   Thu, 24 Jan 2019 13:36:47 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 20/24] userfaultfd: wp: don't wake up when doing
 write protect
Message-ID: <20190124053647.GG18231@xz-x1>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-21-peterx@redhat.com>
 <20190121111039.GB26461@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121111039.GB26461@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 24 Jan 2019 05:36:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:10:39PM +0200, Mike Rapoport wrote:
> On Mon, Jan 21, 2019 at 03:57:18PM +0800, Peter Xu wrote:
> > It does not make sense to try to wake up any waiting thread when we're
> > write-protecting a memory region.  Only wake up when resolving a write
> > protected page fault.
> 
> Probably it would be better to make it default to wake up only when
> requested explicitly?

Yes, I think that's what this series does?

Now when we do UFFDIO_WRITEPROTECT with !WP and !DONTWAKE then we'll
first resolve the page fault, then wake up the process properly.  And
we request that explicity using !WP and DONTWAKE.

Or did I misunderstood the question?

> Then we can simply disallow _DONTWAKE for uffd_wp and only use
> UFFDIO_WRITEPROTECT_MODE_WP as possible mode.

I'd admit I don't know the major usage of DONTWAKE (and I'd be glad to
know...), however since we have this flag for both UFFDIO_COPY and
UFFDIO_ZEROCOPY, then it seems sane to have DONTWAKE for WRITEPROTECT
too?  Or is there any other explicit reason to omit it?

Thanks!

-- 
Peter Xu
