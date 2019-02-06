Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152A1218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mirs8uEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfBFRwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:52:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfBFRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/JM8xhN7e4ll6dIOfHOJWjqFYstXE/mHbTZT2vaTgc4=; b=Mirs8uEthgr5XYNVmirKwundg
        sWy+gu+BS7j+QeM5lRkc2WA/dD5BCWVfh/p5kxzdlLmzzwS+7cmvM0HiMcRgjjlRrPa7gjloa5ZDy
        +6575c/+leWN4hTJAWmMWr5L6+0hOtK0imZ0eTSUttMbVwEFR982PjYdZvNh2irh8Igamks3vDvTS
        Mx/qNCr4b7lmzCj2TNsPQOtUzHuny1h98nsDxCTYZo0T43f9aap7x6O/bmoAshx7/RgHzhxNlDwdv
        isiTF3tSnXWK9uCBLzt4D5ilHRcg+7+W230mHja0ns4B4BQ08k34gVaC5n+e7ik6sYqNIto+SNBA0
        yBmS7qivQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grRNB-00028m-9j; Wed, 06 Feb 2019 17:52:33 +0000
Date:   Wed, 6 Feb 2019 09:52:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206175233.GN21860@bombadil.infradead.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206173114.GB12227@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 10:31:14AM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 06, 2019 at 10:50:00AM +0100, Jan Kara wrote:
> 
> > MM/FS asks for lease to be revoked. The revoke handler agrees with the
> > other side on cancelling RDMA or whatever and drops the page pins. 
> 
> This takes a trip through userspace since the communication protocol
> is entirely managed in userspace.
> 
> Most existing communication protocols don't have a 'cancel operation'.
> 
> > Now I understand there can be HW / communication failures etc. in
> > which case the driver could either block waiting or make sure future
> > IO will fail and drop the pins. 
> 
> We can always rip things away from the userspace.. However..
> 
> > But under normal conditions there should be a way to revoke the
> > access. And if the HW/driver cannot support this, then don't let it
> > anywhere near DAX filesystem.
> 
> I think the general observation is that people who want to do DAX &
> RDMA want it to actually work, without data corruption, random process
> kills or random communication failures.
> 
> Really, few users would actually want to run in a system where revoke
> can be triggered.
> 
> So.. how can the FS/MM side provide a guarantee to the user that
> revoke won't happen under a certain system design?

Most of the cases we want revoke for are things like truncate().
Shouldn't happen with a sane system, but we're trying to avoid users
doing awful things like being able to DMA to pages that are now part of
a different file.
