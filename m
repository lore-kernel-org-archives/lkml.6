Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C19C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E485C20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBDXfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:35:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:59687 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfBDXff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:35:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 15:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="113707140"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 04 Feb 2019 15:35:34 -0800
Date:   Mon, 4 Feb 2019 15:35:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
Message-ID: <20190204233513.GA7917@iweiny-DESK2.sc.intel.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168b980e880-a7d8e0db-84fb-4398-8269-149c66b701b4-000000@email.amazonses.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:14:19PM +0000, Christopher Lameter wrote:
> Frankly I still think this does not solve anything.
> 
> Concurrent write access from two sources to a single page is simply wrong.
> You cannot make this right by allowing long term RDMA pins in a filesystem
> and thus the filesystem can never update part of its files on disk.
> 
> Can we just disable RDMA to regular filesystems? Regular filesystems
> should have full control of the write back and dirty status of their
> pages.

That may be a solution to the corruption/crashes but it is not a solution which
users want to see.  RDMA directly to file systems (specifically DAX) is a use
case we have seen customers ask for.

I think this is the correct path toward supporting this use case.

Ira

