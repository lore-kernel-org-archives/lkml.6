Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5357AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDBE2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfA2Sa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:30:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:7496 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfA2Sa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:30:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 10:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="112066405"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2019 10:30:24 -0800
Date:   Tue, 29 Jan 2019 10:29:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] RDMA/uverbs: add owner parameter to ib_umem_get
Message-ID: <20190129182954.GA10129@iweiny-DESK2.sc.intel.com>
References: <1548768386-28289-1-git-send-email-joeln@il.ibm.com>
 <1548768386-28289-4-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548768386-28289-4-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 03:26:24PM +0200, Joel Nider wrote:
> ib_umem_get is a core function used by drivers that support RDMA.
> The 'owner' parameter signifies the process that owns the memory.
> Until now, it was assumed that the owning process was the current
> process. This adds the flexibility to specify a process other than
> the current process. All drivers that call this function are also
> updated, but the default behaviour is to keep backwards
> compatibility by assuming the current process is the owner when
> the 'owner' parameter is NULL.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
> ---

[snip]

> @@ -183,10 +196,11 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
>  
>  	while (npages) {
>  		down_read(&mm->mmap_sem);
> -		ret = get_user_pages_longterm(cur_base,
> +		ret = get_user_pages_remote_longterm(owner_task,
> +				     mm, cur_base,
>  				     min_t(unsigned long, npages,
> -					   PAGE_SIZE / sizeof (struct page *)),
> -				     gup_flags, page_list, vma_list);
> +				     PAGE_SIZE / sizeof(struct page *)),
> +				     gup_flags, page_list, vma_list, NULL);

qib was recently converted to get_user_pages_longterm.  So qib would need to
be updated as well.

Ira

