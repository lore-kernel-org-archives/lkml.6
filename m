Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A41C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001F32184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfBESBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:01:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:42041 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfBESBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:01:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 10:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,336,1544515200"; 
   d="scan'208";a="124180424"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2019 10:01:39 -0800
Date:   Tue, 5 Feb 2019 10:01:20 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190205180120.GC21617@iweiny-DESK2.sc.intel.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had an old invalid address for Jason Gunthorpe in my address book...  

Correcting his email in the thread.

On Tue, Feb 05, 2019 at 09:50:59AM -0800, 'Ira Weiny' wrote:
> 
> The problem: Once we have pages marked as GUP-pinned how should various
> subsystems work with those markings.
> 
> The current work for John Hubbards proposed solutions (part 1 and 2) is
> progressing.[1]  But the final part (3) of his solution is also going to take
> some work.
> 
> In Johns presentation he lists 3 alternatives for gup-pinned pages:
> 
> 1) Hold off try_to_unmap
> 2) Allow writeback while pinned (via bounce buffers)
> 	[Note this will not work for DAX]
> 3) Use a "revocable reservation" (or lease) on those pages
> 4) Pin the blocks as busy in the FS allocator
> 
> The problem with lease's on pages used by RDMA is that the references to
> these pages is not local to the machine.  Once the user has been given access
> to the page they, through the use of a remote tokens, give a reference to that
> page to remote nodes.  This is the core essence of RDMA, and like it or not,
> something which is increasingly used by major Linux users.
> 
> Therefore we need to discuss the extent by which leases are appropriate and
> what happens should a lease be revoked which a user does not respond to.
> 
> As John Hubbard put it:
> 
> "Other filesystem features that need to replace the page with a new one can
> be inhibited for pages that are GUP-pinned. This will, however, alter and
> limit some of those filesystem features. The only fix for that would be to
> require GUP users monitor and respond to CPU page table updates. Subsystems
> such as ODP and HMM do this, for example. This aspect of the problem is
> still under discussion."
> 
> 	-- John Hubbard[2]
> 
> The following people have been involved in previous conversations and would be key to
> the face to face discussion.
> 
> John Hubbard
> Jan Kara
> Dave Chinner
> Michal Hocko
> Dan Williams
> Matthew Wilcox
> Jason Gunthorpe
> 
> Thank you,
> Ira Weiny
> 
> [1] https://linuxplumbersconf.org/event/2/contributions/126/attachments/136/168/LPC_2018_gup_dma.pdf
> [2] https://lkml.org/lkml/2019/2/4/7
> 
