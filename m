Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB1BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C042089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I3MBtNX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C042089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJDGKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:10:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16605 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJDGKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:10:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb54e8c0000>; Wed, 03 Oct 2018 16:19:40 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 03 Oct 2018 16:19:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 03 Oct 2018 16:19:39 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 3 Oct
 2018 23:19:39 +0000
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
To:     Jan Kara <jack@suse.cz>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com> <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
 <20181003162758.GI24030@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <75712e67-59f1-2057-dc89-779cdf5600ee@nvidia.com>
Date:   Wed, 3 Oct 2018 16:19:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181003162758.GI24030@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538608780; bh=fvdT1XPbgGTXP2Uz0ItLkT9Ikc6hkWFdEupgbkIHC9g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I3MBtNX1jyr1ohDzkCj90b3g0QLGy6mZgR6ceEUCNHWrNjcPCyLIiFat1OeF3J74m
         euB7UF/MT9tkOHYtK/TFzqWK17v/lrOxPgFBPli4M8ClhZ8UZhd8tyOKyt2IEqZ7jI
         /feKzPF/yI68Jj69ggAfLpHskNJNWgkFlOWob96RxiPjs5rV+SCAZJp+nbQWeGmObm
         IreyGYUcdisU2HETadryaQppHyDFBd8bRnjtNO/RKIEoh8DjSnRavyaV6SAgaIzpMH
         blFK4IgnfniKD87fPTTFbgvGgZNlbsMhZ1WL1zx6Pjjl1VBUrDSJnjvFxJiH5MxgNV
         QUkawhrMcW9uw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 9:27 AM, Jan Kara wrote:
> On Fri 28-09-18 20:12:33, John Hubbard wrote:
>>  static inline void release_user_pages(struct page **pages,
>> -                                     unsigned long npages)
>> +                                     unsigned long npages,
>> +                                     bool set_dirty)
>>  {
>> -       while (npages)
>> -               put_user_page(pages[--npages]);
>> +       if (set_dirty)
>> +               release_user_pages_dirty(pages, npages);
>> +       else
>> +               release_user_pages_basic(pages, npages);
>> +}
> 
> Is there a good reason to have this with set_dirty argument? Generally bool
> arguments are not great for readability (or greppability for that matter).
> Also in this case callers can just as easily do:
> 	if (set_dirty)
> 		release_user_pages_dirty(...);
> 	else
> 		release_user_pages(...);
> 
> And furthermore it makes the code author think more whether he needs
> set_page_dirty() or set_page_dirty_lock(), rather than just passing 'true'
> and hoping the function magically does the right thing for him.
> 

Ha, I went through *precisely* that argument in my head, too--and then
got seduced with the idea that it pretties up the existing calling code, 
because it's a drop-in one-liner at the call sites. But yes, I'll change it 
back to omit the bool set_dirty argument.

thanks,
-- 
John Hubbard
NVIDIA
