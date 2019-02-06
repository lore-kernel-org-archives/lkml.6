Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C79C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF85D218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N2Tbyi0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfBFXlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:41:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFXlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:41:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so3887417pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 15:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wtlvdaQ2RfnmKMMXLaG2vLlY5kmAjKB9ewwZ6+Q/zrE=;
        b=N2Tbyi0NYtdj8kT2fMOgphDLJEkRu8Ve7ZbN85OU/bQbcY2ohxaRJxVu7xpTbHlXaz
         r6FrDdc/NGokzSrOKPsEKte53jDC2z3GLhsH5X9tBP4JVBYg1jZ6Dgr8uP28kwHMgXNw
         3I7uhRUVtBRYFLBAyOx+9VlYyWwzL18DlMjooUqe82Wc6lsJIDWYXqqY1twhdcd/jpR0
         s+Ieocxx4JcXuueUFPNDNBXSo/9RN+165tVmt+tNrC37G8fgRpEXqB9X/w9ZGkgBpFMC
         1S1KAtTAWGotwZ3Tw8vdQorheqAg3TpQm22oB6kKfD1QPYDsaDOO2aMfn+BYMgjnYfSj
         qrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtlvdaQ2RfnmKMMXLaG2vLlY5kmAjKB9ewwZ6+Q/zrE=;
        b=eF5Dm5Jd3J9nh8Ssk36v6wW6uwGLBJz89XG0tgQLg6YK5S3rlUNfbCe5Vidp4bC9qV
         V74IjdGPTskGT9u/DZQNB6GMPHd6mFoM2icwuQ4K+DfkhmqbBGBi/DRiiywVIT0/kbqy
         r2pLX7h/PYhojlFN2/DgpdxNilTncjth9Hp5ot7xscZuSkqx7Ei4chRctq0IElg0qyMy
         mbICB/0TAfloKKeXvWi+2hshX53Pk31LOT0uRQvTiQdKcJ0NTOH7b1DjFJcpWydDCFKB
         1BALJ0/Gy/QaDRQ8Z0d92ms0dF58ot81RL0Fmmpziylcp5+70c/oOX12va4rgYzhGIEn
         BhRA==
X-Gm-Message-State: AHQUAuZUkXeuDwo6BraNBvM2MyCtEIKdfJDv3UFCZ1VZRQmIFBxao3JC
        PJHGib6VRE6WRgigWT+Qr6xSlA==
X-Google-Smtp-Source: AHgI3IZOZlROKcj7vcS2xqLMIe3x5syV5VU7DSATGgwTxc0rzKS1U6azoHkiMfw1/uA8lDCseSvfzA==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr13262967pfd.90.1549496493841;
        Wed, 06 Feb 2019 15:41:33 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u186sm10338671pfu.51.2019.02.06.15.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 15:41:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grWou-0004D9-Hy; Wed, 06 Feb 2019 16:41:32 -0700
Date:   Wed, 6 Feb 2019 16:41:32 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190206234132.GB15234@ziepe.ca>
References: <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <20190206232130.GK12227@ziepe.ca>
 <CAPcyv4g2r=L3jfSDoRPt4VG7D_2CxCgv3s+JLu4FQRUSRWg+4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g2r=L3jfSDoRPt4VG7D_2CxCgv3s+JLu4FQRUSRWg+4Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:30:27PM -0800, Dan Williams wrote:
> On Wed, Feb 6, 2019 at 3:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Feb 06, 2019 at 02:44:45PM -0800, Dan Williams wrote:
> >
> > > > Do they need to stick with xfs?
> > >
> > > Can you clarify the motivation for that question? This problem exists
> > > for any filesystem that implements an mmap that where the physical
> > > page backing the mapping is identical to the physical storage location
> > > for the file data.
> >
> > .. and needs to dynamicaly change that mapping. Which is not really
> > something inherent to the general idea of a filesystem. A file system
> > that had *strictly static* block assignments would work fine.
> >
> > Not all filesystem even implement hole punch.
> >
> > Not all filesystem implement reflink.
> >
> > ftruncate doesn't *have* to instantly return the free blocks to
> > allocation pool.
> >
> > ie this is not a DAX & RDMA issue but a XFS & RDMA issue.
> >
> > Replacing XFS is probably not be reasonable, but I wonder if a XFS--
> > operating mode could exist that had enough features removed to be
> > safe?
> 
> You're describing the current situation, i.e. Linux already implements
> this, it's called Device-DAX and some users of RDMA find it
> insufficient. The choices are to continue to tell them "no", or say
> "yes, but you need to submit to lease coordination".

Device-DAX is not what I'm imagining when I say XFS--.

I mean more like XFS with all features that require rellocation of
blocks disabled.

Forbidding hold punch, reflink, cow, etc, doesn't devolve back to
device-dax.

Jason
