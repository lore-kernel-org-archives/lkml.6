Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2B6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B755218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vANjs2HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBFSfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:35:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qI29K96IrArheGtskdty/M4YlvDQ8BSIpYtPNkZIORY=; b=vANjs2HZBeSGsIJ3lVWi8DZVD
        FXcQzXRiaXnlbJbaNHMMz5rB1uCRmtDS05jhtlnMlprwaSI1fr/BZV6C57RLXpkYFPAONlFd1M7E+
        uC2CHtoQOb7aU3uYybJzUyhpS+S7KR9tW27Zg6wJBc1hGIOKddlyTEvjBIPvAtSYc1IJWPJVr3d/c
        5PeTnFCETxFmuk7KuhJTmmutnLRhKJtW+eIx7FpDZ/Ouh2Q0O2ML8CT5BmKJx5v4d5ETgFpkmJrzm
        ouOa+KlxEKtj5CBvL0Tc9uyen/ih/etkhU8eIZfoB15Hol1cNZhC89ThfrkdyVwGSF5bXT8Zgwyw4
        BAR3PItPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grS2K-0005xE-8p; Wed, 06 Feb 2019 18:35:04 +0000
Date:   Wed, 6 Feb 2019 10:35:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190206183503.GO21860@bombadil.infradead.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 01:32:04PM -0500, Doug Ledford wrote:
> On Wed, 2019-02-06 at 09:52 -0800, Matthew Wilcox wrote:
> > On Wed, Feb 06, 2019 at 10:31:14AM -0700, Jason Gunthorpe wrote:
> > > On Wed, Feb 06, 2019 at 10:50:00AM +0100, Jan Kara wrote:
> > > 
> > > > MM/FS asks for lease to be revoked. The revoke handler agrees with the
> > > > other side on cancelling RDMA or whatever and drops the page pins. 
> > > 
> > > This takes a trip through userspace since the communication protocol
> > > is entirely managed in userspace.
> > > 
> > > Most existing communication protocols don't have a 'cancel operation'.
> > > 
> > > > Now I understand there can be HW / communication failures etc. in
> > > > which case the driver could either block waiting or make sure future
> > > > IO will fail and drop the pins. 
> > > 
> > > We can always rip things away from the userspace.. However..
> > > 
> > > > But under normal conditions there should be a way to revoke the
> > > > access. And if the HW/driver cannot support this, then don't let it
> > > > anywhere near DAX filesystem.
> > > 
> > > I think the general observation is that people who want to do DAX &
> > > RDMA want it to actually work, without data corruption, random process
> > > kills or random communication failures.
> > > 
> > > Really, few users would actually want to run in a system where revoke
> > > can be triggered.
> > > 
> > > So.. how can the FS/MM side provide a guarantee to the user that
> > > revoke won't happen under a certain system design?
> > 
> > Most of the cases we want revoke for are things like truncate().
> > Shouldn't happen with a sane system, but we're trying to avoid users
> > doing awful things like being able to DMA to pages that are now part of
> > a different file.
> 
> Why is the solution revoke then?  Is there something besides truncate
> that we have to worry about?  I ask because EBUSY is not currently
> listed as a return value of truncate, so extending the API to include
> EBUSY to mean "this file has pinned pages that can not be freed" is not
> (or should not be) totally out of the question.
> 
> Admittedly, I'm coming in late to this conversation, but did I miss the
> portion where that alternative was ruled out?

That's my preferred option too, but the preponderance of opinion leans
towards "We can't give people a way to make files un-truncatable".

