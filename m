Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B94C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03675214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F2wnBIUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBKVOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:14:04 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2296 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:14:03 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c61e5960000>; Mon, 11 Feb 2019 13:13:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 13:13:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 13:13:57 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 21:13:57 +0000
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
To:     Jason Gunthorpe <jgg@ziepe.ca>, <ira.weiny@intel.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, <netdev@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211201643.7599-3-ira.weiny@intel.com> <20190211203916.GA2771@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
Date:   Mon, 11 Feb 2019 13:13:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211203916.GA2771@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549919638; bh=jCNJwm22GIJyJ9ioZIwP6IZZLdb+CRCGAEh9x8vIK40=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=F2wnBIUIyRcBk9XPZBwpp+6XeprxUtoGbDdGoNtn6k9OQQtZ9hMy5XhGDUFmFyQvs
         Cu4YHNkIG9qjaEMUQRhkvvSf6cPgpUW2gmtvWNL+JD0qKEsXO1dtgAKkGacgp3a61z
         hDrnGMFtLb6t8+segCjn0hgTBqZawFIRjqtd2pbLIpINclPAYE7V/jLZ3XWY+1RIYS
         Wb23jh/Eent8W8fBllFt3+5gBhmFuUN1816D0bLEeGbozqN0PoFUTf21suiDx53cUq
         mbkf2aV9MvY/0qnZtPfLUUi7+mmxWEN7SRwLDUmyfCOq+aEEkWj1a6xvxBd0MgIHbx
         odNPsrr5kqBmg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 12:39 PM, Jason Gunthorpe wrote:
> On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
[...]
>> +static inline int get_user_pages_fast_longterm(unsigned long start, int nr_pages,
>> +					       bool write, struct page **pages)
>> +{
>> +	return get_user_pages_fast(start, nr_pages, write, pages);
>> +}
>>  #endif /* CONFIG_FS_DAX */
>>  
>>  int get_user_pages_fast(unsigned long start, int nr_pages, int write,
>> @@ -2615,6 +2622,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>>  #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
>>  #define FOLL_COW	0x4000	/* internal GUP flag */
>>  #define FOLL_ANON	0x8000	/* don't do file mappings */
>> +#define FOLL_LONGTERM	0x10000	/* mapping is intended for a long term pin */
> 
> If we are adding a new flag, maybe we should get rid of the 'longterm'
> entry points and just rely on the callers to pass the flag?
> 
> Jason
> 

+1, I agree that the overall get_user_pages*() API family will be cleaner
*without* get_user_pages_longterm*() calls. And this new flag makes that possible.
So I'd like to see the "longerm" call replaced with just passing this flag. Maybe
even as part of this patchset, but either way.

Taking a moment to reflect on where I think this might go eventually (the notes
below do not need to affect your patchset here, but this seems like a good place
to mention this):

It seems to me that the longterm vs. short-term is of questionable value.
It's actually better to just call get_user_pages(), and then if it really is
long-term enough to matter internally, we'll see the pages marked as gup-pinned.
If the gup pages are released before anyone (filesystem, that is) notices, then
it must have been short term.

Doing it that way is self-maintaining. Of course, this assumes that we end up with
a design that doesn't require being told, by the call sites, that a given gup
call is intended for "long term" use. So I could be wrong about this direction, but
let's please consider the possibility.

thanks,
-- 
John Hubbard
NVIDIA
