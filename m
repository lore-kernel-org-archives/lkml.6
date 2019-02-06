Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97294C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D14D218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z+Z+SjPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfBFXVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:21:33 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46426 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBFXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:21:33 -0500
Received: by mail-pf1-f172.google.com with SMTP id c73so3840035pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 15:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SerMT47P7Y4EGL4Yc5IRC0eutvUHMCX849kOCq3GxrU=;
        b=Z+Z+SjPcNYJWeza2d4b55BxKrkKQit7wzeJhyZ19nOEfLgBL+LxuR3bra3hNQkLyJh
         3GNCn3UFEiulNHorYHsflZuQJc7av2V9iLscVeglodzrgAHwCNK4eumCxcdbIj+Jr0k+
         7YPhPzqWkqQF72g1jQF6FygbuDXYxT27JHxDyrmX+xFHeTUz4t5/4fqsCri56oCi6Oxv
         pzTFJK3BFyZBh6wyNgcSGeIcuxBpYmGk9PeoajJRNtsEhiFLc/+zMkRv0DsEk3rDG/FE
         +D1Ryfi+/ZjJcHQRAnC2yxqzrbq8hsGysmCh3xn8frpPIOIFosWVjEZ1OdJWsEyP8K8Z
         x4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SerMT47P7Y4EGL4Yc5IRC0eutvUHMCX849kOCq3GxrU=;
        b=hXmn7NDu4UhWKAWYTM8JWRryr2tksSh1XWS/2+50ScXyAWtnt760ZYv5zlwkoy6z3a
         H3bCq5mhnsE966+bZcIx94dHdVY9bSBif2Cs7xiAHFcYPRy3L8/sLQvejYObhjnUYu7n
         cbZgy+dkkxBokxHKntSTegZ3x2yZqXR+6fJXBkZT4MPH25XJFdiJFnBtXmuX2ndT/+E5
         8QjoXeqRcysUXPA/V096Fa/ywBP3NKi7tTybZRp4DsVuQq9xqFAB6LBgOkXCoXHnjPZv
         M4zYy0z2GYeEPX9e/7GU02EWwYD/IKi91lqX6ZgiVCzjQeRr/sifZZre+0XGzQjzuzD2
         Z0YQ==
X-Gm-Message-State: AHQUAuYqt1fMW+NIZBk15kfYgcnQVdcmaF82fDKc2soQwTQvyecb/GZy
        437rEQQhhptJ1RFtoBizkd9t3A==
X-Google-Smtp-Source: AHgI3IaAxkDpETFIE/sxDC6Oen4KkDU2IsiGX44oILKMR/uSR29veBEwrP0zeA/8N9I+tJmnLKsqJg==
X-Received: by 2002:a63:d54a:: with SMTP id v10mr12071643pgi.154.1549495292218;
        Wed, 06 Feb 2019 15:21:32 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j6sm11829074pfg.126.2019.02.06.15.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 15:21:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grWVW-0006HW-6I; Wed, 06 Feb 2019 16:21:30 -0700
Date:   Wed, 6 Feb 2019 16:21:30 -0700
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
Message-ID: <20190206232130.GK12227@ziepe.ca>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz>
 <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 02:44:45PM -0800, Dan Williams wrote:

> > Do they need to stick with xfs?
> 
> Can you clarify the motivation for that question? This problem exists
> for any filesystem that implements an mmap that where the physical
> page backing the mapping is identical to the physical storage location
> for the file data. 

.. and needs to dynamicaly change that mapping. Which is not really
something inherent to the general idea of a filesystem. A file system
that had *strictly static* block assignments would work fine.

Not all filesystem even implement hole punch.

Not all filesystem implement reflink.

ftruncate doesn't *have* to instantly return the free blocks to
allocation pool.

ie this is not a DAX & RDMA issue but a XFS & RDMA issue.

Replacing XFS is probably not be reasonable, but I wonder if a XFS--
operating mode could exist that had enough features removed to be
safe? 

Ie turn off REFLINK. Change the semantic of ftruncate to be more like
ETXTBUSY. Turn off hole punch.

> > Are they really trying to do COW backed mappings for the RDMA
> > targets?  Or do they want a COW backed FS but are perfectly happy
> > if the specific RDMA targets are *not* COW and are statically
> > allocated?
> 
> I would expect the COW to be broken at registration time. Only ODP
> could possibly support reflink + RDMA. So I think this devolves the
> problem back to just the "what to do about truncate/punch-hole"
> problem in the specific case of non-ODP hardware combined with the
> Filesystem-DAX facility.

Usually the problem with COW is that you make a READ RDMA MR and on a
COW'd file, and some other thread breaks the COW..

This probably becomes a problem if the same process that has the MR
triggers a COW break (ie by writing to the CPU mmap). This would cause
the page to be reassigned but the MR would not be updated, which is
not what the app expects.

WRITE is simpler, once the COW is broken during GUP, the pages cannot
be COW'd again until the DMA pin is released. So new reflinks would be
blocked during the DMA pin period.

To fix READ you'd have to treat it like WRITE and break the COW at GPU.

Jason
