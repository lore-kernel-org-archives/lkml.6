Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80735C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3EA2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xyicrd65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfBKWuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:50:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43059 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfBKWuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:50:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so241410pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g/wkTXu46FNOCtPsm2RcpgDTiMDCp2Wv41qyxuMJ8uw=;
        b=Xyicrd65GrNQI2Ux5ANGkLgkEuWZD+V8zy3lXCzVtCwHfz+Pxa5RqFgZPBlj/bQR1x
         4o8n5wvByoZRcFE9M3AaAY3O16dGh1VDI3zvsic+R30HCkc4h1VvB4DicoF6eiJTc6tf
         oVEfSVLiFE4J63MZduYr+ZlerunKjxa7az7slCF6bcMu8qHtEe7WvQLcVGuyLNaZhHST
         U1NYwp8s4lnQmY+x83d71JHYQcZ0AqTTSHuZ66NQfUwNPWkKOj86y7snH64M7fz47UhO
         GvT88qxEaj02hIYWJwcccVe66PSGXxw4YqdBuaYVWdhsK8trnOv2m0nCOq9M9ywl0SPc
         V9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g/wkTXu46FNOCtPsm2RcpgDTiMDCp2Wv41qyxuMJ8uw=;
        b=MBzcd7PfQwW73tp49fjY7hXNLPpf405CGLf4pcPtLjKXBFtQ7Ams06lv3/kpCrdgwF
         DoSelgBLhl0gYPGYKaRJ9CL9dr9E8R/FLmNNXzPaR4c/M2P7CN+pimwG0VTdQ+523IFh
         R3ATOvBMaNgSYT1hpimL1fTmzL1tBqb6OmJTLz9aQ7fv5tSJLF/XeEGYz8OSauRB5Urx
         u4NgVgm0/o/nV454WxdSLX5zvZ8c0dTPx7ciWSSLPR4RNSazfeMWnMzlqbzKuyphumq8
         gLuCBD/THW+FpbqSgkZVg83SfNI5IMc4p40UTuGjKkOc61akGUQQ470Gm6RDRKe3idrl
         2Mpw==
X-Gm-Message-State: AHQUAubtAiaOFlUzN66d3JyBbBOtu6NXTujtVaaFOobBz3HvoZcPjSyF
        jUb9L+j0jVL74ggtFPmJBDlONw==
X-Google-Smtp-Source: AHgI3IZ7DSKOYRlpvuhZ2qLbJkP0aOIpfJquIji12SQBslBl1jfLdEzQLIHmQEmomUVN47PwKzlyug==
X-Received: by 2002:aa7:8199:: with SMTP id g25mr698005pfi.46.1549925453650;
        Mon, 11 Feb 2019 14:50:53 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a187sm10236492pfb.61.2019.02.11.14.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:50:52 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtKPc-0003PQ-8i; Mon, 11 Feb 2019 15:50:52 -0700
Date:   Mon, 11 Feb 2019 15:50:52 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Message-ID: <20190211225052.GL24692@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211203417.a2c2kbmjai43flyz@linux-r8p5>
 <20190211204710.GE24692@ziepe.ca>
 <20190211214257.GA7891@iweiny-DESK2.sc.intel.com>
 <20190211222208.GJ24692@ziepe.ca>
 <2807E5FD2F6FDA4886F6618EAC48510E79BCF37B@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79BCF37B@CRSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:40:02PM +0000, Weiny, Ira wrote:

> > Many drivers do this, the 'doorbell' is a PCI -> CPU thing of some sort
> 
> My surprise is why does _userspace_ allocate this memory?

Well, userspace needs to read the memory, so either userpace allocates
it and the kernel GUP's it, or userspace mmap's a kernel page which
was DMA mapped.

The GUP version lets the doorbells have lower alignment than a PAGE,
and thes RDMA drivers hard requires GUP->DMA to function..

So why not use a umem here? It already has to work.

> > > This does not seem to be allocating memory regions.  Jason, do you
> > > want a patch to just convert these calls and consider it legacy code?
> > 
> > It needs to use umem like all the other drivers on this path.
> > Otherwise it doesn't get the page pinning logic right
>
> Not sure what you mean regarding the pinning logic?

The RLIMIT_MEMLOCK stuff and so on.

> > There is also something else rotten with these longterm callsites,
> > they seem to have very different ideas how to handle
> > RLIMIT_MEMLOCK.
> > 
> > ie vfio doesn't even touch pinned_vm.. and rdma is applying
> > RLIMIT_MEMLOCK to mm->pinned_vm, while vfio is using locked_vm.. No
> > idea which is right, but they should be the same, and this pattern should
> > probably be in core code someplace.
> 
> Neither do I.  But AFAIK pinned_vm is a subset of locked_vm.

I thought so..

> So should we be accounting both of the counters?

Someone should check :)

Since we don't increment locked_vm when we increment pinned_vm and
vfio only checke RLIMIT_MEMLOCK against locked_vm one can certainly
exceed the limit by mixing and matching RDMA and VFIO pins in the same
process. Sure seems like there is a bug somewhere here.

Jason
