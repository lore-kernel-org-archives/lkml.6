Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C725C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCF5217B4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCF5217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbeHMRLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:11:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbeHMRLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:11:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C74E406E8C0;
        Mon, 13 Aug 2018 14:29:10 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21D51178BC;
        Mon, 13 Aug 2018 14:29:08 +0000 (UTC)
Date:   Mon, 13 Aug 2018 10:29:06 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        jack@suse.cz, hch@lst.de, yu c zhang <yu.c.zhang@intel.com>,
        linux-mm@kvack.org, rkrcmar@redhat.com,
        yi z zhang <yi.z.zhang@intel.com>
Subject: Re: [PATCH V3 3/4] mm: add a function to differentiate the pages is
 from DAX device memory
Message-ID: <20180813142906.GA3451@redhat.com>
References: <cover.1533811181.git.yi.z.zhang@linux.intel.com>
 <2b7856596e519130946c834d5d61b00b7f592770.1533811181.git.yi.z.zhang@linux.intel.com>
 <872818364.892078.1533806608252.JavaMail.zimbra@redhat.com>
 <5ea50e63-b55a-c1e1-50be-6e2d951c04cf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea50e63-b55a-c1e1-50be-6e2d951c04cf@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 14:29:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 14:29:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:41:40AM +0800, Zhang,Yi wrote:
> 
> 
> On 2018年08月09日 17:23, Pankaj Gupta wrote:
> >> DAX driver hotplug the device memory and move it to memory zone, these
> >> pages will be marked reserved flag, however, some other kernel componet
> >> will misconceive these pages are reserved mmio (ex: we map these dev_dax
> >> or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
> >> MEMORY_DEVICE_FS_DAX, we can use is_dax_page() to differentiate the pages
> >> is DAX device memory or not.
> >>
> >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> >> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> >> ---
> >>  include/linux/mm.h | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 68a5121..de5cbc3 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -889,6 +889,13 @@ static inline bool is_device_public_page(const struct
> >> page *page)
> >>  		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
> >>  }
> >>  
> >> +static inline bool is_dax_page(const struct page *page)
> >> +{
> >> +	return is_zone_device_page(page) &&
> >> +		(page->pgmap->type == MEMORY_DEVICE_FS_DAX ||
> >> +		page->pgmap->type == MEMORY_DEVICE_DEV_DAX);
> >> +}
> > I think question from Dan for KVM VM with 'MEMORY_DEVICE_PUBLIC' still holds?
> > I am also interested to know if there is any use-case.
> >
> > Thanks,
> > Pankaj
> Yes, it is, thanks for your remind, Pankaj.
> Adding Jerome for Dan's questions on V1:
> [Dan]:
> 
> Jerome, might there be any use case to pass MEMORY_DEVICE_PUBLIC
> memory to a guest vm?

Yes and no, i am not sure how we are going to do it. But being able to
share GPU among multiple VM is on TODO list and those GPU will have
MEMORY_DEVICE_PUBLIC|PRIVATE depending on the platform. So either we
pass down the real underlying resource to the guest, or we will pass
down a fake one and have guest and host driver talk to each other so
that the host driver can do overall resource management accross multiple
guests.

So i would say that for now you can ignore MEMORY_DEVICE_PUBLIC and when
we get to the KVM guest sharing of those and decide how we want to do
it then we can update kvm to properly interpret those.

Cheers,
Jérôme
