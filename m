Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070E4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B36F2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 03:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bnPMaoQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B36F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeI2JjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 05:39:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1696 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2JjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 05:39:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5baeeda10000>; Fri, 28 Sep 2018 20:12:33 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 20:12:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 28 Sep 2018 20:12:34 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 29 Sep
 2018 03:12:33 +0000
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
To:     Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com> <20180928153922.GA17076@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
Date:   Fri, 28 Sep 2018 20:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928153922.GA17076@ziepe.ca>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538190753; bh=5cPDwkzBjUYG/dvcvYDKLruiu5HQvH4QX5CYkyDaQ5g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bnPMaoQS4BupKtwTJqAF4spoVzf3QVgub3CJbTGAzjxskP18n/cqFF0V7yYK8OCqg
         a5ZpGsmGQ961vkdAWx0/Q9CucLnUOZJOXyQdJSFs92fUj/3FEOKmH83sFeFWXSb/tP
         6n6TVbkUVqn6nHnK0R4ibJfj8UU+rz/Nv28NIQe7hzELRUqriqF0Yy5RBfrGG03cQo
         8AZyaxDMISkeBSYtswDKEfzPdHFewWbOB6x2z84UyLs045UQHJi2HBoj2Lh5Bx1a3b
         I7seRCYzLfCMXzeFo269StuVHjPSRLJOD118Xz6ccj1sGGJkT7tBLSka5XhSRvHriu
         /szGWDcR3vlPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 8:39 AM, Jason Gunthorpe wrote:
> On Thu, Sep 27, 2018 at 10:39:47PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>>
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index a41792dbae1f..9430d697cb9f 100644
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>>  		page = sg_page(sg);
>>  		if (!PageDirty(page) && umem->writable && dirty)
>>  			set_page_dirty_lock(page);
>> -		put_page(page);
>> +		put_user_page(page);
> 
> Would it make sense to have a release/put_user_pages_dirtied to absorb
> the set_page_dity pattern too? I notice in this patch there is some
> variety here, I wonder what is the right way?
> 
> Also, I'm told this code here is a big performance bottleneck when the
> number of pages becomes very long (think >> GB of memory), so having a
> future path to use some kind of batching/threading sound great.
> 

Yes. And you asked for this the first time, too. Consistent! :) Sorry for
being slow to pick it up. It looks like there are several patterns, and
we have to support both set_page_dirty() and set_page_dirty_lock(). So
the best combination looks to be adding a few variations of
release_user_pages*(), but leaving put_user_page() alone, because it's
the "do it yourself" basic one. Scatter-gather will be stuck with that.

Here's a differential patch with that, that shows a nice little cleanup in 
a couple of IB places, and as you point out, it also provides the hooks for 
performance upgrades (via batching) in the future.

Does this API look about right?

diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
index c7516029af33..48afec362c31 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -123,11 +123,7 @@ void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
 {
        size_t i;
 
-       for (i = 0; i < npages; i++) {
-               if (dirty)
-                       set_page_dirty_lock(p[i]);
-               put_user_page(p[i]);
-       }
+       release_user_pages_lock(p, npages, dirty);
 
        if (mm) { /* during close after signal, mm can be NULL */
                down_write(&mm->mmap_sem);
diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
index 3f8fd42dd7fc..c57a3a6730b6 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -40,13 +40,7 @@
 static void __qib_release_user_pages(struct page **p, size_t num_pages,
                                     int dirty)
 {
-       size_t i;
-
-       for (i = 0; i < num_pages; i++) {
-               if (dirty)
-                       set_page_dirty_lock(p[i]);
-               put_user_page(p[i]);
-       }
+       release_user_pages_lock(p, num_pages, dirty);
 }
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 72caf803115f..b280d0181e06 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -138,6 +138,9 @@ extern int overcommit_ratio_handler(struct ctl_table *, int, void __user *,
 extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
                                    size_t *, loff_t *);
 
+int set_page_dirty(struct page *page);
+int set_page_dirty_lock(struct page *page);
+
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /* to align the pointer to the (next) page boundary */
@@ -949,12 +952,56 @@ static inline void put_user_page(struct page *page)
        put_page(page);
 }
 
-/* A drop-in replacement for release_pages(): */
+/* For get_user_pages*()-pinned pages, use these variants instead of
+ * release_pages():
+ */
+static inline void release_user_pages_dirty(struct page **pages,
+                                           unsigned long npages)
+{
+       while (npages) {
+               set_page_dirty(pages[npages]);
+               put_user_page(pages[npages]);
+               --npages;
+       }
+}
+
+static inline void release_user_pages_dirty_lock(struct page **pages,
+                                                unsigned long npages)
+{
+       while (npages) {
+               set_page_dirty_lock(pages[npages]);
+               put_user_page(pages[npages]);
+               --npages;
+       }
+}
+
+static inline void release_user_pages_basic(struct page **pages,
+                                           unsigned long npages)
+{
+       while (npages) {
+               put_user_page(pages[npages]);
+               --npages;
+       }
+}
+
 static inline void release_user_pages(struct page **pages,
-                                     unsigned long npages)
+                                     unsigned long npages,
+                                     bool set_dirty)
 {
-       while (npages)
-               put_user_page(pages[--npages]);
+       if (set_dirty)
+               release_user_pages_dirty(pages, npages);
+       else
+               release_user_pages_basic(pages, npages);
+}
+
+static inline void release_user_pages_lock(struct page **pages,
+                                          unsigned long npages,
+                                          bool set_dirty)
+{
+       if (set_dirty)
+               release_user_pages_dirty_lock(pages, npages);
+       else
+               release_user_pages_basic(pages, npages);
 }
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
@@ -1548,8 +1595,6 @@ int redirty_page_for_writepage(struct writeback_control *wbc,
 void account_page_dirtied(struct page *page, struct address_space *mapping);
 void account_page_cleaned(struct page *page, struct address_space *mapping,
                          struct bdi_writeback *wb);
-int set_page_dirty(struct page *page);
-int set_page_dirty_lock(struct page *page);
 void __cancel_dirty_page(struct page *page);
 static inline void cancel_dirty_page(struct page *page)
 {


> Otherwise this RDMA part seems fine to me, there might be some minor
> conflicts however. I assume you want to run this through the -mm tree?
> 
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> 

Great, thanks for the ACK.


thanks,
-- 
John Hubbard
NVIDIA
