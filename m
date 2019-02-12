Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56545C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA082082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="INsI1v2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfBLQzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:55:22 -0500
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:42540 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbfBLQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549990521;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=u5yVrmcqLQyUPSMbbYCxR9JAtuOplVrqP6Ol1t45LIw=;
        b=INsI1v2hT/d5BvFY22/rKInWGEM2LiJkNygvZpkBu6ryWwFKRqJgI4wiS4zAJvBQ
        pxoemWBqjEnQ9ioE+c19sSEi5BeZDpwlK6at4cUE8PHAEONO79kt2g9H0sQ3O9WvTyP
        YQuOEbq5MeRa1glMsh/ceEMpmDICdDL7CngAipak=
Date:   Tue, 12 Feb 2019 16:55:21 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jan Kara <jack@suse.cz>
cc:     Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <20190212163433.GD19076@quack2.suse.cz>
Message-ID: <01000168e2a26936-eb7cef59-9772-4a76-b7f3-a7fdc864fa72-000000@email.amazonses.com>
References: <20190211102402.GF19029@quack2.suse.cz> <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com> <20190211180654.GB24692@ziepe.ca> <20190211181921.GA5526@iweiny-DESK2.sc.intel.com> <20190211182649.GD24692@ziepe.ca>
 <20190211184040.GF12668@bombadil.infradead.org> <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com> <20190211204945.GF24692@ziepe.ca> <CAPcyv4jHjeJxmHMyrbRhg9oeaLK5WbZm-qu1HywjY7bF2DwiDg@mail.gmail.com> <20190211210956.GG24692@ziepe.ca>
 <20190212163433.GD19076@quack2.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.12-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Jan Kara wrote:

> > Isn't that already racy? If the mmap user is fast enough can't it
> > prevent the page from becoming freed in the first place today?
>
> No, it cannot. We block page faulting for the file (via a lock), tear down
> page tables, free pages and blocks. Then we resume faults and return
> SIGBUS (if the page ends up being after the new end of file in case of
> truncate) or do new page fault and fresh block allocation (which can end
> with SIGBUS if the filesystem cannot allocate new block to back the page).

Well that is already pretty inconsistent behavior. Under what conditions
is the SIGBUS occurring without the new fault attempt?

If a new fault is attempted then we have resource constraints that could
have caused a SIGBUS independently of the truncate. So that case is not
really something special to be considered for truncation.

So the only concern left is to figure out under what conditions SIGBUS
occurs with a racing truncate (if at all) if there are sufficient
resources to complete the page fault.


