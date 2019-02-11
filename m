Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21640214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gnJNhkJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfBKXZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:25:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfBKXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:25:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so36402pgd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRXJe8aZrEDHZZ+k1rwRacB9kSieBbyz6GFANJVHSOY=;
        b=gnJNhkJRlEjow9q9Z9lougjKtjwotHpRkU8KW8EOTGblSHlRz78aK6SA5VY6sVzmk5
         GBIUFSRk0TNd7EegRjdswufkGnpZuEox6g4EZEJchdOgaRKoi05AvdVnhrfkAu7VelOO
         UwlWvVS0TttC4Wd+cMfsQPXiKrl5GZR1ZwEd2eFJ3kWU5GI2iZzImZaek1wcu7u8rSC4
         43E+DXMn09CTVzBYI9OAmYpa96svnzDBfeDd2ULpsq3VBEO7F8NaslH4gWDlZa2F57Ls
         5k7A5EVf0neMNeakJIJJsBQ7ro3Abv8FuDMIqD0ekRnoyxFwnJrqdhEH4U33q+EmjNwz
         M3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRXJe8aZrEDHZZ+k1rwRacB9kSieBbyz6GFANJVHSOY=;
        b=cMdFGS00yBpZbsKZoQ2k02gHuSOPsg7rfAL8FrTu9V+7rlyPMcNXsoLaO6wN4X+qBW
         B7fmHBVrOVC34uo1dtuRlvcHdH5sLaoLDGDQp1AVWq1XKd3/6NBetQzt1A0S4GPptxki
         Q9hRFVGaufTI/3MKXZ2d07y992kKXYWG4be+U/HtVPTRqkCArsw9GxfQI9x5OkI36eQY
         Rrp3fGJFZV7mQLWxU8IJb1SWlwjDJbx2AkaoF3NOxSXVW4Q55PyxgaBpR6lGI34+45tQ
         HiV10mQ2qzUdg25Rv9B8sBejBlR0zeQf1dIDfccfAnVFiBBJryR3O5y3niKjBXO1P9rG
         STYw==
X-Gm-Message-State: AHQUAuZLipiAgt/2rRFlOkFZZdKFiwBLTSMUOcfwQEMKgImZMq6StBq1
        dsi6dRj8HcAUYROd7cIrmiT5KQx+CYc=
X-Google-Smtp-Source: AHgI3Ia0Yhbeldmp4Aux/hDjVRNRPVzNAGrUxd+eW42PSy/9nnk/gDKe9W8RDapAE/cCOO5rixjcVg==
X-Received: by 2002:a63:aa46:: with SMTP id x6mr733312pgo.452.1549927511766;
        Mon, 11 Feb 2019 15:25:11 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x6sm9945025pfb.183.2019.02.11.15.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 15:25:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtKwo-0003cn-Kh; Mon, 11 Feb 2019 16:25:10 -0700
Date:   Mon, 11 Feb 2019 16:25:10 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Netdev <netdev@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
Message-ID: <20190211232510.GP24692@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211201643.7599-3-ira.weiny@intel.com>
 <20190211203916.GA2771@ziepe.ca>
 <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
 <20190211212652.GA7790@iweiny-DESK2.sc.intel.com>
 <fc9c880b-24f8-7063-6094-00175bc27f7d@nvidia.com>
 <20190211215238.GA23825@iweiny-DESK2.sc.intel.com>
 <20190211220658.GH24692@ziepe.ca>
 <CAPcyv4htDHmH7PVm_=HOWwRKtpcKTPSjrHPLqhwp2vhBUWL4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4htDHmH7PVm_=HOWwRKtpcKTPSjrHPLqhwp2vhBUWL4-w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:55:10PM -0800, Dan Williams wrote:

> > I also wonder if someone should think about making fast into a flag
> > too..
> >
> > But I'm not sure when fast should be used vs when it shouldn't :(
> 
> Effectively fast should always be used just in case the user cares
> about performance. It's just that it may fail and need to fall back to
> requiring the vma.

But the fall back / slow path is hidden inside the API, so when should
the caller care? 

ie when should the caller care to use gup_fast vs gup_unlocked? (the
comments say they are the same, but this seems to be a mistake)

Based on some of the comments in the code it looks like this API is
trying to convert itself into:

long get_user_pages_locked(struct task_struct *tsk, struct mm_struct *mm,
                           unsigned long start, unsigned long nr_pages,
			   unsigned int gup_flags, struct page **pages,
			   struct vm_area_struct **vmas, bool *locked)

long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
                             unsigned long start, unsigned long nr_pages,
			     unsigned int gup_flags, struct page **pages)

(and maybe a FOLL_FAST if there is some reason we have _fast and
_unlocked)

The reason I ask, is that if there is no reason for fast vs unlocked
then maybe Ira should convert HFI to use gup_unlocked and move the
'fast' code into unlocked?

ie move incrementally closer to the desired end-state here.

Jason
