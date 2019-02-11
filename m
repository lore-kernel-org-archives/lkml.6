Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B5FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E929D21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gB0ndMav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBKWMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:12:50 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42246 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfBKWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:12:49 -0500
Received: by mail-pf1-f174.google.com with SMTP id n74so212372pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=83DmjUWQh+S2vLB7v2POyWHbLsByc2zkoGWWNU6YAPM=;
        b=gB0ndMavIkmtshRqaMuUYA0IV/ApBgqnYbPjyksRq1BBJjKyeq3LdC/xG1McWcTeQX
         nrlUPXmoL33R57gJEqBcQ4NdMD34w4y3m0yMDrQGlSDTfgbKsfOmEqMasbZ+GUNniIGP
         iPHtdLQYITnYXmpZcYXwRjZHui/AFax+dob2kX9rjeHUXFLz6ZXwBcUQO/4e5aDvyKV0
         LwgEtSKK0gNgz29rEg+wZWEfCWyQJznN1+yRyy9VQ/zcmEefHlbtKLk1W98S+MCgHIAS
         dIvqSYf9XtGOoU5AasRE9cVN+saFPAc8XtMbQ8iNWY8Xe9lZj6ekrIQf/wSl1hBOx1YO
         0iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83DmjUWQh+S2vLB7v2POyWHbLsByc2zkoGWWNU6YAPM=;
        b=nBTLajKuQtL19bXXEqRkBFjnlLw0hS5j+OvKpU7mZFZduxI3irbjE7ZkBut51XU8v8
         FD5i88Fr3pdVxabqxvZQwjuxJ8Cdzj2dPE8eaBF7e9RcQ3TNKQL1lIqlLb9CdzWZngOy
         KBBVgaZEFnh453NAa0l8mXhRotMRlORpZifdkesmBzw6VWibHNpp8RsPO8kD/tdgTnka
         cZt7S1QUYWZWjS9EZjZewECusqLXSdC+ZnRwgvTomIPHa3JU4FF2PE7WSwm4n3Rurort
         t3lTvUIJwWBgL/BBeyjYrEfX+ei8RgDzFhca6AMS2rkO1ZGNJFGDTSLWvy4LZMGdC0/S
         yukQ==
X-Gm-Message-State: AHQUAuY8mEn/qiBxtbVbijsuEkNkDOh5CKBcTdDnv2IXKFKDIdD8b74L
        ulIXh7zD7wr6Mp7DbqoVd2S//w==
X-Google-Smtp-Source: AHgI3IYuL3gkNFhcl4a2Z2bh9sUoL6/TO+kjHmUXHSIyVoNduGP/oKTcakRSgEJRoQjAbch4RqeuxA==
X-Received: by 2002:a63:1544:: with SMTP id 4mr475924pgv.290.1549923169126;
        Mon, 11 Feb 2019 14:12:49 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m67sm19284132pfb.25.2019.02.11.14.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:12:48 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtJol-0003Sa-Rp; Mon, 11 Feb 2019 15:12:47 -0700
Date:   Mon, 11 Feb 2019 15:12:47 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211221247.GI24692@ziepe.ca>
References: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <fb507b56-7f8f-cf2c-285c-bae3b2d72c4f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb507b56-7f8f-cf2c-285c-bae3b2d72c4f@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:22:11PM -0800, John Hubbard wrote:

> The only way that breaks is if longterm pins imply an irreversible action, such
> as blocking and waiting in a way that you can't back out of or get interrupted
> out of. And the design doesn't seem to be going in that direction, right?

RDMA, vfio, etc will always have 'long term' pins that are
irreversible on demand. It is part of the HW capability.

I think the flag is badly named, it is really more of a
GUP_LOCK_PHYSICAL_ADDRESSES flag.

ie indicate to the FS that is should not attempt to remap physical
memory addresses backing this VMA. If the FS can't do that it must
fail.

Short term GUP doesn't need that kind of lock.

Jason
