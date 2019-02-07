Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AA6C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F4921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="O9v0AIQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfBGQzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:55:39 -0500
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:49060 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbfBGQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1549558538;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=kTxXE70S20OVI1msr1Fuki8Y508efNovX08aCTnuo4Q=;
        b=O9v0AIQ6CIgIh23VoHXzL1RwD9Rigp93j1vESMl+1EUEU4wW1lR8Htb1VtTJnyCr
        EwILSG3k/nilE5hLcJN278L0gbkYG6rzQ5DXODrl+PasyFAUKhv+m/9hi/6gPzS/w5P
        dMVACULsdkGGxCU0Z++c9rvYHJzQGsPQQZBxqqNA=
Date:   Thu, 7 Feb 2019 16:55:37 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Doug Ledford <dledford@redhat.com>
cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving longterm-GUP
 usage by RDMA
In-Reply-To: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
Message-ID: <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com> <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca> <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com> <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca> <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com> <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.02.07-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One approach that may be a clean way to solve this:

1. Long term GUP usage requires the virtual mapping to the pages be fixed
   for the duration of the GUP Map. There never has been a way to break
   the pinnning and thus this needs to be preserved.

2. Page Cache Long term pins are not allowed since regular filesystems
   depend on COW and other tricks which are incompatible with a long term
   pin.

3. Filesystems that allow bypass of the page cache (like XFS / DAX) will
   provide the virtual mapping when the PIN is done and DO NO OPERATIONS
   on the longterm pinned range until the long term pin is removed.
   Hardware may do its job (like for persistent memory) but no data
   consistency on the NVDIMM medium is guaranteed until the long term pin
   is removed  and the filesystems regains control over the area.

4. Long term pin means that the mapped sections are an actively used part
   of the file (like a filesystem write) and it cannot be truncated for
   the duration of the pin. It can be thought of as if the truncate is
   immediate followed by a write extending the file again. The mapping
   by RDMA implies after all that remote writes can occur at anytime
   within the area pinned long term.
