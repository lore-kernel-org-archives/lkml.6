Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D23BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B5217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cv74FdRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBFUkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:40:01 -0500
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:48860 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbfBFUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549485599;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=KCnUJlwQKrPyUUqRPNg3t9cL/cv5MgY2z3DU/pPTaqc=;
        b=cv74FdRvic7TI9m6xRCUtxP6ud5qi2iADMgwmPf2CPD4JZONmsdNN8aMKlS1ZDCg
        EjPx8+q7zsXPmP0+GM10VSu1+xf6UzXHgRGO/SgI3g8i/TsHOsfuR/+wqLBIZ3s8iaJ
        BlbOoVWBBlE9J2mOS4mq4qPUHB8t0VUts7llH+W8=
Date:   Wed, 6 Feb 2019 20:39:59 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <20190206202021.GQ21860@bombadil.infradead.org>
Message-ID: <01000168c489e945-b34792be-adb9-44ce-b7a3-83d9232848c1-000000@email.amazonses.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com> <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com> <20190206194055.GP21860@bombadil.infradead.org> <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com> <20190206202021.GQ21860@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.06-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019, Matthew Wilcox wrote:

> It's straightforward to migrate text pages from one DIMM to another;
> you remove the PTEs from the CPU's page tables, copy the data over and
> pagefaults put the new PTEs in place.  We don't have a way to do similar
> things to an RDMA device, do we?

We have MMU notifier callbacks that can tell the device to release the
mappings. And an RDMA device may operate in ODP mode which is on demand
paging. With that data may be migrated as usual.


