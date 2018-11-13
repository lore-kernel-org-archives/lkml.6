Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ADDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D72223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D72223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbeKMXCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:02:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733149AbeKMXCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:02:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17F2DB0F8;
        Tue, 13 Nov 2018 13:04:34 +0000 (UTC)
Date:   Tue, 13 Nov 2018 14:04:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yongkai Wu <nic.wuyk@gmail.com>
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetl.c: keep the page mapping info when
 free_huge_page() hit the VM_BUG_ON_PAGE
Message-ID: <20181113130433.GB16182@dhcp22.suse.cz>
References: <CAJtqMcZp5AVva2yOM4gJET8Gd_j_BGJDLTkcqRdJynVCiRRFxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJtqMcZp5AVva2yOM4gJET8Gd_j_BGJDLTkcqRdJynVCiRRFxQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-11-18 20:38:16, Yongkai Wu wrote:
> It is better to keep page mapping info when free_huge_page() hit the
> VM_BUG_ON_PAGE,
> so we can get more infomation from the coredump for further analysis.

The patch seems to be whitespace damaged. Put that aside, have you
actually seen a case where preservning the page state would help to nail
down any bug.

I am not objecting to the patch, it actually makes some sense to me, I
am just curious about a background motivation.
 
> Signed-off-by: Yongkai Wu <nic_w@163.com>
> ---
>  mm/hugetlb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c007fb5..ba693bb 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1248,10 +1248,11 @@ void free_huge_page(struct page *page)
>   (struct hugepage_subpool *)page_private(page);
>   bool restore_reserve;
> 
> +        VM_BUG_ON_PAGE(page_count(page), page);
> +        VM_BUG_ON_PAGE(page_mapcount(page), page);
> +
>   set_page_private(page, 0);
>   page->mapping = NULL;
> - VM_BUG_ON_PAGE(page_count(page), page);
> - VM_BUG_ON_PAGE(page_mapcount(page), page);
>   restore_reserve = PagePrivate(page);
>   ClearPagePrivate(page);
> 
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
