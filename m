Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994DBC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D05222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbfBMPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:06:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:34050 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBMPGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:06:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA3C4AE7F;
        Wed, 13 Feb 2019 15:06:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2BDC1E09CD; Wed, 13 Feb 2019 16:06:32 +0100 (CET)
Date:   Wed, 13 Feb 2019 16:06:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christopher Lameter <cl@linux.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190213150632.GB26828@quack2.suse.cz>
References: <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <20190211182649.GD24692@ziepe.ca>
 <20190211184040.GF12668@bombadil.infradead.org>
 <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com>
 <20190211204945.GF24692@ziepe.ca>
 <CAPcyv4jHjeJxmHMyrbRhg9oeaLK5WbZm-qu1HywjY7bF2DwiDg@mail.gmail.com>
 <20190211210956.GG24692@ziepe.ca>
 <20190212163433.GD19076@quack2.suse.cz>
 <01000168e2a26936-eb7cef59-9772-4a76-b7f3-a7fdc864fa72-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168e2a26936-eb7cef59-9772-4a76-b7f3-a7fdc864fa72-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 16:55:21, Christopher Lameter wrote:
> On Tue, 12 Feb 2019, Jan Kara wrote:
> 
> > > Isn't that already racy? If the mmap user is fast enough can't it
> > > prevent the page from becoming freed in the first place today?
> >
> > No, it cannot. We block page faulting for the file (via a lock), tear down
> > page tables, free pages and blocks. Then we resume faults and return
> > SIGBUS (if the page ends up being after the new end of file in case of
> > truncate) or do new page fault and fresh block allocation (which can end
> > with SIGBUS if the filesystem cannot allocate new block to back the page).
> 
> Well that is already pretty inconsistent behavior. Under what conditions
> is the SIGBUS occurring without the new fault attempt?

I probably didn't express myself clearly enough. I didn't say that SIGBUS
can occur without a page fault. The evaluation of whether a page would be
beyond EOF, page allocation, and block allocation happen only in response
to a page fault...

> If a new fault is attempted then we have resource constraints that could
> have caused a SIGBUS independently of the truncate. So that case is not
> really something special to be considered for truncation.

Agreed. I was just reacting to Jason's question whether an application
cannot prevent page freeing by being aggressive enough.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
