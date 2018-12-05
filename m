Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34C3C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787A92082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787A92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLEBor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:44:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeLEBor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:44:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7894665857;
        Wed,  5 Dec 2018 01:44:46 +0000 (UTC)
Received: from redhat.com (ovpn-120-95.rdu2.redhat.com [10.10.120.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C331070388;
        Wed,  5 Dec 2018 01:44:43 +0000 (UTC)
Date:   Tue, 4 Dec 2018 20:44:41 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181205014441.GA3045@redhat.com>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205011519.GV10377@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 05 Dec 2018 01:44:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:15:19PM -0800, Matthew Wilcox wrote:
> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
> > On 12/4/18 3:03 PM, Dan Williams wrote:
> > > Except the LRU fields are already in use for ZONE_DEVICE pages... how
> > > does this proposal interact with those?
> > 
> > Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
> > use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
> > way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
> > 
> > If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole 
> > LRU field approach is unusable.
> 
> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
> damage:
> 
> +++ b/include/linux/mm_types.h
> @@ -151,10 +151,12 @@ struct page {
>  #endif
>                 };
>                 struct {        /* ZONE_DEVICE pages */
> +                       unsigned long _zd_pad_2;        /* LRU */
> +                       unsigned long _zd_pad_3;        /* LRU */
> +                       unsigned long _zd_pad_1;        /* uses mapping */
>                         /** @pgmap: Points to the hosting device page map. */
>                         struct dev_pagemap *pgmap;
>                         unsigned long hmm_data;
> -                       unsigned long _zd_pad_1;        /* uses mapping */
>                 };
>  
>                 /** @rcu_head: You can use this to free a page by RCU. */
> 
> You don't use page->private or page->index, do you Dan?

page->private and page->index are use by HMM DEVICE page.

Cheers,
Jérôme
