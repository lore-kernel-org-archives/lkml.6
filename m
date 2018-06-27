Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E736426039
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E736426039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965911AbeF0RCw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:02:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:44387 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932406AbeF0RCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7EE1AD6A;
        Wed, 27 Jun 2018 17:02:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 906941E3C15; Wed, 27 Jun 2018 19:02:46 +0200 (CEST)
Date:   Wed, 27 Jun 2018 19:02:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180627170246.qfvucs72seqabaef@quack2.suse.cz>
References: <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <20180626134757.GY28965@dhcp22.suse.cz>
 <20180626164825.fz4m2lv6hydbdrds@quack2.suse.cz>
 <20180627113221.GO32348@dhcp22.suse.cz>
 <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
 <20180627115927.GQ32348@dhcp22.suse.cz>
 <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
 <20180627145718.GB20171@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627145718.GB20171@ziepe.ca>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 08:57:18, Jason Gunthorpe wrote:
> On Wed, Jun 27, 2018 at 02:42:55PM +0200, Jan Kara wrote:
> > On Wed 27-06-18 13:59:27, Michal Hocko wrote:
> > > On Wed 27-06-18 13:53:49, Jan Kara wrote:
> > > > On Wed 27-06-18 13:32:21, Michal Hocko wrote:
> > > [...]
> > > > > Appart from that, do we really care about 32b here? Big DIO, IB users
> > > > > seem to be 64b only AFAIU.
> > > > 
> > > > IMO it is a bad habit to leave unpriviledged-user-triggerable oops in the
> > > > kernel even for uncommon platforms...
> > > 
> > > Absolutely agreed! I didn't mean to keep the blow up for 32b. I just
> > > wanted to say that we can stay with a simple solution for 32b. I thought
> > > the g-u-p-longterm has plugged the most obvious breakage already. But
> > > maybe I just misunderstood.
> > 
> > Most yes, but if you try hard enough, you can still trigger the oops e.g.
> > with appropriately set up direct IO when racing with writeback / reclaim.
> 
> gup longterm is only different from normal gup if you have DAX and few
> people do, which really means it doesn't help at all.. AFAIK??

Right, what I wrote works only for DAX. For non-DAX situation g-u-p
longterm does not currently help at all. Sorry for confusion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
