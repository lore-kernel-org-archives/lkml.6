Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C82FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B45620852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B45620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbeGWRZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:25:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388240AbeGWRZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BC684059FF8;
        Mon, 23 Jul 2018 16:23:13 +0000 (UTC)
Received: from redhat.com (ovpn-123-156.rdu2.redhat.com [10.10.123.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C26D111CB8C;
        Mon, 23 Jul 2018 16:23:10 +0000 (UTC)
Date:   Mon, 23 Jul 2018 12:23:08 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@lst.de
Subject: Re: [PATCH v6 06/13] mm, dev_pagemap: Do not clear ->mapping on
 final put
Message-ID: <20180723162308.GA4704@redhat.com>
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153154380137.34503.3754023882460956800.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3fcb3c8a-2a41-7c78-edde-066c10110d34@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fcb3c8a-2a41-7c78-edde-066c10110d34@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 23 Jul 2018 16:23:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 23 Jul 2018 16:23:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 09:12:06AM -0700, Dave Jiang wrote:
> Jerome,
> Is it possible to get an ack for this? Thanks!
> 
> On 07/13/2018 09:50 PM, Dan Williams wrote:
> > MEMORY_DEVICE_FS_DAX relies on typical page semantics whereby ->mapping
> > is only ever cleared by truncation, not final put.
> > 
> > Without this fix dax pages may forget their mapping association at the
> > end of every page pin event.
> > 
> > Move this atypical behavior that HMM wants into the HMM ->page_free()
> > callback.
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Fixes: d2c997c0f145 ("fs, dax: use page->mapping...")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Jérôme Glisse <jglisse@redhat.com>

> > ---
> >  kernel/memremap.c |    1 -
> >  mm/hmm.c          |    2 ++
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/memremap.c b/kernel/memremap.c
> > index 5857267a4af5..62603634a1d2 100644
> > --- a/kernel/memremap.c
> > +++ b/kernel/memremap.c
> > @@ -339,7 +339,6 @@ void __put_devmap_managed_page(struct page *page)
> >  		__ClearPageActive(page);
> >  		__ClearPageWaiters(page);
> >  
> > -		page->mapping = NULL;
> >  		mem_cgroup_uncharge(page);
> >  
> >  		page->pgmap->page_free(page, page->pgmap->data);
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index de7b6bf77201..f9d1d89dec4d 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -963,6 +963,8 @@ static void hmm_devmem_free(struct page *page, void *data)
> >  {
> >  	struct hmm_devmem *devmem = data;
> >  
> > +	page->mapping = NULL;
> > +
> >  	devmem->ops->free(devmem, page);
> >  }
> >  
> > 
> > _______________________________________________
> > Linux-nvdimm mailing list
> > Linux-nvdimm@lists.01.org
> > https://lists.01.org/mailman/listinfo/linux-nvdimm
> > 
