Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C33AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F6920B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfBFJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:50:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:42260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfBFJuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 04:50:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 263D1AE43;
        Wed,  6 Feb 2019 09:50:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E0631E3E15; Wed,  6 Feb 2019 10:50:00 +0100 (CET)
Date:   Wed, 6 Feb 2019 10:50:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206095000.GA12006@quack2.suse.cz>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-02-19 09:50:59, Ira Weiny wrote:
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

Well, but DAX does not need it because by definition there's nothing to
writeback :)

> 3) Use a "revocable reservation" (or lease) on those pages
> 4) Pin the blocks as busy in the FS allocator
> 
> The problem with lease's on pages used by RDMA is that the references to
> these pages is not local to the machine.  Once the user has been given
> access to the page they, through the use of a remote tokens, give a
> reference to that page to remote nodes.  This is the core essence of
> RDMA, and like it or not, something which is increasingly used by major
> Linux users.
> 
> Therefore we need to discuss the extent by which leases are appropriate and
> what happens should a lease be revoked which a user does not respond to.

I don't know the RDMA hardware so this is just an opinion of filesystem /
mm guy but my idea how this should work would be:

MM/FS asks for lease to be revoked. The revoke handler agrees with the
other side on cancelling RDMA or whatever and drops the page pins. Now I
understand there can be HW / communication failures etc. in which case the
driver could either block waiting or make sure future IO will fail and drop
the pins. But under normal conditions there should be a way to revoke the
access. And if the HW/driver cannot support this, then don't let it anywhere
near DAX filesystem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
