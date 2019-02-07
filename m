Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595FBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23257218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBGQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:48:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:39452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfBGQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:48:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73FC8B017;
        Thu,  7 Feb 2019 16:48:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CFDD71E3DB5; Thu,  7 Feb 2019 17:48:36 +0100 (CET)
Date:   Thu, 7 Feb 2019 17:48:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190207164836.GL3597@quack2.suse.cz>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206194055.GP21860@bombadil.infradead.org>
 <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
 <20190206202021.GQ21860@bombadil.infradead.org>
 <a5b976cad6a578f0a6e6573acbf547ceb9dad6c7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b976cad6a578f0a6e6573acbf547ceb9dad6c7.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-02-19 15:54:01, Doug Ledford wrote:
> On Wed, 2019-02-06 at 12:20 -0800, Matthew Wilcox wrote:
> > On Wed, Feb 06, 2019 at 03:16:02PM -0500, Doug Ledford wrote:
> > > On Wed, 2019-02-06 at 11:40 -0800, Matthew Wilcox wrote:
> > > > On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> > > > > though? If we only allow this use case then we may not have to worry about
> > > > > long term GUP because DAX mapped files will stay in the physical location
> > > > > regardless.
> > > > 
> > > > ... except for truncate.  And now that I think about it, there was a
> > > > desire to support hot-unplug which also needed revoke.
> > > 
> > > We already support hot unplug of RDMA devices.  But it is extreme.  How
> > > does hot unplug deal with a program running from the device (something
> > > that would have returned ETXTBSY)?
> > 
> > Not hot-unplugging the RDMA device but hot-unplugging an NV-DIMM.
> 
> Is an NV-DIMM the only thing we use DAX on?

Currently yes. However KVM people are soon going to use it for their
purposes as well (essentially directly sharing host page cache between
guests).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
