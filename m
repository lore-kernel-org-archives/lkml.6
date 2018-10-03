Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8370C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FBD2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FBD2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJCXRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbeJCXRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:17:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD39BAACA;
        Wed,  3 Oct 2018 16:27:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 886FC1E3613; Wed,  3 Oct 2018 18:27:58 +0200 (CEST)
Date:   Wed, 3 Oct 2018 18:27:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
Message-ID: <20181003162758.GI24030@quack2.suse.cz>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com>
 <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-09-18 20:12:33, John Hubbard wrote:
>  static inline void release_user_pages(struct page **pages,
> -                                     unsigned long npages)
> +                                     unsigned long npages,
> +                                     bool set_dirty)
>  {
> -       while (npages)
> -               put_user_page(pages[--npages]);
> +       if (set_dirty)
> +               release_user_pages_dirty(pages, npages);
> +       else
> +               release_user_pages_basic(pages, npages);
> +}

Is there a good reason to have this with set_dirty argument? Generally bool
arguments are not great for readability (or greppability for that matter).
Also in this case callers can just as easily do:
	if (set_dirty)
		release_user_pages_dirty(...);
	else
		release_user_pages(...);

And furthermore it makes the code author think more whether he needs
set_page_dirty() or set_page_dirty_lock(), rather than just passing 'true'
and hoping the function magically does the right thing for him.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
