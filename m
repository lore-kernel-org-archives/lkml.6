Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C4C4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970A22083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WF44oOck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfBFUbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:31:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45273 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:31:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so3625054plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YbIyUkC8UsSdzZyVesr8tAiigZg7wCHaBbnulVXafGw=;
        b=WF44oOckEfi+7lA1Db/d7VzHyHF8wSXAwVCN2sZnyLKGdSfzhu5QjxpXFLzdXS9quN
         x3sQ0hdDNxoHrqKLRLDnbsI9uH6uIEvprHN2wrNdZAwEvD4D8RYtsYDw+BlJ76uToxuw
         V2Bsyiy7yX6H3VkpWMcK7A8O61EhbZfmfCdo9MTAC14fUjdhr/0dku3dGYKHd8SImXmM
         iS2Z7UtCllEOAonSZxwM5vvbaCI0tLjRY+pgTY8KGkFJamSTKSaIyb69VM/ohynBuRTG
         nFJOGtmS4mCxTdT2ZofAwFIHN34JJtUBDw/aWpvImlDfGnexoZQqY14FsfLtfICF/D7n
         ezoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YbIyUkC8UsSdzZyVesr8tAiigZg7wCHaBbnulVXafGw=;
        b=LHsQ0V5xCLOi73/Fzkpjtw/Fdqjf7xuih64QWETLaokUAx+7eV1GHRY+pVxhUO8WY2
         fLx5vfxFdnAozDiMVtFXXZlLIAgGjAKoix3zF3fTLPgRm6fyF2w2PiWUkImGHkWKF8K9
         JafeqxXq1os9lk9hqjC1JDer5LEFz2fOzp7W4Kp/RY4tqvy5WOzLbRV2MO+KYNKTk678
         nZebmefUAcsq9WPCXQKwSpfKQ745EDeQnRv2WdD0Ammq8jGmsIwR7tN4iUnjvrlb8a1K
         mVgxRU5AYvftIa1pODCfhA/+Nbg3mSLlv9TEzgepYh/jIT30vpm/obmC3CRFk3lihqfp
         H61g==
X-Gm-Message-State: AHQUAuaObXuoau0RcMsFuW+Tdww482VVSmlS7zpQgftxOOXirUOlauDX
        jdMoIw7/chLm1JODXZn9ojfJDw==
X-Google-Smtp-Source: AHgI3IYyYFHm1UB/lEJXyP4bIedLwSbk4vKppJGV+uLvM/DXyuamDSexcWkCjNfC7MybiGjQJRK3ZQ==
X-Received: by 2002:a17:902:eb03:: with SMTP id cw3mr12588301plb.130.1549485110664;
        Wed, 06 Feb 2019 12:31:50 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v184sm11025630pfb.182.2019.02.06.12.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 12:31:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grTrJ-0005Ww-5z; Wed, 06 Feb 2019 13:31:49 -0700
Date:   Wed, 6 Feb 2019 13:31:49 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <20190206203149.GI12227@ziepe.ca>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206194055.GP21860@bombadil.infradead.org>
 <a9df9be75966f34f55f843a3cd7e1ee7d497c7fa.camel@redhat.com>
 <20190206202021.GQ21860@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206202021.GQ21860@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:20:21PM -0800, Matthew Wilcox wrote:
> On Wed, Feb 06, 2019 at 03:16:02PM -0500, Doug Ledford wrote:
> > On Wed, 2019-02-06 at 11:40 -0800, Matthew Wilcox wrote:
> > > On Wed, Feb 06, 2019 at 07:16:21PM +0000, Christopher Lameter wrote:
> > > > 
> > > > though? If we only allow this use case then we may not have to worry about
> > > > long term GUP because DAX mapped files will stay in the physical location
> > > > regardless.
> > > 
> > > ... except for truncate.  And now that I think about it, there was a
> > > desire to support hot-unplug which also needed revoke.
> > 
> > We already support hot unplug of RDMA devices.  But it is extreme.  How
> > does hot unplug deal with a program running from the device (something
> > that would have returned ETXTBSY)?
> 
> Not hot-unplugging the RDMA device but hot-unplugging an NV-DIMM.
> 
> It's straightforward to migrate text pages from one DIMM to another;
> you remove the PTEs from the CPU's page tables, copy the data over and
> pagefaults put the new PTEs in place.  We don't have a way to do similar
> things to an RDMA device, do we?

I've long said it is reasonable to have an emergency hard revoke for
exceptional error cases - like dis-orderly hot unplug and so forth.

However, IHMO a orderly migration should rely on user space to
co-ordinate the migration and the application usages, including some
user space driven scheme to assure forward progress..

.. and you are kind of touching on my fear here. revoke started out as
only being for ftruncate. Now we need it for data migration - how soon
before someone wants to do revoke just to re-balance
usage/bandwidth/etc between NVDIMMS? 

That is now way outside of what a RDMA using system can reasonably
tolerate. How would a system designer prevent this?

Again, nobody is going to want a design where RDMA applications are
under some undefined threat of SIGKILL - which is where any lease
revoke idea is going. :( 

The priority of systems using RDMA is almost always to keep the RDMA
working right as it is the often key service the box is providing.

Jason
