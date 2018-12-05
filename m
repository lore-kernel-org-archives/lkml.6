Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF20A20834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h10BkWVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF20A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeLEBPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:15:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8C7AtVLvFgHkPyGpij5DZEVSdOmgP6KLNjlDNxpPBpM=; b=h10BkWVfeC+Ckdgrek4LvKnww
        xgBhdxl7jJoitU7l3eXsUR41wQu9nvhxODjJoKZ1cjNgSYvEHHabCZ//uIStHabGg6cnoRnyDTP5J
        kneMvN2/36pA6AYFUXE3PqqavkqAeQaJcFn0OdfHIYjamLfkRiSOaHZHCIvuLTeY7sqvoBZZHmcD8
        uhZlZNFpiHh0zd8fE5JOJuT6u7DxnFzEXK3IQYjcgJew5R56CMJMuK/nQ86gnEaimQwYOQ6xbKa/L
        aaBSFCCENXa+4REjwjzKuV2evuS6b67lew05bNODdTwt1wrBWWaFFyKF1pFRx7a6q/SbUx0ZRhVQM
        ZArhHOe8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gULma-0003p9-55; Wed, 05 Dec 2018 01:15:20 +0000
Date:   Tue, 4 Dec 2018 17:15:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181205011519.GV10377@bombadil.infradead.org>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
> On 12/4/18 3:03 PM, Dan Williams wrote:
> > Except the LRU fields are already in use for ZONE_DEVICE pages... how
> > does this proposal interact with those?
> 
> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
> 
> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole 
> LRU field approach is unusable.

We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
damage:

+++ b/include/linux/mm_types.h
@@ -151,10 +151,12 @@ struct page {
 #endif
                };
                struct {        /* ZONE_DEVICE pages */
+                       unsigned long _zd_pad_2;        /* LRU */
+                       unsigned long _zd_pad_3;        /* LRU */
+                       unsigned long _zd_pad_1;        /* uses mapping */
                        /** @pgmap: Points to the hosting device page map. */
                        struct dev_pagemap *pgmap;
                        unsigned long hmm_data;
-                       unsigned long _zd_pad_1;        /* uses mapping */
                };
 
                /** @rcu_head: You can use this to free a page by RCU. */

You don't use page->private or page->index, do you Dan?
